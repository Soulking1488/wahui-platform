Technical Reference
Authentication & Integrity
Authentication
To ensure secure access to DOKU’s APIs, all requests must be authenticated using an API key and Each environment uses its own set of API keys. Don’t expose this key on a website or embed it in a mobile application.
We require all API calls to include a valid authentication token checks. Think of this as the identity card and security seal of every request. With proper authentication, we can verify who is calling our API.
Integrity
Several API might required advance security in terms of integrity request and response. This aspect ensuring the data has not been tempered with or altered during transit. This keeps your transactions safe from tampering and unauthorized access.
The integrity will be implement on the "Signature" attribute on request or response headers. Follow this se