Microsoft Security Copilot is now accessible from within Microsoft Purview data security solutions, as part of the embedded experience. With Copilot in Microsoft Purview, data security and compliance admins can use the power of AI to assess risk exposure more quickly than is otherwise possible, directly from within Microsoft Purview solutions.

> [!NOTE]
>The list of Copilot capabilities embedded in Microsoft Purview is continually growing. This unit provides just a sampling of those capabilities. For more information, see documentation on Microsoft Purview.

Some of the scenarios supported as part of the embedded experience include:

- Gain comprehensive summary of Data Loss Prevention alerts.
- Gain comprehensive summary of Insider Risk Management alerts.
- Gain contextual summary of Communication Compliance policy matches.
- Gain contextual summary of evidence collected in eDiscovery review sets.

For all use cases supported through the embedded experience, as is the case with the standalone experience, your organization must be onboarded to Security Copilot, the Purview plugin must be enabled in Copilot, and your organization must be licensed and onboarded to the applicable Microsoft Purview solutions. To enable the Microsoft Purview plugin, the option to allow Security Copilot to access data from your Microsoft 365 services must be enabled, as part of the owner plugin settings.

:::image type="content" source="../media/purview-plugin-requirement-new.png" lightbox="../media/purview-plugin-requirement-new.png" alt-text="Screen capture of the setting to allow Security Copilot to access data from your Microsoft 365 services, which is required to enable the Microsoft Purview plugin.":::

Additionally, users must have the appropriate role permissions for both Copilot and the Purview solutions. For Copilot, users need, at a minimum, the Copilot workspace contributor role or the Microsoft Entra Security operator role. For Microsoft Purview, as is true for a Microsoft solution enabled via a plugin, Copilot assumes the permissions of the user when it tries to access the data to answer the queries, so you need to have the required permissions to access the data.

### Gain comprehensive summary of alerts

Data security teams generally receive more data security alerts per day than they can review, leaving them exposed to risks. To help with this challenge, Copilot in Microsoft Purview uses the power of generative AI to provide a summary for the alert you want to review and help accelerate your investigation. This capability is supported in Microsoft Purview Data Loss Prevention and Microsoft Purview Insider Risk Management.

#### Data Loss Prevention

To summarize Data Loss Prevention alerts using Copilot:

1. Sign in to the Microsoft Purview compliance portal or the new Microsoft Purview portal and select the Data Loss Prevention solution. 
1. Navigate to the alerts queue and select the alert you want to review.
1. Select "Get a summary from Security Copilot."

    :::image type="content" source="../media/purview-data-loss-prevention-alert-summary.png" lightbox="../media/purview-data-loss-prevention-alert-summary.png" alt-text="Screen capture of the Microsoft Purview DLP alerts page showing the details for a specific alert and the option to get a summary from Security Copilot.":::

1. From the alert summary, you can use the ellipses on the top right of the alert summary to copy the response to clipboard, regenerate, or transition to the standalone experience by selecting Open in Security Copilot.

    :::image type="content" source="../media/purview-data-loss-prevention-alert-summary-ellipses-v4.png" lightbox="../media/purview-data-loss-prevention-alert-summary-ellipses-v4.png" alt-text="Screen capture of the Microsoft Purview DLP alert summary and the options available. Options include copy to clipboard, regenerate, and open in Security Copilot.":::

#### Insider Risk Management

To summarize Insider Risk Management alerts using Copilot, you follow similar steps as described for DLP. 

You sign in to the Microsoft Purview compliance portal or the new Microsoft Purview portal and go to the Insider Risk Management solution. Navigate to the alerts queue to select the alert you want to review. Information about the alert and the option to summarize the alert are displayed.

:::image type="content" source="../media/copilot-insider-risk-management-v2.png" lightbox="../media/copilot-insider-risk-management-v2.png" alt-text="Screen capture of an Insider Risk Management alerts page that shows the option to summarize an alert.":::

You select Summarize to have Copilot generate the alert summary. From the alert summary, you can use the ellipses on the top right of the alert summary to copy the response to clipboard, regenerate, or open it in the standalone Copilot experience.

:::image type="content" source="../media/copilot-insider-risk-management-summary.png" lightbox="../media/copilot-insider-risk-management-summary.png" alt-text="Screen capture of an Insider Risk Management alert summary generated by Copilot.":::

The ability to summarize Insider Risk Management alerts, enables you to quickly gain the highlights of the potential incident by identifying critical user details like exfiltration activities, patterns, user roles, and unusual activities that may lead to potential security incidents.

### Gain contextual summary of content in a Communication Compliance policy

Reviewing communications is an integral part of protecting your organization’s communication landscape, but it's also time-consuming to review content that is hundreds of words long or contain attachments. With Copilot, you can now:

- Get a contextual summary of a message and its attachments in the context of classifier conditions that flagged the message.
- Ask follow-up contextual questions about the message and its attachments.

Contextual Summarization currently supports trainable classifiers as context and contextual summaries are only eligible for messages and attachments with a combined length of 100 words or more.

Before you get started, ensure you have proper licensing to access Communication Compliance and the appropriate role permissions for Copilot and Communication Compliance. To get contextual summaries in policies, you must have Communication Compliance or Communication Compliance Investigator Role. For Copilot, you need, as a minimum, the Entra Security operator or Copilot workspace contributor role.

To get started:

1. Navigate to the Communication Compliance solution from the Microsoft Purview compliance portal or the new Microsoft Purview portal, then navigate to the Policies tab in Communication Compliance.

1. Navigate to a policy that uses trainable classifiers as part of the policy’s configurations and select a policy match to view message content.

1. A Copilot action button appears in the upper left command bar or a Summarize action button in the lower right command bar. Select either action to generate a contextual summary of the message and supported attachments.

    :::image type="content" source="../media/copilot-communication-compliance-v2.png" lightbox="../media/copilot-communication-compliance-v2.png" alt-text="Screen capture of a Communication Compliance policy alerts page and the Copilot summary for that policy alert.":::

1. To learn more about the message, explore other default prompts or type your own question into the text prompt in the Copilot side panel.

    :::image type="content" source="../media/copilot-communication-compliance-follow-up.png" lightbox="../media/copilot-communication-compliance-follow-up.png" alt-text="Screen capture showing more default prompts and the prompt bar to enable the user to learn more about the message that triggered the policy.":::

### Gain contextual summary of evidence collected in eDiscovery review sets

eDiscovery admins or managers spend a significant amount of time reviewing evidence collected in review sets. Copilot embedded with Microsoft Purview eDiscovery (Premium) can help you optimize your time. With Copilot, you can now:

- Get a contextual summary of a single item in a review set.
- Ask follow-up contextual questions about the summary.

To use Copilot in Microsoft Purview with eDiscovery (Premium), you must be licensed for eDiscovery (Premium) and have the appropriate role permissions for Copilot and for eDiscovery. You must have access to eDiscovery (Premium) cases, and to obtain a contextual summary for an item in a review set, the Purview Review role is required. For Copilot, you need, as a minimum, the Entra Security operator or Copilot workspace contributor role.

To get started:

1. Navigate to the Microsoft Purview compliance portal (this use case isn't currently supported in the new Microsoft Purview portal), then navigate to an eDiscovery. (Premium) case.

1. Navigate to and open a review set.

1. Select an item from the review set that you want Copilot to summarize, then select Summarize. Contextual summary of an item is supported only for files types with text extraction support. Copilot only supports single-item summary.

1. You can ask more questions or select one of the default prompts to gain further insights into the generated summary.

:::image type="content" source="../media/purview-ediscovery-context-v2.png" lightbox="../media/purview-ediscovery-context-v2.png" alt-text="Screen capture of the context generated by Copilot for an item in a review set of Microsoft Purview eDiscovery (Premium).":::

### Feedback

For any AI generated content, you can provide feedback and accuracy of the content. Select the feedback prompt on the bottom right of the content window and select from the available options: confirmed, it looks great, off target, inaccurate, or potentially harmful, inappropriate.

:::image type="content" source="../media/ai-accuracy-feedback-data-loss-prevention-summary.png" lightbox="../media/ai-accuracy-feedback-data-loss-prevention-summary.png" alt-text="Screen capture of the feedback options. The options are: confirmed, it looks great, off target, inaccurate, or potentially harmful, inappropriate.":::

