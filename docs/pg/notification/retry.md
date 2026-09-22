# Retry Notification

Your `Notification URL` must response with HTTP status `2xx` to confirm the transaction notification is received. 

If your URL doesn't respond with this status, we'll make 3 attempts to deliver the HTTP Notification. We'll stop retrying once we receive a response from your server or if there's still  no response.


| No | Interval from previous attempts| Interval from original attempts |
| --- | --- | --- |
| 1 | 30 minutes | 30 minutes |
| 2 | 5 hours 30 minutes | 6 hours |
| 3 | 11 hours 30 minutes | 12 hours |



## **Manual Retry Notification**
If you wish to do manual retry for the notification, follow the steps given below:

1. Login to DOKU Back Office

2. Go to Menu Integration >  HTTP Notification

3. Find the notification that you want to try, you could utilize the filter

4. Click the retry icon (plane) to resend the notification

![image.png](https://api.apidog.com/api/v1/projects/995527/resources/360042/image-preview)

5.  Notification successfully published!