
A hybrid cloud combines a private cloud (on-premises infrastructure)
with a public cloud (computing services offered by third-party providers
over the public internet). Hybrid clouds allow data and applications to
consistently move between the two cloud environments. Many organizations
choose a hybrid cloud strategy because of business requirements, such as
meeting regulatory and data sovereignty requirements, maximizing
on-premises technology investments, or addressing latency issues.

The hybrid cloud is evolving to include edge workloads. Cloud-managed
edge computing devices bring the computing power of the public cloud to
the private cloud, closer to where the IoT devices reside, including
data residing in applications, connected devices, and mobile consumer
services. Reducing latency by moving workloads to the edge, devices
spend less time communicating with the cloud and can operate reliably in
extended offline periods.

Multicloud computing uses multiple cloud computing services from more
than one cloud provider (including private and public clouds) in a
heterogeneous environment. A multicloud strategy provides greater
flexibility and mitigates risk. This strategy allows you to choose services from different cloud
providers best suited for a specific task or take advantage of services
offered by a particular cloud provider in a specific location.

The following video provides a good background on hybrid and multicloud strategy within the Cloud Adoption Framework:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWMBdw?postJsllMsg=true]

## Unified operations

**Unified operations** is the intentional approach of maintaining one set of tools and processes to consistently manage each cloud provider through a common set of governance and operations management practices.

The primary objective of unified operations is to create as much process
consistency as possible across deployments. No cloud service provider
will be able to reach 100% feature parity across all hybrid,
multicloud, and edge deployments. However, the provider should be able
to deliver baseline feature sets common across all deployments so that
your [governance](/azure/cloud-adoption-framework/scenarios/hybrid/govern) and 
[operations management](/azure/cloud-adoption-framework/scenarios/hybrid/manage) 
processes remain consistent.

![Diagram that shows customer processes that unified operations can support.](../media/unified-operations.png) 

Most commonly, customers require the ability to deliver consistency
within their defined governance and operations management processes. To
meet long-term requirements, your unified operations solution will need
to be able to scale to meet these common processes specified below.

## Common governance processes (tasks)

-   **Cost management:** View, manage, or optimize costs and identify and provide mitigation guidance for cloud-related IT spend risk.
-   **Security baseline:** Audit, apply, or automate requirements from recommended security controls and identify and provide mitigation guidance for security-related business risks.
-   **Resource consistency:** Onboard, organize, configure resources and services, and identify and provide risk mitigation guidance for potential business risks.
-   **Identity baseline:** Enforce authentication and authorization across user identity and access and identify and provide
    risk-mitigation guidance for potential identity-related business  risks.
-   **Deployment acceleration:** Drive consistency using templates, automation, and pipelines (for deployments, configuration alignment, and reusable assets), establishing policies to ensure compliant, consistent, and repeatable resource deployment and configuration.

## Common operations management processes (tasks)

-   **Inventory and visibility:** Account for, and ensure reporting for all assets, and collect and monitor your inventory's run state in enterprise-grade environments.
-   **Optimized operations:** Track, patch, and optimize supported resources and minimize business interruption risks from
    configuration drift or vulnerabilities from inconsistent patch management.
-   **Protection and recovery:** Backup, business continuity, and disaster recovery best practices and reduce the duration and
    impact of unpreventable outages.
-   **[Platform operations](/azure/cloud-adoption-framework/manage/azure-management-guide/platform-specialization):** Specialized operations for common technology platforms such as SQL databases, virtual desktops, and SAP (for medium to high criticality workloads).
-   **[Workload operations](/azure/cloud-adoption-framework/manage/azure-management-guide/workload-specialization):**  Specialized operations (for high priority/mission-critical workloads) with greater operations requirements.

Your primary cloud platform should be able to provide the required technical capabilities and tools to automate processes and reach the goals above for governance and operations management. Your unified operations solution should enable you to extend these processes across all hybrid, multicloud, and edge deployments.

## Azure Security Operation services

[Azure security operations](/azure/security/fundamentals/operational-security) refer
to the services, controls, and features available to users to protect
their data, applications, and other assets in Microsoft Azure. It is a
framework that incorporates the knowledge gained through various
capabilities that are unique to Microsoft. These capabilities include
the Microsoft Security Development Lifecycle (SDL), the Microsoft
Security Response Center program, and deep awareness of the
cybersecurity threat landscape.

## Azure management services

An IT operations team is responsible for managing hybrid and multicloud
environments, such as data center infrastructure, applications, and
data, including the stability and security of these systems. However,
gaining security insights across increasingly complex IT environments
often requires organizations to cobble together data from multiple
security and management systems.

[Microsoft Azure Monitor logs](/azure/azure-monitor/overview) is
a cloud-based IT management solution that helps you manage and protect
your on-premises and cloud infrastructure. Its core functionality is
provided by the following services that run in Azure. Azure includes
multiple services that help you manage and protect on-premises and cloud
infrastructures. Each service provides a specific management function.
Services can be combined to achieve different management scenarios.

The following management services may be important in a unified operations architecture:

- [Azure Monitor](/azure/azure-monitor/overview) - collects data from managed sources into central data stores. This data can
include events, performance data, or custom data provided through the API. After the data is collected, it is available for alerting, analysis, and export.
- [Azure Automation](/azure/automation/automation-intro) provides a way to automate the manual, long-running, error-prone, and frequently repeated tasks commonly performed in a cloud and enterprise environment. It saves time and increases the reliability of administrative tasks.
- [Azure Backup](/azure/backup/backup-overview) is the Azure-based service that you can use to back up (or protect) and
restore your data in the Microsoft Cloud. Azure Backup replaces existing on-premises or off-site backup solutions with a cloud-based solution that's reliable, secure, and cost-competitive.
- [Azure Site Recovery](https://azure.microsoft.com/documentation/services/site-recovery) provides business continuity by orchestrating the replication of on-premises virtual and physical machines to Azure or a secondary site. If primary sites are unavailable, failover to the secondary location so that users can keep working.
- [Azure Active Directory (Azure AD)](/azure/active-directory/manage-apps/what-is-application-management) is
a comprehensive identity service that:
    - Enables identity and access management (IAM) as a cloud service.
    - Provides central access management, single sign-on (SSO), and reporting.
    - Supports integrated access management for [thousands of applications](https://azuremarketplace.microsoft.com/marketplace/apps/Microsoft.AzureActiveDirectory) in the Azure Marketplace, including Salesforce, Google Apps, Box, and Concur.
- [Microsoft Defender for Cloud](/azure/security-center/security-center-introduction) helps prevent, detect, and respond to threats with increased visibility into (and control over) the security of your Azure resources. It provides integrated security monitoring and policy management across subscriptions. It helps detect threats that might otherwise go unnoticed, and it works with a broad ecosystem of security solutions.

## Example security architecture for hybrid and multicloud

This reference architecture illustrates how to use Microsoft Defender for Cloud and Microsoft Sentinel to monitor the security configuration and telemetry of on-premises and Azure operating system workloads. This includes Azure Stack.

:::image type="content" source="../media/hybrid-security-monitoring.png" alt-text="Diagram illustrating deployed Microsoft Monitoring Agent on on-premises systems as well as on Azure based virtual machines transferring data to Microsoft Defender for Cloud and Microsoft Sentinel" lightbox="../media/hybrid-security-monitoring.png":::

### Components and workflow

The architecture consists of the following workflow:

- **Microsoft Defender for Cloud** This reference architecture uses Microsoft Defender for Cloud to monitor on-premises systems, Azure VMs, Azure Monitor resources, and even VMs hosted by other cloud providers. To support that functionality, the **standard fee-based tier** of Microsoft Defender for Cloud is needed. We recommend that you use the 30-day free trial to validate your requirements.
- **Microsoft Sentinel** Is a cloud-native Security Information and Event Management (SIEM) and security orchestration automated response (SOAR) solution. In this scenario, you can't use the default Defender for Cloud Log Analytics workspace with Microsoft Sentinel. You'll need to create a customized workspace. Data retention for a customized workspace is based on the workspace pricing tier.
- **Azure Stack**. Is a portfolio of products that extend Azure services and capabilities to your environment of choice, from the datacenter to edge locations and remote offices. Systems that you integrate with Azure Stack typically utilize racks of four to sixteen servers, built by trusted hardware partners and delivered straight to your datacenter.
- **Azure Monitor**. Collects monitoring telemetry from a variety of on-premises and Azure sources. Management tools, such as those in Microsoft Defender for Cloud and Azure Automation, also push log data to Azure Monitor.
- **Log Analytics workspace**. Azure Monitor stores log data in a Log Analytics workspace, which is a container that includes data and configuration information.
- **Azure Monitoring Agent**. The Azure Monitoring Agent collects monitoring data from the guest operating system and VM workloads in Azure, other cloud providers, and on-premises. The Azure Monitoring Agent supports Proxy configuration and, typically in this scenario, a Microsoft Operations Management Suite (OMS) Gateway acts as proxy.
- **On-premises network**. This is the firewall configured to support HTTPS egress from defined systems.
- **On-premises Windows and Linux systems**. Systems with the Azure Monitoring Agent installed.
- **Azure Windows and Linux VMs**. Systems on which the Microsoft Defender for Cloud monitoring agent is installed.

For full details on this reference architecture, see [Monitor hybrid security using Microsoft Defender for Cloud and Microsoft Sentinel](/azure/architecture/hybrid/hybrid-security-monitoring)

For an overview of some technologies which can help you secure hybrid and multicloud environments, view the following interactive guide.

:::image type="content" source="../media/secure-azure-hybrid-multi-cloud-interactive-guide.png" alt-text="Screenshot of an interactive guide with the title 'Secure your Azure, hybrid, and multicloud environment'." border="true":::
