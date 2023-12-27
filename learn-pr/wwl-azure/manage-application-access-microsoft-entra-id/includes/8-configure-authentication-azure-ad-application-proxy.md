Microsoft Entra application proxy is a secure and cost-effective remote access solution for on-premises applications. It provides an immediate transition path for “Cloud First” organizations to manage access to legacy on-premises applications that aren’t yet capable of using modern protocols.

Application Proxy is recommended for giving remote users access to internal resources. Application Proxy replaces the need for a VPN or reverse proxy for these remote access use cases. It isn't intended for users who are on the corporate network. These users who use Application Proxy for intranet access may experience undesirable performance issues.

## Plan your implementation

Prerequisites

You need to meet the following prerequisites before beginning your implementation. You can see more information on setting up your environment, including these prerequisites, in this tutorial.

 -  Connectors: Connectors are lightweight agents that you can deploy onto:<br>
     -  Physical hardware on-premises<br>
     -  A VM hosted within any hypervisor solution
     -  A VM hosted in Azure to enable outbound connection to the Application Proxy service.
 -  Microsoft Entra application proxy Connectors.
     -  Connector machines must be enabled for TLS 1.2 before installing the connectors.<br>
     -  If possible, deploy connectors in the same network and segment as the back-end web application servers. It's best to deploy connectors after you complete a discovery of applications.<br>
     -  We recommend that each connector group has at least two connectors to provide high availability and scale. Having three connectors is optimal in case you may need to service a machine at any point. Review the connector capacity table to help with deciding what type of machine to install connectors on. The larger the machine the more buffer and performant the connector will be.<br>
 -  Network access settings: Microsoft Entra application proxy connectors connect to Azure via HTTPS (TCP Port 443) and HTTP (TCP Port 80).<br>
     -  Terminating connector TLS traffic isn't supported and will prevent connectors from establishing a secure channel with their respective Azure App Proxy endpoints.<br>
     -  Avoid all forms of inline inspection on outbound TLS communications between connectors and Azure. Internal inspection between a connector and backend applications is possible, but could degrade the user experience, and as such, isn't recommended.<br>
     -  Load balancing of the connectors themselves is also not supported, or even necessary.<br>

## Important considerations before configuring Microsoft Entra application proxy

The following core requirements must be met in order to configure and implement Microsoft Entra application proxy.

 -  Azure onboarding: Before deploying application proxy, your user identities must be synchronized from an on-premises directory or created directly within your Microsoft Entra tenants. Identity synchronization allows Microsoft Entra ID to pre-authenticate users before granting them access to App Proxy published applications and to have the necessary user identifier information to perform single sign-on (SSO).<br>
 -  Conditional Access requirements: We don't recommend using Application Proxy for intranet access because this adds latency that will impact users. We recommend using Application Proxy with pre-authentication and Conditional Access policies for remote access from the internet. An approach to provide Conditional Access for intranet use is to modernize applications so they can directly authenticate with Microsoft Entra ID. Refer to Resources for migrating applications to Microsoft Entra ID for more information.<br>
 -  Service limits: To protect against overconsumption of resources by individual tenants, there are throttling limits set per application and tenant. To see these limits refer to Microsoft Entra service limits and restrictions. These throttling limits are based on a benchmark far above typical usage volume and provide ample buffer for a majority of deployments.<br>
 -  Public certificate: If you're using custom domain names, you must procure a TLS/SSL certificate. Depending on your organizational requirements, getting a certificate can take some time and we recommend beginning the process as early as possible. Azure Application Proxy supports standard, wildcard, or SAN-based certificates. For more details, see Configure custom domains with Microsoft Entra application proxy.<br>
 -  Domain requirements: Single sign-on to your published applications using Kerberos Constrained Delegation (KCD) requires that the server running the Connector and the server running the app are domain joined and part of the same domain or trusting domains. For detailed information on the topic, see KCD for single sign-on with Application Proxy. The connector service runs in the context of the local system and shouldn't be configured to use a custom identity.<br>
 -  DNS records for URLs<br>
     -  Before using custom domains in Application Proxy you must create a CNAME record in public DNS, allowing clients to resolve the custom defined external URL to the pre-defined Application Proxy address. Failing to create a CNAME record for an application that uses a custom domain prevents remote users from connecting to the application. Steps required to add CNAME records can vary from DNS provider to provider, so learn how to manage DNS records and record sets by using the Microsoft Entra admin center.<br>
     -  Similarly, connector hosts must be able to resolve the internal URL of applications being published.<br>
 -  Administrative rights and roles<br>
     -  Connector installation requires local admin rights to the Windows server that it's being installed on. It also requires a minimum of an Application Administrator role to authenticate and register the connector instance to your Microsoft Entra tenant.<br>
     -  Application publishing and administration require the Application Administrator role. Application Administrators can manage all applications in the directory including registrations, SSO settings, user and group assignments and licensing, Application Proxy settings, and consent. It doesn't grant the ability to manage Conditional Access. The Cloud Application Administrator role has all the abilities of the Application Administrator, except that it doesn't allow management of Application Proxy settings.<br>
 -  Licensing: Application Proxy is available through a Microsoft Entra ID P1 or P2 subscription.<br>
