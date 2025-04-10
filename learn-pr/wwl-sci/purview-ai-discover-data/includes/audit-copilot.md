Microsoft 365 Copilot integrates with apps like Word, Excel, Outlook, and Teams to help users generate content, summarize information, and automate everyday tasks. These capabilities rely on large language models, including GPT-4, and use data from emails, chats, documents, and calendars to provide context-based assistance.

Because of how Copilot works, with access to sensitive content across Microsoft 365, it's important to have visibility into how it's being used. Microsoft Purview Audit helps organizations track Copilot usage to support security, compliance, and organizational policy enforcement.

## How Microsoft Purview Audit helps review Copilot usage

As users interact with Microsoft 365 Copilot across apps like Word, Excel, and Teams, it's important to verify that those interactions meet organizational and regulatory expectations. Microsoft Purview Audit supports this by recording user and admin activity across Microsoft 365, including Copilot usage.

These actions are stored in a unified audit log, which you can search in the Microsoft Purview portal or by using PowerShell. Audit logs help answer key questions such as:

- Who used Copilot and when?
- In which application was it used?
- Did the interaction involve labeled or sensitive content?

These insights give security and compliance teams the visibility they need to ensure Copilot usage aligns with policy.

## Search the audit log for Copilot interactions

Microsoft Purview Audit supports compliance management by capturing Copilot interactions across applications like Word, Excel, PowerPoint, Teams, Loop, Whiteboard, OneNote, and Microsoft 365 Chat. The audit records identify Copilot interactions by the app in which they occur, providing detailed insights into Copilot usage across different contexts.

### Prerequisites for using Microsoft Purview Audit to search Microsoft 365 Copilot interactions

Before you search and analyze Copilot interactions using Microsoft Purview Audit, there are a few steps to ensure your environment is ready. Follow these prerequisites to set up your Microsoft 365 and Purview Audit configurations:

| **Step** | **Description** | **Learn more** |
|------|-------------|------------|
| Verify prerequisites for Copilot | Ensure your IT infrastructure is ready for Copilot and Audit, including necessary network configurations and software updates. | - [Microsoft 365 Copilot requirements](/microsoft-365-copilot/microsoft-365-copilot-requirements?azure-portal=true) |
| Understand searching with Audit | Understand the search functionalities in Microsoft Purview Audit to effectively analyze activities within Microsoft 365. | - [Audit New Search](/purview/audit-new-search?azure-portal=true) |
| Check licensing requirements | Confirm that you have the appropriate Microsoft 365 E3/E5 licenses for Copilot and Microsoft Purview Audit. | - [Microsoft 365 Copilot service description](/office365/servicedescriptions/office-365-platform-service-description/microsoft-365-copilot?azure-portal=true#available-plan) <br> - [Microsoft Purview Audit service description](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-purview-audit?azure-portal=true) |

Note: Microsoft Purview Audit logging is turned on by default, but when setting up a new Microsoft 365 organization, you should verify the auditing status for your organization. If auditing isn't turned on for your organization, you can turn it on in the Microsoft Purview portal or by using Exchange Online PowerShell. For more information on verifying that auditing is enabled and enabling the audit sign in Microsoft Purview, see [Turn auditing on or off](/purview/audit-log-enable-disable?azure-portal=true).

### Search the audit log for Copilot interactions in Microsoft Purview

Microsoft Purview Audit captures user activity across Microsoft 365, including when users interact with Microsoft 365 Copilot. These interactions are recorded based on the application where they occurred, such as Word, Excel, or Teams, and can include details about referenced files, including whether sensitivity labels were applied.

You can search for these events in the Microsoft Purview portal using filters that help narrow your results to Copilot-specific activity.

1. Sign into the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true).
1. In the left navigation pane, select **Solutions** > **Audit**.
1. Select **New Search** tab at the top of the **Audit** page.
1. Configure your search on the **New Search** tab:
   1. Set the **Start date** and **End date** for your search, with the last seven days selected by default.
   1. Enter relevant keywords or phrases in the **Keyword Search**, using asterisks (*) to replace special characters.
   1. Select administrative units from the **Admin Units** dropdown if needed.
   1. Under **Activities - friendly names** select specific activities relevant to Copilot by navigating to **Copilot activities** and selecting **Interacted with Copilot**. You can also use the search bar to find activities related to Copilot by entering _Copilot_.
   :::image type="content" source="../media/audit-copilot-new-search-activities.png" alt-text="Screenshot showing Interacted with Copilot selected under Activities - friendly names." lightbox="../media/audit-copilot-new-search-activities.png":::
   1. For precise searches, use **Activities - operations names** and enter _CopilotInteraction_ as the operation name for Copilot activities.
   1. In the **Record types** dropdown, select record types linked to Copilot activities. Enter _Copilot_ in the search box above the list for easier selection.
   :::image type="content" source="../media/audit-copilot-new-search-record-type.png" alt-text="Screenshot showing CopilotInteraction selected under Record types." lightbox="../media/audit-copilot-new-search-record-type.png":::
   1. Name your search in the **Search name** field for easy identification.
   1. Enter specific users in the **Users** field or leave it blank to return entries for all users (and service accounts) in your organization.
   1. Enter **File, folder, or site** names for targeted searches, or leave this box blank to return entries for all files and folders in your organization.
1. Select **Search** to start your search job. A maximum of 10 search jobs can be run in parallel for one user account. If a user requires more than 10 search jobs, they must wait for an _In progress_ job to finish or delete a search job.

## Limitations and considerations for auditing Copilot interactions

Microsoft Purview Audit provides useful insight into how users interact with Microsoft 365 Copilot, but there are a few limitations to be aware of. Understanding these limitations helps set accurate expectations for what can and can't be captured in the audit logs.

### What's captured in the audit log

- Copilot activity is recorded based on the app in which it occurred (such as Word, Teams, or Excel).
- Events typically include user IDs, time stamps, and references to accessed files.
- If a referenced file has a sensitivity label, that label is included in the log entry.

### What's not captured in audit logs

- **Prompts and responses**: Audit logs record that Copilot was used, but not the actual content of the prompt or the AI-generated response. For more detailed content-level review, use Microsoft Purview eDiscovery.
- **Copilot configuration changes**: Administrative updates to Copilot settings (such as enabling or disabling features) aren't currently logged in Audit.
- **Device details**: Device identifiers aren't included in Copilot-related audit entries.

### Application-specific considerations

- **Copilot in Teams**: If meeting transcripts are turned off, Copilot activities in Teams aren't captured in the audit log.
- **App identifiers**: The source app for each interaction is listed in the log, such as Copilot in Word or Copilot in Teams.

Knowing these limitations can help you plan which tools to use for broader investigations or compliance reviews. Audit is a useful first step for visibility into Copilot activity, but might need to be paired with other solutions for full context.
