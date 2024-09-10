Azure Arc lets you manage physical and virtual Linux machines hosted outside of Azure, on your corporate network, or other cloud provider. Organizations like Contoso can manage their Linux resources with Azure just as they do their Arc-enabled Windows machines. Linux machines onboarded to Azure Arc enjoy the same capabilities as native Azure machines, including standard Azure constructs such as Azure policy and applying tags.

Once your Linux machines are onboarded to Azure Arc, you can:

- Proactively monitor the OS and workloads running on the machine.
- Manage the machines using automation runbooks or solutions like Update Management.
- Use other Azure services such as Microsoft Defender for Cloud.

## Supported Linux distributions

The following Linux distributions are officially supported for the Azure Connected Machine agent:

- Ubuntu 18.04, 20.04, and 22.04 LTS12
- Debian 11 and 12
- Rocky Linux 8 and 9
- SUSE Linux Enterprise Server (SLES) 12 SP3-SP5 and 15
- Red Hat Enterprise Linux (RHEL) 7, 8, and 9
- AlmaLinux 9
- Amazon Linux 2 and 2023
- Azure Linux (CBL-Mariner) 2.0
- Oracle Linux 7, 8 and 9

## Change tracking and inventory

You can track changes in your Azure Arc Linux machines to help you pinpoint operational and environmental issues. Using the Change Tracking and Inventory feature, you can track items including:

- Linux software (packages)
- Linux files
- Linux daemons

## Update Management

Your onboarded Linux machines can use Update Management to manage your operating system updates. You can quickly assess the status of available updates and manage the process of installing required updates for your Linux machines. Update Management integrates with Azure Monitor Logs to store update assessments and update deployment results as log data.

## Security

Linux machines on Azure Arc enjoy the same security features as all Azure resources, including Microsoft Defender for Cloud and Microsoft Sentinel.

### Microsoft Defender for Cloud

Microsoft Defender for Cloud is a Cloud Security Posture Management (CSPM) and Cloud Workload Protection Platform (CWPP). Defender for cloud can monitor the security posture of your Linux machines on Azure Arc and fills three vital needs as you manage the security of your Linux resources and workloads:

- Provides continuous assessment of your security posture so you can track new security opportunities and precisely report on the progress of your security efforts.
- Secures your workloads with step-by-step actions that protect your workloads from known security risks.
- Provides alerts to defend your workloads in real-time so you can react immediately and prevent security events from developing.

### Microsoft Sentinel

Microsoft Sentinel is an integrated SIEM (scalable, cloud-native, security information, and event management) and a SOAR (security orchestration, automation, and response) solution. Microsoft Sentinel delivers threat intelligence, providing a single solution for attack detection, proactive hunting, and threat response. It provides a birds-eye view across the enterprise. Microsoft Sentinel alleviates the stress of increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

The benefits of Microsoft Sentinel include:

- Collect data at cloud scale across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
- Detect previously undetected threats and minimize false positives using Microsoft's analytics and unparalleled threat intelligence.
- Investigate threats with artificial intelligence and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft.
- Respond to incidents rapidly with built-in orchestration and automation of common tasks.

Microsoft Sentinel comes with many connectors for Microsoft solutions, available out of the box and providing real-time integration. For physical and virtual Linux machines, you can install the Log Analytics agent that collects the logs and forwards them to Microsoft Sentinel.

## Monitoring

Azure Monitor Agent (AMA) collects monitoring data from the guest operating system of Azure and hybrid virtual machines. It delivers it to Azure Monitor for use by features, insights, and other services, such as Microsoft Defender for Cloud. AMA uses data collection rules that let you define the types of data you want each agent you install to collect. Data collection rules allow you to create unique, scoped configurations for subsets of your Linux machines. These rules are independent of the workspace and the virtual machine, which means you can define a rule once and reuse it across machines and environments.
