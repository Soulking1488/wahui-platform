# Order & Transaction Status

:::warning[]
Order Status will explain regarding the status of a Checkout Order. If you use Payment API, then just use Transaction Status.
:::

| Status | Description |
| --- | --- |
| PENDING | Checkout Order is generated and pending to be paid |
| EXPIRED | Checkout Order is already expired |
| PAID | Checkout Order is successfully paid |


# Transaction Status
:::info[]
You only require to validate payment status using the **`status`** attribute. The **`state`** attributes provides additional detailed information about the status.
:::

## Internet Banking FPX

| Status | State | Description |
| --- | --- | --- |
| PENDING | INITIATE | Initiation or create payment state  |
| PENDING | WAITING_APPROVAL | waiting approval for payment B2B  |
| PENDING | WAITING_VERIFICATION | payment pending from processor (e.g., acquirer) |
| SUCCESS | COMPLETED | Order fully paid by  | 
| FAILED | COMPLETED | Failed processing payment |
| EXPIRED | COMPLETED | Order was expired |

## Touch 'n Go
| Status | State | Description |
| --- | --- | --- |
| PENDING | INITIATE | Initiation or create payment state  |
| PENDING | WAITING_VERIFICATION | payment pending from processor (e.g., acquirer) |
| SUCCESS | COMPLETED | Order fully paid by  | 
| FAILED | COMPLETED | Failed processing payment |
| EXPIRED | COMPLETED | Order was expired |

## GrabPay
| Status | State | Description |
| --- | --- | --- |
| PENDING | INITIATE | Initiation or create payment state  |
| PENDING | WAITING_VERIFICATION | payment pending from processor (e.g., acquirer) |
| SUCCESS | COMPLETED | Order fully paid by  | 
| FAILED | COMPLETED | Failed processing payment |
| EXPIRED | COMPLETED | Order was expired |

## ShopeePay
| Status | State | Description |
| --- | --- | --- |
| PENDING | INITIATE | Initiation or create payment state  |
| PENDING | WAITING_VERIFICATION | payment pending from processor (e.g., acquirer) |
| SUCCESS | COMPLETED | Order fully paid by  | 
| FAILED | COMPLETED | Failed processing payment |
| EXPIRED | COMPLETED | Order was expired |

## Cards

:::warning[Cards Transaction Status]
Currently Cards channel will not have `state` since using different API Specification

In the future, Cards channel will have the same API Specification with other Channels.
:::

| Name | Description  | Final Status | Merchant Action | 
| --- | --- | --- | --- |
| PENDING | Transaction is waiting to be paid by the customer | No | Wait for HTTP Notification or Call Check Status API to get final status |
| REDIRECT | Transaction is waiting for acquirer verification | No | Wait for HTTP Notification or Call Check Status API to get final status |
| FAILED | Transaction is failed to be paid | No | Generate new payment request to DOKU |
| SUCCESS | Transaction is paid by the customer | Yes | - |
| REFUNDED | Transaction fund is refunded to merchant | Yes | - |

