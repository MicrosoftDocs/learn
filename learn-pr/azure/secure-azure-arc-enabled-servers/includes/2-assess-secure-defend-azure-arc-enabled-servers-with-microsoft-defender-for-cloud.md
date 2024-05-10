With Tailwind Traders' distributed IT infrastructure, it's often difficult to get a coherent view of the entire organization's security posture. Moreover, initiatives to secure and defend resources are increasingly siloed. In this unit, you learn how to use Microsoft Defender for Cloud with Azure Arc-enabled servers. Together, they can facilitate a more comprehensive security strategy to meet the demands of your hybrid and multicloud infrastructure.

## Overview of Microsoft Defender for Cloud

Microsoft Defender for Cloud provides unified security management and advanced threat protection. With its integrated Microsoft Defender plans, Defender for Cloud protects workloads running in Azure, hybrid, and other cloud platforms.

Defender for Cloud enables you to continuously assess, secure, and defend workloads in the cloud and on-premises.  

|Security scenario|Defender for Cloud solution|
|---|---|
|**Continuous assessment: Understand your current security posture.**|Secure score: A single score so that you can tell, at a glance, your current security situation. The higher the score, the lower the identified risk level.|
|**Secure: Harden all connected resources and services.**|Security recommendations: Customized and prioritized hardening tasks to improve your posture. You implement a recommendation by following the detailed remediation steps provided in the recommendation. For many recommendations, Defender for Cloud offers a "Fix" button for automated implementation.|
|**Defend: Detect and resolve threats to those resources and services.**|Security alerts: With the enhanced security features enabled, Defender for Cloud detects threats to your resources and workloads. These alerts appear in the Azure portal and Defender for Cloud. Alerts can be sent by email to the relevant personnel in your organization. Alerts can also be streamed to SIEM, SOAR, or IT Service Management solutions as required.|

## Enhanced security features

Enabling enhanced security extends the capabilities to workloads running in private and other public clouds. Enhanced security provides unified security management and threat protection across your hybrid cloud workloads. Major benefits of enabling enhanced security features with Azure Arc-enabled servers include:

- **Microsoft Defender for Endpoint**: Microsoft Defender for Servers is available as an enhanced security feature. Defender for Servers includes Defender for Endpoint for comprehensive endpoint detection and response (EDR).  
- **Vulnerability assessment for virtual machines, container registries, and SQL resources**: You can use point-and-click vulnerability assessment solutions to discover, manage, and resolve vulnerabilities. You can view, investigate, and remediate the findings directly from within Defender for Cloud.
- **Multicloud security**: Connect your accounts from Amazon Web Services (AWS) and Google Cloud Platform (GCP) to protect resources and workloads on those platforms.
- **Hybrid security**: Get a unified view of security across all your on-premises and cloud workloads. Apply security policies and continuously assess the security of your hybrid cloud workloads to ensure compliance with security standards. Collect, search, and analyze security data from multiple sources, including firewalls and other partner solutions.
- **Track compliance with a range of standards**: Defender for Cloud continuously assesses your hybrid cloud environment to analyze the risk factors according to the controls and best practices in Azure Security Benchmark. When you enable the enhanced security features, you can apply a range of other industry standards, regulatory standards, and benchmarks according to your organization's needs. Add standards and track your compliance with them from the regulatory compliance dashboard.

## Defend multicloud resources on AWS and GCP

Defender for Cloud can protect resources in other clouds, such as AWS and GCP. You can connect AWS and GCP accounts to Defender for Cloud. Multicloud capabilities include:  

- Detection of security misconfigurations across Azure, GCP, and AWS
- A single view showing Defender for Cloud recommendations, GCP Security Command Center findings, and AWS Foundational Security Best Practices
- Incorporation of your GCP and AWS resources into Defender for Cloud's secure score calculations
- Integration of GCP Security Command Center recommendations based on the CIS standard into the Defender for Cloud's regulatory compliance dashboard
- Built-in standards specific to AWS (AWS CIS, AWS PCI DSS, and AWS Foundational Security Best Practices)
- Microsoft Defender for Servers for GCP and AWS resources
