# Signature Component from Request Header


:::warning[Signature for Cards Payment]
This type of signature is only for API under the Cards Payment, for other APIs please refer to the Signature - Global
:::

**To generate a Signature in request header, merchant need to prepare these components:**

```js
Client-Id:value
Request-Id:value
Request-Timestamp:value
Request-Target:value
Digest:value
```

## **Component Explanation**

| No |Component Name| Description |
| --- | --- | --- |
| 1 | `Client-id` | Retrieved from the Request Header |
| 2 | `Request-id`| Retrieved from the Request Header |
| 3 | `Request-Timestamp` | Retrieved from the Request Header|
| 4 | `Request-Target` | The path of the endpoint that will be hitted e.g: /credit-card/v1/payment-page. NOTE: For the `HTTP Notification` from DOKU to merchant server, this will be the path of merchant `Notification URL`. As for the `Inquiry Request`, this will be the path of merchant `Inquiry URL` |
| 5 | `Digest` | Encoded (base64) value of hashed (SHA-256) JSON body. This component only applied for `POST `Method.|

## **Preparation**
Before generating `Signature`, merchant need to prepare all the component required.

**Set Client-Id, Request-Id, Request-Timestamp.**

Use the Client-Id, Request-Id, Request-Timestamp that is placed on the Request Header.

**Set Request-Target**

The Request-Target is depending on who is sending the request:

1. When merchant hits DOKU endpoints: The Request-Target is the path of the DOKU API that merchant hits.
For instance, if merchant wants to hit DOKU Cards API: `https://api.doku.com//credit-card/v1/payment-page`. Therefore, the Request-Target value is `/credit-card/v1/payment-page`.

2. When DOKU hits merchant endpoints **(HTTP Notification / Inquiry Request)**: The Request-Target is the path of merchant `Notification URL` or the `Inquiry URL`.
For instance, if merchant set the `Notification URL`: `https://yourdomain.com/payments/notifications`. Therefore, the Request-Target value is `/payments/notifications.`

**Generate Digest**

`Digest` is the hashed of the request body. To generate the `Digest`:

1. Calculate SHA256 base64 hash from the JSON Body

## **Generating Signature**

After all the Signature component has been set, merchant can now generate it:

1. Arrange the signature components to one component and its value per line by adding  escape character. Don't add  at the end of the string. Sample of the raw format:


```js
Client-Id:MCH-0001-10791114622547\nRequest-Id:cc682442-6c22-493e-8121-b9ef6b3fa728\nRequest-Timestamp:2020-08-11T08:45:42Z\nRequest-Target://credit-card/v1/payment-page\nDigest:5WIYK2TJg6iiZ0d5v4IXSR0EkYEkYOezJIma3Ufli5s=
```

This is how merchant see it:

```js Client-Id:MCH-0001-10791114622547
Request-Id:cc682442-6c22-493e-8121-b9ef6b3fa728
Request-Timestamp:2020-08-11T08:45:42Z
Request-Target:/credit-card/v1/payment-page
Digest:5WIYK2TJg6iiZ0d5v4IXSR0EkYEkYOezJIma3Ufli5s=
```

2. Calculate HMAC-SHA256 base64 from all the components above using the Secret Key from DOKU Back Office
3. Put encoded value and prepend HMACSHA256= to the Signature. Sample:

```js 
Signature: HMACSHA256=OvIRJs/jH8BIcGsktr4d8nnYtxY6E0Uzdm9d1GVgv5s=
```
