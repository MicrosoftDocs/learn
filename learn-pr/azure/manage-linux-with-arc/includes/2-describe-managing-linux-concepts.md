Azure Arc lets you manage physical and virtual Linux machines hosted outside of Azure, whether in your corporate network or hosted on another cloud provider. Organizations like Contoso can manage their Linux resources with Azure, just as they do their Arc-enabled Windows machines. Linux machines onboarded to Azure Arc can be managed just like native Azure machines, including the use of standard Azure constructs such as Azure policy and applying tags.

To onboard a Linux machine to Azure Arc, you deploy the Azure Arc Connected Machine agent to the machine. Azure Arc provides multiple options for deploying the agent individually or at scale across multiple machines. Once the agent is installed and functioning properly, the machine appears as an Arc resource in the Azure portal, and you can manage it like any other Azure resource.

Once your Linux machines are onboarded to Azure Arc, you can:

- Proactively monitor the OS and workloads running on the machine.
- Manage the machines using automation runbooks or solutions such as Update Manager.
- Use other Azure services such as Microsoft Defender for Cloud.

## Supported Linux distributions

The Azure Connected Machine agent supports a wide range of Linux distributions, including recent versions of:

- Ubuntu
- Debian
- Rocky Linux
- SUSE Linux Enterprise Server (SLES)
- Red Hat Enterprise Linux (RHEL)
- AlmaLinux
- Amazon Linux
- Oracle Linux

x86-64 (64-bit) architecture is fully supported, while only some features are supported on Arm64. The Azure Connected Machine agent doesn't run on 32-bit architectures.

## Change tracking and inventory

You can track changes in your Azure Arc Linux machines to help you pinpoint operational and environmental issues. Using the Change Tracking and Inventory feature, you can track items including:

- Linux software (packages)
- Linux files
- Linux daemons

## Update management

Your onboarded Linux machines can use Azure Update Manager to manage your operating system updates. You can quickly assess the status of available updates and manage the process of installing required updates for your Linux machines.

## Security

Linux machines on Azure Arc can use the same security features as all Azure resources, including Microsoft Defender for Cloud and Microsoft Sentinel.

### Microsoft Defender for Cloud

Microsoft Defender for Cloud is a cloud-native application protection platform (CNAPP), including a cloud security posture management (CSPM) solution and a cloud workload protection platform (CWPP). Defender for Cloud can monitor the security posture of your Linux machines on Azure Arc by:

- Providing continuous assessment of your security posture, so you can track new security opportunities and precisely report on the progress of your security efforts.
- Securing your workloads with step-by-step actions that protect your workloads from known security risks.
- Providing alerts to defend your workloads in real-time, so you can respond immediately and limit the risk to your resources

### Microsoft Sentinel

Microsoft Sentinel is a scalable, cloud-native security information and event management (SIEM) with built-in security orchestration, automation, and response (SOAR). Microsoft Sentinel delivers threat intelligence, providing a single solution for attack detection, proactive hunting, and threat response. By providing a birds-eye view across the enterprise, Microsoft Sentinel helps alleviate the stress of dealing with increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

Microsoft Sentinel can help keep your environment secure by:

- Collecting data at cloud scale across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
- Detecting previously undetected threats and minimize false positives using Microsoft's analytics and unparalleled threat intelligence.
- Investigating threats with artificial intelligence and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft.
- Responding to incidents rapidly with built-in orchestration and automation of common tasks.

Microsoft Sentinel comes with many connectors for Microsoft solutions, available out of the box and providing real-time integration.

## Monitoring

The Azure Monitor Agent collects monitoring data from the guest operating system of Azure and hybrid virtual machines. It delivers this data to Azure Monitor, allowing it to be used by other services, such as Microsoft Defender for Cloud. Data collection rules allow you to create unique, scoped configurations for subsets of your Linux machines. These rules are independent of the workspace and the virtual machine, which means you can define a rule once and reuse it across machines and environments.
