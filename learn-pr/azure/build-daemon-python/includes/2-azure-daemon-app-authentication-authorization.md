Applications are added to Azure Active Directory (Azure AD) to use one or more of the services it provides. You can use Azure AD to authenticate and authorize apps that call protected web APIs.

In this unit, you'll learn about authentication, authorization, and how it's supported in Azure AD.

## Authentication

_Authentication_ is the process of proving that you're who you say you are. You prove your identity.

Azure AD uses the OpenID Connect protocol to handle authentication. OpenID Connect allows applications to request and receive information about authenticated sessions and end-users.

## Authorization

_Authorization_ is the act of granting an authenticated party permission to do something. It specifies what data you're allowed to access and what you can do with that data.

Azure AD uses the OAuth 2.0 protocol for handling authorization. OAuth 2.0 provides authorization flows for different applications in Azure AD.

## Application registration

Azure AD requires your application to be registered with it before it can provide identity and access management services. Registering your application establishes a trust relationship between your application and the identity provider. You can register your application through the Azure portal.

The application registration allows you to specify the name of your application, the type of the application (web, desktop, and so on), and the sign-in audience, which is the user accounts you want to allow access to. You can also configure credentials, redirect URIs, and other authentication settings on the application registration.

When an application registration is complete, you receive an **Application (client) ID** that uniquely identifies your application in Azure AD. This ID is used in your application code or in the authentication library as part of the requests made to Azure AD.
