# Generating Signature

After all the Signature component has been set, merchant can now generate it:

1. Arrange the signature components to one component and its value per line by adding  escape character. Don't add  at the end of the string. Sample of the raw format:
```js 
BRN-0239-1709018494325\n2026-08-11T06:39:29Z\n/v3/payments\nkouJDoOZUOcxBcR2TFN5ehxSDcjiPydf8V4uJBywFJ0=
```

This is how merchant see it:
```js
BRN-0239-1709018494325
2026-08-11T06:39:29Z
/v3/payments
kouJDoOZUOcxBcR2TFN5ehxSDcjiPydf8V4uJBywFJ0=
```
2. Calculate HMAC-SHA256 base64 from all the components above using the Secret Key from DOKU Back Office
3. Put encoded value and prepend HMACSHA256= to the Signature. Sample:

```js 
Signature: HMACSHA256=X78G6dJOsfFS5KjPbN9Y0iQ8ZMkadT0UZFzGwHTACHE=
```
