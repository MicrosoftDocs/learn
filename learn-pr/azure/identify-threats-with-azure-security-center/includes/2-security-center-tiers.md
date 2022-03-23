Microsoft Defender for Cloud has two options: Microsoft Defender for Cloud free (enhanced security off) and enhanced security (Enhanced security on). Both provide security policy, assessment, and recommendations and connection with partner solutions.

## Free plan

The free plan (enhanced security off) is automatically enabled on all Azure subscriptions. It provides security policy, continuous security assessment, and actionable security recommendations to help you protect your Azure resources. It monitors the most common app resources in Azure, including:

- Compute resources such as VMs, Azure Functions, and App Service.
- Network access and endpoint security.
- Data storage including Azure Storage, Redis cache for Azure, and Azure SQL.
- Identity and access, including Azure Key Vault.
- IoT Hubs and resources.

## Microsoft Defender for Cloud plans

The Defender for Cloud plans extend the capabilities of the free plan to workloads running in private and other public clouds. These plans provide unified security management and threat protection across all your hybrid cloud workloads.

The Defender for Cloud plans add advanced threat detection capabilities, using analytics and machine learning to identify attacks and zero-day exploits. They can also use access and application controls to reduce exposure to network attacks and malware.

Turning on the enhanced security features for your Defender for Cloud subscription enables the following features:

- **Security event collection**. Defender for Cloud collects logs in a central place. You can then search and analyze them to identify important security events that might require your attention.
- **Network Map**. This feature enables you to visualize the topology of your Azure network infrastructure and the traffic to your Azure VMs. It also enables you to create filters by the severity level and recommendations.
- **Just-in-time (JIT) VM access**. This feature enables admins to grant access to a VM for a defined period of time. Limiting access helps reduce exposure to outside attacks. This feature is especially useful if you’re working with an outside agency that needs to access your VM.
- **Adaptive application controls (approved application listing)**. Adaptive application controls use artificial intelligence to recommend applications to allow. This feature helps protect VMs by preventing malware and unauthorized software from being installed.
- **Regulatory compliance reports**. In the Regulatory compliance dashboard, you have a clear view of the status of all standard regulatory assessments within your environment.
- **File integrity monitoring**. This feature examines files and registries of the operating system, application software, and others in Windows and Linux environments for changes that might indicate an attack.
- **Adaptive Network Hardening**. Adaptive Network Hardening provides recommendations to harden applied Network Security Group (NSG) rules. It uses machine learning algorithms that factor in actual traffic, known trusted configuration, threat intelligence, and other indicators of compromise. It then provides recommendations to allow traffic only from specific IP or port tuples.
- **Security alerts**. Defender for Cloud supports various security alerts such as detection of potential distributed denial-of-service (DDOS) attacks. Just-in-time alerts give you the chance to investigate evolving issues before they result in a service failure.
- **Threat intelligence**. This feature can help determine the nature of an attack, the attack point of origin, and more.
- **Workflow Automation**. This collection of procedures can be executed from Defender for Cloud after a certain playbook is triggered from selected alert. Workflow automation can help automate and orchestrate your response to a specific security alert.

## Switch to Microsoft Defender for Cloud

You can try Microsoft Defender for free for 30 days. This trial enables you to evaluate the other features. You can see how your current environment will benefit from them and decide whether they’re worth the investment.

You can enable Microsoft Defender for Cloud on a per-subscription basis. For each subscription, you can choose what elements you want to enroll. Select  **Environment settings** under **Management** to list all your management groups and subscriptions.

Selecting a subscription enables you to view and control what resource types you want to enable for Microsoft Defender for Cloud.

:::image type="content" source="../media/2-defender-for-cloud-enhanced-security-enabled.png" alt-text="Screenshot that shows the Defender plans pane with the Defender for Cloud plans enabled.":::
