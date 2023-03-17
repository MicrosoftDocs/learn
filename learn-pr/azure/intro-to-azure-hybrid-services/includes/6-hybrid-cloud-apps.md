
Tailwind Traders has several applications that have front-end components that currently run on-premises in a perimeter network. The back-end elements are on a protected internal network. One of Tailwind Traders' aims in moving to a hybrid cloud is to retire its perimeter network and host any public-facing workloads in the cloud. Because of compliance concerns and workload owners' concerns, some of these applications should remain physically in Tailwind Traders facilities instead of being hosted in an Azure datacenter.

Tailwind Traders has some other applications that are accessed through VPN connections into the internal protected networks in the Sydney, Melbourne, and Auckland datacenters. These applications generally require users to authenticate with their on-premises Active Directory instance.

In this unit, you'll learn about the technologies that allow Tailwind Traders to maintain applications that users connect to through Azure even though data or the application itself is still hosted on Tailwind Traders equipment.

## What is Azure Relay?

Azure Relay is a service that you can use to securely expose workloads that run on your organization's internal network to the public cloud. The service enables you to do this without opening an inbound port on a perimeter network firewall.

Azure Relay supports the following scenarios between on-premises services and applications running in Azure:

- Traditional one-way, request/response, and peer-to-peer communication
- Event distribution to enable publish/subscribe scenarios
- Bidirectional and unbuffered socket communication across network boundaries

Azure Relay has the following features:

- **Hybrid Connections**. This feature uses open-standard web sockets and can be used in multiplatform architectures. It supports .NET Core, .NET Framework, JavaScript/Node.js, standards-based open protocols, and remote procedure call (RPC) programming models.
- **WCF Relay**. This feature uses Windows Communication Foundation (WCF) to enable remote procedure calls. It's option that many customers use with their WCF programs. It also supports the .NET Framework.

Azure Relay allows Tailwind Traders to publish some applications that run on the internal network to clients on the internet without requiring a VPN connection. The company should use Azure Relay instead of Azure App Service Hybrid Connections when there is no front-end web app running in Azure. Azure Relay should be used instead of Azure Active Directory (Azure AD) Application Proxy when the application doesn't require Azure AD authentication.

## What is App Service Hybrid Connections?

The Hybrid Connections feature of Azure App Service can use any application resource in any network that can send outbound requests to Azure on port 443. For example, you can use Hybrid Connections to allow a web app running in Azure to use a SQL Server database running on-premises. The Hybrid Connections feature provides access from an app running in Azure to a Transmission Control Protocol (TCP) endpoint. 

Hybrid Connections isn't limited to workloads running on Windows Server platforms. You can configure Hybrid Connections to access any resource that functions as a TCP endpoint, regardless of which application protocol is being used. For example, you can configure a hybrid connection between a web app running in Azure and a MySQL database running on an on-premises Linux virtual machine.

Hybrid Connections uses a relay agent that you deploy in a location where the agent can establish connectivity to the TCP endpoint on the internal network and establish a connection to Azure. This connection is secured through Transport Layer Security (TLS) 1.2. Shared access signature (SAS) keys are used for authentication and authorization. 

The following image shows a hybrid connection between a web app running in Azure and a database endpoint running on-premises.

:::image type="content" source="../media/6-connection.png" alt-text="Diagram showing hybrid connection between a web app in Azure and a database endpoint on-premises." border="false" lightbox="../media/6-connection.png":::

Hybrid Connections has the following functionality:

- Apps running in Azure can access on-premises systems and services in a secure manner.
- The on-premises systems or services don't need to be directly accessible to hosts on the internet.
- It's not necessary to open a port in the firewall to allow inbound access from Azure to the relay agent. All communication is initiated in an outbound manner from the relay agent through port 443.

Hybrid Connections has the following limitations:

- It can't be used to mount an SMB share on an on-premises network.
- It can't use the User Datagram Protocol (UDP).
- It can't access TCP-based services that use dynamic ports.
- It doesn't support Lightweight Directory Access Protocol (LDAP) because of the reliance on UDP.
- It can't be used to perform an Active Directory Domain Services domain-join operation.

For Tailwind Traders, Hybrid Connections will enable the retirement of several applications that currently have their front ends running on the Tailwind Traders perimeter network. These apps can be migrated to Azure. Hybrid Connections will then provide a secure connection to protected networks that host the app's back-end components.

## What is Azure AD Application Proxy?

Azure AD Application Proxy allows you to provide secure remote access to a web application that's running in an on-premises environment through an external URL. You can configure Application Proxy to allow remote access and single sign-on to SharePoint, Microsoft Teams, IIS web applications, and Remote Desktop. Application Proxy can be implemented as a replacement for VPNs to internal networks or reverse proxies.

Application Proxy functions with the following applications:

- Web applications that use Integrated Windows Authentication
- Web applications that use header-based or form-based authentication
- Applications hosted through Remote Desktop Gateway

Application Proxy functions in the following way:

1. The user connects to the application through a publicly available endpoint and then performs an Azure AD sign-on.
2. A token is forwarded to the user's device after the sign-in is complete.
3. The client device forwards the token to the Application Proxy service, which returns the user principal name (UPN) and security principal name (SPN) from the token. Application Proxy then forwards the request to the Application Proxy connector.
4. If single sign-on has been enabled, the Application Proxy connector performs additional authentication.
5. The Application Proxy connector forwards the request to the on-premises application.
6. The response is sent through the connector and the Application Proxy service to the user.

The following image shows this process:

:::image type="content" source="../media/6-application-proxy-process-diagram.png" alt-text="Diagram showing Application Proxy functionality with the user outside the organizational network making a connection through Application Proxy to an on-premises application." border="false" lightbox="../media/6-application-proxy-process-diagram.png":::

Users of internal networks that allow direct connection to applications should avoid using Application Proxy.

Tailwind Traders can use Azure AD Application Proxy to give external users access to internal applications that use Active Directory authentication.
