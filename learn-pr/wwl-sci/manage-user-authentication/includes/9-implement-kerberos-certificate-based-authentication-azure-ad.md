You can provide single sign-on for on-premises applications published through Application Proxy. The apps are secured with integrated Windows authentication. These applications require a Kerberos ticket for access. Application Proxy uses Kerberos Constrained Delegation (KCD) to support these applications. You can enable single sign-on to your applications using integrated Windows authentication. Give the Application Proxy connectors permission in Active Directory to impersonate users. The connectors use this permission to send and receive tokens on their behalf.

### Kerberos authentication process flow

:::image type="content" source="../media/kerberos-authentication-cdf4cd35.png" alt-text="Diagram of the authentication process flow with Kerberos is configured for Application Proxy authentication.":::


1.  The user enters the URL to access the on premises application through Application Proxy.
2.  Application Proxy redirects the request to Azure AD authentication services to preauthenticate. At this point, Azure AD applies any applicable authentication and authorization policies, such as multifactor authentication. If the user is validated, Azure AD creates a token and sends it to the user.
3.  The user passes the token to Application Proxy.
4.  Application Proxy validates the token and retrieves the User Principal Name (UPN) from it, and then the Connector pulls the UPN, and the Service Principal Name (SPN) through a dually authenticated secure channel.
5.  The Connector performs Kerberos Constrained Delegation (KCD) negotiation with the on premises AD, impersonating the user to get a Kerberos token to the application.
6.  Active Directory sends the Kerberos token for the application to the Connector.
7.  The Connector sends the original request to the application server, using the Kerberos token it received from AD.
8.  The application sends the response to the Connector, which is then returned to the Application Proxy service and finally to the user.

### Ensure your environment is ready

Before you get started with single sign-on for integrated windows authentication applications, make sure your environment is ready with the following settings and configurations:

 -  Your apps, like SharePoint Web apps, are set to use integrated Windows authentication.
 -  All your apps have Service Principal names.
 -  The server running the Connector and the server running the app are domain joined.
 -  The server running the Connector has access to read the TokenGroupsGlobalAndUniversal attribute for users.
