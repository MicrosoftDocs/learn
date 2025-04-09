Microsoft Purview Communication Compliance is a tool within Microsoft Purview designed to help organizations review and manage various communication channels, including Microsoft Copilot. This solution helps identify and address potential issues in messages to ensure they meet organizational standards.

It helps address the challenges of modern communication. These challenges include the high volume of message data and the variety of channels such as email, Microsoft Teams, and Microsoft 365 Copilot. With preset and custom policies, Communication Compliance supports regulatory compliance and helps protect your communication environment.

## Communication Compliance policies for Microsoft 365 Copilot

Communication Compliance extends to Copilot interactions, enabling organizations to assess and manage these AI-driven communications. To set up policies for Copilot, navigate to the Microsoft Purview portal. Users with the _Communication Compliance Admins_ role can create and manage policies, defining:

- The scope of communications and users under review.
- Custom conditions that the communications must meet.
- Who is responsible for conducting the reviews.

You can use the **Detect Microsoft 365 Copilot interactions** template to quickly create a policy that reviews Copilot prompts and responses. The template covers common configuration options and helps you get started faster. Default configuration options for this template include:

- **Location**: Microsoft 365 Copilot
- **Direction**: Inbound, Outbound, Internal
- **Review Percentage**: 100%
- **Conditions**: No conditions are selected by default, but you must select at least one condition.

Communication compliance policies can be adjusted as needed but can't be renamed. Once policies are no longer needed, they should be deleted. Modifications to policies, including alert status and resolved items, can be exported to a CSV file for record-keeping.

Policies scan communications every 24 hours based on their creation time. For example, if a policy is created at 11:00 AM, it runs daily at that time. The **Last policy scan** column on the **Policy** page provides information about the last scan date and time. It might take up to 24 hours after creating a new policy to see the first policy scan data.

### Manage Copilot interactions with Communication Compliance

Communication compliance supports Microsoft 365 Copilot, analyzing interactions (prompts and responses) entered into Copilot to detect inappropriate or risky interactions or sharing of confidential information.

Supported Copilot apps include:

- Teams (chats/channels/meetings) Copilot
- Word Copilot
- PowerPoint Copilot
- Excel Copilot
- OneNote Copilot
- Loop Copilot
- Whiteboard Copilot
- Microsoft 365 Chat in Teams
- Microsoft 365 Chat in Bing

Any prompt or response entered into a supported Copilot app that matches a communication compliance policy is displayed as a policy match [on the **Policies** page on the **Pending** tab](/purview/communication-compliance-investigate-remediate?azure-portal=true), with separate entries for prompts and responses. If only the prompt or only the response matches a policy, an item is created on the **Pending** tab just for that policy match. You can remediate policy matches for Copilot in the same way that you remediate any other policy match.

For each item on the **Pending** tab for Copilot policy matches, you find:

- **Copilot icon**: This icon (![Copilot icon.](../media/microsoft-365-copilot.png)) identifies the policy match as a Copilot interaction.
- **Subject column**: The value in this column identifies the policy match as a Copilot interaction and lists the name of the app that was used. For example: _Copilot in Excel_.
- **Sender column**: Sender of the message. If the policy match is a response from Copilot, the value is _Copilot_.
- **Recipient column**: Recipients included in the message. If the policy match is a prompt to Copilot, the value is _Copilot_.
- **Message text**: The message text that the user entered (the text that caused the policy match) is shown on the right side of the screen in its entirety.

[Learn more about Microsoft Purview support for Microsoft 365 Copilot](/purview/ai-microsoft-purview?azure-portal=true#microsoft-purview-supports-compliance-management-for-copilot)

### Prerequisites for setting up communication compliance policies

Before creating communication compliance policies for Microsoft 365 Copilot, make sure your environment is ready with the required tools and permissions. Here are the prerequisites:

| **Step** | **Description** | **Learn more** |
|------|-------------|------------|
| Understand communication compliance policies | Understand how communication compliance policies help you detect, capture, and act on inappropriate messages that can lead to potential data security or compliance incidents within your organization. | [Learn about communication compliance](/purview/communication-compliance?azure-portal=true)|
| Check licensing requirements | Ensure you have the right Microsoft 365 E3/E5 licenses for Microsoft Purview Communication Compliance.  | [Microsoft Purview Communication Compliance service description](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance?azure-portal=true#microsoft-purview-communication-compliance) |
| Enable permissions | There are six role groups that define initial permissions for communication compliance features. To access and configure these features in the Microsoft Purview Portal, you must be assigned to one of these roles or role groups. | [Enable permissions for communication compliance](/purview/communication-compliance-configure?azure-portal=true#step-1-required-enable-permissions-for-communication-compliance) |
| Enable the audit log | Communication compliance requires audit logs to show alerts and track remediation actions taken by reviewers. | [Turn auditing on or off](/purview/audit-log-enable-disable?azure-portal=true) |

### Create a communication compliance policy with the Detect Microsoft 365 Copilot interactions template

To create a communication compliance policy with the **Detect Microsoft 365 Copilot interactions** template in Microsoft Purview:

1. Sign into the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true) using credentials for an admin account in your Microsoft 365 organization.
1. In the Microsoft Purview portal, select **Solutions** > **Communication compliance** > **Policies**.
1. Select **Create policy** then select the **Detect Microsoft 365 Copilot** template.
1. From the flyout page on the right, confirm or update the policy name. Policy names can't be changed once the policy is created.
1. Choose the users or groups to apply the policy to, including the users or groups you'd like to exclude.
1. Choose the reviewers for the policy. Reviewers are individual users, and all reviewers must have mailboxes hosted on Exchange Online. Reviewers added here are the reviewers that you can choose from when escalating an alert in the investigation and remediation workflow. When reviewers are added to a policy, they automatically receive an email message that notifies them of the assignment to the policy and provides links to information about the review process.
1. Choose a limited condition field, usually a sensitive info type or keyword dictionary to apply to the policy.

### Add AI signals to any communication compliance policy

When you create or edit a communication compliance policy, you can include Generative AI interactions as a location. This option is available whether you start from a template or create a custom policy.

In the **Choose locations to detect communications** step, you can select from the following AI-related options:

- **Microsoft Copilot experiences**: It covers built-in and custom Microsoft 365 Copilot interactions. These interactions include prompts and responses in apps like Word, Excel, PowerPoint, Loop, OneNote, and Microsoft 365 Chat in Teams and Bing.
- **Enterprise AI apps**: Covers non-Copilot AI apps that have been registered through Microsoft Entra ID or added using Microsoft data connectors. This option helps review activity in connected non-Microsoft or custom AI tools.
- **Other AI apps**: Covers AI tools accessed through the browser. These apps are automatically identified and categorized as Generative AI in Microsoft Defender for Cloud Apps.

:::image type="content" source="../media/communication-compliance-ai-signals.png" alt-text="Screenshot showing the AI signals in communication compliance." lightbox=" ../media/communication-compliance-ai-signals.png":::

You can combine these options with other locations, such as Exchange, Teams, and Viva Engage. Adding AI signals allows you to apply the same review and remediation workflows used for other communication types.

For more information, see [Detect channel signals with communication compliance](/purview/communication-compliance-channels?azure-portal=true).
