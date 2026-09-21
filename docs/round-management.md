# Round Management

This document proposes how the House should create, publish, close, announce, and settle a Wahui round. It is a business and product design document for the early development stage; it is not yet an implementation specification.

## 1. Operating Model

A round is a controlled betting event managed by the House. The House prepares the round before players can see or bet on it, publishes the clues during the betting window, closes betting at a fixed time, records the result, and settles the payout from an immutable snapshot of the bets.

The core principle is simple:

> The House may configure and publish a round, but it must not be able to change the answer, clues, or payout inputs after betting begins.

This protects player trust and gives the operator an auditable history for disputes, reporting, and compliance.

## 2. Terminology

### Board

A numbered game choice in the board catalog. For example, board `26` is `KURA-KURA`.

### Board synonym

A reusable word or phrase associated with a board. Synonyms help the House and players interpret clues. They are not automatically a separate betting outcome.

Example:

```text
Board 26: KURA-KURA
Synonyms: penyu, sisir, petir, kalung, kura-kura
```

### Round clue

The four pantun lines or phrases published for one round. A round clue is a snapshot of the content shown to players. It should not depend on a live synonym record that an administrator can later edit.

### Winning answer

The board selected as the official result of the round. For the first version, the winning answer should resolve to a board number, not to an arbitrary text string.

### House bet

A declared House stake associated with the round. Its accounting treatment must be fixed before launch and displayed in the round rules.

## 3. Round Lifecycle

A round should move through explicit states. The application should reject actions that do not match the current state.

| State | House actions | Player actions |
| --- | --- | --- |
| `draft` | Configure boards, clues, answer, schedule, and House bet | None |
| `scheduled` | Review and publish the locked configuration | View only, if exposed |
| `open` | Monitor activity; no answer edits | View clues and place or amend bets |
| `closed` | No content edits; prepare settlement | No new bets or amendments |
| `announced` | Publish the winning board and result summary | View result and provisional payout |
| `settled` | Finalize payouts and reports | View final payout and transaction history |
| `cancelled` | Record reason and refund policy | View cancellation and refund result |

The early implementation can start with `draft`, `open`, `closed`, `announced`, and `settled`, but the state must still be stored explicitly rather than inferred from timestamps alone.

## 4. House Workflow

### Step 1: Create a draft

The House creates a new round with:

- A unique round number or public reference
- The list of boards available for this round
- The four clue lines
- The winning board or answer commitment
- The House bet amount and its accounting policy
- Betting opening time
- Betting closing time
- Announcement time

The House should normally select a subset of the board catalog for a round. The product documentation describes 20 betting boards per round, while the reference catalog contains 37 boards.

### Step 2: Validate the draft

Before publication, the system should require:

- Exactly four clue lines
- At least one active betting board
- A winning board that belongs to the round's available board set
- A betting closing time after the opening time
- An announcement time after the betting closing time
- A non-negative House bet amount
- A valid payout configuration
- No duplicate public round number

The House should preview the exact player-facing round before publishing it.

### Step 3: Lock and publish

Publishing changes the round from `draft` to `open` or `scheduled`.

At this point the system should create a publication snapshot containing:

- The four clue lines
- Board numbers and names available for betting
- The answer commitment or securely protected result
- House bet details
- All timestamps
- The publishing administrator and timestamp

After publication, the House must not edit the clues, available boards, answer, or payout rules. Corrections should create a new round or use a formally recorded cancellation process.

### Step 4: Accept bets

During `open`:

- Only authenticated, eligible players may bet.
- The player must have enough available balance.
- The selected board must be available in the round.
- Every wager must create an immutable transaction record.
- A player may amend or cancel a wager only until the closing time, according to the published rules.
- The server must enforce the closing time; a client countdown is not security.

### Step 5: Close betting

At `betting_closing_time`, the system should atomically:

1. Change the round to `closed`.
2. Reject all later wager requests.
3. Record the final wager totals by board.
4. Record the total player stake and House stake.
5. Store a settlement snapshot.

The close operation must be idempotent so a job retry cannot close or charge a round twice.

### Step 6: Announce the result

At `announcement_time`, the House or an automated job changes the round to `announced`.

The result should show:

- Winning board number and name
- The four published clues
- Total amount wagered
- Number of winning players
- Payout ratio or payout amount
- Settlement status

The result must come from the locked answer commitment, not from a value typed into a public announcement form after betting closes.

### Step 7: Settle the round

Settlement calculates payouts from the stored snapshot, creates payout transactions, and updates wallets in one controlled operation. A retry must not create duplicate payouts.

The system should record:

- Settlement execution time
- Settlement version or calculation identifier
- Total losing pool
- Total winning player stake
- House contribution, if applicable
- Payout ratio
- Each player's eligible stake and payout
- Any rounding remainder
- The administrator or job that initiated settlement

## 5. Recommended Answer Model

For the MVP, players should bet on a **board number**, not on an individual synonym.

The synonym dictionary is a clue and content-management tool:

```text
Board 26 -> KURA-KURA
Synonyms -> penyu, sisir, petir, kalung, kura-kura
```

The four pantun lines guide the player toward board 26. The official result is still board 26. This keeps the betting product understandable and avoids ambiguous disputes such as whether `penyu` and `kura-kura` should pay differently.

The round should store both:

- `winning_board_id`: the canonical settlement answer
- A locked four-line clue snapshot: what players actually saw

The reusable board synonym table should not be used as the historical source for a completed round, because an administrator may edit the dictionary later.

## 6. Recommended MVP Payout Model

Use a transparent pari-mutuel pool model with no synonym tiers at first.

### Definitions

- `L`: total player stakes placed on losing boards
- `W`: total player stakes placed on the winning board
- `H`: House amount included in the published payout policy
- `S`: one winning player's stake

The first product decision is how `H` is treated. These are separate business options and must not be mixed silently.

### Option A: House bet is a contribution to the winning pool

If the House bet is placed on the winning board and participates as a stake, use:

$$
Payout(S) = \frac{L}{W + H} \times S
$$

The player's returned amount can be defined as either:

- **Profit only:** `Payout(S)` plus the original stake `S` is returned separately; or
- **Total return:** the formula is explicitly changed to include the original stake.

The UI and ledger must use one definition consistently.

### Option B: House bet is operational liquidity

If the House bet is a promotional or liquidity contribution rather than a winning stake, do not include it in `W + H`. Instead, document whether it is added to the payout pool, retained by the House, or used to cover a guaranteed minimum.

### Recommendation

For the first release, choose **Option A only if the House bet is genuinely funded, disclosed, and treated like a winning-side stake**. Otherwise use a simpler player-only pool and show the House amount separately.

A trustworthy product should never describe the House bet as a player stake in one screen and as House revenue in another.

### Edge cases

The settlement policy must define:

- No losing bets: no pool-funded profit; return winning stakes according to the published rule.
- No winning player bets: the round has no player payout; document House treatment.
- Multiple winners: divide the pool by winning stake proportionally.
- Decimal rounding: round at the smallest supported currency unit and record any remainder.
- Insufficient funds: settlement must fail safely and remain retryable without duplicate payouts.
- Cancelled round: refund all valid player stakes with a cancellation transaction.

## 7. Should Specific Synonyms Pay More?

### Recommendation: not in the MVP

Do not pay a higher percentage merely because a player selected a more specific synonym when the player is actually betting on a board. That creates several business problems:

- Players may not understand whether they are betting on a board or a word.
- The House could accidentally publish clues with different implied odds.
- Similar words become dispute cases.
- A tiered payout makes the pool calculation harder to explain and audit.
- It can reward wording interpretation rather than the core board prediction.

### Future option: explicit answer tiers

If the product later wants synonym-level betting, make it a separate, clearly named market:

| Market | Example | Payout behavior |
| --- | --- | --- |
| Board answer | `KURA-KURA` | Standard pool payout |
| Exact synonym | `PENYU` | Separate pool or published fixed multiplier |

Do not mix both markets in one pool. Every tier would need its own odds, liability limit, settlement rule, and player-facing explanation. The multiplier must be fixed before betting opens and recorded in the round snapshot.

## 8. House Controls and Separation of Duties

A gambling business should avoid giving one operator unrestricted control over both the result and the settlement.

Recommended controls:

- The creator publishes the draft; a second authorized operator approves high-value or high-risk rounds.
- The answer commitment is locked before the round opens.
- Changes after publication require cancellation and a reason.
- Settlement runs from an immutable snapshot.
- Financial actions create append-only ledger records.
- Admin actions are logged with actor, timestamp, old value, and new value.
- House bets and operator exposure are visible in internal reports.
- Access to player balances and round results follows least privilege.

## 9. Suggested Admin Screens

### Round list

Show:

- Round number
- State
- Opening, closing, and announcement times
- Available board count
- Total player stake
- Settlement status

### Round editor

In `draft`, allow the House to manage:

- Available boards
- Four pantun lines
- Winning board
- House bet policy and amount
- Schedule

### Round review

Before publication, show the exact player-facing content and require confirmation that the answer, clues, board set, and payout policy are correct.

### Round monitoring

While `open`, show totals by board without exposing sensitive operator controls to ordinary users.

### Settlement report

After settlement, show the immutable calculation inputs, payout ratio, player payouts, refunds, rounding, and transaction identifiers.

## 10. Business Recommendation

For the early release:

1. Publish board-number betting only.
2. Use synonyms and pantun lines as clues, not separate odds tiers.
3. Lock the answer and clue snapshot before betting opens.
4. Use one simple proportional pool formula.
5. Make the House bet treatment explicit and consistent.
6. Add cancellation, refund, and settlement audit paths before real-money use.
7. Add synonym-level markets only after the board market is understandable, tested, and legally reviewed.

This gives the House operational control without making the game feel arbitrary, and gives players a payout model they can verify from the published rules.

## 11. Open Decisions

Before implementation, the product owner should decide:

- Are there 20 available boards per round, or can all 37 be available?
- Is the House bet a winning-side stake, a prize contribution, or House exposure?
- Does the displayed payout mean profit only or total return including the original stake?
- Can players amend bets, and until exactly when?
- Who approves a published result?
- What is the refund rule for cancellation or technical failure?
- What currency and smallest unit does the ledger support?
- Which responsible-gambling, licensing, age-verification, and jurisdiction controls apply before launch?
