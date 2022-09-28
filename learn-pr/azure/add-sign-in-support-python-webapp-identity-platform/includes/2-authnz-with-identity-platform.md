The Microsoft identity platform simplifies authorization and authentication for application developers by providing identity as a service. It supports industry-standard protocols like OpenID Connect protocol for handling authentication and OAuth 2.0 protocol for handling authorization. By leveraging the identity platform, developers can build applications that sign in all Microsoft identities, get tokens to call the Microsoft Graph API or access other protected APIs.

As you integrate the Microsoft identity platform into your application, understanding the parties involved in the authentication and authorization flow will make the integration tasks easier.
The parties include:
- **User**: The user is the resource owner who owns the data and has the power to allow clients to access the data or resource. Users typically request a service from the application.

- **Trusted agent**: The component that the user interacts with. This trusted agent is usually a web browser.

- **Web app**: The application or resource server is where the resource or data resides. It trusts the identity provider to securely authenticate and authorize the trusted agent.

- **Azure Active Directory (Azure AD)**: Azure AD is the authorization server, also known as the identity provider. It securely manages anything to do with the user's information, their access, and the trust relationships between parties in a flow. It authenticates the identity of the user, grants and revokes access to resources and issues tokens.

## Application registration

To securely authenticate and authorize users into your application using the identity platform, developers must register their applications in an Azure AD tenant. Registering your application establishes a trust relationship between your application and the Microsoft identity platform, which is the identity provider.

When you register an application in the Azure portal, Microsoft identity platform assigns it a number of values that allow your application to communicate with Azure AD. These include: 

#### Application (client) ID

The application ID, or client ID, is a GUID value that uniquely identifies the application and its configuration within the identity platform. You add the client ID to your application's code and authentication libraries include this value in their requests to the identity platform.

#### Redirect URI

The redirect URI, also known as Reply URL, is the location where the identity platform redirects a user's client and sends security tokens after authentication. During development, this is the endpoint where you run an app locally.

#### Client credentials

Client credentials allow applications to request security tokens to access their own resources without requiring interaction from a user. You can use any of the three types of credentials that the Microsoft identity platform supports; certificates, client secrets, or federated credentials.

#### Authority

The authority is the identity provider URL (the instance) and the sign-in audience for your application. The instance and sign-in audience, when concatenated, make up the authority. It's in the form of `https://login.microsoftonline.com/<your_tenant>`

#### App roles

App roles allow you to securely enforce authorization in your application. When using app roles, an administrator manages access to protected resources by granting permissions to roles and not to individual users or groups. This allows you to manage access to resources in a way that is independent of user and group management.

The administrator can then use the Azure portal to assign roles to different users and groups to control who has access to what content and functionality. For instance, adding an *admin role* to your app registration could allow a set of employees with this role assignment to read users' profile data.

After you register the application, you can configure it to communicate with Azure AD by implementing the authentication logic yourself or using libraries such as Microsoft Authentication Library (MSAL). The latter is recommended.