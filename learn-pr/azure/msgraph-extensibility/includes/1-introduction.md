
Microsoft Graph provides a unified endpoint that you can use to access the tremendous amount of data in Microsoft cloud services such as Microsoft 365, Enterprise Mobility + Security, and Windows. In addition, Microsoft Graph also supports **extensions** as a lightweight option for adding custom properties and using them to store app-specific data.

Suppose you're a developer at a multinational organization with subsidiaries and hundreds of employees across continents. Your organization uses Azure Active Directory (Azure AD) and Microsoft 365 for identity and access management, collaboration, and security. Your team wants to deploy a team bonding mobile app that will allow employees to discover each other and connect within and through their external social networks. Through the app, employees will add data about themselves and they'll discover each other, their interests, and their social networks.

The employees want to share the following details in their app profiles:
+ Their public LinkedIn profile URL
+ Their Skype ID
+ Their Xbox gamertag

Azure AD, Microsoft 365, and Microsoft Graph don't expose these properties natively to allow the employees to update their profiles. However, the organization also doesn't want to invest in another database.

You've identified extension options available in Microsoft Graph as suited for the data needs of the app. You want to evaluate the available extension options, their suitability to extend user profile data in your team bonding app, and how to use them.

## What will we be doing?

1. You'll use an Azure AD test tenant and an API client to call Microsoft Graph and create custom properties using the available extension options.
2. You'll then store the LinkedIn profile URL, Skype ID, and Xbox gamertag in the new extension properties.
3. You'll model the HTTP requests for reading and managing the extensions in Microsoft Graph.


## What is the main goal?

By the end of this module, you'll be able to:

1. Choose an extension option for adding custom data to Microsoft Graph.
2. Add, query, and update custom data through Microsoft Graph.
3. Use the custom data to extend your application.


> [!NOTE]
> Microsoft Graph exposes two endpoints - `beta` and `v1.0` where `beta` retrieves the preview version of an API while `v1.0` retrieves the generally available version of an API. APIs that are generally available are recommended for production. For the exercises in this module, you'll use the generally available version of Microsoft Graph APIs.