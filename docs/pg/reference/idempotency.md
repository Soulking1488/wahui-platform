Technical Reference
Idempotency
Idempotency Requests
DOKU Global API supports idempotency, which allows merchants to safely retry requests without triggering duplicate processing. Idempotency ensures that when the same request is sent multiple times, the system treats it as a single operation and always returns the same result as the first attempt.
The idempotency layer compares incoming payload to those of the original request and errors if they’re not the same to prevent accidental misuse. Subsequent requests with the same key and payload (digest) return the same result, including http code 409 conflicts.
DOKU only verified the keys for last 24 hours old and we suggest using V4 UUIDs to generate the Id, or another random string with enough entropy to avoid collisions. Idempotency keys are up to 255 characters long.