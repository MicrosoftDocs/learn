
Web Application Proxy is a Remote Access role service. This role service functions as a reverse web proxy, and provides users located on the internet with access to internal corporate web applications or Remote Desktop Gateway servers. Web Application Proxy can use AD FS to preauthenticate internet users and acts as an AD FS proxy for publishing claims-aware applications. 

> [!NOTE]
> A claims-aware application can use any information about a user such as group membership, email address, department, or company as part of user authorization.

Before you install Web Application Proxy, you must deploy AD FS as a prerequisite. Web Application proxy uses AD FS for authentication services. One feature provided by AD FS is SSO functionality, which means that if users enter their credentials for accessing a corporate web application once, they will not be asked to enter their credentials again for subsequent access to the corporate web application. You can also use AD FS to authenticate users at Web Application Proxy before users communicate with the application.

Placing the Web Application Proxy server in the perimeter network between two firewall devices is a typical configuration. The AD FS server and applications that are published are located on the corporate network, and together with domain controllers and other internal servers, are protected by the second firewall. This scenario provides secure access to corporate applications for users located on the internet, and at the same time protects the corporate IT infrastructure from security threats on the internet.

:::image type="content" source="../media/m15-web-application-proxy.png" alt-text="A diagram that displays a typical WAP architecture." border="false":::

## Authentication options for Web Application Proxy

When you configure an application in Web Application Proxy, you need to select the type of preauthentication. You can choose either AD FS preauthentication or pass-through preauthentication. AD FS preauthentication provides more features and benefits, but pass-through preauthentication is compatible with all web apps.

### AD FS preauthentication

AD FS preauthentication uses AD FS for web applications that use claims-based authentication. When a user initiates a connection to the corporate web application, the first entry point the user connects to is the Web Application Proxy. Web Application Proxy preauthenticates the user in the AD FS server. If the authentication is successful, Web Application Proxy establishes a connection to the web server in the corporate network where the application is hosted.

By using AD FS preauthentication, you ensure that only authorized users can send data packets to the web application. This prevents hackers from taking advantage of web-app flaws before authentication. AD FS preauthentication significantly reduces the attack surface for a web app.

### Pass-through preauthentication

Pass-through preauthentication doesn't use AD FS for authentication, nor does Web Application Proxy preauthenticate the user. Instead, the user is connected to the web application through Web Application Proxy. The web application proxy rebuilds the data packets as they are delivered to the web app, which provides protection from flaws such as malformed packets. However, the data portion of the packet passes to the web app. The web app is responsible for authenticating users.

### AD FS preauthentication benefits

AD FS preauthentication provides the following benefits over pass-through preauthentication:

- SSO. Enables users that are preauthenticated by AD FS to enter their credentials only once. If users subsequently access other applications that use AD FS for authentication, they won't be prompted again for their credentials.
- Multifactor authentication (MFA). MFA allows you to configure multiple types of credentials to strengthen security. For example, you can configure the system so that users enter their username and password together with a smart card.
- Multifactor access control. Multifactor access controls used in organizations that want to strengthen their security when publishing web applications by implementing authorization claim rules. The rules are configured so that they issue either a permit, or a deny claim, which determines whether a user or a group is allowed or denied access to a web application that is using AD FS preauthentication.

## Publish applications with Web Application Proxy

After the Web Application Proxy role service is installed, you configure it by using the Web Application Proxy Configuration Wizard from the Remote Access Management console. When the Web Application Proxy Configuration Wizard completes, it creates the Web Application Proxy console, which you can use for further management and configuration of Web Application Proxy.

The Web Application Proxy Configuration Wizard requires that you enter the following information during the initial configuration process:

- AD FS name. To locate this name, open the AD FS Management console, and, under Edit Federation Service Properties, find the value in the Federation Service name box.
- Credentials of local administrator account for AD FS.
- AD FS Proxy Certificate. This is a certificate that Web Application Proxy will use for AD FS proxy functionality.

> [!TIP]
> The AD FS proxy certificate must contain the AD FS name in the subject field of the certificate because the Web Application Proxy Configure Wizard requires it. Additionally, the subject alternative names field of the certificate should include the AD FS name.

After completing the Web Application Proxy Configuration Wizard, you can publish your web app by using Web Application Proxy console or Windows PowerShell cmdlets. The Windows PowerShell cmdlets for managing published apps are:

- `Add-WebApplicationProxyApplication`
- `Get-WebApplicationProxyApplication`
- `Set-WebApplicationProxyApplication`

When you publish your web app, you must provide the following information:

- The type of preauthentication, for example, pass-through.
- The application to publish.
- The external URL of the application, for example, `https://lon-svr1.adatum.com`.
- A certificate whose subject name covers the external URL, for example, `lon-svr1.adatum.com`.
- The URL of the backend server, which is entered automatically when you enter the external URL.
