
Suppose you're a developer at a multinational organization with subsidiaries and hundreds of employees across continents. Your organization uses Azure Active Directory (Azure AD) and Microsoft 365 for identity and access management, collaboration, and security. Your team wants to deploy a team bonding mobile app that will allow employees to discover each other and connect within and through their external social networks. Through the app, employees will add data about themselves and they'll discover each other, their interests, and their social networks.

<!--placeholder. Need to explicitly call out at this stage the info (and their associated properties) that we'll store then build the different conceptuals and exercise units around this info.

You want employees to store data about the following:
+ Their LinkedIn public profile URL
+ 

Microsoft Graph is a unified API endpoint for accessing data in various Microsoft cloud services like Microsoft 365, Enterprise Mobility and Security, and Windows. Data in these cloud services is exposed through Microsoft Graph resources that define properties through which data is exposed. Through Microsoft Graph, organizations can build apps with unique experiences for users and organizations around the data that's stored in the Microsoft cloud services.

In addition to the wealth of data that Microsoft Graph exposes for Microsoft cloud services like Azure AD and Microsoft 365, Microsoft Graph also allows developers to extend it with custom properties. They can use these custom properties to store additional data that may not be available out-of-the-box through the resources and properties that Microsoft Graph already exposes.

In the team bonding app, you want employees to store data about the following:
+ Their LinkedIn public profile URL
+ 



-->

The organization doesn't want to invest in another database and has identified extensibility options available in Microsoft Graph as suited for the data needs of the app. You want to evaluate the available extension options and how to use them in the team bonding app.

## Learning objectives

By the end of this module, you'll be able to:

- Choose extension options for adding custom properties to Microsoft Graph
- Add, query, and update custom properties and their associated data through Microsoft Graph
- Use data in custom properties to extend your application

## Prerequisites

- Access to an [Azure Active Directory tenant](/azure/active-directory/develop/quickstart-create-new-tenant) where you have the Global Administrator role for your account
- Basic knowledge of working with REST APIs and how to use the create, read, update, and delete (CRUD) REST API operations
- Basic knowledge of working with data in Azure AD and Microsoft 365 using Microsoft Graph