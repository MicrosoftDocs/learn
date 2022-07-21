The Microsoft identity platform simplifies authorization and authentication for application developers by providing identity as a service. It supports industry-standard protocols such as OpenID Connect protocol for handling authentication and OAuth 2.0 protocol for handling authorization. By leveraging the identity platform, developers can build applications that sign in all Microsoft identities, get tokens to call the Microsoft Graph API or access other APIs built by developers.

## Application registration

To securely authenticate and authorize users into your application using the identity platform, developers must register their applications in the Azure portal. Registering your application establishes a trust relationship between your application and the identity provider, the Microsoft identity platform. 

The application registration process collects and assigns values that allow your application to communicate with Azure Active Directory (Azure AD).

### Application (client) ID

The application ID, or client ID, is a value the Microsoft identity platform assigns to your application when you register it in Azure AD. The application ID is a GUID value that uniquely identifies the application and its configuration within the identity platform. You add the app ID to your application's code, and authentication libraries include the value in their requests to the identity platform at application runtime.

### Redirect URI

The redirect URI, also known as Reply URL, is the location where the identity platform redirects a user's client and sends security tokens after authentication. During development, this is the endpoint where you run your app locally.


### Client credentials 

Credentials allow your application to authenticate as itself, requiring no interaction from a user at runtime. You can add certificates, client secrets, or federated credentials to your app registration.

### Authority

The authority is the full directory URL that identifies a token authority. It should in the form of `https://login.microsoftonline.com/<your_tenant>`

### App roles

App roles provide a way for a resource server to govern access to its protected resources. They represent privileges that the subject has been granted. 

App roles defined during the app registration process are used to securely enforce authorization in your application. When using app roles, an administrator grants permissions to roles and not to individual users or groups. The administrator can then use the Azure portal to assign roles to different users and groups to control who has access to what content and functionality.  For instance, an admin role could allow email administrators to read everyone's email.

After you register the application, you can configure it to communicate with Azure AD by implementing the authentication logic yourself or using libraries such as Microsoft Authentication Library (MSAL). The latter is recommended.