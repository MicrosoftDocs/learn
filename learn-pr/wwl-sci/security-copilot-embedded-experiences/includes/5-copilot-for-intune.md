Microsoft Intune has capabilities that are powered by Microsoft Security Copilot. These capabilities access your Intune data, and can help you manage your policies & settings, understand your security posture, and troubleshoot device issues.

Access to your Intune data is supported through Microsoft Security Copilot, referred to as the standalone experience, or embedded within the Intune admin center, referred to as Copilot in Intune. This unit focuses on the embedded experience.

> [!NOTE]
>The list of Copilot capabilities embedded in Microsoft Intune is continually growing. This unit provides just a sampling of those capabilities. For more information, see documentation on Microsoft Intune.

### Before you begin

To enable Copilot to access your Intune data, for either the embedded or standalone experience, Microsoft Security Copilot must be configured, the Microsoft Intune plugin must be enabled, and you need to have appropriate role permissions. The Intune Administrator role in Microsoft Entra ID has access to Copilot in Intune by default. Other roles can be assigned access through Security Copilot. There isn't a built-in Intune service role (such as Intune Endpoint Security Manager) that includes access to Copilot—Copilot access is controlled separately.

:::image type="content" source="../media/intune-plugin.png" lightbox="../media/intune-plugin.png" alt-text="Screen capture showing the Microsoft Intune plugin enabled.":::

For the specific setup tasks, go to [Describe how to enable Microsoft Security Copilot](/training/modules/security-copilot-getting-started/6-describe-how-to-enable-security-copilot).

You can check the status of Copilot in Intune from the Intune admin center.

:::image type="content" source="../media/copilot-in-intune-v2.png" lightbox="../media/copilot-in-intune-v2.png" alt-text="Screen capture of Intune admin portal showing that Copilot in Intune is enabled.":::

### Copilot in Intune

Currently, Copilot in Intune is available for:

- Policy and setting management
- Device details and troubleshooting
- Data exploration using natural language
- Automated tasks through Copilot agents

#### Policy and setting management

Copilot is embedded on policy settings and with your existing policies, on the following policy types in Intune:

- Compliance policies
- Device configuration policies, including the settings catalog
- Most endpoint security policies

When you create a new policy, you can use Copilot to learn more about individual settings, their impact, and recommended values by using the Copilot tooltips. 

The example that follows shows the compliance settings tab for a new macOS compliance policy. Next to each setting is a Copilot icon. Selecting the Copilot icon displays detailed information about the setting.

:::image type="content" source="../media/intune-copilot-settings-tooltip-preview-v2.png" lightbox="../media/intune-copilot-settings-tooltip-preview-v2.png" alt-text="Screen capture of Copilot in Intune tool tip icon for a setting and the information Copilot generates for that setting.":::

From an existing policy, you can use Copilot to summarize the policy. The summary describes what the policy does, the users and groups assigned to the policy, and the settings in the policy. This feature can help you understand the impact of a policy and its settings on your users and devices.

:::image type="content" source="../media/intune-policy-summarize.png" lightbox="../media/intune-policy-summarize.png" alt-text="Screen capture of Copilot in Intune showing a summary for a device policy and the available prompts.":::

Whether you're using Copilot to learn about the settings for a new policy or summarizing an existing policy, the Copilot window provides more prompts that you can use. You can also select the prompt guide icon on the bottom right and select from an existing list of prompts.

:::image type="content" source="../media/intune-prompt-guide.png" lightbox="../media/intune-prompt-guide.png" alt-text="Screen capture of Copilot in Intune prompt guide icon and the available prompts.":::

#### Device details and troubleshooting

You can use Copilot to get device-specific information, like the installed apps, group membership, and other information that can help troubleshoot a device.

:::image type="content" source="../media/intune-copilot-device-summary-troubleshooting.png" lightbox="../media/intune-copilot-device-summary-troubleshooting.png" alt-text="Screen capture of Copilot in Intune device summary, showing prompts that provide device specific information and can help in troubleshooting.":::

When the Copilot window opens, select a prompt, and enter any required or optional input, if needed. You can also open the prompt guide for some follow-up questions.

#### Data exploration

Copilot in Intune supports natural language queries across your Intune data. From the Copilot panel, you can ask questions about your devices, users, apps, policies, updates, and compliance—without writing queries or navigating through multiple admin pages. Built-in examples help you discover the kinds of questions you can ask.

When you run a query, Copilot summarizes the results and surfaces recommended actions you can take based on the output. Results can also feed directly into creating custom reports or adding users or devices to groups. This capability extends to Windows 365 Cloud PCs, allowing you to troubleshoot and get insights about Cloud PCs using the same natural language experience.

#### Copilot agents in Intune

Security Copilot agents in Intune are AI-powered assistants that go beyond prompt-based assistance to help automate key endpoint management tasks. Intune includes four specialized agents:

- **Change Review Agent** – Evaluates Multi Admin Approval requests and recommends actions.
- **Device Offboarding Agent** – Identifies stale or misaligned devices and provides insights before offboarding.
- **Policy Configuration Agent** – Converts plain-language documents and industry security baselines into recommended Intune policy settings.
- **Vulnerability Remediation Agent** – Uses Defender data to monitor vulnerabilities and prioritize remediation with AI-driven risk assessments.

These agents help IT teams quickly address vulnerabilities, policy gaps, and emerging threats across managed devices.