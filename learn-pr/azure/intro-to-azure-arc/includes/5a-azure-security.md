Contoso wants to protect the servers and Kubernetes clusters it's connected to Azure Arc. Microsoft Sentinel lets Contoso collect security-related events for their Arc-enabled servers, providing alert detection, threat visability, and other benefits. Through Microsoft Defender for Servers, Contoso can monitor the security posture of their Arc-enabled servers, while also securing their Kubernetes clusters through Microsoft Defender for Containers.

## Azure Arc security with Microsoft Sentinel

Microsoft Sentinel is a scalable, cloud-native, security information and event management (SIEM) and security orchestration, automation, and response (SOAR) solution. Microsoft Sentinel delivers threat intelligence across the enterprise, providing a single solution for attack detection, proactive hunting, and threat response.

Microsoft Sentinel is your birds-eye view across the enterprise alleviating the stress of increasingly sophisticated attacks, increasing volumes of alerts, and long resolution time frames.

- **Collect data at cloud scale** across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
- **Detect previously undetected threats** and minimize false positives using Microsoft's analytics and unparalleled threat intelligence.
- **Investigate threats with artificial intelligence** and hunt for suspicious activities at scale, tapping into years of cyber security work at Microsoft.
- **Respond to incidents rapidly** with built-in orchestration and automation of common tasks.

<!--Microsoft Sentinel provides a single solution for alert detection, threat visibility, proactive hunting, and threat response across the enterprise. Microsoft Sentinel collects data from a wide array of sources, detects and investigates threats, and rapidly responds to incidents using automation of common tasks.-->

### Onboard Azure Arc-enabled servers to Microsoft Sentinel

In order to onboard a Azure Arc-enabled server to Microsoft Sentinel, you'll need the following:

- A Log Analytics workspace
- Microsoft Sentinel enabled in your subscription
- Your server connected to Azure Arc-enabled servers

Microsoft Sentinel comes with a number of connectors for Microsoft solutions, available out of the box and providing real-time integration. For physical and virtual machines, you can install the Log Analytics agent that collects the logs and forwards them to Microsoft Sentinel. Azure Arc-enabled servers supports deploying the Log Analytics agent using the following methods:

- Using the **VM extensions framework**, you can deploy the Log Analytics agent VM extension to a non-Azure Windows and/or Linux server. VM extensions can be managed using the Azure portal, Azure CLI, Azure PowerShell, and Azure Resource Manager templates.
- Using **Azure Policy**, you can Deploy Log Analytics agent to Linux or Windows Azure Arc machines to audit if the Azure Arc-enabled server has the Log Analytics agent installed. If the agent isn't installed, it automatically deploys it using a remediation task. You can also use the built-in Azure Policy to Enable Azure Monitor for VMs initiative to install and configure the Log Analytics agent.

After your Arc-enabled servers are connected, your data starts streaming into Microsoft Sentinel and is ready for you to use!

### Detecting threats

Contoso can use Microsoft Sentinel's threat detection templates to create their own rules for detecting suspicious activity. These rule templates are based on known threats and common attack vectors, allowing Contoso to create specific rules to automatically search their environment for threats. Templates can be customized to search for activities or filter them out as needed. 

All the analytics rules and detections in Microsoft Sentinel can be viewed from the **Analytics > Rule templates** tab:
 
:::image type="content" source="../media/view-oob-detections.png" alt-text="Screenshot that depicts the Map tab on the Insights page for a VM in Azure. ContosoVM1 is displayed with details of open TCP ports. A VM summary is also displayed, detailing the VM's operating system, IP address, and links for Health, Machine properties, and Azure VM properties. Three buttons are displayed for access to Properties (selected), Log Events, Alerts, and Connections." border="false":::

## Azure Arc security with Microsoft Defender

Microsoft Defender for Servers and Microsoft Defender for Containers provide added threat protection for Contoso's servers and Kubernetes clusters:

- **Defender for Servers** is one of the enhanced security features of Microsoft Defender for Cloud. Microsoft Defender for Servers adds threat detection and advanced defenses to your Windows and Linux machines whether they're running in Azure, on-premises, or in a multi-cloud environment.
- **Defender for Containers** is the cloud-native solution for securing your containers. Defender protects your clusters running in Azure Kubernetes Service (AKS) or other common container environments (such as Amazon Elastic Kubernetes Service (AKS) or Google Kubernetes Engine (GKE)).

### What security benefits does Defender for Servers provide?

Core benefits of Microsoft Defender for Servers include:

- **Vulnerability assessment tools** to deploy to your machines. Any vulnerabilities uncovered are shown in a security recommendation.
- **Integration with Microsoft Defender for Endpoint** to provide comprehensive endpoint and detection capabilities. When Defender for Endpoint detects a threat, it triggers an alert. The alert is shown in Defender for Cloud. From Defender for Cloud, you can also pivot to the Defender for Endpoint console and perform a detailed investigation to uncover the scope of the attack. 
- **File integrity monitoring (FIM)** examines files and registries of operating systems and application software for changes that might indicate an attack. A comparison method is used to determine if the current state of the file is different from the last scan of the file. You can use this comparison to determine if valid or suspicious modifications have been made to your files.
- **Adaptive application controls (AAC)** are an intelligent and automated solution for defining allowlists of known-safe applications for your machines. When you've configured adaptive application controls, you'll get security alerts if any application runs other than the ones you've defined as safe

### How does Defender for Containers secure my Kubernetes clusters?

Defender for Containers helps with the core aspects of container security:

- **Environment hardening** - Defender for Containers protects your Kubernetes clusters whether they're running on Azure Kubernetes Service, Kubernetes on-premises / IaaS, or Amazon EKS. By continuously assessing clusters, Defender for Containers provides visibility into misconfigurations and guidelines to help mitigate identified threats.
- **Vulnerability assessment** - Vulnerability assessment and management tools for images stored in ACR registries and running in Azure Kubernetes Service.
- **Run-time threat protection for nodes and clusters** - Threat protection for clusters and Linux nodes generates security alerts for suspicious activities.
