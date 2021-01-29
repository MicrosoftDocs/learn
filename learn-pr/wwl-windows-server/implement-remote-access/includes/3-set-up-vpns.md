When planning VPNs, Contoso must consider a number of factors, including the appropriate tunneling protocol and authentication method. They must also consider how best to setup their VPN servers to support their users' remote access needs.

## Select a tunneling protocol

Contoso could choose to implement VPNs using one of several tunneling protocols and authentication methods. VPN connections can use one of the following tunneling protocols:

- Point-to-Point Tunneling Protocol (PPTP)
- Layer 2 Tunneling Protocol with Internet Protocol Security (L2TP/IPsec)
- Secure Socket Tunneling Protocol (SSTP)
- Internet Key Exchange version 2 (IKEv2)

All VPN tunneling protocols share three features:

- Encapsulation. VPN technology encapsulates private data with a header that contains routing information, which allows the data to traverse the transit network.
- Authentication. There are three types of authentication for VPN connections, including:
  - User-level authentication by using Point-to-Point Protocol (PPP) authentication.
  - Computer-level authentication by using Internet Key Exchange (IKE).
  - Data-origin authentication and data integrity.
- Data encryption. To ensure data confidentiality as it traverses the shared or public transit network, the sender encrypts the data, and the receiver decrypts it.

The following table describes the supported tunneling protocols.

| Protocol   | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| PPTP       | You can use PPTP for remote access and site-to-site VPN (virtual private network) connections. When you use the internet as the VPN public network, the PPTP server is a PPTP-enabled VPN server that has one interface on the internet and one on your intranet. |
| L2TP/IPsec | L2TP enables you to encrypt multiprotocol traffic that is sent over any medium that supports point-to-point datagram delivery, such as IP or asynchronous transfer mode (ATM). L2TP is a combination of PPTP and Layer 2 Forwarding (L2F). L2TP represents the best features of PPTP and L2F. |
| SSTP       | SSTP is a tunneling protocol that uses the HTTPS protocol over TCP port 443 to pass traffic through firewalls and web proxies, which otherwise might block PPTP and L2TP/IPsec traffic. SSTP provides a mechanism to encapsulate PPP traffic over the SSL channel of the HTTPS protocol. The use of PPP allows support for strong authentication methods, such as EAP-TLS. SSL provides transport-level security with enhanced key negotiation, encryption, and integrity checking. |
| IKEv2      | IKEv2 uses the IPsec Tunnel Mode protocol over UDP port 500. IKEv2 supports mobility, making it a good protocol choice for a mobile workforce. IKEv2-based VPNs enable users to move easily between wireless hotspots or between wireless and wired connections. |

> [!CAUTION]
> You shouldn't use PPTP because of security vulnerabilities. Instead, use IKEv2 wherever possible because it is more secure and offers advantages over L2TP.

## Select an authentication option

The authentication of access clients is an important security concern. Authentication methods typically use an authentication protocol that is negotiated during the connection establishment process. The Remote Access server role supports the methods that the following table describes.

| Method    | Description                                                  |
| --------- | ------------------------------------------------------------ |
| PAP       | Password Authentication Protocol (PAP) uses plaintext passwords and is the least secure authentication protocol. It typically is negotiated if the remote access client and Remote Access server can't negotiate a more secure form of validation. Windows Server  includes PAP to support older client operating systems that support no other authentication method. |
| CHAP      | The Challenge Handshake Authentication Protocol (CHAP) is a challenge-response authentication protocol that uses the industry-standard MD5 hashing scheme to encrypt the response. Various vendors of network access servers and clients use CHAP. However, because CHAP requires that you use a reversibly encrypted password, you should consider using another authentication protocol, such as MS-CHAPv2. |
| MS-CHAPv2 | Microsoft Challenge Handshake Authentication Protocol version 2 (MS-CHAPv2) is a one-way, encrypted password, mutual-authentication protocol and provides improvements over CHAP. |
| EAP       | If you use Extensible Authentication Protocol (EAP), an arbitrary authentication mechanism authenticates a remote access connection. The remote access client and the authenticator, which is either the Remote Access server or the Remote Authentication Dial-In User Service (RADIUS) server, negotiate the exact authentication scheme they will use. Routing and Remote Access includes support for Extensible Authentication Protocol-Transport Layer Security (EAP-TLS) by default. You can plug in other EAP modules to the server that is running Routing and Remote Access to provide other EAP methods. |

## Additional considerations

In addition to the tunneling protocol and authentication method, before you deploy your organization’s VPN solution, you must consider the following:

- Ensure that your VPN server has two network interfaces. You must determine which network interface will connect to the internet and which will connect to your private network. During configuration, you must choose which network interface connects to the internet. If you specify the incorrect network interface, your remote-access VPN server will not operate correctly.
- Determine whether remote clients receive IP addresses from a DHCP server on your private network or from the remote-access VPN server that you are configuring. If you have a DHCP server on your private network, the remote access VPN server can lease 10 addresses at a time from the DHCP server and then assign those addresses to remote clients.
  If you don't have a DHCP server on your private network, the remote-access VPN server can automatically generate and assign IP addresses to remote clients. If you want the remote-access VPN server to assign IP addresses from a range that you specify, you must determine what that range should be.
- Determine whether you want a Remote Authentication Dial-In User Service (RADIUS) server or a remote-access VPN server that you configure to authenticate connection requests from VPN clients. Adding a RADIUS server is useful if you plan to install multiple remote-access VPN servers, wireless access points, or other RADIUS clients to your private network.
