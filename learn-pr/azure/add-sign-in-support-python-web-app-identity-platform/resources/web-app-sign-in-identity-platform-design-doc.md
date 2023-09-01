# Title

Add sign-in support to a Python web app using the Microsoft identity platform

## Role(s)

Developer, student

## Level

Beginner

## Product(s)

Azure Active Directory

## Prerequisites

- An Azure Active Directory (Azure AD) tenant with permissions for managing app registrations. To create a free account, we recommend going through [Create an Azure account](https://learn.microsoft.com/learn/modules/create-an-azure-account/) module.
- Familiarity with basic Python programming concepts and terminology.
- An understanding of cloud computing concepts and services.
- Basic knowledge of the [Microsoft identity platform](https://learn.microsoft.com/learn/modules/explore-microsoft-identity-platform/)

## Summary

Add core authentication and authorization features to a Python web app using the Microsoft identity platform. Your web app will sign in Azure AD users and fetch data from a protected web API, such as the Microsoft Graph API.


## Learning objectives

After completing this module, you'll be able to:

- Register and configure a web app with the Microsoft identity platform.
- Add code to support core authentication and authorization features.
- Sign in your organizational users and fetch data from a protected web API.


## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create a web app | TODO |  Knowledge check | TODO | Yes |
| Register your app in the Azure portal | TODO | Exercise | TODO | Yes |
| Add code to authenticate and authorize users | TODO | Exercise | TODO | Yes |
| Get access token and fetch user data  | TODO | Exercise | TODO | Yes |

## Outline the units

Add more units as needed for your content

1. Introduction

 Provide a scenario of a real-world job task that shows how the technology is used in practice:

   Suppose you work at insurance company ABC as a software developer. You're developing an insurance data solution that signs in your agency's employees and clients. The company wants the solution to allow clients to access their data while allowing employees to derive insights from the customer data for decision-making processes. You need to build a confidential client application that signs in all company users and allows them to access data based on their roles in the company.

1. Create a Python webapp and register it in the Azure portal

    List the content that will enable the learner to complete the subtask:

    - Create your application project directory
    - Install the required Python packages
    - Install MSAL for Python

    **Knowledge check**

    What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

    - Question type
    - Question type

1. Register your application with Azure AD

   List the content that will enable the learner to _register an app in Azure portal_:

   1. Sign in the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
   1. Describe the app registration process
   1. Describe how to add a client secret
   1. Define app registration parameters

   **Exercise**
   List the steps that apply the learning content from previous unit:

   1. Sign in the <a href="https://portal.azure.com/" target="_blank">Azure portal</a>.
   1. Create a new app in the Azure portal
   1. Add a client secret to the created app
   1. Take note of the application registration values
   1. Add app roles to your application
   1. Assign app roles to users and groups.

1. Add code to authenticate and authorize users

   List the content that will enable the learner to _sign in users_:

   1. Update the app configuration with the following values:
         1. Application (client) ID
         1. Directory (tenant) ID
         1. Client secret

   1. Build the authorization code flow

   **Exercise**
   List the steps that apply the learning content from previous unit:

   1. Write code to build the authorization code flow in a Python web app application

1. Get access tokens and fetch user data from a web API

   List the content that will enable the learner to _call Microsoft Graph API_:

   1. Configure the Microsoft Graph API endpoint
   1. Acquire a token interactively and silently


1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

   1. Installed the Microsoft Authentication Library (MSAL) for Python
   1. Registered an application in the Azure portal and configured it to use the Microsoft identity platform
   1. Built the authorization code flow
   1. Defined and created app roles for access control
   1. Acquired a valid access token for calling a protected web API


## Notes

- [Python 3](https://www.python.org/download/releases/3.0/)
- [Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app)
- [Microsoft identity platform access tokens](/azure/active-directory/develop/access-tokens)
- [Use the Microsoft Graph API](https://learn.microsoft.com/graph/use-the-api)
