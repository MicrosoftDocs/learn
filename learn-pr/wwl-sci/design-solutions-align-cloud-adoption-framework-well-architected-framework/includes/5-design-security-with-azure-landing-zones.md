This design area creates a foundation for security across your Azure, hybrid, and multicloud environments. You can enhance this foundation later with security guidance outlined in the [Secure methodology](/azure/cloud-adoption-framework/secure/) of the Cloud Adoption Framework.

## Design area review

**Involved roles or functions:** This design area is led by [cloud security](/azure/cloud-adoption-framework/organize/cloud-security), specifically the [security architects within that team](/azure/cloud-adoption-framework/organize/cloud-security-architecture). The [cloud platform](/azure/cloud-adoption-framework/organize/cloud-platform) and [cloud center of excellence](/azure/cloud-adoption-framework/organize/cloud-center-of-excellence) are required to review networking and identity decisions. The collective roles might be required to define and implement the technical requirements coming from this exercise. More advanced security guardrails might also need support from [cloud governance](/azure/cloud-adoption-framework/organize/cloud-governance).

**Scope:** The goal of this exercise is to understand security requirements and implement them consistently across all workloads in your cloud platform. The primary scope of this exercise focuses on security operations tooling and access control. This scope includes zero trust and advanced network security.

**Out of scope:** This exercise focuses on the foundation for a modern security operations center in the cloud. To streamline the conversation, this exercise doesn't address some of the disciplines in the [CAF Secure methodology](/azure/cloud-adoption-framework/secure/). Security operations, asset protection, and innovation security will build on your Azure landing zone deployment. However, they're out of scope for this design area discussion.

## Design area overview

Security is a core consideration for all customers, in every environment. When designing and implementing an Azure landing zone, security should be a consideration throughout the process.

The security design area focuses on considerations and recommendations for landing zone decisions. The [Secure methodology](/azure/cloud-adoption-framework/secure/) of the Cloud Adoption Framework also provides further in-depth guidance for holistic security processes and tools.

**New (greenfield) cloud environment:** To start your cloud journey with a small set of subscriptions, see [Create your initial Azure subscriptions](/azure/cloud-adoption-framework/ready/azure-best-practices/initial-subscriptions). Also, consider using Bicep deployment templates in building out your Azure landing zones. For more information, see [Azure Landing Zones Bicep - Deployment Flow](https://github.com/Azure/ALZ-Bicep/wiki/DeploymentFlow).

**Existing (brownfield) cloud environment:** Consider using the following [Microsoft Entra](https://www.microsoft.com/security/business/microsoft-entra) identity and access services if you are interested in applying the principles from security design area to existing Azure environments:

-   Make use of Microsoft's [top 10 Azure security best practices](/azure/cloud-adoption-framework/secure/security-top-10). This guidance summarizes field-proven guidance from Microsoft cloud solution architects (CSAs) as well as Microsoft Partners.
-   Deploy [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync) to provide your local Active Directory Domain Services (AD DS) users with secure single sign-on (SSO) to your Microsoft Entra ID-backed applications. An additional benefit to configuring hybrid identity is you can enforce [Microsoft Entra multifactor authentication](/azure/active-directory/authentication/concept-mfa-howitworks) and [Microsoft Entra Password Protection](/azure/active-directory/authentication/concept-password-ban-bad-on-premises) to further protect these identities
-   Consider [Microsoft Entra Conditional Access](/azure/active-directory/conditional-access/overview) to provided secure authentication to your cloud apps and Azure resources.
-   Implement [Microsoft Entra Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) to ensure least-privilege access and deep reporting in your entire Azure environment. Teams should begin recurring access reviews to ensure the right people and service principles have current and correct authorization levels.
-   Make use of the recommendations, alerting, and remediation capabilities of [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction). Your security team can also integrate Microsoft Defender for Cloud into [Microsoft Sentinel](/azure/sentinel/overview) if they need a more robust, centrally managed hybrid and multicloud Security Information Event Management (SIEM)/Security Orchestration and Response (SOAR) solution.

The [Azure Landing Zones Bicep - Deployment Flow](https://github.com/Azure/ALZ-Bicep/wiki/DeploymentFlow) repository contains a number of Bicep deployment templates that can accelerate your greenfield and brownfield Azure landing zone deployments. These templates already have Microsoft proven-practice security guidance integrated within them.

For more information on working in brownfield cloud environments, see [Brownfield environment considerations](/azure/cloud-adoption-framework/ready/landing-zone/brownfield-considerations).

### Microsoft cloud security benchmark

The Microsoft cloud security benchmark includes high-impact security recommendations to help you secure most of the services you use in Azure. You can think of these recommendations as _general_ or _organizational_, as they're applicable to most Azure services. The Microsoft cloud security benchmark recommendations are then customized for each Azure service. This customized guidance is contained in service recommendations articles.

The Microsoft cloud security benchmark documentation specifies security controls and service recommendations.

-   [Security controls](/security/benchmark/azure/overview): The Microsoft cloud security benchmark recommendations are categorized by security controls. Security controls represent high-level vendor-agnostic security requirements, like network security and data protection. Each security control has a set of security recommendations and instructions that help you implement those recommendations.
-   [Service recommendations](/security/benchmark/azure/security-baselines-overview): When available, benchmark recommendations for Azure services will include Microsoft cloud security benchmark recommendations that are tailored specifically for that service.

## Security design considerations

An organization must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework.

### Security operations design considerations

|Scope|Context|
|---|---|
| Security alerts | - Which teams require notifications for security alerts? <br> - Are there groups of services that alerts require routing to different teams? <br> - Business requirements for real-time monitoring and alerting. <br> - Security information and event management integration with Microsoft Defender for Cloud and Microsoft Sentinel. |
| Security logs |- Data retention periods for audit data. Microsoft Entra ID P1 or P2 reports have a 30-day retention period. <br> - Long-term archiving of logs like Azure activity logs, virtual machine (VM) logs, and platform as a service (PaaS) logs.|
| Security controls| - Baseline security configuration via Azure in-guest VM policy. <br> - Consider how your security controls will align with governance guardrails. |
| Vulnerability management | - Emergency patching for critical vulnerabilities. <br> - Patching for VMs that are offline for extended periods of time. <br> - Vulnerability assessment of VMs.
| Shared responsibility | - Where are the handoffs for team responsibilities? These responsibilities need consideration when monitoring or responding to security events. <br> -  Consider the guidance in the Secure methodology for security operations. |
| Encryption and keys | - Who requires access to keys in the environment? <br> - Who will be responsible for managing the keys? <br> - Explore encryption and keys further. |

## Security operations design recommendations

-   Use [Microsoft Entra ID reporting capabilities](/azure/active-directory/reports-monitoring/concept-audit-logs) to generate access control audit reports.
-   Export Azure activity logs to Azure Monitor Logs for long-term data retention. Export to Azure Storage for long-term storage beyond two years, if necessary.
-   [Enable Defender for Cloud standard](/azure/security-center/security-center-get-started) for all subscriptions, and use Azure Policy to ensure compliance.
-   Monitor base operating system patching drift via Azure Monitor Logs and Microsoft Defender for Cloud.
-   Use Azure policies to automatically deploy software configurations through VM extensions and enforce a compliant baseline VM configuration.
-   Monitor VM security configuration drift via Azure Policy.
-   Connect default resource configurations to a centralized Azure Monitor Log Analytics workspace.
-   Use an Azure Event Grid-based solution for log-oriented, real-time alerts.

### Access control design considerations

Modern security boundaries are more complex than boundaries in a traditional datacenter. The four walls of the datacenter no longer contain your assets. Keeping users out of the protected network is no longer sufficient to control access. In the cloud, your perimeter is composed of two parts: network security controls and zero trust access controls.

#### Advanced network security

|Scope|Context|
|---|---|
| Plan for inbound and outbound internet connectivity | [Describes recommended connectivity models for inbound and outbound connectivity to and from the public internet](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-inbound-and-outbound-internet-connectivity). |
| Plan for landing zone network segmentation | [Explores key recommendations to deliver highly secure internal network segmentation within a landing zone. These recommendations drive network zero-trust implementation](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-landing-zone-network-segmentation). |
| Define network encryption requirements | [Explores key recommendations to achieve network encryption between on-premises and Azure and across Azure regions](/azure/cloud-adoption-framework/ready/azure-best-practices/define-network-encryption-requirements). |
|Plan for traffic inspection | [Explores key considerations and recommended approaches for mirroring or tapping traffic within Azure Virtual Network](/azure/cloud-adoption-framework/ready/azure-best-practices/plan-for-traffic-inspection). |

#### Zero trust

-   Which teams or individuals require access to services within the landing zone? What roles are they doing?
-   Who should authorize the access requests?
-   Who should receive the notifications when privileged roles are activated?
-   Who should have access to the audit history?

For more information, see [Microsoft Entra Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure).

### Access control design recommendations

-   In the context of your underlying requirements, conduct a joint examination of each required service. If you want to bring your own keys, it might not be supported across all considered services. Implement relevant mitigation so that inconsistencies don't hinder wanted outcomes. Choose appropriate region pairs and disaster recovery regions that minimize latency.
-   Develop a security allowlist plan to assess services like security configuration, monitoring, and alerts. Then create a plan to integrate them with existing systems.
-   Determine the incident response plan for Azure services before moving it into production.
-   Align your security requirements with Azure platform roadmaps to stay current with newly released security controls.
-   Implement a [zero-trust approach for access](/azure/cloud-adoption-framework/secure/access-control) to the Azure platform where appropriate.


## Security in the Azure landing zone accelerator

Security is at the core of the Azure landing zone accelerator. As part of the implementation, many tools and controls are deployed to help organizations quickly achieve a security baseline.

For example, the following are included:

Tools:

-   Microsoft Defender for Cloud, standard or free tier
-   Microsoft Sentinel
-   Azure DDoS Network Protection (optional)
-   Azure Firewall
-   Web Application Firewall (WAF)
-   Privileged Identity Management (PIM)

Policies for online and corporate-connected landing zones:

-   Enforce secure access, like HTTPS, to storage accounts
-   Enforce auditing for Azure SQL Database
-   Enforce encryption for Azure SQL Database
-   Prevent IP forwarding
-   Prevent inbound RDP from internet
-   Ensure subnets are associated with NSG
