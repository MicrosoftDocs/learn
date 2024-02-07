
Microsoft Copilot for Security is accessible from within Microsoft Purview solutions, as part of the embedded experience. Data security and compliance admins can leverage Copilot powered summarization capabilities and natural language support, directly from Microsoft Purview solutions, and then seamlessly transition to the standalone experience. These capabilities help you accelerate time to action and enable analysts at all levels to conduct advanced investigations.

The scenarios supported as part of the embedded experience are:

- Gain comprehensive summary of Data Loss Prevention alerts.
- Gain comprehensive summary of Insider Risk Management alerts.
- Gain contextual summary of Communication Compliance policy matches.
- Gain contextual summary of evidence collected in eDiscovery review sets.
- Generate keyword query language from natural language prompt in eDiscovery.

For all use cases supported through the embedded experience, as is the case with the standalone experience, your organization must be licensed and onboarded to the applicable Microsoft Purview solutions and the Purview plugin must be enabled in Microsoft Copilot for Security.  Because Copilot assumes the permissions of the user when it tries to access the data to answer the queries, you also need to have the required permissions to access the data.

For any AI generated content, you can provide feedback and accuracy of the content. Select the feedback prompt on the bottom right of the content window and select from the available options. confirmed, it looks great, off target, inaccurate, or potentially harmful, inappropriate.

:::image type="content" source="../media/ai-accuracy-feedback-data-loss-prevention-summary.png" lightbox="../media/ai-accuracy-feedback-data-loss-prevention-summary.png" alt-text="Screen capture of the feedback options. The options are: confirmed, it looks great, off target, inaccurate, or potentially harmful, inappropriate.":::

### Gain comprehensive summary of alerts

Data security teams generally receive more data security alerts per day, than they can review leaving them exposed to risks. To help with this challenge, Microsoft Copilot in Microsoft Purview leverages the power of generative AI to provide a summary for the alert you want to review and help accelerate your investigation.  This capability is supported in Microsoft Purview Data Loss Prevention and Microsoft Purview Insider Risk Management.

#### Data Loss Prevention

To summarize Data Loss Prevention alerts using Copilot:

1. Sign in to the compliance portal and go to the Data Loss Prevention solution.
1. Navigate to the alerts queue and select the alert you want to review.
1. Select "Get a summary from Security Copilot."

    :::image type="content" source="../media/purview-data-loss-prevention-alert-summary.png" lightbox="../media/purview-data-loss-prevention-alert-summary.png" alt-text="Screen capture of the Microsoft Purview DLP alerts page showing the details for a specific alert and the option to get a summary from Security Copilot.":::

1. From the alert summary, you can use the ellipses on the top right of the alert summary to copy the response to
clipboard, regenerate, or open it in the standalone Security Copilot experience.

    :::image type="content" source="../media/purview-data-loss-prevention-alert-summary-ellipses-v4.png" lightbox="../media/purview-data-loss-prevention-alert-summary-ellipses-v4.png" alt-text="Screen capture of the Microsoft Purview DLP alert summary and the options available.  Options include copy to clipboard, regenerate, and open in Security Copilot.":::

#### Insider Risk Management

To summarize Insider Risk Management alerts using Copilot, you follow similar steps as described for DLP.  

You sign in to the compliance portal and go to the Insider Risk Management solution. Navigate to the alerts queue to select the alert you want to review. Information about the alert will be displayed and from there you can select Summarize to have Copilot generate the alert summary.

:::image type="content" source="../media/purview-insider-risk-management-alert-summary-v4.png" lightbox="../media/purview-insider-risk-management-alert-summary-v4.png" alt-text="Screen capture of an Insider Risk Management alert page that shows the Security Copilot summary for a specific alert.":::

From the alert summary, you can use the ellipses on the top right of the alert summary to copy the response to clipboard, regenerate, or open it in the standalone Copilot experience. Similarly, you can select the feedback icon on the bottom right of the summary window to provide feedback on the accuracy of the AI generated content.

The ability to summarize Insider Risk Management alerts, enables you to quickly gain the highlights of the potential incident by identifying critical user details like exfiltration activities, patterns, user roles and unusual activities that may lead to potential security incidents.

### Gain contextual summary of content in a Communication Compliance policy

Reviewing communications is an integral part of protecting your organization’s communication landscape, but it's also time-consuming to review content that is hundreds of words long or contain attachments. With Copilot, you can now:

- Get a contextual summary of a message and its attachments in the context of classifier conditions that flagged the message.
- Ask follow-up contextual questions about the message and its attachments.

Contextual Summarization currently supports trainable classifiers as context and contextual summaries are only eligible for messages and attachments with a combined length of 100 words or more.

Before you get started, ensure you have proper licensing to access Communication Compliance and the appropriate role permissions. To get contextual summaries in policies, you must have Communication Compliance or Communication Compliance Investigator Role and Security Reader role.

To get started:

1. Navigate to Communication Compliance in the compliance portal then navigate to the Policies tab in Communication Compliance.  

1. Navigate to a policy that uses trainable classifiers as part of the policy’s configurations and select a policy match to view message content.

1. A Copilot action button appears in the upper left command bar or a Summarize action button in the lower right command bar. Select either action to generate a contextual summary of the message and supported attachments.

1. To learn more about the message, explore additional default prompts or type your own question into the text prompt in the Security Copilot side panel.

:::image type="content" source="../media/purview-communication-compliance.png" lightbox="../media/purview-communication-compliance.png" alt-text="Screen capture of a Communication Compliance policy alert page and the Security Copilot summary for that policy alert.":::

***Limitations***

- Copilot interactions aren't protected under Communication Compliance
policies.

- Content summarization length is currently limited 20,000 tokens, which is approximately 15,000 words.

### Copilot with Microsoft Purview eDiscovery (Premium)

Copilot for Security embedded with Microsoft Purview eDiscovery (Premium) supports the following scenarios:

- Gain contextual summary of evidence collected in eDiscovery review sets.
- Generate keyword query language from natural language prompt in eDiscovery.

Each of these is described in the section that follows, but before you get started with either scenario, you must be licensed for eDiscovery (Premium) and have the appropriate role permissions.  In addition to the security reader role, as a minimum, for Security Copilot, you must have access to eDiscovery (Premium) cases. To obtain a contextual summary for an item in a review set, the Purview Review role is required.  To generate a search query, you must have the Purview Compliance Search role.

#### Gain contextual summary of evidence collected in eDiscovery review sets

eDiscovery admin or managers spend a significant amount of time reviewing evidence collected in review sets. Copilot embedded with Microsoft Purview eDiscovery (Premium) can help you optimize your time.  With Copilot, you can now:

- Get a contextual summary of a single item in a review set.
- Ask follow-up contextual questions about the summary.

To get started:

1. Navigate to the compliance portal, then navigate to an eDiscovery
(Premium) case.  eDiscovery (Standard) cases aren't supported for this scenario.

1. Navigate to and open a review set.

1. Select an item from the review set that you want Copilot to summarize, then select Summarize. Contextual summary of an item is supported only for files types with text extraction support. Copilot only supports single-item summary.

1. You can ask additional questions or select one of the default prompts to gain further insights into the generated summary.

:::image type="content" source="../media/purview-ediscovery-context.png" lightbox="../media/purview-ediscovery-context.png" alt-text="Screen capture of the context generated by Copilot for an item in a review set of Microsoft Purview eDiscovery (Premium).":::

#### Generate keyword query language from natural language prompt in eDiscovery

Search is one of the most used but highly time-intensive workflows in an investigation. An accurate search is crucial for the success of an investigation. Traditionally, in eDiscovery, a search happens through a condition builder or the input of a query in Keyword Query Language (KQL). While condition builder surfaces most used properties and operators, eDiscovery search is rich in functionality and supports many more properties and operators through KQL. However, there's a considerable learning curve involved in creating a KQL query, including learning all supported properties and operators as well the
proper format for construction.

With Copilot embedded in Purview eDiscovery (Premium), you can now:

- Provide a prompt in natural language and get a query generated in KQL that they can use as-is or build onto their existing query.
- Refine and enhance your natural language prompt for a more accurate KQL.

To get started:

1. Navigate to the compliance portal, then navigate to an eDiscovery
(Premium) case.  eDiscovery (Standard) cases aren't supported for this scenario.

1. Navigate to Searches and select the option to Create a Search.  Enter the search name, the description, then select Create.

    :::image type="content" source="../media/ediscovery-create-search.png" lightbox="../media/ediscovery-create-search.png" alt-text="Screen capture of the Microsoft Purview eDiscovery (Premium) page to create a search.":::

1. For the search you created, select Draft with Security Copilot.

    :::image type="content" source="../media/ediscovery-draft-with-copilot.png" lightbox="../media/ediscovery-draft-with-copilot.png" alt-text="Screen capture of the Microsoft Purview eDiscovery (Premium) search page, highlighting the option to draft a search with Copilot.":::

1. Provide your own natural language input or select one of the suggested prompts.

    :::image type="content" source="../media/ediscovery-kql-prompt-suggestions-v2.png" lightbox="../media/ediscovery-kql-prompt-suggestions-v2.png" alt-text="Screen capture of the page where you can enter a natural language prompt for your query or use a suggested prompted.":::

1. From the bottom of the natural language prompt box, you can select the option to refine your prompt.  Once you're satisfied with the prompt, select Generate KQL.  

1. Copilot generates the KQL query, which you can then copy to the KQL text box.  Once copied, you can run the query or save as draft.

    :::image type="content" source="../media/ediscovery-generated-kql-query-v3.png" lightbox="../media/ediscovery-generated-kql-query-v3.png" alt-text="Screen capture of the page showing the generated query.  The page also highlights where you can copy the KQL so it can be saved as a draft.":::

#### Limitations of Copilot for Purview eDiscovery

- The Copilot embedded experience with Purview eDiscovery is supported only with Microsoft Purview eDiscovery (Premium).

- Copilot activities aren't discoverable in Purview eDiscovery. You can’t search and preserve Copilot activities.

- No audit activities are available for Copilot activities.

- Content summarization length is currently limited 20,000 tokens, which is approximately 15,000 words.

- Copilot doesn't reference prior responses when responding to new
questions about this message.

- This experience is only available on the new Microsoft Purview compliance portal (preview).
