Azure Defender is a built-in tool that provides threat protection for workloads running in Azure, on-premises, and other clouds. Defender is the leading Microsoft extended detection and response (XDR) solution for threat protection. Integrated with Azure Security Center, Azure Defender protects your hybrid data, cloud-native services, and servers and integrates with your existing security workflows.

In addition to the built-in policies that come with each Azure Defender plan, you can add custom policies and initiatives. You can add regulatory standards - such as NIST and Azure CIS - as well as the Azure Security Benchmark for a truly customized view of your compliance.

The Azure Defender dashboard can be found in Azure Security Center and provides visibility and control of your organization's cloud workload protection (CWP) features across your network.

### Scope of Azure Defender

Azure Defender comes with several different plans that can be enabled separately and will run simultaneously to provide a comprehensive defense for compute, data, and service layers of your environment. The Azure Defender plans you can select from are:

- **Azure Defender for servers**: Azure Defender for servers adds threat detection and advanced defenses for your Windows and Linux machines.
- **Azure Defender for App Service**: uses the cloud-scale to identify attacks targeting applications running over App Service.
- **Azure Defender for Storage**: detects potentially harmful activity on your Azure Storage accounts. Your data can be protected, whether stored as blob containers, file shares, or data lakes.
- **Azure Defender for SQL**: extends Azure Security Center's data security package to secure your databases and their data wherever they're located.
- **Azure Defender for Kubernetes**: provides the best cloud-native Kubernetes security environment hardening, workload protection, and run-time protection.
- **Azure Defender for container registries**: protects all the Azure Resource Manager based registries in your subscription. Azure Defender scans all images pushed to the registry, imported into the registry, or any images pulled within the last 30 days.
- **Azure Defender for Key Vault**: is Azure-native, advanced threat protection for Azure Key Vault, providing an additional layer of security intelligence.

### Hybrid cloud protection

As well as defending your Azure environment, you can add Azure Defender capabilities to your hybrid cloud environment:

- Protect your non-Azure servers
- Protect your virtual machines in other clouds (such as AWS and GCP)

You can customize threat intelligence and prioritized alerts according to your specific environment so that you can focus on what matters the most.

### Azure Defender alerts

When Azure Defender detects a threat in any area of your environment, it generates an alert. These alerts describe details of the affected resources, suggested remediation steps, and in some cases, an option to trigger a logic app in response. In addition, these alerts can be exported into Azure Sentinel.

### Advanced protection

Azure Defender uses advanced analytics for tailored recommendations as they relate to your resources, including securing the management ports of your VMs with just-in-time access and adaptive application controls to create allow lists for what apps should and shouldn't run on your machines.

### Vulnerability assessment

Azure Defender includes vulnerability scanning for your virtual machines and container registries. Review the findings from these vulnerability scanners and respond to them all from within Security Center.
