## Basic and enhanced security features

### Basic features

When you open Defender for Cloud in the Azure portal for the first time or if you enable it through the Application Programming Interface (API), Defender for Cloud is **enabled for free on all your Azure subscriptions**. Defender for Cloud provides foundational **cloud security and posture management (CSPM)** features by default. The foundational CSPM includes a **secure score**, **security policy and basic recommendations**, and **network security assessment** to help you **protect your Azure resources**.

### Defender Cloud Security Posture Management (CSPM) plan options

Defender for cloud **offers foundational multicloud CSPM capabilities for free**. These capabilities are automatically enabled by default on any subscription or account that has been onboarded to Defender for Cloud. The foundational CSPM includes asset discovery, continuous assessment and security recommendations for posture hardening, compliance with Microsoft Cloud Security Benchmark (MCSB), and a Secure score which measure the current status of your organization’s posture.

The optional Defender CSPM plan provides advanced posture management capabilities such as **Attack path analysis**, **Cloud security explorer**, **advanced threat hunting**, **security governance capabilities**, and also tools to assess your security compliance with a wide range of benchmarks, regulatory standards, and any custom security policies required in your organization, industry, or region.

The following table summarizes each plan and its cloud availability.

:::image type="content" source="../media/defender-cspm-plans-f0ad4520.png" alt-text="Table showing Defender Cloud Security Poster Management plan options.":::


### Enhanced features

If you want to try out the enhanced security features, enable enhanced security features for free for the first 30 days. At the end of 30 days, if you decide to continue using the service, we'll automatically start charging for usage.

### Prerequisites

To get started with Defender for Cloud, you'll need a Microsoft Azure subscription with Defender for Cloud enabled. If you don't have an Azure subscription, you can sign up for a free subscription.

 -  You can enable **Microsoft Defender for Storage accounts** at either the subscription level or resource level.
 -  You can enable **Microsoft Defender for SQL (Structured Query Language)** at either the subscription level or resource level.
 -  You can enable **Microsoft Defender for open-source relational databases** at the resource level only.
 -  The Microsoft Defender plans available at the workspace level are Microsoft Defender for Servers and Microsoft Defender for SQL servers on machines.

When you enabled Defender plans on an entire Azure subscription, the protections are inherited by all resources in the subscription.

Microsoft Defender for Cloud uses monitoring components to collect data from your resources. These extensions are automatically deployed when you turn on a Defender plan. Each Defender plan has its own requirements for monitoring components, so it's important that the required extensions are deployed to your resources to get all of the benefits of each plan.

The Defender plans show you the monitoring coverage for each Defender plan. If the monitoring coverage is Full, all of the necessary extensions are installed. If the monitoring coverage is Partial, the information tooltip tells you what extensions are missing. For some plans, you can configure specific monitoring settings.

### Enhanced features

When you enable the enhanced security features (paid), Defender for Cloud can provide unified security management and threat protection across your hybrid cloud workloads, including:

 -  **Microsoft Defender for Endpoint** \- Microsoft Defender for Servers includes Microsoft Defender for Endpoint for comprehensive endpoint detection and response (EDR).
 -  **Vulnerability assessment for virtual machines, container registries, and SQL resources** \- Easily enable vulnerability assessment solutions to discover, manage, and resolve vulnerabilities. View, investigate, and remediate the findings directly from within Defender for Cloud.
 -  **Multicloud security** \- Connect your accounts from Amazon Web Services (AWS) and Google Cloud Platform (GCP) to protect resources and workloads on those platforms with a range of Microsoft Defender for Cloud security features.
 -  **Hybrid security** – Get a unified view of security across all of your on-premises and cloud workloads. Apply security policies and continuously assess the security of your hybrid cloud workloads to ensure compliance with security standards. Collect, search, and analyze security data from multiple sources, including firewalls and other partner solutions.
 -  **Threat protection alerts** \- Advanced behavioral analytics and the Microsoft Intelligent Security Graph provide an edge over evolving cyber-attacks. Built-in behavioral analytics and machine learning can identify attacks and zero-day exploits. Monitor networks, machines, data stores (SQL servers hosted inside and outside Azure, Azure SQL databases, Azure SQL Managed Instance, and Azure Storage), and cloud services for incoming attacks and post-breach activity. Streamline investigation with interactive tools and contextual threat intelligence.
 -  **Track compliance with a range of standards** \- Defender for Cloud continuously assesses your hybrid cloud environment to analyze the risk factors according to the controls and best practices in the Microsoft cloud security benchmark. When you enable enhanced security features, you can apply a range of other industry standards, regulatory standards, and benchmarks according to your organization's needs. Add standards and track your compliance with them from the regulatory compliance dashboard.
 -  **Access and application controls** \- Block malware and other unwanted applications by applying machine learning-powered recommendations adapted to your specific workloads to create allowlists and blocklists. Reduce the network attack surface with just-in-time, controlled access to management ports on Azure VMs. Access and application control drastically reduce exposure to brute force and other network attacks.
 -  **Container security features** \- Benefit from vulnerability management and real-time threat protection in your containerized environments. Charges are based on the number of unique container images pushed to your connected registry. After an image has been scanned once, you won't be charged for it again unless it's modified and pushed once more.
 -  **Breadth threat protection for resources connected to Azure** \- Cloud-native threat protection for the Azure services common to all of your resources: Azure Resource Manager, Azure Domain Name System (DNS), Azure network layer, and Azure Key Vault. Defender for Cloud has unique visibility into the Azure management layer and the Azure DNS layer and can therefore protect cloud resources that are connected to those layers.
 -  **Manage your Cloud Security Posture Management (CSPM)** \- CSPM offers you the ability to remediate security issues and review your security posture through the tools provided.
    
    These tools include:
    
    
     -  **Security governance and regulatory compliance**
         -  What is Security governance and regulatory compliance? Security governance and regulatory compliance refer to the policies and processes which organizations have in place to ensure that they comply with laws, rules, and regulations put in place by external bodies (government) that control activity in a given jurisdiction. Defender for Cloud allows you to view your regulatory compliance through the regulatory compliance dashboard. Defender for Cloud continuously assesses your hybrid cloud environment to analyze the risk factors according to the controls and best practices in the standards you've applied to your subscriptions. The dashboard reflects the status of your compliance with these standards.
     -  **Cloud security graph**
         -  What is a cloud security graph? The cloud security graph is a **graph-based context engine** that exists within Defender for Cloud. The cloud security graph collects data from your multicloud environment and other data sources. **For example**, the cloud assets inventory, connections and lateral movement possibilities between resources, exposure to the internet, permissions, network connections, vulnerabilities, and more. The data collected is then used to build a graph representing your multicloud environment. Defender for Cloud then uses the generated graph to perform an attack path analysis and find the issues with the highest risk that exist within your environment. You can also query the graph using the cloud security explorer.
     -  **Attack path analysis**
         -  What is Attack path analysis? Attack path analysis helps you to **address the security issues that pose immediate threats with the greatest potential of being exploited in your environment**. Defender for Cloud analyzes which security issues are part of potential attack paths that attackers could use to breach your environment. It also highlights the security recommendations that need to be resolved in order to mitigate the issue.
     -  **Agentless scanning for machines**
         -  What is agentless scanning for machines? Microsoft Defender for Cloud maximizes coverage on OS posture issues and extends beyond the reach of agent-based assessments. With agentless scanning for VMs, you can get frictionless, wide, and instant visibility on actionable posture issues without installed agents, network connectivity requirements, or machine performance impact. **Agentless scanning for VMs provides vulnerability assessment and software inventory** powered by Defender vulnerability management in Azure and Amazon AWS environments. Agentless scanning is available in Defender Cloud Security Posture Management (CSPM) and Defender for Servers.
