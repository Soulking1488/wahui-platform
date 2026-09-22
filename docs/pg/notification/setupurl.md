# Setup Notification URL

To get notified by DOKU, you must setup the Notification URL on DOKU Back Office on Webhook Menu. For security reason, we encourage you to use https:// URL protocol prefix.

> <TipInfo> **NOTIFICATION URL MUST BE ABLE ACCESSED FROM INTERNET** </TipInfo> Make sure to input Notification URL that can be reached from Public Internet. DOKU will not be able to send notification to localhost, URL protected with authentication, URL behind VPN, unusual destination port, and etc.

## **Setting Up a Webhook for Payment Notification URL**

Follow the steps below to configure your webhook so you can receive real-time payment notifications from DOKU:

1. First, open the DOKU Back Office, go to Settings, and select the Webhook menu.

![Screenshot 2025-11-25 at 16.28.11.png](https://api.apidog.com/api/v1/projects/1033353/resources/366488/image-preview)
    

![Screenshot 2025-11-25 at 16.29.00.png](https://api.apidog.com/api/v1/projects/1033353/resources/366489/image-preview)

2. Next, click Create Webhook to add a new webhook configuration. Currently, the webhook only supports the Payment Notification event.

![Screenshot 2025-11-25 at 16.31.02.png](https://api.apidog.com/api/v1/projects/1033353/resources/366490/image-preview)

3. You will be directed to the webhook detail page. Fill in the following fields:

- Description – A brief note to help identify this webhook.

- URL Endpoint – Your URL Endpoint Address that will receive payment notifications.

- Payment Channel – Select the payment channel you want to enable.

**Note: Only active payment channels are displayed in the list.**

![Screenshot 2025-11-25 at 16.31.54.png](https://api.apidog.com/api/v1/projects/1033353/resources/366491/image-preview)

4. After all fields are completed, click Save to store the webhook configuration. The system will validate the input and perform the save process.

![Screenshot 2025-11-25 at 16.39.44.png](https://api.apidog.com/api/v1/projects/1033353/resources/366495/image-preview)

5. If successful, a confirmation pop-up will appear stating that the webhook has been saved. Your new webhook will be added to the existing webhook list.


![Screenshot 2025-11-25 at 16.43.14.png](https://api.apidog.com/api/v1/projects/1033353/resources/366497/image-preview)

6. Please note that each payment channel can only be linked to one URL Endpoint. This means if a payment channel is already used in another webhook, that channel will no longer appear when you create a new webhook.

![Screenshot 2025-11-25 at 16.41.55.png](https://api.apidog.com/api/v1/projects/1033353/resources/366496/image-preview)