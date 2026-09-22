# Authentication & API Keys

### Environments and Keys

DOKU provides two separate environments:

| Environment | Purpose | Base URL |
| --- | --- | --- |
| Sandbox | For testing and integration | https://api-sandbox.doku.com |
| Production | For real transactions | https://api.doku.com |

Each environment uses its own set of credentials and API keys. You’ll receive both after registering your merchant account.

### Types of Credentials

After registration, you will get the following credentials for each environment:

| Credential Name | Description |
| --- | --- |
| Client ID | Unique Identifier to associate your API Request with your merchant account |
| Secret Key | Used to generate signature & access tokens |
| API Key | Provided by DOKU, used for access the API endpoints by including it as an user on Authorization header.|

:::info[Notes for API Key]
- The API-Key will be used as a credential to authenticate requests at DOKU's API endpoints. You will use this API-Key as a username in the Basic Authentication scheme when making API calls. 
- Please ensure the Authorization header is formatted correctly as follows:  `Authorization: Basic BASE64_ENCODED(API-Key:)`
- Please ensure to add a colon (:) after the API-Key before encoding it in Base64 format. This indicates that there is no password associated with the API-Key.
- Example: If your API-Key is "your_api_key", the string to be encoded in Base64 would be "your_api_key:". be provided to you upon registration or request from DOKU's support team.
- Keep it secure and do not share it publicly, as it grants access to your DOKU account and its associated services.
:::