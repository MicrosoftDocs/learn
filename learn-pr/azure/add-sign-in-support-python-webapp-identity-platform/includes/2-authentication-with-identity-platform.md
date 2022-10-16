The Microsoft identity platform simplifies authentication and authorization for application developers by providing identity as a service. It supports industry-standard protocols like OpenID Connect for handling authentication and OAuth 2.0 for handling authorization. By leveraging the identity platform, developers can build applications that sign in all Microsoft identities, get tokens to call the Microsoft Graph API or access other protected APIs.

As you integrate the Microsoft identity platform into your application, understanding the parties involved in the authentication and authorization flow will make the integration tasks easier.
The parties include:

- **Resource owner**: An entity that owns a protected resource and is capable of granting access to the resources. The resource owner could be an entity such as an organization that owns data or a person, typically referred to as an end user.

- **User-agent**: The component that the user interacts with to access the authorization server. It could be a browser or mobile application running on the user's device.

- **Resource server**: The resource server hosts or provides access to a resource owner's data. It trusts the identity provider to securely authenticate and authorize the user-agent.

- **Azure Active Directory (Azure AD)**: Azure AD is the identity provider. It securely manages anything to do with the user's information, their access, and the trust relationships between parties in a flow. It authenticates the identity of the user, grants and revokes access to resources and issues tokens.

## Application registration

Developers should register their applications in an Azure AD tenant before delegating identity and access management services to the Microsoft identity platform. Registering your application establishes a trust relationship between your application and the identity platform.

When you register an application in the Azure portal, Microsoft identity platform assigns it a number of values that allow your application to communicate with Azure AD. These include:

#### Application (client) ID

The application ID, or client ID, is a GUID value that uniquely identifies the application and its configuration within the identity platform. You add the client ID to your application's code and authentication libraries include this value in their requests to the identity platform.

#### Redirect URI

The redirect URI, also known as Reply URL, is the location where the identity platform redirects a user's client and sends security tokens after authentication. During development, this is the endpoint where you run an app locally.

#### Client credentials

Client credentials allow applications to request security tokens to access their own resources without requiring interaction from a user. You can use any of the three types of credentials that the Microsoft identity platform supports; certificates, client secrets, or federated credentials.

#### Authority URL

The authority URL is the identity provider URL when concatenated with the sign-in audience for your application. It's in the form of `https://login.microsoftonline.com/<your_tenant>`

#### App roles

App roles allow you to securely enforce authorization in your application. When using role-based access control (RBAC), an administrator defines application roles in the Azure portal. They then assign roles to different users and groups to control who has access to what content and functionality. For instance, adding an *admin role* to your app registration could allow a set of employees with the *admin role* assignment to read users' profile data.

After you register the application, you can configure it to communicate with Azure AD by implementing the authentication logic yourself or using libraries such as Microsoft Authentication Library (MSAL). The latter is recommended.