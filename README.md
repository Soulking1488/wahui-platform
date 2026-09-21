# Wahui

Wahui is a Rails web portal for a digital version of the Wahui board game. Players use a set of pantun-style clues to choose a board for each game round. The House publishes rounds, controls the betting window, announces results, and manages the payout process.

This repository is an early development version. Authentication, role-based dashboards, the board catalog, round data, and local seed data are available. Real-money deposits, withdrawals, betting, payout processing, and the complete House administration workflow are still under development.

## Product Model

### Players

Players register with an email address and password, then use the player dashboard. A new public registration receives the `player` role.

### House and administrators

Administrators manage rounds, boards, clues, house bets, results, users, and financial auditing. `admin` and `house_operator` users can access the current admin area. Public registration never accepts a role parameter.

### Game rounds

Each `Wahuiboard` represents a round and stores:

- The winning board
- Four round-specific pantun clues
- Betting closing time
- Announcement time
- House bet board and amount

The reference catalog contains 37 board names from the game documentation. The mechanics document describes 20 boards being available in a given round; selecting that active subset is a future round-management feature.

## Current Routes

| Route | Purpose |
| --- | --- |
| `/` | Public home page |
| `/users/sign_up` | Player registration |
| `/users/sign_in` | Login |
| `/dashboard` | Authenticated player dashboard |
| `/admin` | Admin and House operator dashboard |

The admin routes for boards, users, and transactions are declared but their full controllers and views are not complete yet.

## Requirements

- Ruby 3.4+
- Bundler
- MySQL 8 or a compatible MySQL server
- ImageMagick/libvips support if image processing is needed

The project uses Rails 8.1, Devise, MySQL, Propshaft, Tailwind CSS Rails, Turbo, Stimulus, and Solid Queue/Cache/Cable.

## Local Setup

Install dependencies:

```bash
bundle install
```

Configure the database connection in `config/database.yml` or through the environment variables expected by that file. Then create the database, apply migrations, and load development data:

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

Start the development server:

```bash
bin/rails server
```

Open <http://127.0.0.1:3000>.

For the Rails development process file, use:

```bash
bin/dev
```

## Development Seed Data

`bin/rails db:seed` is idempotent for the included development records. It creates or promotes:

- Admin account: `admin@email.com`
- Fresh-install admin password: `123123`
- 37 reference boards
- One sample round named `Demo Round 001`
- Four clues associated with that round

Change the development admin password immediately when using a shared environment. Do not use the seeded credentials outside local development.

## Data Model

- `User`: Devise authentication and role (`player`, `house_operator`, `risk_manager`, or `admin`)
- `Board`: A selectable board in the reference catalog
- `Wahuiboard`: A game round, winning board, schedule, and house bet
- `Synonym`: A clue associated with a game round
- `Wallet`: Intended player balance container
- `WahuiTransaction`: Intended record for wagers, payouts, deposits, and withdrawals

The current authentication schema uses Devise's `encrypted_password` column. The older `password_digest` column remains for now and is not used by Devise.

## Game Flow

1. The House creates a round and chooses the winning board.
2. The House publishes four pantun clues and a house bet.
3. Players choose a board and place bets while the round is open.
4. Betting closes at `betting_closing_time`.
5. The result is announced at `announcement_time`.
6. The payout process distributes eligible winnings and records transactions.

The betting lockout, wallet mutations, payout calculation, and audit trail must be enforced server-side before real-money use. A client-side countdown is only a presentation aid.

## Commands

```bash
bin/rails routes
bin/rails console
bin/rails db:migrate
bin/rails db:seed
bin/rubocop
bin/brakeman
bin/bundler-audit
```

The repository currently has no comprehensive automated test suite. New betting, wallet, payout, and authorization behavior should receive model/request tests before being exposed to users.

## Planned Work

- House interface for creating and publishing rounds
- Active board selection per round
- Player board selection and wager placement
- Betting close enforcement and round state transitions
- Wallet deposits and withdrawals
- Pool payout calculation and payout jobs
- Immutable financial transaction auditing
- Admin user and role management
- Automated tests for authorization, balances, betting deadlines, and payouts

## Responsible Launch Requirements

This application is intended for a gambling product and must not be deployed for real-money use until the operator has completed the legal and operational work required for the target jurisdiction. That includes licensing, age and identity checks, responsible-gambling controls, payment compliance, fraud prevention, secure audit logging, privacy requirements, and independent testing of payout and balance logic.

## Documentation

- [Game mechanics](docs/mechanics.md)
- [Wahuiboard data model](docs/wahuiboards.md)
