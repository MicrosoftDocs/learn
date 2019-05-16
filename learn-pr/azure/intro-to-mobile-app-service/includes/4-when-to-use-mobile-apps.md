Here, we'll discuss when to use Mobile Apps in Azure App Service to support a mobile client app.

## When to use Mobile Apps in Azure App Service

Mobile Apps in Azure App Service help you provide authentication, authorization, data synchronization and push notifications for mobile client apps.

| | |
| --- | --- |
| **Data** | Mobile Apps is most valuable when you need to manage, store, and synchronize user data.  |
| **Data sync** | The key question to ask when you're considering Mobile Apps is _"do I need to sync data between the mobile client and a backend service?"_ Mobile Apps is ideal when you're providing two-way data transfers. If all of the data remains on the client app, you may not need a backend service. |
| **Authentication** | Are you storing or presenting sensitive data? Do you need to authenticate a user before giving them access to data or the client app? Verifying identity can be done using on-device biometrics, but using an OAuth identity provider allows you to verify users without relying on local hardware capabilities. |
| **Cross-platform** | Will your mobile client app run on multiple platforms? The Mobile Apps SDK provides a consistent API across mobile platforms, reducing the porting time and learning curve to implement authentication, data-sync, and notifications. |
| **Integration** | Will you integrate your mobile app with other cloud services? Using Azure App Service allows you to connect and extend your Mobile Apps to send and receive data from other services like power apps, serverless or IoT. |
| **Push Notifications**  | If you plan to use push notifications, especially if you're targeting multiple mobile client platforms, App Service's integration with Notification Hubs can help streamline integrating push notifications and sending notifications.  | 
|   |   |

Mobile Apps helps streamline these features when targeting multiple mobile client platforms like iOS and Android. It's also a great foundation for integrating with other Azure cloud services.