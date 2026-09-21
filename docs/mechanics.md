# Wahui Online Game Mechanics

This document outlines the core mechanics of the Wahui Online game, a digital adaptation of the traditional Sabahan gambling game "Wahui".

## I. Game Objective and Core Components

### A. Game Objective

The primary objective for the player is to correctly predict and place a bet on the winning board for a given round, utilizing the unique rhyming clue system (*Pantun*) provided.

### B. Core Betting Components

| Component        | Description                                                                                                 |
| ---------------- | ----------------------------------------------------------------------------------------------------------- |
| **Betting Boards** | There are 20 different boards available for players to bet on each round.                                       |
| **User/Wallet**    | Required for user accounts and authentication. Manages player funds.                                        |
| **Game Rounds**    | The central state manager for the game, controlling the winning board selection and associated clues.         |

## II. Game Cycle and Round Management

The game operates on a fixed, scheduled cycle, with the "House" acting as the central administrator and publisher.

### A. The House Role (Round Game Maker)

The House serves as the *Pantun* Publisher/Round Game Maker.

1.  **Round Initiation:** The House initiates the game round by determining the winning board and creating the clues.
2.  **House Bet:** For each round, the House establishes a specific *House Bet*. This bet is tied directly to the published *Pantun* phrases for that round.
3.  **Management Interface:** These administrative actions are managed through the central Wahuiboards system.

### B. Fixed Game Cycle

The temporal mechanic is defined by a fixed daily schedule:

*   **Round Frequency:** The platform hosts 3 rounds per day.
*   **Timing Control:** The system must record the `betting_closing_time` and `announcement_time` within the `wahuiboards` table to manage the betting window and result announcement.
*   **Betting Lockout:** The system must cease accepting bets once the round timer expires. The frontend utilizes Hotwire (Turbo and Stimulus) to display a real-time countdown.

## III. Unique Clue System (The Pantun Mechanic)

The Synonyms feature is repurposed to deliver the unique clue structure required for Wahui Online.

*   **Clue Delivery:** Clues are provided via the Synonyms feature.
*   **Clue Structure:** Players receive 4 phrases during each round. These phrases are sentences that rhyme (*Pantun*).
*   **Clue Resolution:** The four rhyming phrases collectively serve as the clue that "resembles 1 answer".
*   **The Answer:** The final answer derived from the *Pantun* is the winning board upon which players must bet.
*   **Data Storage:** The specific *Pantun* phrases are stored in the `synonyms` database table and are associated with the `wahuiboards` table for the corresponding game round.

## IV. Financial and Payout Mechanics

The game uses a Pool Payout system, where winners share the stakes lost by others.

### A. Pool Payout System

The payout is based on the concept of accumulated lose bet.

*   **Payout Calculation:** Winnings are calculated by dividing the total amount from losing bets by the total amount from winning bets (including the House Bet), and then multiplying that by each winner's individual stake.

    **Formula:**
    `Prize per Winner = (Total Losing Bets / Total Winning Bets) * Winner's Stake`

*   **Required Metrics:** The application's backend must track the total wagered on all 19 losing boards and tally the total units/stakes placed by winning players and the House Bet amount.
*   **Fund Update:** Successful payouts update the player's wallet balance.

### B. Financial Transaction Mechanics

The application requires dedicated features to manage the player's wallet beyond just betting:

*   **Deposit Feature:** Required for players to add funds to their balance.
*   **Withdrawal Feature:** Required for players to cash out funds.
*   **Auditing:** A transaction logging mechanism is necessary to audit all fund movements, including deposits, withdrawals, wagers, and payouts, ensuring the integrity of the current balance.

## V. Future Development

The following features are mentioned in this document but are not yet implemented:

*   **Game Round Management:** An admin interface for the "House" to create and manage game rounds (selecting winning board, writing clues, setting timers, placing House Bet).
*   **Payout Administration:** A feature for an admin to trigger the payout process at the end of a round.
*   **Transaction Auditing:** An admin dashboard to view and audit all financial transactions.
*   **Withdrawal Feature:** A system for users to withdraw funds from their wallet.