
Microsoft Graph provides a single API endpoint to access data across Microsoft cloud services such as Microsoft 365, Azure Active Directory (Azure AD), and Windows. In addition, Microsoft Graph supports *extensions* as a lightweight option for adding custom properties and using them to store app-specific data.

## Example scenario

Suppose you're a developer at a multinational organization with subsidiaries and hundreds of employees across the continents. Your organization uses Azure AD and Microsoft 365 for identity and access management, collaboration, and security. Your team wants to deploy a team-bonding mobile app that will allow employees to share data about their interests and social networks, and discover and connect with each other.

The employees want to share the following details in their app profiles:

- Public LinkedIn profile URL
- Skype ID
- Xbox gamertag

Microsoft Graph doesn't expose these social properties natively for users. The organization also doesn't want to invest in another database.

You've identified extensions in Microsoft Graph as suitable for the data needs of the app. You want to evaluate the available extension options, their suitability to extend user profile data in your team-bonding app, and how to use them.

## What will we be doing?

In this module, you'll:

+ Use an Azure AD test tenant and a client app such as [Graph Explorer](https://aka.ms/ge) to call Microsoft Graph and create custom properties by using extensions.
+ Store the LinkedIn profile URL, Skype ID, and Xbox gamertag in the new extension properties.
+ Model the HTTP requests for reading and managing extensions in Microsoft Graph.

## What is the main goal?

When you've completed this module, you'll be able to:

+ Choose an extension option for adding custom data to Microsoft Graph.
+ Add, query, and update custom data through Microsoft Graph.
+ Use the custom data to extend your application.

> [!NOTE]
> Microsoft Graph exposes two endpoints, `beta` and `v1.0`. The `beta` endpoint retrieves the preview version of an API, and `v1.0` retrieves the generally available version of an API. We recommend that you use generally available APIs for production. For the exercises in this module, you'll use the generally available version of the Microsoft Graph APIs.