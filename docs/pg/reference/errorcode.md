# Error Code

When something goes wrong, we return a structured error code and message to help you quickly identify the cause. This lets you:

1. Troubleshoot faster
2. Implement proper fallbacks
3. Improve user experience
4. Build predictable logic flows

We categorize errors by type so you know the exact next step to take.

## Authetication & Signature
| Code | Http Status | Description |
| --- | --- | --- |
| unauthorized | 401 | Authentication failed. Please provice a valid API key or token |
| invalid_signature | 401 | Invalid Signature, please check the signature components |
| api_key_missing | 401 | API Key is required but was not provided |
| signature_missing | 400 | Signature is required but was not provided |
| request_timestamp_invalid | 400 | Request-Timestamp is missing or outside the allowed range. |
| expired_token | 401 | Access token has expired. Please re-authenticate |
| forbidden | 403 | You do not have permission to access this resource |
| ip_not_allowed | 403 | Your IP address is not allowed to access this resource |
| account_locked | 403 | Your account has been locked due to multiple failed login attempts. |
| api_key_revoked | 403 | API Key has been revoked. |

## Idempotency & Concurrency
| Code | Http Status | Description |
| --- | --- | --- |
| idempotency_id_required | 400 | Idempotency key is required for this request |
| idempotency_id_conflict | 409 | Duplicate request with the same idempotency id |
| concurrent_modification | 409 | Concurrent update detected in the resource. Try again. |

## Request Validation
| Code | Http Status | Description |
| --- | --- | --- |
| invalid_request | 400 | The request is malformed or missing required parameters. |
| missing_parameter | 400 | Required paramater {param} is missing. |
| invalid_parameter | 400 | Parameter {param} has invalid value or format. |
| invalid_query_param | 400 | One or more query parameters ar invalid. |
| invalid_json | 400 | Request body must be valid JSON. |
| payload_too_large | 400 | Request payload is too large |
| unsupported_media_type | 400 | Content-Type must be application/json. |

## Transaction & Payment Errors
| Code | Http Status | Description |
| --- | --- | --- |
| transaction_not_found | 404 | Transaction with the given ID does not exist | 400 |
| transaction_failed | 400 | Transaction failed to process |
| transaction_already_paid | 400 | The Transaction has already been paid |
| duplicate_transaction | 400 | A transaction with the same reference already exists. |
| payment_channel_unavailable | 404 | Selected payment channel is currently unavailable |
| insufficient_funds | 400 | Payment failed due to insufficient balance |
| card_declined | 400 | Card was declined by the issuing bank. |
| invalid_card_number | 400 | The card is expired |
| expired_card | 400 | Provided card number is not valid |
| payment_timeout | 408 | Payment processing timed out. Please try again |
| currency_not_support | 400 | The selected currency is not supported |

## Complience & Risk
| Code | Http Status | Description |
| --- | --- | --- |
| fraud_suspected | 403 | Transaction is suspedted to be fraudulent. |

## Merchant & Account Errors
| Code |Http Status| Description |
| --- | --- | --- |
| invalid_client_id | 404 | Client Id is not registered. |
| inactive_client_id | 403 | Client Id is inactive or suspended. |

## Webhook & Callback Errors
| Code | Http Status | Description |
| --- | --- | --- |
| webhook_url_invalid | 400 | Provided webhook URL is invalid or unreachable |
| webhook_failed | 400 | Webhook delivery failed |


## System/Internal Errors
| Code | Http Status | Description |
| --- | --- | --- |
| internal_server_errors | 500 | An unexpected error occured on the server. |
| service_unavailable | 503 | The service is temporarily unavailable. Please try again later.
| timeout_error | 504 | The request timed out while processing. |

## Rate Limiting & Quotas
| Code | Http Status | Description |
| --- | --- | --- |
| rate_limit_exceeded | 429 | Too many requests. Please slow down. |
| quota_exceeded | 429 | Your usage quota has been exceeded |


