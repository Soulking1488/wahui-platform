# Signature from API Get Method

For API that uses `GET` method such as, Check Status API, merchant don't need to generate a `Digest.`


1. Arrange the signature components to one component and its value per line by adding  escape character. Don't add  at the end of the string. Sample of the raw format:

```js
Client-Id:MCH-0001-10791114622547\nRequest-Id:d895fb53-479c-4f77-a76a-ab81b40d77cb\nRequest-Timestamp:2020-08-11T08:45:42Z\nRequest-Target:/orders/v1/status/INV-123123-12313
```

This is how merchant see it : 

```js
Client-Id:MCH-0001-10791114622547
Request-Id:d895fb53-479c-4f77-a76a-ab81b40d77cb
Request-Timestamp:2020-08-11T08:45:42Z
Request-Target:/orders/v1/status/INV-123123-12313
```

2. Calculate HMAC-SHA256 base64 from all the components above using the Secret Key from DOKU Back Office.

3. Put encoded value and prepend`HMACSHA256=` to the `Signature` Sample:


```js
Signature: HMACSHA256=B1cKBzk/aB1AXADCZkq135bnktxY1o02zmmdd2cVgf12=
```