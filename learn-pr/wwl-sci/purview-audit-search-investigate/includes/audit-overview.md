Data security and compliance require clear visibility into user and admin activity. Microsoft Purview Audit records activities across Microsoft 365 services so you can analyze events, investigate issues, and meet regulatory requirements.

## Microsoft Purview auditing solutions

Audit (Standard) is on by default for most tenants and lets you search thousands of activities across Microsoft 365. Audit (Premium) builds on this with audit log retention policies, longer retention, intelligent insights, and higher bandwidth for the Office 365 Management Activity API.

## Key capabilities at a glance

| Capability | Audit (Standard) | Audit (Premium) |
|-----|-----|-----|
| Enabled by default | ✔ | ✔ |
| Search thousands of activities | ✔ | ✔ |
| Export search results to CSV | ✔ | ✔ |
| `Search-UnifiedAuditLog` PowerShell cmdlet | ✔ | ✔ |
| Office 365 Management Activity API access  | ✔ | ✔ |
| Higher API bandwidth allocation | | ✔ |
| Default retention up to 180 days | ✔ | ✔ |
| Default 1-year retention for Microsoft Entra ID, Exchange, SharePoint, OneDrive | | ✔ |
| Audit log retention policies (up to 10 years with add-on) | | ✔ |
| Intelligent insights (for high-value events such as mail access) | | ✔ |
| Audit Search Graph API | ✔ | ✔ |

## Audit (Standard) in Microsoft Purview

Audit (Standard) logs and makes searchable a wide range of activities performed by users and administrators across Microsoft 365 services. This supports forensic investigations, IT troubleshooting, and compliance reviews.

- **Enabled by default**: No manual setup is required for activity logging in organizations with eligible subscriptions. You only need to assign permissions for users to access the audit search tool in the Microsoft Purview portal.
- **Thousands of searchable audit events**: Includes events from multiple Microsoft 365 services, allowing a broad view of user and admin activity.
- **Searchability**: Audit logs are searchable in the Microsoft Purview portal by activity, user, or timeframe. You can also use the `Search-UnifiedAuditLog` cmdlet in Exchange Online PowerShell for advanced or automated searches.
- **Export to CSV**: Search results can be exported for deeper analysis in Excel or other tools.
- **API access**: The Office 365 Management Activity API allows integration with SIEM systems or long-term storage.
- **180-day retention**: By default, audit records are retained for 180 days.

## Audit (Premium) in Microsoft Purview

Audit (Premium) includes all capabilities from Audit (Standard) and adds advanced tools for managing audit data and performing detailed investigations.

- **Audit log retention policies**: Configure policies to retain records up to one year, or up to 10 years with the required add-on license.
- **Longer default retention**: Records from Microsoft Entra ID, Exchange, SharePoint, and OneDrive are retained for one year by default. Other workloads follow the standard 180-day retention unless covered by a custom policy.
- **Intelligent insights**: Includes high-value events that capture deeper context, such as when a labeled mail item is accessed or when a user performs searches in Exchange Online or SharePoint Online.
- **Higher API bandwidth**: Premium users get roughly twice the bandwidth allocation for the Office 365 Management Activity API compared to Standard.

### Long-term retention of audit logs

- **One-year default**: Applies automatically to Microsoft Entra ID, Exchange, SharePoint, and OneDrive audit records.
- **Up to 10-year option**: With the add-on license, you can retain specified audit records for up to 10 years. This setting applies from the time the policy is created and doesn't retroactively extend older data.

### Audit log retention policies

Retention policies can be scoped by service, activity type, or user. Policies have priorities to control which one applies when scopes overlap. Changing a policy only affects data going forward; previously logged data keeps its original expiration date.

### Audit (Premium) activities

Audit (Premium) can record more granular activities, such as:

- **Exchange Online**: Logs mail item access, including details for items with sensitivity labels.
- **Microsoft Teams**: Captures chat interactions, meeting participation details, and message modifications or deletions.

## Copilot and AI application auditing

Interactions with **Microsoft Copilot and supported AI apps** are logged in the unified audit log when auditing is enabled. You can search by friendly name or operation (for example, the **CopilotInteraction** event and related record types). Schema fields include context like thread IDs and accessed resources.

## Where you work

Use the **Microsoft Purview portal** to run targeted searches, save them, and export results. You can also use PowerShell for scripted queries and automation, and the Unified Audit Log Retention cmdlets to create and manage retention policies.

## Knowledge check

Choose the best response for this question.
