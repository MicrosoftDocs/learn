Contoso wants to protect the servers and Kubernetes clusters that it has connected to Azure Arc. By using Microsoft Sentinel, Contoso can collect security-related events for their Arc-enabled servers, providing alert detection, threat visibility, and other benefits. Contoso can also use Microsoft Defender for Servers to monitor the security posture of their Arc-enabled servers, while also helping to secure their Kubernetes clusters through Microsoft Defender for Containers.

## Azure Arc security with Microsoft Sentinel

Microsoft Sentinel is an integrated SIEM (scalable, cloud-native, security information, and event management) and a SOAR (security orchestration, automation, and response) solution. Microsoft Sentinel delivers threat intelligence, providing a single solution for attack detection, proactive hunting, and threat response. It provides a birds-eye view across the enterprise, alleviating the stress of increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

The benefits of Microsoft Sentinel include:

- **Collect data at cloud scale** across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
- **Detect previously undetected threats** and minimize false positives using Microsoft's analytics and unparalleled threat intelligence.
- **Investigate threats with artificial intelligence** and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft.
- **Respond to incidents rapidly** with built-in orchestration and automation of common tasks.

Through Azure Arc, these benefits can extend to servers across Contoso's hybrid environment.

Microsoft Sentinel comes with several connectors for Microsoft solutions available out of the box and providing real-time integration. For physical and virtual machines, you install the Log Analytics agent that collects the logs and forwards them to Microsoft Sentinel.

After your Azure Arc-enabled servers have been connected to the Log Analytics workspace and Microsoft Sentinel has been enabled, you can set up data connectors to start ingesting logs.

Contoso can use Microsoft Sentinel's threat detection templates to create their own rules for detecting suspicious activity. These rule templates are based on known threats and common attack vectors, allowing Contoso to create specific rules to automatically search their environment for threats. Templates can be customized to search for activities or filter them out as needed.

## Azure Arc security with Microsoft Defender

Microsoft Defender for Servers and Microsoft Defender for Containers provide added threat protection for Contoso's servers and Kubernetes clusters.

Microsoft Defender for Servers is one of the enhanced security features of Defender for Cloud. Defender for Servers adds threat detection and advanced defenses to your Windows and Linux machines whether they're running in Azure, on-premises, or in a multicloud environment.

Microsoft Defender for Containers is the cloud-native solution for securing your containers. Defender for Containers protects your clusters by continuously assessing them, offering visibility into misconfigurations and providing guidelines to help mitigate identified threats. Threat protection generates security alerts for suspicious activities.