Because your company is a financial organization, it needs to meet the highest standards for security. Each customer or partner transaction must be completely protected from threats, and you must also respond effectively to potential threats. For example, if a virtual machine (VM) is compromised, you must act rapidly to address the issue.

This unit describes how to protect resources and respond to threats by using Microsoft Defender for Cloud. Defender for Cloud helps you ensure that the security configuration of your infrastructure is as secure as possible.

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

Defender for Cloud recommends ways to address the issues and risks that it uncovers. You can use recommendations to improve the security and compliance of your architecture.

:::image type="content" source="../media/6-security-center-update-02.png" alt-text="Screenshot of recommendation in Microsoft Defender for Cloud." lightbox="../media/6-security-center-update-02.png":::

## Protect against threats

You can use Defender for Cloud just-in-time (JIT) VM access and adaptive application controls to help block suspicious activity and protect your resources. To access these controls, select **Workload protections** in the **Cloud Security** section of the Defender for Cloud left navigation.

### JIT VM access

You can protect your VMs by using the just-in-time (JIT) VM access feature to block persistent VM access. Your VMs can be accessed based only on audited access that you configure.

To enable JIT, select **Just-in-time VM access** on the **Workload protections** screen under **Advanced protection**. On the **Just-in-time VM access** page, select the checkboxes next to one or more VMs on the **Not Configured** list, and then select **Enable JIT on (number) VM(s)** to configure JIT for the VMs.

Defender for Cloud shows you a list of default ports that JIT targets, or you can configure your own ports.

:::image type="content" source="../media/6-security-center-update-03.png" alt-text="Screenshot of JIT configuration." lightbox="../media/6-security-center-update-03.png":::

### Adaptive application controls

You can use adaptive application controls to control which applications are allowed to run on your VMs. Defender for Cloud uses machine learning to look at the processes running on your VMs, create exception rules for each resource group that holds your VMs, and give recommendations.

To configure adaptive controls, select **Adaptive application control** on the **Workload protections** screen under **Advanced protection**. The **Adaptive application controls** screen shows a list of resource groups that contain your VMs. The **Recommended** tab lists the resource groups that Defender for Cloud recommends for adaptive application controls.

:::image type="content" source="../media/6-security-center-update-04.png" alt-text="Screenshot of Adaptive application controls." lightbox="../media/6-security-center-update-04.png":::

Select a resource group and use the **Configure application control rules** screen to target VMs and applications that should have the control rules applied.

## Respond to threats

Defender for Cloud gives you a centralized view of all your security alerts, ranked by their severity. You can view your security alerts by selecting **Security alerts** in the Defender for Cloud left navigation.

:::image type="content" source="../media/6-security-center-update-01.png" alt-text="Screenshot of security alerts." lightbox="../media/6-security-center-update-01.png":::

Defender for Cloud combines related alerts into a single security incident as much as possible. Select an incident to see the specific security alerts that the incident holds.

Drill down into an alert by selecting the alert and then selecting **View full details**.

:::image type="content" source="../media/6-security-center-update-06.png" alt-text="Screenshot of incident details." lightbox="../media/6-security-center-update-06.png":::

Defender for Cloud can help you respond to threats faster and in an automated way by taking actions. Select **Next: Take Action** to take action on the alert.

:::image type="content" source="../media/6-security-center-update-08.png" alt-text="Screenshot of alert details." lightbox="../media/6-security-center-update-08.png":::

Expand any of the following sections to take action on the alert:

- **Inspect resource context** to examine the resource logs around the time of the alert.
- **Mitigate the threat** to see suggestions for minimizing or remediating the threat.
- **Prevent future attacks** to implement security recommendations.
- **Trigger automated response** to trigger a logic app as an automated response to this security alert.
- **Suppress similar alerts** by creating a suppression rule with predefined conditions.
- **Configure email notification settings** to select who to notify about the alert and under what conditions.

:::image type="content" source="../media/6-security-center-update-10.png" alt-text="Screenshot of the Take action pane." lightbox="../media/6-security-center-update-10.png":::

In the alert details, you should dismiss alerts if no action is required, for example if there are false positives. You should act to address known attacks, for example by blocking known malicious IP addresses, and you should decide which alerts require more investigation.

:::image type="content" source="../media/6-security-center-update-09.png" alt-text="Screenshot of alert status." lightbox="../media/6-security-center-update-09.png":::

