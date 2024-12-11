For users connecting to a remote session, there are three separate authentication points:

 -  **Service authentication to Azure Virtual Desktop**: retrieving a list of resources the user has access to when accessing the client. The experience depends on the Microsoft Entra account configuration. For example, if the user has multifactor authentication enabled, the user is prompted for their user account and a second form of authentication, in the same way as accessing other services.
 -  **Session host**: when starting a remote session. A username and password is required for a session host, but this is seamless to the user if single sign-on (SSO) is enabled.
 -  **In-session authentication**: connecting to other resources within a remote session.

The following sections explain each of these authentication points in detail.

### Service authentication

To access Azure Virtual Desktop resources, you must first authenticate to the service by signing in with a Microsoft Entra account. Authentication happens whenever you subscribe to a workspace to retrieve your resources and connect to apps or desktops. You can use [third-party identity providers](/azure/active-directory/devices/azureadjoin-plan#federated-environment) as long as they federate with Microsoft Entra ID.

#### Multifactor authentication

Follow the instructions in [Enforce Microsoft Entra multifactor authentication for Azure Virtual Desktop using Conditional Access](/azure/virtual-desktop/set-up-mfa) to learn how to enforce Microsoft Entra multifactor authentication for your deployment. That article will also tell you how to configure how often your users are prompted to enter their credentials. When deploying Microsoft Entra joined VMs, note the extra steps for [Microsoft Entra joined session host VMs](/azure/virtual-desktop/set-up-mfa#azure-ad-joined-session-host-vms).

#### Passwordless authentication

You can use any authentication type supported by Microsoft Entra ID, such as [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview) and other [passwordless authentication options](/azure/active-directory/authentication/concept-authentication-passwordless) (for example, FIDO keys), to authenticate to the service.

#### Smart card authentication

To use a smart card to authenticate to Microsoft Entra ID, you must first [configure AD FS for user certificate authentication](/windows-server/identity/ad-fs/operations/configure-user-certificate-authentication) or [configure Microsoft Entra certificate-based authentication](/azure/active-directory/authentication/concept-certificate-based-authentication).

### Session host authentication

If you haven't already enabled [single sign-on](/azure/virtual-desktop/authentication#single-sign-on-sso) or saved your credentials locally, you'll also need to authenticate to the session host when launching a connection. The following list describes which types of authentication each Azure Virtual Desktop client currently supports. Some clients might require a specific version to be used, which you can find in the link for each authentication type.

| **Client**                      | **Supported authentication type(s)**                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Windows Desktop client          | Username and password<br>Smart card<br>[Windows Hello for Business certificate trust](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust)<br>[Windows Hello for Business key trust with certificates](/windows/security/identity-protection/hello-for-business/hello-deployment-rdp-certs)<br>[Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on) |
| Azure Virtual Desktop Store app | Username and password<br>Smart card<br>[Windows Hello for Business certificate trust](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust)<br>[Windows Hello for Business key trust with certificates](/windows/security/identity-protection/hello-for-business/hello-deployment-rdp-certs)<br>[Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on) |
| Remote Desktop app              | Username and password                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Web client                      | Username and password<br>[Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on)                                                                                                                                                                                                                                                                                                                                                          |
| Android client                  | Username and password<br>[Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on)                                                                                                                                                                                                                                                                                                                                                          |
| iOS client                      | Username and password<br>[Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on)                                                                                                                                                                                                                                                                                                                                                          |
| macOS client                    | Username and password<br>Smart card: support for smart card-based sign in using smart card redirection at the Winlogon prompt when NLA is not negotiated.<br>[Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on)                                                                                                                                                                                                                      |

> [!IMPORTANT]
> In order for authentication to work properly, your local machine must also be able to access the [required URLs for Remote Desktop clients](/azure/virtual-desktop/safe-url-list#remote-desktop-clients).

#### Single sign-on (SSO)

SSO allows the connection to skip the session host credential prompt and automatically sign the user in to Windows. For session hosts that are Microsoft Entra joined or Microsoft Entra hybrid joined, it's recommended to enable [SSO using Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on). Microsoft Entra authentication provides other benefits including passwordless authentication and support for third-party identity providers.

Azure Virtual Desktop also supports [SSO using Active Directory Federation Services (AD FS)](/azure/virtual-desktop/configure-adfs-sso) for the Windows Desktop and web clients.

Without SSO, the client will prompt users for their session host credentials for every connection. The only way to avoid being prompted is to save the credentials in the client. We recommend you only save credentials on secure devices to prevent other users from accessing your resources.

#### Smart card and Windows Hello for Business

Azure Virtual Desktop supports both NT LAN Manager (NTLM) and Kerberos for session host authentication, however Smart card and Windows Hello for Business can only use Kerberos to sign in. To use Kerberos, the client needs to get Kerberos security tickets from a Key Distribution Center (KDC) service running on a domain controller. To get tickets, the client needs a direct networking line-of-sight to the domain controller. You can get a line-of-sight by connecting directly within your corporate network, using a VPN connection or setting up a [KDC Proxy server](/azure/virtual-desktop/key-distribution-center-proxy).

### In-session authentication

Once you're connected to your RemoteApp or desktop, you may be prompted for authentication inside the session. This section explains how to use credentials other than username and password in this scenario.

#### In-session passwordless authentication

Azure Virtual Desktop supports in-session passwordless authentication using [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview) or security devices like FIDO keys when using the [Windows Desktop client](/azure/virtual-desktop/users/connect-windows). Passwordless authentication is enabled automatically when the session host and local PC are using the following operating systems:

 -  Windows 11 single or multi-session with the [2022-10 Cumulative Updates for Windows 11 (KB5018418)](https://support.microsoft.com/kb/KB5018418) or later installed.
 -  Windows 10 single or multi-session, versions 20H2 or later with the [2022-10 Cumulative Updates for Windows 10 (KB5018410)](https://support.microsoft.com/kb/KB5018410) or later installed.
 -  Windows Server 2022 with the [2022-10 Cumulative Update for Microsoft server operating system (KB5018421)](https://support.microsoft.com/kb/KB5018421) or later installed.

To disable passwordless authentication on your host pool, you must [customize an RDP property](/azure/virtual-desktop/customize-rdp-properties). You can find the **WebAuthn redirection** property under the **Device redirection** tab in the Azure portal or set the **redirectwebauthn** property to **0** using PowerShell.

When enabled, all WebAuthn requests in the session are redirected to the local PC. You can use Windows Hello for Business or locally attached security devices to complete the authentication process.

To access Microsoft Entra resources with Windows Hello for Business or security devices, you must enable the FIDO2 Security Key as an authentication method for your users. To enable this method, follow the steps in [Enable FIDO2 security key method](/azure/active-directory/authentication/howto-authentication-passwordless-security-key#enable-fido2-security-key-method).

#### In-session smart card authentication

To use a smart card in your session, make sure you've installed the smart card drivers on the session host and enabled [smart card redirection](/azure/virtual-desktop/configure-device-redirections#smart-card-redirection). Review the [client comparison chart](/windows-server/remote/remote-desktop-services/clients/remote-desktop-app-compare#other-redirection-devices-etc) to make sure your client supports smart card redirection.
