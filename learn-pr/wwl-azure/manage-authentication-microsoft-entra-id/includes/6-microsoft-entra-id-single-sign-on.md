Single sign-on is an authentication method that allows users to sign in using one set of credentials to multiple independent software systems. Using SSO means a user doesn't have to sign in to every application they use. With SSO, users can access all needed applications without being required to authenticate using different credentials.

Many applications already exist in Microsoft Entra ID that you can use with SSO. You have several options for SSO depending on the needs of the application and how it's implemented. Take time to plan your SSO deployment before you create applications in Microsoft Entra ID. The management of applications can be made easier by using the My Apps portal.

:::image type="content" source="../media/single-sign-on-example-9cf5ab58.jpg" alt-text="Diagram showing an example of single sign-on functionality.":::


## Single sign-on options

Choosing an SSO method depends on how the application is configured for authentication. Cloud applications can use federation-based options, such as OpenID Connect, Open Authorization (OAuth), and Security Assertion Markup Language (SAML). The application can also use password-based SSO, linked-based SSO, or SSO can be disabled.

 -  Federation - When you set up SSO to work between multiple identity providers, it's called federation. An SSO implementation based on federation protocols improves security, reliability, end-user experiences, and implementation.<br>
     -  With federated single sign-on, Microsoft Entra authenticates the user to the application by using their Microsoft Entra account. This method is supported for SAML 2.0, Web Services Federation (WS-Federation), or OpenID Connect applications. Federated SSO is the richest mode of SSO. Use federated SSO with Microsoft Entra ID when an application supports it, instead of password-based SSO and Active Directory Federation Services (AD FS).<br>
     -  There are some scenarios where the SSO option isn't present for an enterprise application. If the application was registered using App registrations in the portal, then the single sign-on capability is configured to use OpenID Connect and OAuth by default. In this case, the single sign-on option doesn't appear in the navigation under enterprise applications.<br>
     -  Single sign-on isn't available when an application is hosted in another tenant. Single sign-on is also not available if your account doesn't have the required permissions (Global Administrator, Cloud Application Administrator, Application Administrator, or owner of the service principal). Permissions can also cause a scenario where you can open single sign-on but might not be able to save.<br>
 -  Password - On-premises applications can use a password-based method for SSO. This choice works when applications are configured for Application Proxy.
     -  With password-based SSO, users sign in to the application with a username and password the first time they access it. After the first sign-on, Microsoft Entra ID provides the username and password to the application. Password-based SSO enables secure application password storage and replay using a web browser extension or mobile app. This option uses the existing sign-in process provided by the application, enables an administrator to manage the passwords, and doesn't require the user to know the password.
 -  Linked - Linked sign-on can provide a consistent user experience while you migrate applications over a period of time. If you're migrating applications to Microsoft Entra ID, you can use linked-based SSO to quickly publish links to all the applications you intend to migrate. Users can find all the links in the My Apps or Microsoft 365 portals.
     -  After a user has authenticated with a linked application, an account needs to be created before the user is provided single sign-on access. Provisioning this account can either occur automatically, or it can occur manually by an administrator. You can't apply Conditional Access policies or multifactor authentication to a linked application because a linked application doesn't provide single sign-on capabilities through Microsoft Entra ID. When you configure a linked application, you're simply adding a link that appears for launching the application.
 -  Disabled - When SSO is disabled, it isn't available for the application. When single sign-on is disabled, users might need to authenticate twice. First, users authenticate to Microsoft Entra ID, and then they sign in to the application.
     -  Disable SSO when:
         -  You're not ready to integrate this application with Microsoft Entra single sign-on
         -  You're testing other aspects of the application
         -  An on-premises application doesn't require users to authenticate, but you want them to. With SSO disabled, the user needs to authenticate.
         -  If you configured the application for SP-initiated SAML-based SSO and you change the SSO mode to disabled, it doesn't stop users from signing in to the application outside the MyApps portal. To stop users from signing in from outside My apps portal, you need to disable the ability for users to sign in.

## Plan SSO deployment

Web applications are hosted by various companies and made available as a service. Some popular examples of web applications include Microsoft 365, GitHub, and Salesforce. There are thousands of others. People access web applications using a web browser on their computer. Single sign-on makes it possible for people to navigate between the various web applications without having to sign in multiple times. For more information, see Plan a single sign-on deployment.

How you implement SSO depends on where the application is hosted. Hosting matters because of the way network traffic is routed to access the application. Users don't need to use the Internet to access on-premises applications (hosted on a local network). If the application is hosted in the cloud, users need the Internet to use it. Cloud hosted applications are also called Software as a Service (SaaS) applications.<br>

For cloud applications, federation protocols are used. You can also use single sign-on for on-premises applications. You can use Application Proxy to configure access for your on-premises application.

## My Apps

If you're a user of an application, you likely don't care much about SSO details. You just want to use the applications that make you productive without having to type your password so much. You can find and manage your applications at the My Apps portal.
