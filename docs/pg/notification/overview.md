# Overview

DOKU uses HTTP Notification to notify your application when an event happens in your account. HTTP Notification particularly useful for asychronous events such as when your customer completes the payment process for Cards. Not all DOKU integration require HTTP Notification. Keep reading to learn more about what HTTP Notification is and when you should use them.

What is HTTP Notification?
HTTP Notification is a notification that DOKU send to notify your application for certain events. Basically, you need to setup an endpoint on your side to receive the notification, which could be written in Java, PHP, Python, Node.js, or anything. The HTTP Notification endpoint has an associated URL (e.g., https://your-domain.com/notifications/payments).

DOKU will send the notification body in JSON format, therefore you can parse it with JSON parser. Please mind that DOKU might add new fields in the notification body in order to cover new use cases in our notification service, you are suggested to parse it in non strict format. This prevents the parser from throwing an error or exception for new fields.

After setting up your Notification URL, we will send the notification for certain events such as when the Credit Card has been charged, Credit Card failed, and etc.

Once the customers finish the payment, DOKU will send the notification to your defined Notification URL.

:::warning[Cards Notification]
Currently Cards will have a different notification body since using different API Specification, learn more the Cards Sample Notification [here](https://doku-developers.apidog.io/sample-notification-cards-42667320e0.md).

In the future, Cards channel will have the same specification with other Channels.
:::