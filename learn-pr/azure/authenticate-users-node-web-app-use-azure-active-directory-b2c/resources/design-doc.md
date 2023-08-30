# Title

Authenticate users in a Node web app by using Azure Active Directory B2C

## Role(s)

- developer
- solution-architect

## Level

intermediate

## Product(s)

- azure-active-directory-b2c
- msal-node

## Prerequisites

- An Azure account with an [active subscription](https://azure.microsoft.com/free/).

- Familiarity with identity concepts such as authentication, security tokens and OpenID Connect protocol at beginner level.

- Ability to navigate the Azure portal such as searching resources and switching between directories.

- An Azure Active Directory B2C (Azure AD B2C) tenant that you manage as a Global administrator.

- Ability to write code in JavaScript/Node at beginner level.

- Must have [Node.js](https://nodejs.org/en/) and [Visual Studio Code](https://code.visualstudio.com/) installed on your computer.

## Summary

Create a Node web app and configure it to authenticate users. When users sign in, the web app delegates the authentication task to the customer identity service.

## Learning objectives

After completing this module, you'll be able to:

1. Prepare Azure AD B2C to authenticate users in a web app.

1. Configure authentication in a Node web app by using Azure AD B2C.

1. Run and test the Node web app.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Register web app in Azure AD B2C | So, your organization wants to use Azure AD B2C as an identity provider because you can customize the entire user experience with your brand. | Exercises, Knowledge check | 1 | Yes |
| Create combined sign up sign in user flow|customers can sign up or sign in to the web app. | Exercise | 1 | No, Subtask 1|
|Configure identity providers in Azure AD B2C| customers can sign up or sign in to the web app using email or a social account. | Exercise | 1 | No, Subtask 1 |
| Create a Node web app | Your organization is launching a new Node web app | Exercise | 2| Yes |
|Add Azure AD B2C authentication to the Node web app| Because of customer data sensitivity and authentication scaling complexities, your organization don't want to manage customer identities from within the Node web app. So, your organization wants to use Azure AD B2C as an identity provider because you can customize the entire user experience with your brand. | Exercise | 2 | Yes |
| Test sign in and sign up in the Node web app | web app authenticates customers for them to make an order. | Exercise | 3 |No, Subtask 5|

## Outline the units

1. Introduction

    Suppose you're the solution architect for an eCommerce organization. Your organization is launching a new Node web app, which enables customers to order groceries online. Your organization requires that the web app authenticates customers for them to make an order, so they can sign up or sign in to the web app using their email or a social account. Because of customer data sensitivity and authentication scaling complexities, your organization doesn't want to manage customer identities from within the Node web app. So, your organization wants to use Azure AD B2C as an identity provider because you can customize the entire user experience with your brand. You want to start by authenticating users to the Node web app by using Azure AD B2C.

1. Authenticate users by using Azure AD B2C

    1. Role of Azure AD B2C.
    1. What App types does Azure AD B2C support?
    1. Azure AD B2C user experiences using user flows and identity providers.
    1. Application registration.
    1. OpenID Connect protocol.

1. Exercise - Prepare Azure AD B2C to authenticate users in a web app.
    1. Register a web app in Azure AD B2C tenant.
    1. Create a combined sign up and sign in user flow and select an identity provider, user attributes and token claims.
    1. Test the user flow in Azure portal.

1. Plan your Node.js web app
    1. How to create a Node.js application.
    1. Role and installing dependencies.
    1. ExpressJS routing.
    1. HandleBars templating language

1. Exercise - Create a Node.js web app
    1. Create a node project and install dependencies.
    1. Create web app user interface by using Handlebars.
    1. Add express routes - app entry, sign up and sign in routes, sign out and the Azure AD B2C redirect route/URI.

1. Add authenticate to a Node web app by using Azure AD B2C
    1. Microsoft Authentication Library (MSAL) & confidential clients vs public clients.
    1. msal-node configuration object.
    1. msal-node instance.
    1. How msal-node implements the two steps in OAuth2.0's Authorization Code flow.
    1. Get authorization Code URL by using `getAuthCodeUrl` method - OAuth2.0's Authorization Code flow's step 1.
    1. Acquire `idToken` by exchanging the Authorization Code received by using `acquireTokenByCode` method- OAuth2.0's Authorization Code flow's step 2.
    1. Sign user out of Node web app by sending sign out request to Azure AD B2C' logout URI.

1. Exercise - Configure authentication in a Node web app by using Azure AD B2C
    1. Install msal-node as a dependence.
    1. Create authentication library configuration file.
    1. Configure the authentication library.
    1. Use MSAL to sign up/in/out users to the Node.js web app.
    1. Run and test the node web app.
 
1. Knowledge check
    1. How should one prepare Azure AD B2C to authenticate users in a web application?
    1. Why is it advisable to use Microsoft Authentication Library (MSAL) to configure authentication in a web app?
    1. What is the result of a request sent by a web app to Azure AD B2C?

1. Summary

Your organization was launching an online grocery store. Your organization needed customers to be authenticated in a web app before they could make an order. Instead of managing customer identities from within the web app, which is a challenge, and wouldn't scale well, your organization needed to use an identity management solution.

Azure AD B2C helped your organization to authenticate users into your web app. We used Azure AD B2C's user flows to manage a users sign up and sign in journeys. Your Node web app redirected the user to Azure AD B2C where user authentication occurred and only received a response from Azure AD B2C as an ID token and token claims for user identification.

If your organization didn't use Azure AD B2C, you'd have to build a whole authentication module from scratch, model a user's data schema, and store the data yourself. Because users can also use social identities, you'd perform the integration yourself. Besides, you'd have to deal with scaling and safety of the authentication platform.

By using Azure AD B2C and with the help of msal-node library, you added an authentication module to your web app quickly with few lines of code. Also, Azure AD B2C handles scaling and safety out of the box.

## Notes

- [Azure AD B2C product content](/azure/active-directory-b2c).
- [microsoft-authentication-libraries-for-js](https://azuread.github.io/microsoft-authentication-library-for-js/ref/modules/_azure_msal_node.html).
- [msal-node package in npm](https://www.npmjs.com/package/@azure/msal-node).
- [MSAL Node Standalone Sample: Authorization Code Grant on Azure AD B2C](https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/samples/msal-node-samples/b2c-auth-code).
