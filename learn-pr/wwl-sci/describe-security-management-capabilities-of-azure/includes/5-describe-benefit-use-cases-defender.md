Azure Defender is a built-in tool that provides threat protection for workloads running in Azure, on-premises, and other clouds. Azure Defender is the leading Microsoft extended detection and response (XDR) solution for threat protection. Integrated with Azure Security Center, Azure Defender protects your hybrid data, cloud-native services and servers, and integrates with your existing security workflows.

Built-in policies come with each Azure Defender plan, and you can add custom policies and initiatives. Also, you can add regulatory standards, such as NIST and Azure CIS, and the Azure Security Benchmark for a truly customized view of your compliance.

You'll find the Azure Defender dashboard in Azure Security Center. It provides visibility and control of your organization's cloud workload protection (CWP) features across the network.

### Scope of Azure Defender

Azure Defender comes with several different plans that can be enabled separately and will run simultaneously to provide a comprehensive defense for compute, data, and service layers in your environment. The Azure Defender plans you can select from are:

- **Azure Defender for servers** adds threat detection and advanced defenses for your Windows and Linux machines.
- **Azure Defender for App Service** uses the cloud scale to identify attacks targeting applications running over App Service.
- **Azure Defender for Storage** detects potentially harmful activity on your Azure Storage accounts. Data can be protected, whether stored as blob containers, file shares, or data lakes.
- **Azure Defender for SQL** extends Azure Security Center's data security package to secure your databases and their data wherever they're located.
- **Azure Defender for Kubernetes** provides the best cloud-native Kubernetes security environment hardening, workload protection, and run-time protection.
- **Azure Defender for container registries** protects all the Azure Resource Manager based registries in your subscription. Azure Defender scans all images pushed to the registry, or imported into the registry, or any images pulled within the last 30 days.
- **Azure Defender for Key Vault** is Azure-native, advanced threat protection for Azure Key Vault, providing an extra layer of security intelligence.

### Hybrid cloud protection

You can defend your Azure environment, and add Azure Defender capabilities to the hybrid cloud environment:

- Protect your non-Azure servers.
- Protect your virtual machines in other clouds (such as AWS and GCP).

To focus on what matters most, you can customize threat intelligence and prioritize alerts according to your specific environment.

### Azure Defender alerts

When Azure Defender detects a threat in any area of your environment, it generates an alert. These alerts describe details of the affected resources, suggested remediation steps, and in some cases, an option to trigger a logic app in response. The alerts can also be exported into Azure Sentinel.

### Advanced protection

Azure Defender uses advanced analytics for tailored recommendations as they relate to your resources. These analytics might include securing the management ports of your VMs with just-in-time access and adaptive application controls to create allow lists for what apps should and shouldn't run on your machines.

### Vulnerability assessment

Azure Defender includes vulnerability scanning for your virtual machines and container registries. Review the findings from these vulnerability scanners and respond to them all from within Security Center.
