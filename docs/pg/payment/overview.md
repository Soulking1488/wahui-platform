# Overview

The Payment API is a unified direct payment API that supports multiple payment channels through a single endpoint. Merchants specify the desired payment channel in the request payload, allowing full customization of the payment flow and user experience.

## Supported Payment Method
| Payment Channel | Payment Method | Value |
| --- | --- | --- |
| FPX | Internet Banking | `INTERNET_BANKING_FPX` |
| Touch 'n Go | E-Wallet | `EWALLET_TNG` |
| GrabPay | E-Wallet | `EWALLET_GRABPAY` |
| ShopeePay | E-Wallet | `EWALLET_SHOPEEPAY` |
| PayLater by Grab | BNPL | `BNPL_GRABPAY` |
| SPayLater | BNPL | `BNPL_SHOPEEPAY` |
| Atome | BNPL | `BNPL_ATOME` |


:::info[Cards Payment Channel]
Currently Cards channel aren't available on Payment API.

Cards channel will be supported in the future.
:::

## Integration Steps
### Payment API
```mermaid
sequenceDiagram
    participant C as Customer
    participant MS as Merchant System
    participant DAPI as DOKU API
    participant APP as Acquirer Payment Page
    
    alt Initiate Payment
    C->>MS: 1 Initiate Payment
    note over C,MS: For FPX, customer will chose the Bank and initiate payment
    MS->>DAPI: 1.1 Request Payment
    note over MS,DAPI: 🔹 Payment API, 
    DAPI->>MS: 1.2 Response with Redirect URL
    MS->>C: 1.3 Redirect to Acquirer Payment Page
    end

    alt Complete Transaction
    C->>APP: 2 Redirected to Acquirer Payment Page
    APP->>C: 2.1 Show Acquirer Payment Page
    C->>APP: 2.2 Complete Transaction
    end
    
    alt Redirect to Merchant Page
    APP->>DAPI: 3 Redirect to DOKU 
    DAPI->>MS: 3.1 Redirect to Merchant 
    MS->>C: 3.2 Merchant Page show result page Success/Fail (Callback URL)
    end
    
    alt Payment Notification
    APP-->>DAPI: 4 Notify transaction status
    DAPI-->>MS: 4.1 Notify transaction status 
    end
    
    alt [Optional] Retrieve Payment
    MS->>DAPI: 5 Hit Retrieve API
    note over MS,DAPI: 🔹 Retrieve API
    DAPI->>MS: 5.1 Response with Transaction Status
    end
```
Here is the overview of how to Payment API works:
1. **Initiate Payment**
Customer will trigger the Merchant System for Request Payment. Additionally, merchants can customize the transaction by sending several objects and parameter. Learn more about Payment API [here](https://doku-developers.apidog.io/create-payment-42667309e0.md). For FPX, merchant must request the Get Bank List API to get the `bank_code` and put it as a request on the Payment API.

2. **Complete Transaction**
After get response from DOKU Payment API, Merchant must handle the response and redirect the customers to acquirer payment page. Customer will complete the transaction on acquirer page, and the process is based on what payment methods that customer chose. 

3. **Redirect to Merchant Page**
Given that customer already complete the transaction, DOKU will redirect your customers to Callback URL that already set on the request.

4. **Payment Notification**
DOKU will send HTTP notification to the merchant side. Learn how to handle the notification from DOKU [here](https://doku-developers.apidog.io/5654146f0.md).

5. **[Optional] Retrieve Payment**
Besides receiving notification, merchant can use Retrieve Payment API to get the latest transaction status. Learn more [here](https://doku-developers.apidog.io/retrieve-payment-status-42667311e0.md).

### Get Bank List - FPX
```mermaid
sequenceDiagram
    participant C as Customer
    participant MS as Merchant System
    participant DAPI as DOKU API
    
    MS->>DAPI: Initiate Get Bank List
     note over MS,DAPI: 🔹 Get Bank List API
    DAPI->>MS: Return FPX Bank List
    MS->>C: Show FPX Bank List  
```
Get Bank List API will return the `bank_code` of  FPX Banks, either B2C or B2B Banks based on the payment `type` that the merchant request. Learn more about Get Bank List API [here](https://doku-developers.apidog.io/get-bank-list-fpx-42667310e0.md).

:::info[Mandatory for FPX]
This API will be mandatory if you use FPX as a payment method, because on the Payment API you are mandatory to include the `bank_code` if the payment channel is `INTERNET_BANKING_FPX`.
:::



