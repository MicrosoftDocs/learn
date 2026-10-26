With Tailwind Traders' distributed IT infrastructure, it's often difficult to get a coherent view of the entire organization's security posture. Moreover, initiatives to secure and defend resources are increasingly siloed. In this unit, you learn how to use Microsoft Defender for Cloud with Azure Arc-enabled servers. Together, they can facilitate a more comprehensive security strategy to meet the demands of your hybrid and multicloud infrastructure.

Reference links for this unit are in the summary's **More info** section.

## Overview of Microsoft Defender for Cloud

Microsoft Defender for Cloud provides unified security management and advanced threat protection. With its integrated Microsoft Defender plans, Defender for Cloud protects workloads running in Azure, hybrid, and other cloud platforms.

The following table summarizes how Defender for Cloud helps you continuously assess, secure, and defend workloads in the cloud and on-premises.

|Security scenario|Defender for Cloud solution|
|---|---|
|**Continuous assessment: Understand your current security posture.**|Secure score: A single score so that you can tell, at a glance, your current security situation. The higher the score, the lower the identified risk level.|
|**Secure: Harden all connected resources and services.**|Security recommendations: Customized and prioritized hardening tasks to improve your posture. You implement a recommendation by following the detailed remediation steps provided in the recommendation. For many recommendations, Defender for Cloud offers a **Fix** button for automated implementation.|
|**Defend: Detect and resolve threats to those resources and services.**|Security alerts: With the enhanced security features enabled, Defender for Cloud detects threats to your resources and workloads. These alerts appear in the Azure portal and Defender for Cloud. Alerts can be sent by email to the relevant personnel in your organization. Alerts can also be streamed to SIEM, SOAR, or IT service management solutions as required.|

## Enhanced security features

Enabling enhanced security extends the capabilities to workloads running in private and other public clouds. Enhanced security provides unified security management and threat protection across your hybrid cloud workloads. Major benefits of enabling enhanced security features with Azure Arc-enabled servers include:

- **Microsoft Defender for Endpoint**: Microsoft Defender for Servers is available as an enhanced security feature. Defender for Servers includes Defender for Endpoint for comprehensive endpoint detection and response (EDR).
- **Vulnerability assessment for virtual machines, container registries, and SQL resources**: With the applicable Defender plan enabled, you can discover and investigate vulnerability findings in Defender for Cloud. Review the finding's remediation guidance and apply the required changes to the affected workload, such as updating vulnerable software or correcting a database configuration.
- **Multicloud security**: Connect your accounts from Amazon Web Services (AWS) and Google Cloud Platform (GCP) to protect resources and workloads on those platforms.
- **Hybrid security**: Get a unified view of security across all your on-premises and cloud workloads. Apply security policies and continuously assess the security of your hybrid cloud workloads to ensure compliance with security standards. Collect, search, and analyze security data from multiple sources, including firewalls and other partner solutions.
- **Track your security posture against standards**: Defender for Cloud assesses resources against the Microsoft cloud security benchmark (MCSB). Use the regulatory compliance dashboard to review applicable controls and, with the required plan and permissions, configure additional standards for your environment. Automated assessments support your compliance work but don't establish certification or assess every control. For details, see *MCSB in Defender for Cloud* and *Regulatory compliance standards*.

> [!NOTE]
> A **Fix** action is available only for recommendations that support it. Otherwise, follow the recommendation's remediation steps. Submitting a Defender Vulnerability Management remediation request creates an activity for tracking the work; it doesn't apply changes to devices.

## Defend multicloud resources on AWS and GCP

Connect AWS accounts and GCP projects or organizations through Defender for Cloud's native multicloud connectors. Defender for Cloud discovers resources in the connected scope and produces security assessments, recommendations, and workload-protection findings according to the plans you enable.

Multicloud capabilities include:

- Assessments of security misconfigurations across Azure, AWS, and GCP.
- A consolidated view of resources and Defender for Cloud recommendations.
- Secure score based on applicable security recommendations.
- MCSB assessments and cloud-specific standards. AWS also has the AWS Foundational Security Best Practices default standard; GCP has the GCP Default standard.
- Defender for Servers protection for supported AWS and GCP machines, with Azure Arc onboarding and endpoint components configured as described in each connector's deployment guidance.

Connecting a server to Azure Arc doesn't itself connect the provider's entire account or project. Follow *Connect your AWS account* or *Connect your GCP project*, review the access requirements, and select only the plans your organization needs.
