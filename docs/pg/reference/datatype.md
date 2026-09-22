# Data Type

DOKU defines standard data types to ensure consistent validation across all APIs. Below are the supported types and their patterns.

| Type | Pattern | Remarks |
| --- | --- | --- |
| Identity | `^[A-Za-z0-9-_]+` | sample usage for `reference_id`, `Idempotency-Id`
| Safe String | `^[a-zA-Z0-9.-/+,=_:'@%\|]` | will be use generally for all string attribute e.g: `name`, `metadata`, etc'


This ensures a predictable and secure structure for all request and response fields.