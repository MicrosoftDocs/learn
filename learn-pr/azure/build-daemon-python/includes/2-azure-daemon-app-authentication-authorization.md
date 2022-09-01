Applications that operate without interaction with a user also need a way to access secured resources, such as web APIs. Azure Active Directory (Azure AD) supports applications to acquire a token for their own identities.

In the financial company scenario, your company needs to use Azure AD to manage applications' identity and authentication journey in your Python daemon application.

In this unit, you'll learn about authentication, authorization, and how it's supported in Azure AD.

## Authentication

_Authentication_ is the process of proving your identity. Azure AD uses the OpenID Connect protocol to handle authentication. OpenID Connect allows applications to request and receive information about authenticated sessions and end-users.

## Authorization

_Authorization_ is the act of granting an authenticated party permission to do something. It specifies what data you're allowed to access and what you can do with that data.

Azure AD uses the OAuth 2.0 protocol for handling authorization. OAuth 2.0 provides authorization flows for different applications in Azure AD.

## Application registration

Azure AD requires your application to be registered before providing identity and access management services. The application registration allows you to specify the name of your application, the type of the application (web, desktop, etc.), and the sign-in audience. The sign-in audience specifies what types of user accounts are allowed to sign-in to a given application.

When an application registration is complete, you receive an **Application (client) ID** that uniquely identifies your application in Azure AD. This ID is used in your application code or in the authentication library as part of the requests made to Azure AD.
