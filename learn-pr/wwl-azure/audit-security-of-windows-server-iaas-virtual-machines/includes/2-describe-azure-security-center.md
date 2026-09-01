To address the unique security challenges that a hybrid environment presents, such as rapidly changing services, sophisticated attacks, and increased workloads, Contoso IT staff need tools to help assess their security posture and identify risks. Ideally, they want to deploy those tools with minimal effort. Microsoft Defender for Cloud can help them meet these requirements.

## What is Microsoft Defender for Cloud

*Microsoft Defender for Cloud* is a Cloud Native Application Protection Platform (CNAPP) for managing the security of cloud, multicloud, DevOps, and on-premises resources. With Microsoft Defender for Cloud capabilities, you can:

- Improve your security posture. Use Microsoft Defender for Cloud to implement security best practices across IaaS, platform as a service (PaaS), data, DevOps, and on-premises resources. You can also track compliance against regulatory standards.
- Protect your environment. Monitor for security threats to your cloud and on-premises servers, identify misconfigurations, and provide server endpoint detection and response (EDR) with Microsoft Defender for Endpoint.
- Protect your workloads and data. Identify suspicious activity in servers, containers, storage accounts, databases, and other cloud workloads. Defender for Cloud also helps identify sensitive data and prioritize risks in supported services.

## How Microsoft Defender for Cloud works in hybrid environments

In addition to monitoring and protecting Azure IaaS, PaaS, DevOps, and data resources, Microsoft Defender for Cloud helps protect servers outside Azure. To protect non-Azure servers, onboard them as Azure Arc-enabled servers and enable a Defender for Servers plan. Defender for Servers protects Windows and Linux machines running in Azure, Amazon Web Services (AWS), Google Cloud Platform (GCP), and on-premises environments.

Defender for Servers now relies on Microsoft Defender for Endpoint integration and agentless machine scanning for most server protection features. These capabilities provide EDR, vulnerability scanning, software inventory, threat detection, malware and secrets discovery, and security recommendations without depending on the retired Log Analytics agent.

> [!NOTE]
> The Log Analytics agent, also known as the Microsoft Monitoring Agent (MMA), retired in November 2024. Use Azure Arc, Defender for Endpoint integration, and agentless scanning instead of MMA-based onboarding.

### Notifications

One of the first things to do when onboarding to Microsoft Defender for Cloud is to provide contact information so Microsoft Defender for Cloud can notify you when it detects compromised resources. In Microsoft Defender for Cloud, configure **Email notifications** from **Environment settings**. Provide security contact details and choose which alert severities should generate notifications.

### Microsoft Defender for Cloud feature coverage for VMs

Microsoft Defender for Cloud provides a wide variety of features. Foundational Cloud Security Posture Management (CSPM) capabilities are available without enabling a paid plan. Advanced posture management and workload protection capabilities require a Defender plan, such as Defender CSPM or Defender for Servers.

> [!NOTE]
> Only some features apply to on-premises servers and VMs. For hybrid server protection, connect servers to Azure Arc and enable Defender for Servers.

Some common Microsoft Defender for Cloud features include:

- Secure score
- Regulatory compliance dashboard and reports
- Security governance
- Attack path analysis
- Cloud Security Explorer
- Missing operating system updates assessment powered by Azure Update Manager
- Operating system baseline assessment
- Agent-based and agentless vulnerability scanning
- Software inventory
- Malware scanning
- Machine secrets scanning
- Threat detection and security alerts
- Defender for Endpoint
- Just-in-time (JIT) VM access
- File integrity monitoring
- Cloud security graph
- Integration with SIEM and SOAR solutions

You can find out which Microsoft Defender for Cloud features are included with each plan, and learn more about what they do, by reviewing [Defender for Servers](/azure/defender-for-cloud/defender-for-servers-overview) and [What is Microsoft Defender for Cloud?](/azure/defender-for-cloud/defender-for-cloud-introduction).
