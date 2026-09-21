# Wahuiboards Documentation

## Overview

The `Wahuiboard` model is the central component for managing game rounds in the Wahui Online application. Each `Wahuiboard` record represents a single game round and holds all the necessary information related to that round, from the clues and betting times to the final results and house bet.

## Attributes

A `Wahuiboard` has the following key attributes:

*   **Winning Board:** A reference to the `Board` that is the winning board for the round.
*   **Pantun Clues:** A set of four rhyming phrases (*Pantun*) that serve as the clue for the round. These are stored as `Synonym` records associated with the `Wahuiboard`.
*   `betting_closing_time` (datetime): The time at which betting for the round closes.
*   `announcement_time` (datetime): The time at which the results of the round are announced.
*   `house_bet_board_id` (integer): The ID of the board the house is betting on (the winning board).
*   `house_bet_amount` (decimal): The amount of the House Bet for the round.

## Associations

*   `has_many :synonyms`: A `Wahuiboard` has many `Synonym` records, which represent the *Pantun* clues for the round.
*   `belongs_to :board`: A `Wahuiboard` belongs to a `Board`, which is the winning board for the round.

## Role in the Game Cycle

The `Wahuiboard` is created by an administrator (the "House") at the beginning of each game round. The administrator sets the winning board, the clues, the betting times, and the House Bet. Once the `betting_closing_time` is reached, no more bets are accepted. After the `announcement_time`, the results are revealed, and the payout process is initiated based on the information stored in the `Wahuiboard`.

## Board Reference

| Board Number | Board Name       | Synonyms                                                                                                                            |
|--------------|------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| 1            | IKAN BESAR       | Juara, Ketua, Ikan Duyung, Sendiri tiada kawan.                                                                                     |
| 2            | BUAYA            | Kasut, baju, gunting, arak, pisau, cukur, buaya darat, tukang kasut/gunting, kopi, cap buaya, barang-barang kulit, bujang senang, pengurat, pendiam dan bahaya. |
| 3            | SIPUT            | Cincin, bertunang, kahwin tiga, puting susu, pelukis, lembab.                                                                        |
| 4            | ITIK             | Syabuh, penagih, pondan, orang lepak, kipas angin, kicap, cerek, donald duck.                                                        |
| 5            | MERPATI          | Padi/beras, burung surat, postman, rumah jeneral 5 bintang, cili padi, keladi, tangan, pelacur, pos laju, bersalaman, perindu bulan, sarang burung, telepon. |
| 6            | SINGA            | Ubat nyamuk, singa laut, raja rimba, passport, pelarian, orang asing, pondan, keterangan diri, kad pengenalan, singa-singa, hong kong, shanghai bank, singapura, pink panther. |
| 7            | ARNAB/BULAN      | Arnab, masjid, playboy, bintang, seluar, bola, kuih bulan, perayaan cina/hari raya, ilmu, pen, hari minggu, lambang, datang kotor, ambulans. |
| 8            | BABI HIDUP       | Cermin mata, telefon, orang buta, pakistan, bisaya naik kapal, timor, orang terkenal, basikal, motorsikal orang kenamaan, rantai babi, pengotor, pembawa penyakit, hodoh. |
| 9            | HARIMAU          | Harimau belang, tiger balm, kereta, topi, bank, shell minyak, tiger beer, lukcy nine, perempuan bunting, maybank.                  |
| 10           | LEMBU            | Sapi, budak, susu, gugur anak luar nikah, buang anak, bas.                                                                          |
| 11           | SYAITAN          | Arak, hantu pontianak, kayu ara, balan-balan, mayat, hantu bangkit.                                                                   |
| 12           | GAJAH            | Jam, masa/waktu, gajah laut, racun nyamuk, fumakila, tunggul mata, waktu rehat/makan, sarkas, curi masa, tidak berhenti.             |
| 13           | TIKUS            | Penjara, putri, daun terup, 13 daun, pia-pia, ikan lumahan, pulau tikus, pencuri kecil, tuan putri, banduan, mickey mouse.         |
| 14           | KUDA JANTAN      | Toto, kuda laut, senapang m-14, pistol, kuda kayangan, kuat.                                                                        |
| 15           | HARIMAU BINTANG  | Tentera, kapal terbang, kenderaan, barang jenama puma, billiard/snooker, makan angin/melancong, pantas, bintang filem, bintang dilangit. |
| 16           | PENYENGAT        | Doktor, senapang m-16, gula-gula, rumah/orang sakit, perempuan bermadu tiga, bunga, suntik.                                         |
| 17           | BABI MATI        | Panggang, orang mati, kuburan, babique, mayat, tidak bergerak.                                                                      |
| 18           | BANGAU           | Kerbau, burung bangau, rokok, pelangi, bidadari, orang susah, orang senang, mandur, pemalas, juragan kapal, kurang ajar, bongkak, jet, kapten. |
| 19           | KUCING           | Karan/elektrik, tv, radio, kabel, kaset, computer, curi karan, suluh, mata/balat, kucing, wirering, kucing sarawak, cakera padat(disc), pussy cat. |
| 20           | RAMA-RAMA        | Wang/duit, kupu-kupu, lampu pom, kunang-kunang, bendera amerika, perempuan yang menjual diri (pelacur).                               |
| 21           | LIPAN            | Emas, rantai leher, hakim, rasuah, casino, kereta api, benda-benda 21, kaki lipan.                                                  |
| 22           | KUDA BETINA      | Stc, kuda laut, pistol, kuda kayangan, pelacur.                                                                                     |
| 23           | PELACUR          | Bunga ros, tahan lasak, tidak jerak, duri.                                                                                          |
| 24           | MONYET           | Pisang, kelapa, polis, trafik, bomba, alarm, tanah pusaka, pencuri, penyapu, titian, bernasip malang, hodoh, bergunaan.             |
| 25           | PERAHU           | Katak, perahu layar, payung, hujan, orang laut, alarm, badan tahan, ombak, perahu syabu, seluar katak(dalam), hidup menyendiri(dalam tempurung). |
| 26           | KURA-KURA        | Penyu, sisir/sikat, petir, kalung, medal, lipas, kutu, kura-kura, strerika, motokar.                                                 |
| 27           | NAGA             | Api, tapekong cina, buddha, bola api, perahu naga, pusaka cina, dragon ball.                                                         |
| 28           | ANJING           | Polis, stout(bulldog), hot dog.                                                                                                     |
| 29           | AYAM JANTAN      | Sabung, matahari,kfc, ikan laut, bapa ayam, lintah darat.                                                                           |
| 30           | BELUT            | Lindung, meriam, bom, butu, bunga api, peluru berpandu, terima gaji, pelir.                                                          |
| 31           | IKAN KECIL       | Bendera, ikan sardin,memancing, tarikh hari merdeka, ikan piranha.                                                                   |
| 32           | ULAR BESAR       | Orang tua, tomgkat, intan, batu permata, night club, jalan raya, rajin, indian.                                                      |
| 33           | PAYAU            | Ular kecil, santa claus, christmas, pelanduk/kancil, pelancong, filem lucah, pintar.                                                 |
| 34           | UDANG            | Gitar, artis/penyanyi, karaoke, kepiting, ketam, belacan, undang-undang.                                                            |
| 35           | AYAMBETINA       | Labah-labah,.pukat, pelacur/ayam cari duit, perempuan malam, telur ayam, spiderman.                                                 |
| 36           | KAMBING          | Pondan, haji/imam, naik haji, bergantung anak, pakistan, arab.                                                                      |
| 37           | MUSANG           | Pencuri, lanun, superman, tandas, orang tua, kerapu, kubing.                                                                        |

## Game Rules

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

    **Formula:**winning bets (including the House Bet), and then multiplying that by each winner's individual stake.

    **Formula:**
*   **Required Metrics:** The application's backend must track the total wagered on all 19 losing boards and tally the total units/stakes placed by winning players and the House Bet amount.
*   **Fund Update:** Successful payouts update the player's wallet balance.

### B. Financial Transaction Mechanics

The application requires dedicated features to manage the player's wallet beyond just betting:

*   **Deposit Feature:** Required for players to add funds to their balance.
*   **Withdrawal Feature:** Required for players to cash out funds.
*   **Auditing:** A transaction logging mechanism is necessary to audit all fund movements, including deposits, withdrawals, wagers, and payouts, ensuring the integrity of the current balance.

## V. Future Development
LLM
The following features are mentioned in this document but are not yet implemented:

*   **Game Round Management:** An admin interface for the "House" to create and manage game rounds (selecting winning board, writing clues, setting timers, placing House Bet).
*   **Payout Administration:** A feature for an admin to trigger the payout process at the end of a round.
*   **Transaction Auditing:** An admin dashboard to view and audit all financial transactions.
*   **Withdrawal Feature:** A system for users to withdraw funds from their wallet.