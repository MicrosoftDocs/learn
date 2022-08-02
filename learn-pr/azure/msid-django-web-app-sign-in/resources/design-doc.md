# Title

Enable user sign-in to your Django web app using Azure AD

## Role(s)

- Developer

## Level

- intermediate

## Product(s)

- azure-active-directory
- msal-python

## Prerequisites

- Beginner level Python 3.8+ and Django web framework.
- An Azure account with an [active subscription](https://azure.microsoft.com/free/).
- An Azure Active Directory (Azure AD) tenant that you manage as a Global administrator.
- A user account in your own Azure AD tenant.

## Summary

Create a Django web app that signs in users using the Microsoft identity platform. You will register a Django web app in your Azure AD tenant, add a user in the tenant and sign in the user to your Django web app.

## Learning objectives

Upon completion of this module/unit, the student will be able to:

- Register web application in an Azure AD tenant.
- Configure Django web application to use its Azure AD tenant app registration details.
- Sign-in user to a Django web application to obtain an ID token.

## Chunk your content into subtasks

Identify the subtasks of module title.

## Outline the units

1. **Introduction**

Suppose you work at a banking company as a developer. Your company is looking to develop a web application to help customers access services and information. These services range from checking their account balances, making transactions and applying for loans. To ensure these services are accessed in a secure way, users need to authenticate before they can access these resources. Your company uses Python Django as the web framework to build its web apps. You've been tasked with the responsibility of building an authentication mechanism to authenticate users before they can access these resources.

1. **Register web app in Azure AD tenant.**

    - Authentication flow for web apps in Azure AD
    - Choose the Azure AD tenant where you want to create your web app
    - Create user in tenant
    - Azure AD web app registration

1. **Exercise - Register Django web app in Azure AD tenant.**

    - Create a single tenant web app registration
    - Create a client secret in Azure AD.

1. **Sign in users to a Django web app using Azure AD.**

    - Use Python MSAL library
    - Django project structure
    - Configure Django web app to use app registration details

1. **Exercise - Sign in user to a Django web app using Azure AD.**

    - Set up Django development environment
    - Configure Django web app to use app registration details
    - Sign-in user to your Django web app using Azure AD

1. **Knowledge check**

    - What is the use of the redirect URI configured in the Azure AD tenant when registering a web app?
    - What is the first step in signing-in a user using a web app registered in Azure AD?
    - What elements are required to create, configure and/or collect when registering an Azure AD app for use with the OAuth 2.0 authorization code grant flow in web apps?

1. **Summary**

Our financial institution wanted to provide its customers with access to resources in a secure manner. In this module, you learned how Azure AD enables you to quickly secure a Django web app by authenticating users during sign-in. By using Python MSAL, we were able to authenticate users in an Azure AD tenant thereby keeping resources safe. Azure AD is a robust identity provider that helps you quickly secure your app and handles your authentication logic thereby saving your business time and resources required in implementing an authentication system.

## Notes

[Python MSAL in Django web app reference material](https://github.com/Azure-Samples/ms-identity-python-django-tutorial/tree/main/1-Authentication/sign-in)
