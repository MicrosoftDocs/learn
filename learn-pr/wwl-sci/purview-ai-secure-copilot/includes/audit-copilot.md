Audit logs help your organization track how Microsoft 365 Copilot is used. These logs include user interactions, such as prompts submitted to Copilot and the resources Copilot accessed to generate responses. They also include admin activity, such as changes to plugin settings, promptbooks, and AI configurations.

Audit logs for Microsoft 365 Copilot are included in **Audit (Standard)**. If auditing is enabled in your organization, no additional configuration is required. Audit logs are retained for 180 days by default, based on your organization's license and audit configuration.

This gives your organization visibility into Copilot activity without requiring additional setup.

## What Copilot audit logs include

When a user interacts with Microsoft 365 Copilot, Microsoft Purview generates audit logs that include:

- Which user initiated the interaction
- When and where the interaction occurred
- Files, emails, or other content Copilot accessed
- Details about the AI system, such as plugin IDs and agents involved

Each interaction is logged as a discrete entry with detailed metadata.

### Common record types

Copilot audit entries might use any of these record types:

- **CopilotInteraction**: Interactions with Microsoft-developed Copilot apps like Word, Excel, Teams, or Outlook
- **TeamCopilotInteraction**: Interactions with Microsoft Facilitator features such as AI Notes or Meeting Moderation in Teams
- **ConnectedAIAppInteraction**: Interactions with third-party or custom-built Copilot apps deployed in your organization
- **AIAppInteraction**: Interactions with browser-based or external AI tools not deployed within your environment
- **CopilotResponseExported**: When users export or copy Copilot-generated content from the app

### Other useful fields

Audit records for Copilot include additional properties that help identify the context of each interaction:

- **AppIdentity**: Identifies the specific Copilot or AI app involved in the interaction (such as `Copilot.MicrosoftCopilot.Microsoft365Copilot`)
- **AppHost**: Indicates where the interaction occurred (such as `Word`, `Teams`, or `microsoft365.com/chat`)
- **AccessedResources**: Lists the files, messages, or sites Copilot referenced, including details like file name, sensitivity label ID, and access status
- **Messages**: Shows prompts and responses, including a flag for whether the entry is a user prompt or AI response
- **AISystemPlugin**: Identifies any plugins used by Copilot during the interaction
- **ModelTransparencyDetails**: Includes the name, version, and provider of the model used

These fields can help confirm whether sensitive information was involved or whether any unusual behavior occurred.

## Search for Copilot interactions in the audit log

To view Copilot interactions in Microsoft Purview Audit:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).
1. Select **Solutions** > **Audit**.
1. On the **Search** page, set a **Start date** and **End date**.
1. Under **Activities - friendly names**, enter a keyword like _Copilot_ or _AI_ to view related user and admin activities. Select the activities relevant to your investigation or review. These might include interactions with Copilot, updates to plugins or promptbooks, or actions related to AI-powered meeting notes.
   :::image type="content" source="../media/audit-copilot-search-activities.png" alt-text="Screenshot showing Interacted with Copilot selected under Activities - friendly names." lightbox="../media/audit-copilot-search-activities.png":::
1. For more targeted searches, use **Activities - operation names** and enter operation values such as `CopilotInteraction`, `AINotesUpdate`, or other known operation names.
1. In the **Record types** dropdown, select types such as `CopilotInteraction`, `ConnectedAIAppInteraction`, or `AIAppInteraction` to scope the results to AI activity.
1. (Optional) Use fields like **Users**, **AppIdentity**, or **File, folder, or site** to narrow your results based on specific criteria.
1. Enter a name for your search and select **Search** to run it.

To filter by additional attributes such as `AppIdentity` or `AccessedResources`, export the results to a CSV file and filter offline.

> [!NOTE]
> Audit logs for Microsoft Copilot are included with your Microsoft 365 subscription. Logs for non-Microsoft AI apps (such as third-party browser-based tools) are available only if you enable pay-as-you-go billing.

## Examples of Copilot audit records

| Scenario | RecordType| AppIdentity | AppHost |
|-----|-----|-----|-----|
| Copilot used in Word | CopilotInteraction | `Copilot.MicrosoftCopilot.Microsoft365Copilot` | `Word` |
| Prompt submitted through BizChat | CopilotInteraction | `Copilot.MicrosoftCopilot.BizChat` | `BizChat` |
| AI Notes used in Teams | TeamCopilotInteraction | `Copilot.TeamCopilot.AINotes`| `Teams` |
| Custom Copilot built in Copilot Studio | CopilotInteraction     | `Copilot.Studio.<AppId>` | `Teams` |

By auditing Copilot interactions, your organization can track how Copilot is used, investigate potential issues, and confirm whether sensitive data was accessed. This helps you maintain oversight and support responsible use of AI features in Microsoft 365.
