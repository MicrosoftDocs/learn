
Tailwind Traders has several applications that have front-end components that currently run on-premises in their perimeter network with the back-end elements on a protected internal network. One of Tailwind Traders’ aims in moving to a hybrid cloud is to retire their perimeter network and host any public-facing workloads in the cloud. Because of compliance concerns and workload owners’ concerns, some of these applications should remain physically in Tailwind Traders facilities instead of being hosted in an Azure datacenter.

Tailwind Traders has some other applications that are accessed through VPN connections into the internal protected networks in the Sydney, Melbourne, and Auckland datacenters. These applications generally require users to authenticate with their on-premises Active Directory.

In this unit, you’ll learn about the technologies that allow Tailwind Traders to maintain applications that users connect to through Azure even though data or the application itself are still hosted on Tailwind Traders equipment.

## What is Azure Relay?

[Azure Relay](https://docs.microsoft.com/azure/azure-relay/relay-what-is-it), previously called Service Bus Relay, is a service that allows you to securely expose workloads that run on your organization’s internal network to the public cloud. The service enables you to do this without opening an inbound port on a perimeter network firewall.

Azure Relay supports the following scenarios between on-premises services and applications running in Azure:

- Traditional one-way, request/response, and peer-to-peer communication.
- Event distribution to enable publish/subscribe scenarios.
- Bidirectional and unbuffered socket communication across network boundaries.

Azure Relay has the following features:

- Hybrid Connections. Hybrid Connections uses the open-standard web sockets and can be used in multiplatform architectures. It supports .NET Core, .NET Framework, Java script/Node.JS, standards-based open protocols, and remote procedure call (RPC) programming models.
- WCF Relays. WCF Relays uses Windows Communication Foundation (WCF) to enable remote procedure calls. This is an existing option that many customers use with their WCF programs. It also supports WCF Relay and .NET Framework.

Azure Relay allows Tailwind Traders to publish some applications that run on the internal network to clients on the internet without requiring a VPN connection. The company should use Azure Relay instead of App Service Hybrid Connections when there is no front-end web app running in Azure. Azure Relay should be used instead of Azure AD Application Proxy when the application doesn’t require Azure AD Authentication.

## What are Azure App Service Hybrid Connections?

[App Service Hybrid Connections](ttps://docs.microsoft.com/azure/app-service/app-service-hybrid-connections) can use any application resource in any network that’s able to send outbound requests to Azure on port 443. For example, you can use Azure App Service Hybrid Connections to allow a web app running in Azure to use a SQL Server database running on-premises. Hybrid Connections provide access from an app running in Azure to a Transmission Control Protocol (TCP) endpoint. App Service Hybrid Connections aren’t limited to workloads running on Windows Server platforms and you can configure App Service Hybrid Connections to access any resource provided it functions as a TCP endpoint, regardless of which application protocol is being used. For example, you could configure an App Service Hybrid Connection between a web app running in Azure and a MySQL database running on an on-premises Linux virtual machine.

Hybrid Connections use a relay agent that you deploy in a location where the agent can establish connectivity to the TCP endpoint on the internal network and establish a connection to Azure. This connection is secured by using Transport Layer Security (TLS) 1.2 and shared access signature (SAS) keys are used for authentication and authorization. Figure 12 depicts an App Service Hybrid Connection between a web app running in Azure and a database endpoint running on-premises.

:::image type="content" source="../media/image12.png" alt-text="App Service Hybrid Connection between Web App in Azure and database endpoint on-premises." border="false":::

Figure 12. App Service Hybrid Connection.

App Service Hybrid Connections have the following functionality:

- Apps running in Azure can access on-premises systems and services in a secure manner.
- The on-premises system or service doesn’t need to be directly accessible to hosts on the internet.
- It’s not necessary to open a port in the firewall to allow inbound access from Azure to the relay agent. All communication is initiated in an outbound manner from the relay agent by using port 443.

App Service Hybrid Connections have the following limitations:

- Can’t be used to mount an SMB share on an on-premises network.
- Can’t leverage the UDP protocol.
- Can’t access TCP-based services that use dynamic ports.
- Doesn’t support Lightweight Directory Access Protocol (LDAP) because of the reliance on User Datagram Protocol (UDP).
- Can’t be used to perform an Active Directory Domain Services domain-join operation.

For Tailwind Traders, App Service Hybrid connections will allow them to retire several applications that currently have their front ends running on the Tailwind Traders perimeter network. These apps can be migrated to Azure, with App Service Hybrid Connections providing a secure connection through to protected networks that host the app’s back-end components.

## What is Azure AD Application Proxy?

[Azure AD Application Proxy](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy) allows you to provide secure remote access to a web application that’s
running in an on-premises environment through an external URL. Application Proxy can be configured to allow remote access and single sign-on to SharePoint, Teams, IIS web applications and Remote Desktop. Application Proxy can be implemented as a replacement for VPNs to internal networks or reverse proxies.

Application Proxy functions with the following applications:

- Web applications that use [Integrated Windows Authentication](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy-configure-single-sign-on-with-kcd)
- Web applications that use [header-based or form-based authentication](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy-configure-single-sign-on-with-ping-access)
- Applications hosted through [Remote Desktop Gateway](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy-integrate-with-remote-desktop-services)

Application Proxy functions in the following manner depicted in Figure 13:

1. The user connects to the application through a publicly available endpoint and then performs an Azure AD sign-on.
2. A token is forwarded to the user’s device after the sign-in completes.
3. The client device forwards token to the Application Proxy service, which returns the User Principal Name (UPN) and Security Principal Name (SPN) from the token. Application proxy then forwards the request to the Application Proxy Connector.
4. If single sign-on has been enabled, the Application Proxy Connector performs additional authentication.
5. The Application Proxy Connector forwards request to the on-premises application.
6. The response is sent through connector and Application Proxy service to user.

:::image type="content" source="../media/image13.png" alt-text=" Application Proxy functionality with user outside organizational network making connection through Application Proxy Service to on-premises application." border="false":::

Figure 13. Application Proxy.

**Note:** Users of internal networks that allow direct connection to applications should avoid using Application Proxy.

At Tailwind Traders, Azure AD Application proxy can be used to provide external users access to internal applications that use Active Directory authentication.
