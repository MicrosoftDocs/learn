Microsoft Security Copilot is a cloud-based AI platform offering a natural language interface to support security professionals in scenarios like incident response, threat hunting, and intelligence gathering. By integrating with Microsoft Intune, Security Copilot provides detailed insights about your Intune-managed devices and policies.

## Security Admin Focus

Security Copilot is designed with a Security Operations Center (SOC) or security admin focus. SOC analysts and security admins can use it to get the security posture of devices managed by Intune. For example, if a device shows signs of malicious intent or an unknown device enrolls in Intune, admins can use Security Copilot to gather more information, such as device properties, enrollment time, user details, device type, and compliance status. This information can be used with Microsoft Defender to determine appropriate actions based on device type.

## Prerequisites

To access Microsoft Intune data in Security Copilot, you need:
- Active subscriptions for both Microsoft Security Copilot and Microsoft Intune
- Administrative access to both Microsoft 365 and Azure environments.
- Properly configured Intune policies and security settings.
- RBAC roles and Intune scope tag assigned to you.

## Open Copilot for Security and enable Intune

To use the Intune capabilities in Copilot for Security, enable the Intune plugin.

1. Go to [Microsoft Copilot for Security](https://go.microsoft.com/fwlink/?linkid=2247989) and sign in with your credentials.
2. In the prompt bar, select **Sources** (right corner).

    :::image type="content" source="../media/security-copilot-sources.png" alt-text="Screenshot that shows the plugin sources that are available, enabled, and disabled in Microsoft Copilot for Security.":::

3. In **Manage sources**, turn on Microsoft Intune:

    :::image type="content" source="../media/intune-plugin-enabled.png" alt-text="Screenshot that shows the Microsoft Intune plugin source is enabled in Microsoft Copilot for Security.":::

> [!NOTE]
> Some roles can enable or disable plugins. For more information, go to [Manage plugins in Microsoft Copilot for Security](/security-copilot/manage-plugins).

## Use the built-in features

In Copilot for Security, there are built in system features that are helpful for Intune admins. For a walkthrough of Copilot for Security, go to [Navigating Microsoft Copilot for Security](/security-copilot/navigating-security-copilot).

This section describes some of the features that are helpful for Intune admins.

### System capabilities

Capabilities are built-in features that can get data from the different plugins that you enable, including Microsoft Intune. When you use a prompt to ask something about your Intune data, like apps assigned to a user or device details, your prompts use these Intune capabilities.

To view the list of Intune built-in system capabilities for Intune, use the following steps:

1. In the [Copilot for Security portal](https://go.microsoft.com/fwlink/?linkid=2247989) prompt bar, select the Copilot prompts icon > **See all system capabilities**.

    :::image type="content" source="../media/security-copilot-system-capabilities.png" alt-text="Screenshot that shows how to select the prompts icon and system capabilities in Microsoft Copilot for Security.":::

2. In the Microsoft Intune section, there's a list of all the built-in capabilities for Intune. You can select any of the capabilities and get more information about that capability.

### Sessions

When you use prompts in the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) or in the Copilot for Security portal, the sessions are saved. To see the saved sessions, use the following steps:

1. In the [Copilot for Security portal](https://go.microsoft.com/fwlink/?linkid=2247989), go to the menu > **My sessions**.

    :::image type="content" source="../media/security-copilot-menu-my-sessions.png" alt-text="Screenshot that shows the Microsoft Copilot for Security menu and My sessions with previous sessions in Copilot for Security portal.":::

2. When you select a session, your previous prompts and results are shown. Every session also has a session ID in the URL. You can share this session ID with others to review the same prompt session.

## Provide feedback

Your feedback on the Intune integration with Copilot for Security helps with development. To provide feedback, in Copilot for Security, use the feedback buttons at the bottom of each completed prompt.

:::image type="content" source="../media/security-copilot-prompt-feedback.png" alt-text="Screenshot that shows how to submit feedback on the prompt results in Microsoft Copilot for Security.":::

Whenever possible, and when the result isn't what you expect, write a few words explaining what can be done to improve the outcome. If you entered Intune-specific prompts and the results aren't Intune related, then include that information.