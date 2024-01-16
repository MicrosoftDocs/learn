> [!NOTE]
> Azure Security Center and Azure Defender are now called Microsoft Defender for Cloud. We've also renamed *Azure Defender* plans to *Microsoft Defender* plans. For example, Azure Defender for Storage is now Microsoft Defender for Storage. [Learn more about the recent renaming of Microsoft security services.](https://aka.ms/secblg11)

Defender for Cloud is a tool for security posture management and threat protection. It strengthens the security posture of your cloud resources, and with its integrated Microsoft Defender plans, Defender for Cloud protects workloads running in Azure, hybrid, and other cloud platforms.

Defender for Cloud provides the tools needed to harden your resources, track your security posture, protect against cyber attacks, and streamline security management. Because it's natively integrated, deployment of Defender for Cloud is easy, providing you with simple auto provisioning to secure your resources by default.

Defender for Cloud fills three vital needs as you manage the security of your resources and workloads in the cloud and on-premises:

:::row:::
  :::column:::
    **Security requirement**
  :::column-end:::
  :::column:::
    **Defender for Cloud solution**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Continuous assessment** \- Understand your current security posture.
  :::column-end:::
  :::column:::
    Secure score - A single score so that you can tell, at a glance, your current security situation: the higher the score, the lower the identified risk level.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Secure** \- Harden all connected resources and services.
  :::column-end:::
  :::column:::
    Security recommendations - Customized and prioritized hardening tasks to improve your posture. You implement a recommendation by following the detailed remediation steps provided in the recommendation. For many recommendations, Defender for Cloud offers a "Fix" button for automated implementation!
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Defend** \- Detect and resolve threats to those resources and services.
  :::column-end:::
  :::column:::
    Security alerts - With the enhanced security features enabled, Defender for Cloud detects threats to your resources and workloads. These alerts appear in the Azure portal and Defender for Cloud can also send them by email to the relevant personnel in your organization. Alerts can also be streamed to SIEM, SOAR, or IT Service Management solutions as required.
  :::column-end:::
:::row-end:::

## Posture management and workload protection

Microsoft Defender for Cloud features cover the two broad pillars of cloud security: cloud security posture management and cloud workload protection.

### Cloud security posture management (CSPM)

In Defender for Cloud, the posture management features provide:

- **Visibility** \- to help you understand your current security situation
- **Hardening guidance** \- to help you efficiently and effectively improve your security

The central feature in Defender for Cloud that enables you to achieve those goals is **secure score**. Defender for Cloud continually assesses your resources, subscriptions, and organization for security issues. It then aggregates all the findings into a single score so that you can tell, at a glance, your current security situation: the higher the score, the lower the identified risk level.

### Cloud workload protection (CWP)

Defender for Cloud offers security alerts that are powered by [Microsoft Threat Intelligence](https://go.microsoft.com/fwlink/?linkid=2128684). It also includes a range of advanced, intelligent, protections for your workloads. The workload protections are provided through Microsoft Defender plans specific to the types of resources in your subscriptions. For example, you can enable **Microsoft Defender for Storage** to get alerted about suspicious activities related to your Azure Storage accounts.

## Azure, hybrid, and multicloud protections

Because Defender for Cloud is an Azure-native service, many Azure services are monitored and protected without needing any deployment.

When necessary, Defender for Cloud can automatically deploy a Log Analytics agent to gather security-related data. For Azure machines, deployment is handled directly. For hybrid and multicloud environments, Microsoft Defender plans are extended to non Azure machines with the help of [Azure Arc](https://azure.microsoft.com/services/azure-arc/). CSPM features are extended to multicloud machines without the need for any agents.

### Azure-native protections

Defender for Cloud helps you detect threats across:

- **Azure PaaS services** \- Detect threats targeting Azure services including Azure App Service, Azure SQL, Azure Storage Account, and more data services. You can also perform anomaly detection on your Azure activity logs using the native integration with Microsoft Defender for Cloud Apps (formerly known as Microsoft Cloud App Security).
- **Azure data services** \- Defender for Cloud includes capabilities that help you automatically classify your data in Azure SQL. You can also get assessments for potential vulnerabilities across Azure SQL and Storage services, and recommendations for how to mitigate them.
- **Networks** \- Defender for Cloud helps you limit exposure to brute force attacks. By reducing access to virtual machine ports, using the just-in-time VM access, you can harden your network by preventing unnecessary access. You can set secure access policies on selected ports for authorized users, allowed source IP address ranges or IP addresses, and for a limited amount of time.

### Defend your hybrid resources

In addition to defending your Azure environment, you can add Defender for Cloud capabilities to your hybrid cloud environment to protect your non-Azure servers. To help you focus on what matters the most, you get customized threat intelligence and prioritized alerts according to your specific environment.

To extend protection to on-premises machines, deploy [Azure Arc](https://azure.microsoft.com/services/azure-arc/) and enable Defender for Cloud's enhanced security features. Learn more in [Add non-Azure machines with Azure Arc](/azure/defender-for-cloud/quickstart-onboard-machines?pivots=azure-arc#add-non-azure-machines-with-azure-arc).
