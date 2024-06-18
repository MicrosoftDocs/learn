[Develop secure applications on Azure](/azure/security/develop/secure-develop) is a general guide to the security questions and controls you should consider at each phase of the software development lifecycle when developing applications for the cloud.

## Cloud security advantages<br>

It's important to understand the [division of responsibility](/azure/security/fundamentals/shared-responsibility) between you and Microsoft. On-premises, you own the whole stack but as you move to the cloud some responsibilities transfer to Microsoft.

There are [security advantages to being in the cloud](/azure/security/fundamentals/shared-responsibility#cloud-security-advantages). In an on-premises environment, organizations likely have unmet responsibilities and limited resources available to invest in security, which creates an environment where attackers are able to exploit vulnerabilities at all layers.

Organizations are able to improve their threat detection and response times by using a provider's cloud-based security capabilities and cloud intelligence. By shifting responsibilities to the cloud provider, organizations can get more security coverage, which enables them to reallocate security resources and budget to other business priorities.

## Security advantages of a PaaS cloud service model

Let's look at the security advantages of an Azure PaaS deployment versus on-premises.

:::image type="content" source="../media/advantages-of-platform-as-a-service-e78b8c76.png" alt-text="Diagram showing an example of advantages of the platform as a service model.":::


Starting at the bottom of the stack, the physical infrastructure, Microsoft mitigates common risks and responsibilities. Because the Microsoft cloud is continually monitored by Microsoft, it's hard to attack. It doesn't make sense for an attacker to pursue the Microsoft cloud as a target. Unless the attacker has lots of money and resources, the attacker is likely to move on to another target.

In the middle of the stack, there's no difference between a PaaS deployment and on-premises. At the application layer and the account and access management layer, you have similar risks. In the next steps section of this article, we'll guide you to best practices for eliminating or minimizing these risks.

At the top of the stack, data governance and rights management, you take on one risk that can be mitigated by key management. (Key management is covered in best practices.) While key management is an additional responsibility, you have areas in a PaaS deployment that you no longer have to manage so you can shift resources to key management.

The Azure platform also provides you with strong DDoS protection by using various network-based technologies. However, all types of network-based DDoS protection methods have their limits on a per-link and per-datacenter basis. To help avoid the impact of large DDoS attacks, you can take advantage of Azure's core cloud capability of enabling you to quickly and automatically scale out to defend against DDoS attacks. We'll go into more detail on how you can do this in the recommended practices articles.

## Modernizing the Defender for Cloud's mindset<br>

With PaaS deployments come a shift in your overall approach to security. You shift from needing to control everything yourself to sharing responsibility with Microsoft.

Another significant difference between PaaS and traditional on-premises deployments is a new view of what defines the primary security perimeter. Historically, the primary on-premises security perimeter was your network and most on-premises security designs use the network as its primary security pivot. For PaaS deployments, you're better served by considering identity to be the primary security perimeter.

## Adopt a policy of identity as the primary security perimeter

One of the five essential characteristics of cloud computing is broad network access, which makes network-centric thinking less relevant. The goal of much of cloud computing is to allow users to access resources regardless of location. For most users, their location is going to be somewhere on the Internet.

The following figure shows how the security perimeter has evolved from a network perimeter to an identity perimeter. Security becomes less about defending your network and more about defending your data, as well as managing the security of your apps and users. The key difference is that you want to push security closer to what's important to your company.

:::image type="content" source="../media/the-evolving-security-perimeter-5a7b51a8.png" alt-text="Diagram showing how the security perimeter has evolved from a network perimeter to an identity perimeter.":::


Initially, Azure PaaS services (for example, web roles and Azure SQL) provided little or no traditional network perimeter defenses. It was understood that the element's purpose was to be exposed to the Internet (web role) and that authentication provides the new perimeter (for example, BLOB or Azure SQL).

Modern security practices assume that the adversary has breached the network perimeter. Therefore, modern defense practices have moved to identity. Organizations must establish an identity-based security perimeter with strong authentication and authorization hygiene (best practices).

Principles and patterns for the network perimeter have been available for decades. In contrast, the industry has relatively less experience with using identity as the primary security perimeter. With that said, we have accumulated enough experience to provide some general recommendations that are proven in the field and apply to almost all PaaS services.

The following are best practices for managing the identity perimeter.

Best practice: Secure your keys and credentials to secure your PaaS deployment. Detail: Losing keys and credentials is a common problem. You can use a centralized solution where keys and secrets can be stored in hardware security modules (HSMs). Azure Key Vault safeguards your keys and secrets by encrypting authentication keys, storage account keys, data encryption keys, .pfx files, and passwords using keys that are protected by HSMs.

Best practice: Don't put credentials and other secrets in source code or GitHub. Detail: The only thing worse than losing your keys and credentials is having an unauthorized party gain access to them. Attackers can take advantage of bot technologies to find keys and secrets stored in code repositories such as GitHub. Don't put key and secrets in these public code repositories.

Best practice: Protect your VM management interfaces on hybrid PaaS and IaaS services by using a management interface that enables you to remote manage these VMs directly. Detail: Remote management protocols such as SSH, RDP, and PowerShell remoting can be used. In general, we recommend that you don't enable direct remote access to VMs from the internet.

If possible, use alternate approaches like using virtual private networks in an Azure virtual network. If alternative approaches aren't available, ensure that you use complex passphrases and two-factor authentication (such as Microsoft Entra multifactor authentication).

Best practice: Use strong authentication and authorization platforms. Detail: Use federated identities in Microsoft Entra ID instead of custom user stores. When you use federated identities, you take advantage of a platform-based approach and you delegate the management of authorized identities to your partners. A federated identity approach is especially important when employees are terminated and that information needs to be reflected through multiple identity and authorization systems.

Use platform-supplied authentication and authorization mechanisms instead of custom code. The reason is that developing custom authentication code can be error prone. Most of your developers aren't security experts and are unlikely to be aware of the subtleties and the latest developments in authentication and authorization. Commercial code (for example, from Microsoft) is often extensively security reviewed.

Use two-factor authentication. Two-factor authentication is the current standard for authentication and authorization because it avoids the security weaknesses inherent in username and password types of authentication. Access to both the Azure management (portal/remote PowerShell) interfaces and customer-facing services should be designed and configured to use Microsoft Entra multifactor authentication.

Use standard authentication protocols, such as OAuth2 and Kerberos. These protocols have been extensively peer reviewed and are likely implemented as part of your platform libraries for authentication and authorization.

## Use threat modeling during application design

The Microsoft Security Development Lifecycle specifies that teams should engage in a process called threat modeling during the design phase. To help facilitate this process, Microsoft has created the SDL Threat Modeling Tool. Modeling the application design and enumerating STRIDE (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service DoS, and Elevation) of privilege threats across all trust boundaries can catch design errors early on.

The following table lists the STRIDE threats and gives some example mitigations that use Azure features. These mitigations won't work in every situation.

| **Threat**             | **Security property** | **Potential Azure platform mitigations**                                                              |
| ---------------------- | --------------------- | ----------------------------------------------------------------------------------------------------- |
| Spoofing               | Authentication        | Require HTTPS connections.                                                                            |
| Tampering              | Integrity             | Validate TLS/SSL certificates.                                                                        |
| Repudiation            | Non-repudiation       | Enable Azure monitoring and diagnostics.                                                              |
| Information disclosure | Confidentiality       | Encrypt sensitive data at rest by using service certificates.                                         |
| Denial of service      | Availability          | Monitor performance metrics for potential denial-of-service conditions. Implement connection filters. |
| Elevation of privilege | Authorization         | Use Privileged Identity Management.                                                                   |

## Develop on Azure App Service

[Azure App Service](/azure/app-service/overview) is a PaaS offering that lets you create web and mobile apps for any platform or device and connect to data anywhere, in the cloud or on-premises. App Service includes the web and mobile capabilities that were previously delivered separately as Azure Websites and Azure Mobile Services. It also includes new capabilities for automating business processes and hosting cloud APIs. As a single integrated service, App Service brings a rich set of capabilities to web, mobile, and integration scenarios.

Following are best practices for using App Service.

Best practice: [Authenticate through Microsoft Entra ID](/azure/app-service/overview-authentication-authorization). Detail: App Service provides an OAuth 2.0 service for your identity provider. OAuth 2.0 focuses on client developer simplicity while providing specific authorization flows for web applications, desktop applications, and mobile phones. Microsoft Entra ID uses OAuth 2.0 to enable you to authorize access to mobile and web applications.

Best practice: Restrict access based on the need to know and least privilege security principles. Detail: Restricting access is imperative for organizations that want to enforce security policies for data access. You can use Azure RBAC to assign permissions to users, groups, and applications at a certain scope. To learn more about granting users access to applications, see [Get started with access management](/azure/role-based-access-control/overview).

Best practice: Protect your keys. Detail: Azure Key Vault helps safeguard cryptographic keys and secrets that cloud applications and services use. With Key Vault, you can encrypt keys and secrets (such as authentication keys, storage account keys, data encryption keys, .PFX files, and passwords) by using keys that are protected by hardware security modules (HSMs). For added assurance, you can import or generate keys in HSMs. See [Azure Key Vault](/azure/key-vault/general/overview) to learn more. You can also use Key Vault to manage your TLS certificates with auto-renewal.

Best practice: Restrict incoming source IP addresses. Detail: [App Service Environment](/azure/app-service/environment/intro) has a virtual network integration feature that helps you restrict incoming source IP addresses through network security groups. Virtual networks enable you to place Azure resources in a non-internet, routable network that you control access to. To learn more, see [Integrate your app with an Azure virtual network](/azure/app-service/overview-vnet-integration).

Best practice: Monitor the security state of your App Service environments. Detail: Use [Microsoft Defender for Cloud to monitor your App Service environments](/azure/security-center/asset-inventory). When Defender for Cloud identifies potential security vulnerabilities, it creates recommendations that guide you through the process of configuring the needed controls.

## Azure Cloud Services

[Azure Cloud Services](/azure/cloud-services/cloud-services-choose-me) is an example of a PaaS. Like Azure App Service, this technology is designed to support applications that are scalable, reliable, and inexpensive to operate. In the same way that App Service is hosted on virtual machines (VMs), so too is Azure Cloud Services. However, you have more control over the VMs. You can install your own software on VMs that use Azure Cloud Services, and you can access them remotely.

## Install a web application firewall

Web applications are increasingly targets of malicious attacks that exploit common known vulnerabilities. Common among these exploits are SQL injection attacks, cross site scripting attacks to name a few. Preventing such attacks in application code can be challenging and may require rigorous maintenance, patching and monitoring at many layers of the application topology. A centralized web application firewall helps make security management much simpler and gives better assurance to application administrators against threats or intrusions. A WAF solution can also react to a security threat faster by patching a known vulnerability at a central location versus securing each of individual web applications.

[Web Application Firewall (WAF)](/azure/web-application-firewall/overview) provides centralized protection of your web applications from common exploits and vulnerabilities.

## Distributed denial of service (DDoS) protection

[Azure DDoS Protection](/azure/ddos-protection/ddos-protection-overview), combined with application-design best practices, provides enhanced DDoS mitigation features to provide more defense against DDoS attacks. You should enable [Azure DDOS Protection](/azure/ddos-protection/ddos-protection-overview) on any perimeter virtual network.

## Monitor the performance of your applications

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your application. An effective monitoring strategy helps you understand the detailed operation of the components of your application. It helps you increase your uptime by notifying you of critical issues so that you can resolve them before they become problems. It also helps you detect anomalies that might be security related.

Use [Azure Application Insights](/azure/azure-monitor/app/app-insights-overview) to monitor availability, performance, and usage of your application, whether it's hosted in the cloud or on-premises. By using Application Insights, you can quickly identify and diagnose errors in your application without waiting for a user to report them. With the information that you collect, you can make informed choices on your application's maintenance and improvements.

Application Insights has extensive tools for interacting with the data that it collects. Application Insights stores its data in a common repository. It can take advantage of shared functionality such as alerts, dashboards, and deep analysis with the Kusto query language.

## Perform security penetration testing

Validating security defenses is as important as testing any other functionality. Make [penetration testing](/azure/security/fundamentals/pen-testing) a standard part of your build and deployment process. Schedule regular security tests and vulnerability scanning on deployed applications, and monitor for open ports, endpoints, and attacks.

Fuzz testing is a method for finding program failures (code errors) by supplying malformed input data to program interfaces (entry points) that parse and consume this data.
