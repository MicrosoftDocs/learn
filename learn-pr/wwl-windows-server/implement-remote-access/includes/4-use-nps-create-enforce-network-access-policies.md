To manage remote access users more easily, organizations like Contoso deploy and configure the NPS server role. NPS enables Contoso to create and enforce organization-wide network access policies for connection request authentication and authorization. They can use NPS to implement network-access authentication, authorization, and accounting with any combination of the following functions:

- RADIUS server
- RADIUS proxy
- RADIUS accounting

## **RADIUS server**

RADIUS is an industry-standard authentication protocol that vendors use to support the exchange of authentication information between elements of a remote-access solution. NPS is the Microsoft implementation of a RADIUS server. NPS enables the use of a heterogeneous set of wireless, switch, remote access, or VPN equipment. You can use NPS with the Routing and Remote Access service, which is available in the Windows Server operating system. In addition, you can use NPS with the Remote Access role in Windows Server.

NPS performs centralized connection authentication, authorization, and accounting for wireless, RD Gateway servers, authenticating switches, VPNs, and dial-up connections. When using NPS as a RADIUS server, you configure network access servers (NASs), such as wireless access points and VPN servers, which are also known as RADIUS clients in NPS.

You also configure the network policies that NPS uses to authorize connection requests, and you can configure RADIUS accounting so that NPS logs accounting information to log files on the local hard disk or in a Microsoft SQL Server database.

> [!IMPORTANT]
> You can't install NPS on Server Core editions of Windows Server.

When an NPS server is a member of an Active Directory Domain Services (AD DS) domain, NPS uses AD DS as its user-account database and provides single sign-on (SSO) capability. This means that the same set of user credentials enable network-access control, such as authenticating and authorizing access to a network, and access to resources within the AD DS domain.

Organizations that maintain network access, such as ISPs, have the challenge of managing a variety of network-access methods from a single administration point, regardless of the type of network-access equipment they use. The RADIUS standard supports this requirement. RADIUS is a client-server protocol that enables network-access equipment, when used as RADIUS clients, to submit authentication and accounting requests to a RADIUS server.

A RADIUS server has access to user-account information and can verify network-access authentication credentials. If the user’s credentials are authentic and RADIUS authorizes the connection attempt, the RADIUS server then authorizes the user’s access based on configured conditions, and logs the network access connection in an accounting log. Using RADIUS allows you to collect and maintain the network access user authentication, authorization, and accounting data in a central location, rather than on each access server.

## **RADIUS proxy**

When using NPS as a RADIUS proxy, you configure connection request policies that indicate which connection requests the NPS server will forward to other RADIUS servers and to which RADIUS servers you want to forward connection requests. You can also configure NPS to forward accounting data for logging by one or more computers in a remote RADIUS server group. With NPS, your organization can also outsource its remote-access infrastructure to a service provider, while retaining control over user authentication, authorization, and accounting. You can create NPS configurations for the following solutions:

- VPN servers.
- Wireless access points.
- RD Gateway servers.
- Outsourced VPN, dial-up, or wireless access.
- Internet access.
- Authenticated access to extranet resources for business partners.

### **RADIUS accounting**

You can configure NPS to perform RADIUS accounting for user authentication requests, Access-Accept messages, Access-Reject messages, accounting requests and responses, and periodic status updates. NPS enables you to log to a Microsoft SQL Server database in addition to, or instead of, logging to a local file.
