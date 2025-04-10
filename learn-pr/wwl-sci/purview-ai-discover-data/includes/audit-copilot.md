Microsoft 365 Copilot integrates with apps like Word, Excel, Outlook, and Teams to help users generate content, summarize information, and automate tasks. These tools use large language models, including GPT-4, and access data from emails, chats, documents, and calendars to generate helpful, context-aware responses.

Because Copilot can access sensitive data, organizations need a way to understand how it's used. Microsoft Purview Audit supports this by capturing logs of user interactions and administrator activity related to Copilot and AI applications. These audit logs help support internal policies, security controls, and compliance requirements.

## How Microsoft Purview Audit captures Copilot and AI activity

Audit logging for Copilot and AI applications is included with Microsoft Purview Audit (Standard). If auditing is enabled in your Microsoft 365 tenant, no extra configuration is required to begin capturing these activities.

Audit logs include both user interactions with Copilot and administrator actions that affect how Copilot is deployed or configured. These logs are available through the Microsoft Purview portal or PowerShell and can be searched using filters based on activity type, app, or user.

Examples of the types of questions audit logs can help answer:

- Which users interacted with Copilot?
- When and where did these interactions occur?
- Which apps or services were involved?
- Was labeled or sensitive content referenced?
- Did Copilot use external sources like the public web

## Key fields in Copilot and AI audit records

Audit records contain structured fields to help you interpret each interaction or activity. Some of the most important fields include:

- **Operation**: Describes the type of action, such as CopilotInteraction or AINotesUpdate.
- **RecordType**: Identifies the category of application:
  - `CopilotInteraction`: User interacted with a Microsoft Copilot app
  - `ConnectedAIAppInteraction`: User interacted with a deployed non-Microsoft or custom Copilot app
  - `AIAppInteraction`: User interacted with a non-Microsoft AI app not deployed in the tenant
- **Workload**: Describes the app category (such as `Copilot`, `ConnectedAIApp`, or `AIApp`)
- **AppIdentity**: Identifies the specific app in the format `workloadName.appGroup.appName`
- **AppHost**: Indicates which host application was used during the interaction, such as:
  - `Word`, `Excel`, `PowerPoint`, `Outlook`
  - `BizChat` (for Microsoft 365 Chat)
  - `Teams`, `Loop`, `Whiteboard`, `OneNote`
  - `Defender` (for Security Copilot)

To determine if the public web was used in a Copilot interaction, check if `AISystemPlugin.Id` equals `BingWebSearch`.

> [!NOTE]
> `AppIdentity` and `AppHost` aren't shown in the Microsoft Purview portal interface. To view these fields, export the audit logs or use **PowerShell** or the **Office 365 Management Activity API**.

## Administrator activity logging

Microsoft Purview Audit also captures administrator actions related to Copilot settings, plugins, promptbooks, and workspaces. These logs provide a record of configuration changes and help trace how Copilot capabilities are managed within the organization.

You can search for these actions in the audit log using operation names listed in the [Copilot activities reference](/purview/audit-log-activities#copilot-activities?azure-portal=true).

## Search the audit log for Copilot activity

The Microsoft Purview portal allows you to search audit logs by activity type, app, user, and other filters. These searches help identify when and how Copilot and AI apps were used.

To search for Copilot-related activity:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).
1. Select **Solutions** > **Audit**.
1. On the **Search** page, set a **Start date** and **End date**.
1. Under **Activities - friendly names**, enter a keyword like _Copilot_ or _AI_ to view related user and admin activities. Select the activities relevant to your investigation or review. These might include interactions with Copilot, updates to plugins or promptbooks, or actions related to AI-powered meeting notes.
   :::image type="content" source="../media/audit-copilot-search-activities.png" alt-text="Screenshot showing Interacted with Copilot selected under Activities - friendly names." lightbox="../media/audit-copilot-search-activities.png":::
1. For more targeted searches, use **Activities - operation names** and enter operation values such as `CopilotInteraction`, `AINotesUpdate`, or other known operation names.
1. In the **Record types** dropdown, select types such as `CopilotInteraction`, `ConnectedAIAppInteraction`, or `AIAppInteraction` to scope the results to AI activity.
1. (Optional) Use fields like **Users**, **AppIdentity**, or **File, folder, or site** to narrow your results based on specific criteria.
1. Enter a name for your search and select **Search** to run it.

> [!TIP]
> You can run up to 10 searches in progress at one time. If all slots are used, wait for one to complete or remove an existing search.

### Example scenarios and audit entries

The following examples show how different types of Copilot interactions appear in audit records:

| Scenario | Operation | RecordType | AppIdentity | AppHost |
|-----|-----|-----|-----|-----|
| Microsoft 365 Copilot in Chat | CopilotInteraction | CopilotInteraction | Copilot.MicrosoftCopilot.BizChat | BizChat |
| Security Copilot in Microsoft Defender | CopilotInteraction | CopilotInteraction | Copilot.Security.SecurityCopilot | Defender |
| Custom Copilot Studio app in Teams | CopilotInteraction | CopilotInteraction | Copilot.Studio.<GUID> | Teams |
| AI Notes or Live Notes updated in Teams | AINotesUpdate / LiveNotesUpdate | TeamCopilotInteraction | Copilot.TeamCopilot.* | Teams |

## Scope and limitations

### Included in audit logs

- Interactions across Microsoft 365 apps such as Word, Excel, PowerPoint, Outlook, Teams, and more
- Application and user context for each interaction
- References to sensitivity labels when protected content is involved
- Indications when public web data was accessed (via AISystemPlugin.Id)

### Not included in audit logs

- Prompt text submitted by the user
- AI-generated responses from Copilot
- Device-specific details
- Some admin configuration changes (not all are logged)

### App-specific considerations

- Copilot in Teams: If transcription is disabled, interactions in meetings might not be recorded
- Logs include the host app name to clarify where the interaction occurred

Microsoft Purview Audit captures and stores detailed records of activity related to Microsoft 365 Copilot and other AI applications. This logging supports your ability to search for and review how these tools are used across Microsoft 365 apps and services. While the audit log provides useful insights into app usage and file access, it doesn't include prompt or response content. For deeper investigations, use audit logs alongside other tools such as eDiscovery.
