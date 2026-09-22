# Make your first API call

### Overview

This example helps you generate a hosted payment page using DOKU Checkout API, so your customer can pay via payment channels provided on Checkout Page, learn more [here](https://doku-developers.apidog.io/5559991f0.md).

No complexity. Just follow these 3 steps. Are you ready? let's start.

What You Need Before Starting
- ✅ Your Client ID
- ✅ Your Secret Key
- ✅ Your Authorization
- ✅ A tool like Postman or cURL 

<Icon icon="material-outline-info"/> No OAuth token needed — this API uses HMAC-SHA256 Signature in the headers to protect each request.


### Use Case
**Accepting a Payment with Checkout**
You want to send an invoice of MYR 100.25 to a customer, and let them pay via Checkout API.


### Step 1: Generating Signature
You can refer to [these](https://doku-developers.apidog.io/5726900f0.md) page for generating signature.

### Step 2: Prepare the Payload
As an example, we're gonna use the Checkout API. You can see the full API Documentation [here](https://doku-developers.apidog.io/create-checkout-42667307e0.md).

```js
{
    "id": "8fdC56eo-cC99-46E1-B6AC-4asD8755B25C",
    "order": {
        "amount": 100.25,
        "invoice_number": "INV-20210231-0001",
        "currency": "MYR",
        "line_items": [
            {
                "id": "24",
                "name": "Fresh flowers",
                "quantity": 1,
                "price": 90.05,
                "sku": "FF01",
                "category": "gift-and-flowers"
            },
            {
                "name": "SST",
                "quantity": 1,
                "price": 10.2,
            }
        ],
        "expired_at": "2025-10-03T22:22:25.333Z"
    },
    "checkout_experience": {
        "channels": [
            "EWALLET_TNG",
            "INTERNET_BANKING_FPX",
            "EWALLET_GRABPAY"
        ],
        "language": "EN",
        "auto_redirect": true,
        "retry_payment": {
            "enabled": true
        },
        "callback_url": "https://merchant.host/payment/callback",
        "callback_url_cancel": "https://young-thorn.biz/",
        "callback_url_result": "https://dim-starboard.net/"
    },
    "metadata": {
        "sample_key": "GOLD MEMBER"
    },
    "customer": {
        "id": "DOKU-CUSTOMER-001",
        "name": "John Doe",
        "email": "john.doe@sample.com",
        "phone": "+6091891918",
        "country": "MY",
        "address": "Street 1"
    },
    "device_info": {
        "platform": "WEB",
        "browser": "Chrome 91.0.4472.124",
        "os": "Android 13",
        "ip_address": "127.0.0.1"
    }
}
```

### Step 3: Send the Request


If the transaction is success, you’ll get this:

```js
{
    "id": "8fdC56eo-cC99-46E1-B6AC-4asD8755B25C",
    "order": {
        "amount": 100.25,
        "invoice_number": "INV-20210231-0001",
        "currency": "MYR",
        "expired_at": "2025-10-03T22:22:25.333Z"
    },
    "checkout_experience": {
        "channels": [
            "EWALLET_TNG",
            "INTERNET_BANKING_FPX",
            "EWALLET_GRABPAY"
        ],
        "language": "EN",
        "auto_redirect": true,
        "retry_payment": {
            "enabled": true,
        }
    },
    "payment": {
        "checkout_url": "https://sandbox.doku.com/checkout-link-v2/2ebffd22d23e436895ce5c38f7ddcf8620244712094712362",
        "type": "SALE",
        "status": "PENDING",
        "state": "INITIATE"
    },
    "customer": {
        "id": "DOKU-CUSTOMER-001",
        "name": "John Doe",
        "email": "john.doe@sample.com",
        "phone": "+6091891918",
        "country": "MY",
        "address": "Street 1"
    }
}
```

### Final Step: Redirect Your Customer

Send the customer to the checkout_url.
They’ll see a secure page where they can pay via payment channels provided.

✅ Done!

You just created your first DOKU Checkout payment!


### What’s Next?
1. Setup your Notification Endpoint URL to get notified when payment is completed. Learn more [here](https://doku-developers.apidog.io/setup-notification-url-2375709m0.md)
2. Try other amounts and invoice numbers.
3. Try our other APIs.
4. Ready to go live? Just swap to Production credentials.
