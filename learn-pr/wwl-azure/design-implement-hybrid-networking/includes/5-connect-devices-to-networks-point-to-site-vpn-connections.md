A Point-to-Site (P2S) VPN gateway connection lets you create a secure connection to your virtual network from an individual client computer. A P2S connection is established by starting it from the client computer. This solution is useful for telecommuters who want to connect to Azure VNets from a remote location, such as from home or a conference. P2S VPN is also a useful solution to use instead of S2S VPN when you have only a few clients that need to connect to a VNet.

:::image type="content" source="../media/point-site-diagram.png" alt-text="Connect from a computer to an Azure VNet - point-to-site connection diagram":::


### Point-to-site protocols

Point-to-site VPN can use one of the following protocols:

 -  OpenVPN® Protocol, an SSL/TLS based VPN protocol. A TLS VPN solution can penetrate firewalls, since most firewalls open TCP port 443 outbound, which TLS uses. OpenVPN can be used to connect from Android, iOS (versions 11.0 and above), Windows, Linux, and Mac devices (macOS versions 10.13 and above).
 -  Secure Socket Tunneling Protocol (SSTP), a proprietary TLS-based VPN protocol. A TLS VPN solution can penetrate firewalls, since most firewalls open TCP port 443 outbound, which TLS uses. SSTP is only supported on Windows devices. Azure supports all versions of Windows that have SSTP (Windows 7 and later).
 -  IKEv2 VPN, a standards-based IPsec VPN solution. IKEv2 VPN can be used to connect from Mac devices (macOS versions 10.11 and above).

### Point-to-site authentication methods

The user must be authenticated before Azure accepts a P2S VPN connection. There are two mechanisms that Azure offers to authenticate a connecting user.

### Authenticate using native Azure certificate authentication

When using the native Azure certificate authentication, a client certificate on the device is used to authenticate the connecting user. Client certificates are generated from a trusted root certificate and then installed on each client computer. You can use a root certificate that was generated using an Enterprise solution, or you can generate a self-signed certificate.

The validation of the client certificate is performed by the VPN gateway and happens during establishment of the P2S VPN connection. The root certificate is required for the validation and must be uploaded to Azure.

<a name='authenticate-using-native-azure-active-directory-authentication'></a>

### Authenticate using native Microsoft Entra authentication

Microsoft Entra authentication allows users to connect to Azure using their Microsoft Entra credentials. Native Microsoft Entra authentication is only supported for OpenVPN protocol and Windows 10 and requires the use of the Azure VPN Client.

With native Microsoft Entra authentication, you can leverage Microsoft Entra Conditional Access as well as multifactor authentication (MFA) features for VPN.

At a high level, you need to perform the following steps to configure Microsoft Entra authentication:

 -  Configure a Microsoft Entra tenant
 -  Enable Microsoft Entra authentication on the gateway
 -  Download and configure Azure VPN Client

### Authenticate using Active Directory (AD) Domain Server

AD Domain authentication is a popular option because it allows users to connect to Azure using their organization domain credentials. It requires a RADIUS server that integrates with the AD server. Organizations can also leverage their existing RADIUS deployment.

The RADIUS server is deployed either on-premises or in your Azure VNet. During authentication, the Azure VPN Gateway passes authentication messages back and forth between the RADIUS server and the connecting device. Thus, the Gateway must be able to communicate with the RADIUS server. If the RADIUS server is present on-premises, then a VPN S2S connection from Azure to the on-premises site is required for reachability.

The RADIUS server can also integrate with AD certificate services. This lets you use the RADIUS server and your enterprise certificate deployment for P2S certificate authentication as an alternative to the Azure certificate authentication. Integrating the RADIUS server with AD certificate services means that you can do all your certificate management in AD, you don’t need to upload root certificates and revoked certificates to Azure.

A RADIUS server can also integrate with other external identity systems. This opens many authentication options for P2S VPN, including multi-factor options.

:::image type="content" source="../media/p2s-authenticate-with-ad-b603595a.png" alt-text="RADIUS authentication of client.":::


## Configure point-to-site clients

Users use the native VPN clients on Windows and Mac devices for P2S. Azure provides a VPN client configuration zip file that contains settings required by these native clients to connect to Azure.

 -  For Windows devices, the VPN client configuration consists of an installer package that users install on their devices.
 -  For Mac devices, it consists of the mobileconfig file that users install on their devices.

:::image type="content" source="../media/configure-point-site-45b81c3f.png" alt-text="configuration window in the Azure portal for a point to site connection":::


The zip file also provides the values of some of the important settings on the Azure side that you can use to create your own profile for these devices. Some of the values include the VPN gateway address, configured tunnel types, routes, and the root certificate for gateway validation.

> [!NOTE]
> That for Windows clients, you must have administrator rights on the client device to initiate the VPN connection from the client device to Azure.
