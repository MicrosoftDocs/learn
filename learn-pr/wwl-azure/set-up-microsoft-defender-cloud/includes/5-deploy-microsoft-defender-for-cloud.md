Defender for Cloud is **enabled for free on all your Azure subscriptions**. Defender for Cloud provides foundational **cloud security and posture management (CSPM)** features by default. The foundational CSPM includes a **secure score**, **security policy and basic recommendations**, and **network security assessment** to help you **protect your Azure resources**.

### Defender Cloud Security Posture Management (CSPM) plan options

Defender for cloud **offers foundational multicloud CSPM capabilities for free**. These capabilities are automatically enabled by default on any subscription or account that onboarded to Defender for Cloud. Foundational CSPM includes asset discovery, continuous assessment, and security recommendations for posture hardening. Along with features like compliance with Microsoft Cloud Security Benchmark (MCSB), and a Secure score that measures the current status of your organization’s posture.

The optional Defender CSPM plan provides advanced posture management capabilities such as **Attack path analysis**, **Cloud security explorer**, **advanced threat hunting**, **security governance capabilities**, and also tools to assess your security compliance with a wide range of benchmarks, regulatory standards, and any custom security policies required in your organization, industry, or region.

The following table summarizes each plan and its cloud availability.

| **Feature**                                                                | **Foundational CSPM** | **Defender CSPM** | **Cloud availability**       |
| -------------------------------------------------------------------------- | --------------------- | ----------------- | ---------------------------- |
| Security recommendations                                                   | Yes                   | Yes               | Azure, Amazon Web Service (AWS), Google Cloud Platform (GCP), on-premises |
| Asset inventory                                                            | Yes                   | Yes               | Azure, AWS, GCP, on-premises |
| Secure score                                                               | Yes                   | Yes               | Azure, AWS, GCP, on-premises |
| Data visualization and reporting with Azure Workbooks                      | Yes                   | Yes               | Azure, AWS, GCP, on-premises |
| Data exporting                                                             | Yes                   | Yes               | Azure, AWS, GCP, on-premises |
| Workflow automation                                                        | Yes                   | Yes               | Azure, AWS, GCP, on-premises |
| Tools for remediation                                                      | Yes                   | Yes               | Azure, AWS, GCP, on-premises |
| Microsoft Cloud Security Benchmark                                         | Yes                   | Yes               | Azure, AWS, GCP              |
| Security governance                                                        | -                     | Yes               | Azure, AWS, GCP, on-premises |
| Regulatory compliance standards                                            | -                     | Yes               | Azure, AWS, GCP, on-premises |
| Cloud security explorer                                                    | -                     | Yes               | Azure, AWS, GCP              |
| Attack path analysis                                                       | -                     | Yes               | Azure, AWS, GCP              |
| Agentless scanning for machines                                            | -                     | Yes               | Azure, AWS, GCP              |
| Agentless container security posture                                       | -                     | Yes               | Azure, AWS, GCP              |
| Container registries vulnerability assessment, including registry scanning | -                     | Yes               | Azure, AWS, GCP              |
| Data aware security posture                                                | -                     | Yes               | Azure, AWS, GCP              |
| External Attack Surface Management (EASM) insights in network exposure                                          | -                     | Yes               | Azure, AWS, GCP              |
| Permissions management (Preview)                                           | -                     | Yes               | Azure, AWS, GCP              |

### Defender plans (paid features)

Defender plans are available for a free 30-day trial. After the trial period, usage charges apply automatically if you continue using the service.

### Prerequisites

To get started with Defender for Cloud, you need a Microsoft Azure subscription with Defender for Cloud enabled. If you don't have an Azure subscription, you can sign up for a free subscription. You can enable:

- **Microsoft Defender for Storage accounts** at either the subscription level or resource level.
- **Microsoft Defender for SQL (Structured Query Language)** at either the subscription level or resource level.
- **Microsoft Defender for open-source relational databases** at the resource level only.
   - The Microsoft Defender plans available at the workspace level are Microsoft Defender for Servers and Microsoft Defender for SQL servers on machines.

When you enabled Defender plans on an entire Azure subscription, the protections apply to all resources in the subscription.

Microsoft Defender for Cloud uses monitoring components to collect data from your resources. These extensions are automatically deployed when you turn on a Defender plan. Each Defender plan has its own requirements for monitoring components, so it's important that the required extensions are deployed to your resources to get all of the benefits of each plan.

The Defender plans show you the monitoring coverage for each Defender plan. If the monitoring coverage is Full, all of the necessary extensions are installed. If the monitoring coverage is Partial, the information tooltip tells you what extensions are missing. For some plans, you can configure specific monitoring settings.

### Defender plans features

When you enable Defender plans (paid), you gain unified security management and threat protection across hybrid cloud workloads, including:

- **Microsoft Defender for Endpoint** - Included with Microsoft Defender for Servers for comprehensive endpoint detection and response (EDR).
- **Vulnerability assessment** - Discover, manage, and resolve vulnerabilities across virtual machines, container registries, and SQL resources directly from Defender for Cloud.
- **Multicloud security** - Connect AWS and GCP accounts to protect resources across platforms with Defender for Cloud security features.
- **Hybrid security** – Unified security view across on-premises and cloud workloads with continuous assessment, policy enforcement, and compliance monitoring.
- **Threat protection alerts** - Behavioral analytics and Microsoft Intelligent Security Graph detect attacks and zero-day exploits. Monitor networks, machines, SQL databases, and storage for threats with contextual intelligence.
- **Compliance tracking** - Continuous assessment against Microsoft Cloud Security Benchmark with options to add industry and regulatory standards. Track compliance through the regulatory compliance dashboard.
- **Access and application controls** - Apply machine learning-powered recommendations to create allow lists and block lists for applications. Use just-in-time (JIT) access (requires **Defender for Servers Plan 2**) to control management port access and reduce exposure to brute force attacks.
- **Container security** - Vulnerability management and real-time threat protection for containerized environments. Charges apply per unique container image scanned.
- **Azure threat protection** - Cloud-native protection for Azure Resource Manager, DNS, network layer, and Key Vault with unique visibility into Azure management and DNS layers.
- **Cloud Security Posture Management (CSPM)** - Remediate security issues and review security posture with these tools:
    
     -  **Security governance and regulatory compliance** - View regulatory compliance through the dashboard. Defender for Cloud continuously assesses your environment against applied standards and displays compliance status.
     -  **Cloud security graph** - A graph-based context engine that collects multicloud environment data including assets, connections, permissions, network configurations, and vulnerabilities. Used to perform attack path analysis and enable cloud security explorer queries.
     -  **Attack path analysis** - Identifies security issues in potential attack paths that could lead to environment breaches. Highlights recommendations to break attack paths and prevent exploitation.
     -  **Agentless scanning for machines** - Provides vulnerability assessment and software inventory for VMs without agents, network connectivity requirements, or performance decrease. Available in Defender CSPM and Defender for Servers.
