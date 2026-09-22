# Credit Card Acquirer Response Code

The table below shows all Credit Card acquirer response codes categorized by response type, category, and applicability.

| Acquirer Response Code | Description | Category |
| :--- | :--- | :--- |
| 00 | Approved or completed successfully | Issuer approved |
| 01 | Refer to card issuer, Contact card issuer | Generic response codes |
| 02 | Refer to card issuer - Special conditions | Generic response codes |
| 03 | Invalid merchant | Issuer cannot approve at this time |
| 04 | Pick up card (no fraud) | Issuer will never approve |
| 05 | Do not honor | Generic response codes |
| 06 | Error (applies for VISA) | Generic response codes |
| 07 | Pickup card, special conditions (applies for VISA) | Issuer will never approve |
| 08 | Honor with ID (applies for VISA) | Issuer approved |
| 10 | Partial value approved | Generic response codes |
| 11 | Approved V.I.P (applies for MASTERCARD) | Issuer approved |
| 12 | Invalid transaction | Issuer will never approve |
| 13 | Invalid value/amount | Generic response codes |
| 14 | Invalid card number | Issuer will never approve |
| 15 | No such issuer | Issuer will never approve |
| 19 | Re-enter transaction (applies for VISA) | Issuer cannot approve at this time |
| 21 | No action taken (applies for VISA) | Generic response codes |
| 25 | Unable to locate record on file (applies for VISA) | Generic response codes |
| 28 | File is temporarily unavailable (applies for VISA) | Generic response codes |
| 30 | Format error (applies for MASTERCARD) | Generic response codes |
| 39 | No credit account (applies for VISA) | Issuer cannot approve at this time |
| 41 | Lost card - pick up | Issuer will never approve |
| 43 | Stolen card - pick up | Issuer will never approve |
| 46 | Closed Account (applies for VISA) | Issuer will never approve |
| 51 | Insufficient funds | Issuer cannot approve at this time |
| 52 | No checking account (applies for VISA) | Issuer cannot approve at this time |
| 53 | No savings account (applies for VISA) | Issuer cannot approve at this time |
| 54 | Expired card | Issuer cannot approve based on details provided |
| 55 | Incorrect PIN | Issuer cannot approve based on details provided |
| 57 | Transaction not permitted to cardholder | Issuer will never approve |
| 58 | Transaction not permitted to terminal | Generic response codes |
| 59 | Suspected fraud | Issuer cannot approve at this time |
| 61 | Exceeds withdrawal amount limits | Issuer cannot approve at this time |
| 62 | Restricted card | Issuer cannot approve at this time |
| 63 | Security Violation | Issuer cannot approve based on details provided |
| 64 | Transaction does not fulfill AML requirement (applies for VISA) | Generic response codes |
| 65 | Exceeds withdrawal frequency limit | Issuer cannot approve at this time |
| 70 | Contact Card Issuer (applies for MASTERCARD) | Issuer cannot approve at this time |
| 70 | PIN data required (applies for VISA) | Issuer cannot approve based on details provided |
| 71 | PIN not changed (applies for MASTERCARD) | Issuer cannot approve at this time |
| 74 | Different value than that used for PIN encryption errors | Generic response codes |
| 75 | Allowable PIN tries exceeded | Issuer cannot approve at this time |
| 76 | Invalid/nonexistent “To Account” specified (applies for MASTERCARD) | Generic response codes |
| 76 | Unsolicited reversal (applies for VISA) | Generic response codes |
| 77 | Invalid/nonexistent “From Account” specified (applies for MASTERCARD) | Generic response codes |
| 78 | Blocked card, first time card usage (applies for VISA) | Issuer cannot approve at this time |
| 78 | Invalid/nonexistent account specified (applies for MASTERCARD) | Generic response codes |
| 79 | Life Cycle (applies for MASTERCARD) | Generic response codes |
| 79 | Already reversed by Switch (applies for VISA) | Generic response codes |
| 80 | Credit issuer unavailable (applies for MASTERCARD) | Generic response codes |
| 80 | No financial impact (applies for VISA) | Generic response codes |
| 81 | Domestic Debit Transaction Not Allowed (applies for MASTERCARD) | Generic response codes |
| 81 | Cryptographic error found in PIN (applies for VISA) | Generic response codes |
| 82 | Negative CAM, dCVV, iCVV, or CVV results (applies for VISA) | Issuer cannot approve based on details provided |
| 82 | Policy (applies for MASTERCARD) | Generic response codes |
| 83 | Fraud/Security (applies for MASTERCARD) | Generic response codes |
| 84 | Invalid Authorization Life Cycle (applies for MASTERCARD) | Generic response codes |
| 85 | No reason to decline | Issuer approved |
| 86 | Cannot verify PIN | Issuer cannot approve at this time |
| 87 | Purchase amount only, no cash back allowed (applies for MASTERCARD) | Issuer approved |
| 88 | Cryptographic failure (applies for MASTERCARD) | Generic response codes |
| 89 | Unacceptable PIN (applies for MASTERCARD) | Generic response codes |
| 89 | Ineligible to receive financial position information (applies for VISA) | Generic response codes |
| 90 | Cutoff is in progress (applies for MASTERCARD) | Generic response codes |
| 91 | Issuer or switch is inoperative | Issuer cannot approve at this time |
| 92 | Destination cannot be found for routing | Generic response codes |
| 93 | Transaction cannot be completed - violation of law (applies for VISA) | Issuer cannot approve at this time |
| 94 | Duplicate transmission / invoice | Generic response codes |
| 96 | System malfunction | Issuer cannot approve at this time |
| RJ | Decision Black List CC | Issuer cannot approve based on details provided |
| DA | Declined Authentication | Issuer cannot approve at this time |
| TO | Timeout | Issuer cannot approve at this time |
| 1A | Authentication required (applies for VISA) | Issuer cannot approve based on details provided |
| 6P | Verification data failed (applies for VISA) | Generic response codes |
| B1 | Surcharge amount not permitted (applies for VISA) | Generic response codes |
| B2 | Surcharge amount not supported by debit network issuer (applies for VISA) | Generic response codes |
| N0 | Force STIP (applies for VISA) | Generic response codes |
| N3 | Cash service not available (applies for VISA) | Issuer cannot approve at this time |
| N4 | Cash request exceeds issuer or approved limit (applies for VISA) | Issuer cannot approve at this time |
| N5 | Ineligible for resubmission (applies for VISA) | Generic response codes |
| N7 | Decline for CVV2 failure (applies for VISA) | Issuer cannot approve based on details provided |
| N8 | Transaction amount exceeds preauthorized approval amount (applies for VISA) | Generic response codes |
| P5 | Denied PIN unblock (applies for VISA) | Generic response codes |
| P6 | Denied PIN change (applies for VISA) | Generic response codes |
| Q1 | Card Authentication failed (applies for VISA) | Generic response codes |
| R0 | Stop Payment Order (applies for VISA) | Issuer will never approve |
| R1 | Revocation of authorization order (applies for VISA) | Issuer will never approve |
| R2 | Transaction does not qualify for Visa PIN (applies for VISA) | Generic response codes |
| R3 | Revocation of all authorizations order (applies for VISA) | Issuer will never approve |
| Z3 | Unable to go online (applies for VISA) | Generic response codes |
| 1Z | Authorization System or issuer system inoperative (applies for MASTERCARD) | Generic response codes |