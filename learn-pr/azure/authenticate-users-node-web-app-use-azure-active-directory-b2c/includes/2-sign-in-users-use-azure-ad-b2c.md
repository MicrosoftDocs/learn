To ensure secure authentication of users into applications, Azure AD B2C has different resources that a solution architect has to interact with to understand how it supports its features.

In the eCommerce organization scenario, your organization needs to use Azure AD B2C to manage customer identities and authentication journey in your Node web application.

Here you'll learn about the components that Azure AD B2C uses to support user authentication

## Role of Azure Active Directory B2C

Azure Active Directory B2C (Azure AD B2C) is a white-label authentication solution for Microsoft. It's part of the Microsoft identity platform. It provides authentication capabilities by enabling organizations to sign in users into customer facing apps. Customers do this by creating new accounts or using existing credentials, including the most common social identity providers such Facebook and LinkedIn. If you're building a web application, instead of building authentication capability within the web application, you delegate this function to Azure AD B2C. The authentication scenarios include sign up, sign in, single sign on, sign out, forgot password, change password, multifactor authentication, profile editing and progressive profiling.

Azure AD B2C can support millions of users and billions of authentications per day. It also takes care of the scaling and safety of the authentication platform, monitoring, and automatically handling threats like denial-of-service, password spray, or brute force attacks.  

## What application types does Azure AD B2C support?

Regardless of your preferred language or platform, Azure AD B2C supports authentication for various modern application architectures, which are based on industry-standard protocol, OpenID Connect. Currently, Azure AD B2C can authenticate users into the following application types:

* **Single-page applications (SPAs)** - JavaScript web applications that run in the browser, such as the apps written in JavaScript or frameworks like AngularJS, React and VueJs.
* **Web applications** - Web applications that are hosted/runs on a server and accessed through a browser such as the app written in .NET, PHP, Java, Ruby, Python, and Node.js.
* **Mobile and native applications** -  Mobile or desktop applications that run natively on a device.
* **Web APIs** - RESTful web services/APIs that are build using server side languages such as .NET or Node.js and can be accessed by SPAs, Web applications or Mobile and native applications.

## OpenID Connect authentication protocol

OpenID Connect protocol extends the OAuth 2.0 authorization protocol for use as an authentication protocol. This authentication protocol allows you to perform single sign-on. It introduces the concept of an *ID token*, which allows the client to verify the identity of the user and obtain basic profile information about the user.

Azure AD B2C extends the standard OpenID Connect protocol to do more than just authentication and authorization. It introduces an element called *policies*, which enables you to use OpenID Connect to add user journeys to your application, such as sign up, sign in, and profile management.

## User experiences using policies

Azure AD B2C extends the standard OpenID Connect protocol to introduce *policies*, which model user journeys. A user journey is the path that you want users to take in your application to achieve their goal. For example, you might want your users to sign up, sign in, and later update their profile.

Policies enable you to control user identity experience behaviors in your application such as the following:

* Account types used for sign-in, such as social accounts like a Facebook, or local accounts that use an email address and password for sign-in
* Data to be collected from the consumer, such as first name, postal code, or country/region of residency.
* Customization of the user interface.
* Claims in a token that your application receives after the user completes the user journey.
* Session management

Azure AD B2C supports two types of policies:

* **User flows** - They're predefined policies built-in, configurable policies that Azure AD B2C provides so you can create sign up, sign in, and policy editing experiences quickly.
* **Custom policies** - They enable you to create your own user journeys for complex identity experience.

Azure AD B2C has the following types of *user flows* generally available:

* **Sign up and sign in** - A combined sign in and sign up, which enables a user to create an account or sign in to their account. It also supports *forgot password* if you enable *Self-service password reset* feature.

* **Sign in** - Enables a user to sign in to their account.

* **Sign up** - Enables a user to create a new account.

* **Password reset** - Enables a user to create a new password after verifying their email.

* **Profile editing** - Enables a user to update their profile details.

* **Sign in using resource owner password credentials (ROPC)** - Enables a user with a local account to sign in directly in native applications as long there isn't any interruption to the authentication flow.

## Support different identity providers

An identity provider is the method you use to allow users to be authenticated into your application. Users can create an account that is local to Azure AD B2C by using their email address, username, user ID or phone number, or use their existing social identities such as Facebook or LinkedIn. Azure AD B2C provides a list of identity providers you can choose from or you can add your own OpenID Connect identity provider.

:::image type="content" alt-text="Screenshot of identity provider for Azure A D B 2 C." source="./../media/identity-providers.png" :::

## Application registration

Any type of application that needs to communicate with Azure AD B2C, must be registered. You register applications in the Azure portal. The application registration process collects and assigns the values for your application:

* An **Application (client) ID** that uniquely identifies your application.
* A **Redirect URI** that you can use to direct responses from Azure AD B2C back to your application.
* Other scenario-specific values such as **supported account types** and **Client secret**.

After you register the application, you can configure it to communicate with Azure AD B2C implementing the authentication logic yourself or using libraries such as Microsoft Authentication Library (MSAL). The latter is recommended.