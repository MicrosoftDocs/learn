Because your company is a financial organization, it needs to meet the highest standards for security. Each customer or partner transaction must be completely protected from threats, and you must also respond effectively to potential threats. For example, if a virtual machine (VM) is compromised, you must act rapidly to address the issue.

This unit describes how to protect resources and respond to threats by using Microsoft Defender for Cloud. Defender for Cloud helps you ensure that the security configuration of your resources is as secure as possible.

You can use Defender for Cloud to:

- Understand your architecture's security posture.
- Identify and address risks and threats to your infrastructure.
- Secure a complex infrastructure by using traditional in-house skills and capital.
- Secure an infrastructure that consists of on-premises and cloud resources.

## Understand your security posture

You must understand your architecture's security posture to help you build and maintain better infrastructures. Defender for Cloud helps you understand the security of your architecture by giving you detailed analyses of different components of your environment, including:

- Data security
- Network security
- Identity and access
- Application security

Defender for Cloud uses Azure Monitor Logs to collect data from your VMs to monitor for security vulnerabilities and threats. An agent reads various security-related configurations and event logs from the VM and copies the data to your Log Analytics workspace for analysis.

:::image type="content" source="../media/6-security-center-update-01.png" alt-text="Screenshot of Microsoft Defender for Cloud Overview screen." lightbox="../media/6-security-center-update-01.png":::

Defender for Cloud recommends ways to address the issues and risks that it uncovers. You can use recommendations to improve the security and compliance of your architecture.

:::image type="content" source="../media/6-security-center-update-02.png" alt-text="Screenshot of recommendation in Microsoft Defender for Cloud." lightbox="../media/6-security-center-update-02.png":::

## Protect against threats

You can use Defender for Cloud access and application controls to block suspicious activity and help protect your resources.

### JIT VM access

You can protect your VMs by using the just-in-time (JIT) VM access feature to block persistent VM access. Your VMs can be accessed based only on audited access that you configure.

You can enable JIT by selecting **Just in time VM access** in the **Workload protections** section of Defender for Cloud in the Azure portal. You see a lists of VMs that already have JIT configured or don't have JIT configured. Choose a VM in the **Not configured** list, and then select the **Enable JIT on (number) VMs** option to configure JIT for the VM.

Defender for Cloud shows you a list of default ports that JIT targets, or you can configure your own ports.

:::image type="content" source="../media/6-security-center-update-03.png" alt-text="Screenshot of JIT configuration." lightbox="../media/6-security-center-update-03.png":::

### Adaptive application controls

You can use adaptive application controls to control which applications are allowed to run on your VMs. Defender for Cloud uses machine learning to look at the processes running on your VMs, create exception rules for each resource group that holds your VMs, and give recommendations.

You can configure adaptive controls by selecting **Adaptive application controls** option in the **Advanced protection** section of the Microsoft Defender for Cloud left navigation. You get a list of resource groups that contain your VMs. The **Recommended** section lists the resource groups that Defender for Cloud recommends for adaptive application controls.

:::image type="content" source="../media/6-security-center-update-04.png" alt-text="Screenshot of Adaptive application controls." lightbox="../media/6-security-center-update-04.png":::

Select a resource group and use **Create application control rules** to target the VMs. You can also use **Create application control rules** to target processes to apply the rule to.

## Respond to threats

Defender for Cloud gives you a centralized view of all your security alerts, ranked by their severity. Defender for Cloud also combines related alerts into a single security incident as much as possible.

You can view your security alerts by selecting **Security alerts** under the **General** section of the Defender for Cloud left navigation.

:::image type="content" source="../media/6-security-center-update-05.png" alt-text="Screenshot of Security alerts overview." lightbox="../media/6-security-center-update-05.png":::

Drill down into specific security incidents by selecting an incident.

:::image type="content" source="../media/6-security-center-update-06.png" alt-text="Screenshot of incident details." lightbox="../media/6-security-center-update-06.png":::

You see the list of alerts that the incident holds.

:::image type="content" source="../media/6-security-center-update-07.png" alt-text="Screenshot of incident with alert list." lightbox="../media/6-security-center-update-07.png":::

Select an alert to get more information about the alert.

:::image type="content" source="../media/6-security-center-update-08.png" alt-text="Screenshot of alert details." lightbox="../media/6-security-center-update-08.png":::

You should dismiss alerts if no action is required, for example if there are false positives. You must act to address known attacks, for example by blocking known malicious IP addresses. You also need to decide which alerts require more investigation.

:::image type="content" source="../media/6-security-center-update-09.png" alt-text="Screenshot of alert status." lightbox="../media/6-security-center-update-09.png":::

Defender for Cloud helps you respond to threats faster and in an automated way by taking actions. Actions can include:

- Mitigating the threat
- Preventing future attacks
- Triggering an automated response with Azure Logic Apps
- Suppressing similar alerts

:::image type="content" source="../media/6-security-center-update-10.png" alt-text="Screenshot of alert action options." lightbox="../media/6-security-center-update-10.png":::
