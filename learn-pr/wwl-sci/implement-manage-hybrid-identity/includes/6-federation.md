Federation can use a new or existing on-premises Active Directory farm in Windows Server 2012 R2 (or later), and Microsoft Entra Connect enable users to log into Microsoft Entra resources using their on-premises password.

:::image type="content" source="../media/sc300-federation-flow-diagram-8eb4c413.png" alt-text="Diagram of federation between on-premises and Microsoft Entra ID. Shows users able log into both on-premises and cloud resources with a single shared login.":::


Federation is a collection of domains that have established trust. The level of trust varies, but typically includes authentication and almost always includes authorization. A typical federation might include a number of organizations that have established trust for shared access to a set of resources.

You can federate your on-premises environment with Microsoft Entra ID and use this federation for authentication and authorization. This sign-in method ensures that all user authentication occurs on-premises. This method allows administrators to implement more rigorous levels of access control. Federation with AD FS and PingFederate is available.

With federated sign-in, your users can sign in to Microsoft Entra based services with their on-premises passwords. While they're on the corporate network, they don't even have to enter their passwords. By using the federation option with AD FS, you can deploy a new or existing farm with AD FS in Windows Server 2012 R2 or later. If you choose to specify an existing farm, Microsoft Entra Connect configures the trust between your farm and Microsoft Entra ID so that your users can sign in.

## Requirement to deploy federation with AD FS and Microsoft Entra Connect

Deploying to an AD FS farm, you need:

 -  Local administrator credentials on your federation servers.
 -  Local administrator credentials on any workgroup servers (not domain-joined) that you intend to deploy the Web Application Proxy role on.
 -  The machine that you run the wizard on to be able to connect to any other machines that you want to install AD FS or Web Application Proxy on by using Windows Remote Management.

## Set up your federation using Microsoft Entra Connect to connect to an AD FS farm

:::image type="content" source="../media/sc300-federation-setup-dialog-f995542d.png" alt-text="Screenshot of Microsoft Entra Connect application showing the create and connect to an AD FS farm dialog.":::


**Specify the AD FS servers** Specify the servers where you want to install AD FS. You can add one or more servers, depending on your capacity needs. Before you set up this configuration, join all AD FS servers to Active Directory. This step isn't required for the Web Application Proxy servers. Microsoft recommends installing a single AD FS server for test and pilot deployments. After the initial configuration, you can add and deploy more servers to meet your scaling needs by running Microsoft Entra Connect again.

**Specify the Web Application Proxy servers** Specify your Web Application Proxy servers. The Web Application Proxy server is deployed in your perimeter network, facing the extranet. It supports authentication requests from the extranet. You can add one or more servers, depending on your capacity needs. After the initial configuration, you can add and deploy more servers to meet your scaling needs by running Microsoft Entra Connect again.

**Specify the service account for the AD FS service** The AD FS service requires a domain service account to authenticate users and to look up user information in Active Directory. It can support two types of service accounts:

 -  Group managed service account
 -  Domain user account

**Select the Microsoft Entra domain that you want to federate** Use the Microsoft Entra domain page to set up the federation relationship between AD FS and Microsoft Entra ID. Here, you configure AD FS to provide security tokens to Microsoft Entra ID. You also configure Microsoft Entra ID to trust the tokens from this AD FS instance. On this page, you can configure only a single domain in the initial installation. You can configure more domains later by running Microsoft Entra Connect again.

## Microsoft Entra Connect tools to manage your federation

You can complete various AD FS-related tasks in Microsoft Entra Connect with minimal user intervention by using the Microsoft Entra Connect wizard. Even after you've finished installing Microsoft Entra Connect by running the wizard, you can run the wizard again to do other tasks. For example, you can use the wizard to repair the trust with Microsoft 365, federate with Microsoft Entra ID using alternate sign in ID, and add an AD FS Web Application Proxy (WAP) server.

**Repair the trust** You can use Microsoft Entra Connect to check the current health of the AD FS and Microsoft Entra ID trust and take appropriate actions to repair the trust.

**Federate with Microsoft Entra ID using AlternateID** It is recommended that the on-premises User Principal Name(UPN) and the cloud User Principal Name are kept the same. If the on-premises UPN uses a non-routable domain (ex. Contoso.local) or cannot be changed due to local application dependencies, we recommend setting up alternate sign in ID. Alternate sign in ID allows you to configure a sign-in experience where users can sign in with an attribute other than their UPN, such as mail. The choice for User Principal Name in Microsoft Entra ID Connect defaults to the userPrincipalName attribute in Active Directory. If you choose any other attribute for User Principal Name and are federating using AD FS, then Microsoft Entra Connect will configure AD FS for alternate sign in ID.

**Add a federated domain** It's easy to add a domain to be federated with Microsoft Entra ID by using Microsoft Entra Connect. Microsoft Entra Connect adds the domain for federation and modifies the claim rules to correctly reflect the issuer when you have multiple domains federated with Microsoft Entra ID.

Along with **Add and AD FS Server** and **Add an AD FS Web Application Proxy server**.

## Device writeback

Device writeback is used to enable device-based conditional Access for ADFS-protected devices. This conditional Access provides extra security and assurance that access to applications is granted only to trusted devices. Device writeback enables this security by synchronizing all devices registered in Azure back to the on-premises Active Directory. When configured during setup, the following operations are performed to prepare the AD forest:

 -  If they do not exist already, create and configure new containers and objects under: **CN=Device Registration Configuration,CN=Services,CN=Configuration,\[forest dn \]**.
 -  If they do not exist already, create and configure new containers and objects under: **CN=RegisteredDevices,\[domain-dn\]**. Device objects will be created in this container.
 -  Set necessary permissions on the Microsoft Entra Connector account, to manage devices on your Active Directory.
