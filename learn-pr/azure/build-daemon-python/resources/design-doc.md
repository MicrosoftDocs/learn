# Title

Build a Python daemon app calling a protected API using the Microsoft identity platform

## Role(s)

Developer

## Level

Intermediate

## Product(s)

- azure-active-directory
- msal-python

## Prerequisites

- An Azure account. Learn how to create a free account in [Create an Azure account](/learn/modules/create-an-azure-account).
- [Python 3+](https://www.python.org/downloads/) installed on your computer.
- An Azure Active Directory (Azure AD) tenant that you manage as a Global Administrator, Cloud app Administrator, or app Administrator.

## Summary

Create a Python a daemon app that authenticates using the Microsoft identity platform. You'll register an app in your Azure AD tenant, add a client secret, acquire token from your app and call a protected web API.

## Learning objectives

By the end of this module, you'll be able to:

1. Register a daemon app in an Azure AD tenant.
1. Call a protected web API from an authenticated Python daemon app.

## Chunk your content into subtasks

Identify the subtasks of module title.

## Outline the units

1. Introduction

   Suppose you work at a financial technology company as a software developer. Your company is looking to develop an automated service to help customers pay their obligations on time by sending a notification before the due date. Your company uses Python to develop applications. You've been tasked with the responsibility of building an application that runs in the background to call a protected web API.

2. Authentication and authorization in Azure AD

   - What is Azure AD?
   - Understand authentication and authorization
   - Application registration
     - What is the purpose of registering an application with Azure AD?

3. Exercise - Register an application with Azure AD

   - Register an application using <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
   - Add a client secret

4. Explore the Microsoft Authentication Library

   - Use MSAL for Python
     - What is Public client applications?
     - What is Confidential client application?
     - How to acquire access token?
     - Authorize access to call protected API

5. Exercise - Configure authentication in a daemon app
   - Create folder structure to host your code
   - Write code to enable an app acquire a token
   - Call protected web API

6. Knowledge check

   - John is granting permission to an application registered within the Azure Active Directory (Azure AD) tenant. Which of the following permissions will allow a daemon application to authenticate as itself without user interaction and call Microsoft Graph?
   - A company is adding Microsoft Authentication Library (MSAL) for Python to an existing project. Which of the following commands will install MSAL for Python?

7. Summary

   Our finance team needed to notify our customers of their upcoming obligations before the due date. We built a Python daemon app that represents a confidential client app that calls Microsoft Graph as itself to read customers data from a resource. The Microsoft identity platform lets us register a Python daemon app to perform identity and access management (IAM). The Azure portal displays the app registration's Overview pane. We see the Application (client) ID. Also called the client ID, this value uniquely identifies our application in the Microsoft identity platform. We used Microsoft Authentication Library (MSAL) for Python to create a client confidential application. Finally, we acquire an access token and call the Microsoft Graph.

## Notes

- [Python 3](https://www.python.org/download/releases/3.0/)
- [Register an application with the Microsoft identity platform](https://docs.microsoft.com/azure/active-directory/develop/quickstart-register-app)
