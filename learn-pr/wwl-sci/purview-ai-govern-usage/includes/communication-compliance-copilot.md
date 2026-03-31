Microsoft Purview Communication Compliance is a tool within Microsoft Purview designed to help organizations review and manage various communication channels, including Microsoft Copilot. This solution helps identify and address potential issues in messages to ensure they meet organizational standards.

It helps address the challenges of modern communication. These challenges include the high volume of message data and the variety of channels such as email, Microsoft Teams, and Microsoft 365 Copilot. With preset and custom policies, Communication Compliance supports regulatory compliance and helps protect your communication environment.

## Use Communication Compliance to manage AI-generated content

Communication Compliance supports policies that evaluate user prompts and AI-generated responses in Microsoft Copilot and other AI tools. In the Microsoft Purview portal, users with the _Communication Compliance Admins_ role can create and manage these policies by defining:

- The scope of communications and users under review.
- Custom conditions that the communications must meet.
- The individuals responsible for conducting the reviews.

You can use the **Detect Microsoft 365 Copilot interactions** template to quickly create a policy that reviews Copilot prompts and responses. The template covers common configuration options and helps you get started faster. Default configuration options for this template include:

- **Location**: Microsoft 365 Copilot
- **Direction**: Inbound, Outbound, Internal
- **Review Percentage**: 100%
- **Conditions**: No conditions are selected by default, but you must select at least one condition.

Communication compliance policies can be adjusted as needed but can't be renamed. Once policies are no longer needed, they should be deleted. Modifications to policies, including alert status and resolved items, can be exported to a CSV file for record-keeping.

Policies scan communications every 24 hours based on their creation time. For example, if a policy is created at 11:00 AM, it runs daily at that time. The **Last policy scan** column on the **Policy** page provides information about the last scan date and time. It might take up to 24 hours after creating a new policy to see the first policy scan data.

### Review AI interactions with Communication Compliance

Communication Compliance helps your organization assess messages generated or influenced by AI. This includes interactions in Microsoft Copilot experiences, non-Microsoft enterprise AI tools, and browser-based AI apps.

You can define policies that review user prompts and AI-generated responses. When a policy match occurs, an entry appears on the **Pending** tab of the **Policies** page in Microsoft Purview. Separate entries are created for the prompt and the response if only one meets the policy conditions.

Supported categories of AI apps include:

- **Microsoft Copilot experiences**: Built-in and custom interactions in apps like Word, Excel, Teams, and Microsoft 365 Chat
- **Enterprise AI apps**: Non-Copilot tools connected to your tenant through Microsoft Entra ID or data connectors
- **Other AI apps**: Browser-based tools detected and categorized as Generative AI by Microsoft Defender for Cloud Apps

Each policy match includes the app name, sender and recipient details, and the full message content that triggered the alert. Items involving Copilot are identified with a Copilot icon and labeled by the app used, such as Copilot in Word.

### Prerequisites for setting up communication compliance policies

Before creating communication compliance policies for Microsoft 365 Copilot, make sure your environment is ready with the required tools and permissions. Here are the prerequisites:

| **Step** | **Description** | **Learn more** |
|----------|-----------------|----------------|
| Understand communication compliance policies | Learn what communication compliance policies do and how they work. | [Learn about communication compliance](/purview/communication-compliance?azure-portal=true) |
| Check licensing requirements | Make sure you have the right Microsoft 365 licenses. | [Microsoft Purview Communication Compliance service description](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance?azure-portal=true#microsoft-purview-communication-compliance) |
| Enable permissions | Assign the correct roles to access and manage policies. | [Enable permissions for communication compliance](/purview/communication-compliance-configure?azure-portal=true#step-1-required-enable-permissions-for-communication-compliance) |
| Enable the audit log | Turn on auditing to track alerts and actions. | [Turn auditing on or off](/purview/audit-log-enable-disable?azure-portal=true) |

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

When configuring a communication compliance policy, you can include Generative AI as a location. This applies whether you're starting from a template or creating a custom policy.

In the **Choose locations to detect communications** step, you can select from:

- Microsoft Copilot experiences
- Enterprise AI apps
- Other AI apps

These options let you apply your policy to prompts and responses across a broad range of Copilot and non-Copilot tools. You can also combine AI-related locations with others like Exchange, Teams, and Viva Engage.

:::image type="content" source="../media/communication-compliance-ai-signals.png" alt-text="Screenshot showing the AI signals in communication compliance." lightbox=" ../media/communication-compliance-ai-signals.png":::

### Use DSPM for AI to create policies that surface in Communication Compliance

Microsoft Purview Data Security Posture Management (DSPM) for AI includes a built-in policy option to detect sensitive information. It also helps identify potentially unethical behavior in AI apps, such as Microsoft Copilot experiences and ChatGPT for Enterprise. This policy is configured in DSPM for AI but routes alerts to Communication Compliance for review.

When you set up the **Detect unethical behavior in AI apps** policy in DSPM for AI:

- The policy scans prompts and responses in supported AI apps.
- Alerts are generated when sensitive or potentially inappropriate content is detected.
- These alerts appear in Communication Compliance under Pending items for review and remediation.

This integration supports a layered approach to managing AI use. DSPM identifies risky interactions, while Communication Compliance offers a structured review and remediation workflow.

To create this one-click policy in DSPM for AI:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).
1. Select **Solutions** > **DSMP for AI** > **Recommendations**
1. Select the **Detect unethical behavior in AI apps** recommendation, then select **Create policies**.

   :::image type="content" source="../media/dspm-ai-communication-compliance.png" alt-text="Screenshot showing locations to detect communications in communication compliance." lightbox=" ../media/dspm-ai-communication-compliance.png":::
