# Prepare Signature Component

## Calculation DOKU Global API Signature
### Components
- **DOKU Secret Key**: is a unique string for each API Key created at DOKU. The secret key is like a password, and is transmitted only as part of the calculated signature. 

- **Timestamp**: The header time was generated (UTC ISO 8601 format) when send request or receive response. Used to prevent replay attacks.

- **Request Path**: The path of the endpoint that will be hitted e.g: /v2/payment. NOTE: For the HTTP request from DOKU to merchant server, this will be the path of merchant URL. As for the Webhook Payment Request, this will be the path of merchant Webhook URL.

- **Digest**: Encoded (base64) value of hashed (SHA-256) JSON body. This component only applied for http method POST, PATCH.

### Construct The Component
Define a strict order to construct signature component and separate it with a new line

#### Request Signature
```bash
"Client-Id" Header 
"Request-Timestamp" Header 
"Request Path"
"Digest" of request body
```

#### Response Signature
```bash
"Client-Id" Header 
"Response-Timestamp" Header 
"Digest" of response body
```

## Do & Don't
- <Icon icon="material-outline-cancel" color="red"/> Don't deserialized request body to build the digest (*e.g: beutify the json*), use request body as it is from DOKU.
- <Icon icon="material-outline-cancel" color="red"/> Don't share secret key to anyone.
- <Icon icon="material-outline-cancel" color="red"/> Don’t expose secret key on a website or embed it in a mobile application.
- <Icon icon="material-outline-check_circle" color="green"/> Do ensure secret key are encrypted prior to storage.
