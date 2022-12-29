The Microsoft identity platform helps you build applications your users and customers can sign in to using their Microsoft identities or social accounts, and authorize access to protected web APIs like the Microsoft Graph API or your own APIs.

In this module, you'll learn how to add core authentication and authorization features to a Python web app using the Microsoft identity platform.

:::image type="content" source="../media/1-python-web-app-integrate-identity-platform.png" alt-text="Diagram that shows the integration of Microsoft identity platform into a Python web app.":::

## Example scenario

Suppose you work at insurance company as a software developer. You're developing a web application that signs in your agency's employees and customers. The company wants the application to allow customers to access their data while enabling employees to derive insights from the customer data for decision-making processes. You need to build an application that signs in all users and allows them to access data based on their roles in the company.

## What will we be doing?

You'll use the Microsoft identity platform to simplify authorization and authentication in your Python web app. After creating the app, you'll use the identity platform as a centralized identity provider in the cloud that controls how users sign in and access data. The tasks required to implement this solution are:

- Create a Python web application using the Flask framework
- Install the Microsoft Authentication Library and other dependencies
- Register the application with your Azure AD tenant
- Configure platform settings and credentials
- Add app roles to your application
- Build the authorization code flow
- Create app routes
- Sign in and sign out users
- Acquire a token and call the Microsoft Graph API

## What's the main goal?

By the end of this session, you'll be able to add sign-in support to a Python Flask web app using the Microsoft identity platform. The app you build can sign in users and allow them to access protected data based on their roles.