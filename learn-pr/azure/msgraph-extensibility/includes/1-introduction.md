
Microsoft Graph extensions allow you to extend Microsoft Graph resources by adding custom properties and using them to store app-specific data.

Suppose you're a developer at a multinational organization with subsidiaries and hundreds of employees across continents. Your organization uses Azure Active Directory (Azure AD) and Microsoft 365 for identity and access management, collaboration, and security. Your team wants to deploy a team bonding mobile app that will allow employees to discover each other and connect within and through their external social networks. Through the app, employees will add data about themselves and they'll discover each other, their interests, and their social networks.

<!--placeholder. Need to explicitly call out at this stage the info (and their associated properties) that we'll store then build the different conceptuals and exercise units around this info.-->
The employees have expressed a need to share the following details in their app profiles:
+ Their public LinkedIn URL profile
+ Their Skype ID
+ Their XBox gamertag

Azure AD, Microsoft 365, and Microsoft Graph do not expose these properties natively to allow the employees to update their profiles. However, the organization also doesn't want to invest in another database.

You have identified extensibility options available in Microsoft Graph as suited for the data needs of the app. You want to evaluate the available extension options, their suitability to extend user profile data in your team bonding app, and how to use them.

## What will we be doing?

1. You will use an Azure AD test tenant and a API client to call Microsoft Graph and create custom properties using the available extension options.
2. You'll then add new properties and store user-specific data in the properties.
3. You'll model the HTTP requests for managing and reading the extensions properties and associated data.


## What is the main goal?

By the end of this module, you'll be able to:

1. Choose an extension option for adding custom properties to Microsoft Graph.
2. Add, query, and update custom properties and their associated data through Microsoft Graph.
3. Use data in custom properties to extend your application.