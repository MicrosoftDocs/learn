Organizations build apps to serve various use cases. While most applications require users to interact with them, there are also requirements to build applications that are secure and don't require user interaction. These apps, given that they access resources independently of users, need to prove their identity. Azure Active Directory (Azure AD) lets you authenticate your app and provide authorized access to a protected web API.

## Example scenario

Suppose you work at a financial technology company as a software developer. Your company is looking to develop an application that will perform a batch job to generate a report that lists the users who have an upcoming monthly payment. Your company will use the report to notify the users of their monthly payment. Your company uses Python to develop applications. You've been tasked with the responsibility of building an application that will acquire a token to call a protected web API on behalf of itself.

## What will you be doing?

In this module, you'll:

- Register an application with an Azure AD tenant.
- Enable a daemon app to authenticate and acquire an access token from Azure AD.
- Use an access token to call a protected web API.

## What is the main goal?

By the end of this module, you'll be able to create a Python daemon app that uses its own identity and acquires a valid access token to call a protected web API.
