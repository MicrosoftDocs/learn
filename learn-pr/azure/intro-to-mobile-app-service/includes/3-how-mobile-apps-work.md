Now that we know the basics of Mobile Apps, let's see how it's used and integrated into a client mobile app.

## Backend service

At its core, Azure App Service is a cloud hosted Internet Information Service (IIS). Mobile Apps supports two options to define your IIS hosted backend logic: ASP.NET and node.js.

This provides both storage and compute resources. If needed, you can also create and publish a public facing website like you would with Azure App Service. This website can access to the same data and services provided to your mobile client.

### Mobile Apps hosting features

Because Mobile Apps is part of Azure App Service, you get all of the hosting benefits including:

- auto-scaling
- staging environments
- continuous deployments
- virtual networks

See the other modules in Microsoft Learn on Azure App Service for more information about hosting and publishing.

## Azure Mobile Apps SDKs

You're responsible for creating the mobile client app that leverages Mobile Apps backend services.

You can connect and parse data from the hosted Mobile App using standard networking classes and APIs on the client devices via standard web protocols (HTTP + JSON). As long as you know the published endpoints of your Mobile App in Azure App Service, you can interact with your service instance.

However, Microsoft publishes a set of client SDKs to interact with Mobile Apps on the Azure App Services platform. The SDK provides support to access all the features of the Mobile App service including:

- Authentication and authorization
- Data access
- Offline sync
- Push notifications

SDKs are published for iOS, Android, Xamarin, and Apache Cordova; all SDKs are open-source and available on GitHub.

### Authentication and authorization

Azure App Service provides authentication and authorization services that are also available in Mobile Apps. There are two approaches you can use to authenticate a user:
- use an SDK provided by the identity provider
- use the Mobile Apps client SDK

SDKs published by providers such as Facebook, Google or Microsoft will often come with an authentication experience that more tightly integrates with the operating system on the client device. For example, on iOS devices, users can sign in to Facebook on the device, and the OS will assist with authentication from the native application when requested by an iOS app. For example, for Facebook, authentication would be done through the Facebook app instead of browser based authentication. This will require you to install the provider's SDK and follow their documentation for authentication.

When using the Mobile Apps SDK, your users will use a webview on the client device to perform authentication. Implementing authentication is greatly simplified when using the Mobile Apps SDK; typically authentication can be accomplished with a single line of code. The SDK will manage the OAuth flow including retrieving and storing authorization tokens.

The Microsoft client SDK can also be used for corporate sign-in by authenticating with Azure Active Directory.

Typically using a provider's SDK gives a better user experience but requires more work on part of the developer.

### Offline synchronization

Synchronizing data from mobile client devices can be a challenge. Mobile devices may lose connectivity, when this happens, changes made on the client device need to be cached locally and then synced with the backend once the connection is restored.

Additionally, if more than one client edits the same data, you'll need a way to manage and prioritize conflicting changes.

When using the Mobile Apps client SDK, offline synchronization can be enabled. This will automatically cache changes made to tables locally, and automatically push those changes to the backend when the mobile device has an active internet connection.

#### Conflict resolution

If two or more clients change the same data, the synchronization may fail. The SDK provides details of the conflict and you can provide the logic in the client app to decide how to proceed. For example, you could decide that the last change should always be saved, or you could retrieve the conflicting data and attempt to automatically merge, or you could present a dialog to the user and allow them to decide.

The best approach will depend on your app's needs, but the SDK and APIs will give you the tools you need to manage conflicts.

### Broadcast push notifications

Azure Notification Hubs is a highly scalable mobile-push notification service that can be used to send millions of push notifications to iOS, Android, or Windows devices. Notifications Hubs can be connected to any Azure App Service backend including Mobile Apps, which allows you to send push notifications to users of your mobile client app.

To receive push notifications, the mobile client app will need to include the Mobile Apps client SDK.

## Mobile App Quickstarts

Mobile Apps in Azure App Service can be integrated with existing mobile client applications. However, if you're creating a new client app, you can download starter client app projects from the Azure portal.

The client applications are automatically created for iOS, Android, Xamarin and Apache Cordova. The client projects includes the Mobile Apps SDK and are configured to work with your instance of the Mobile App service. 

The sample app is a basic ToDo app that allows you to store and retrieve data from your backend. You'll need to perform additional development work on the client app to meet your app functionality and UX requirements; but it's a great foundation to start your client app.