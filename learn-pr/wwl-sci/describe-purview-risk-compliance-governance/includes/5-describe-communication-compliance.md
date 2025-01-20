
Microsoft Purview Communication Compliance is an insider risk solution that helps you detect, capture, and act on inappropriate messages that can lead to potential data security or compliance incidents within your organization. Communication compliance evaluates text and image-based messages in Microsoft and third-party apps (Teams, Viva Engage, Outlook, WhatsApp, etc.) for potential business policy violations. Including inappropriate sharing of sensitive information, threatening or harassing language and potential regulatory violations.

Communication Compliance has predefined and custom policies that allow you to check internal and external communications for policy matches so that designated reviewers can examine them. Reviewers can investigate email, Microsoft Teams, Microsoft Copilot for Microsoft 365, Viva Engage, or third-party communications in your organization and take appropriate actions to make sure they're compliant with your organization's message standards.

With role-based access controls, Communication compliance supports the separation of duties between your IT admins and your compliance management team. For example, the IT group for your organization might be responsible for setting up communication compliance role permissions, groups, and policies. While investigators and reviewers might be responsible for message triage, review, and mitigation actions.

Identifying and resolving compliance issues with communication compliance in Microsoft Purview uses the following workflow:

:::image type="content" source="../media/communication-compliance-workflow.png" lightbox="../media/communication-compliance-workflow.png" alt-text="Diagram showing the communication compliance workflow.":::

- **Configure** – in this step, admins identify compliance requirements and configure applicable communication compliance policies.
- **Investigate** – admins look deeper into the issues detected when matching your communication compliance policies. Tools and steps that help include alerts, issue management to help remediation, document reviews, reviewing user history, and filters.
- **Remediate** – remediate communications compliance issues. Options include: resolving an alert, tagging a message, notifying the user, escalating to another reviewer, marking an alert as a false positive, removing a message in Teams, and escalating for investigation.
- **Monitor** – Keeping track and managing compliance issues identified by communication compliance policies spans the entire workflow process. Communication compliance dashboard widgets, export logs, and events recorded in the unified audit logs can be used to continually evaluate and improve your compliance posture.

Some important compliance areas where communication compliance policies can assist with reviewing messages include:

- **Corporate policies** - Users have to follow corporate policies like usage and ethical standards in their day-to-day business communications. With communication compliance, admins can scan user communications across the organization for potential concerns of offensive language or harassment.
- **Risk management** - Communication compliance can help admins scan for unauthorized communication about projects that are considered to be confidential, such as acquisitions, earnings disclosures, and more.
- **Regulatory compliance** - Most organizations are expected to follow some regulatory compliance standards during their day-to-day operations. For example, a regulation might require organizations to review communications of its brokers to safeguard against potential insider trading, money laundering, or bribery. Communication compliance enables the organization to scan and report on these types of communications in a way that meets their requirements.

Communication compliance is a powerful tool that can help maintain and safeguard your staff your data and your organization.

### Integration with Microsoft Security Copilot

Microsoft Purview Communication Compliance supports integration with Microsoft Security Copilot, through the embedded experience. Users whose organization is onboarded to Copilot, enable Copilot to access data from Microsoft 365 services, and have the appropriate role permissions can experience Copilot integration through the following supported capabilities:

- Get a contextual summary of a message and its attachments in the context of classifier conditions that flagged the message.
- Ask follow-up contextual questions about the message and its attachments.

Contextual Summarization currently supports trainable classifiers as context and contextual summaries are only eligible for messages and attachments with a combined length of 100 words or more.

To access Copilot from within Microsoft Purview Communication Compliance:

1. Navigate to the Communication Compliance solution from the Microsoft Purview compliance portal, or the new Microsoft Purview portal currently in preview, then navigate to the Policies tab in Communication Compliance.
1. Navigate to a policy that uses trainable classifiers as part of the policy’s configurations and view message content by selecting a policy match.
1. A Copilot action button appears in the upper left command bar or a Summarize action button in the lower right command bar. Select either action to generate a contextual summary of the message and supported attachments.

    :::image type="content" source="../media/copilot-communication-compliance-v2.png" lightbox="../media/copilot-communication-compliance-v2.png" alt-text="Screen capture of a Communication Compliance policy alerts page and the Security Copilot summary for that policy alert.":::

1. To learn more about the message, explore other default prompts or type your own follow-up question into the text prompt in the Security Copilot side panel.

    :::image type="content" source="../media/copilot-communication-compliance-follow-up.png" lightbox="../media/copilot-communication-compliance-follow-up.png" alt-text="Screen capture showing more default prompts and the prompt bar to enable the user to learn more about the message that triggered the policy.":::
