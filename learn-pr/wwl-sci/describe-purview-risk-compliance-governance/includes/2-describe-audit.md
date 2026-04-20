
Auditing solutions in Microsoft Purview help organizations effectively respond to security events, forensic investigations, internal investigations, and compliance obligations. Thousands of user and admin operations performed in dozens of Microsoft 365 services and solutions—including Microsoft 365 Copilot and Microsoft Security Copilot—are captured, recorded, and retained in your organization's unified audit log. Security operations teams, IT admins, insider risk teams, and compliance and legal investigators can search audit records for these events. This visibility into activities performed across your Microsoft 365 organization supports compliance obligations, incident response, and organizational accountability.

## What the audit log captures

The unified audit log records user and administrator activities across a wide range of Microsoft 365 services. Here are some examples of what gets captured:

- **Exchange Online**: email message access, deletion, forwarding, and replies; mailbox permission changes; forwarding rules created by users
- **SharePoint Online and OneDrive**: file access, downloads, uploads, and sharing events; site permission changes; document and folder creation
- **Microsoft Teams**: messages created or deleted; meetings created or modified; channel and team changes
- **Microsoft Entra ID**: user sign-ins; password changes; role assignments; conditional access policy modifications
- **Microsoft 365 Copilot and Microsoft Security Copilot**: user prompts and AI responses. Microsoft 365 Copilot activities are captured automatically across apps such as Teams, Outlook, and Word. Microsoft Security Copilot requires a Copilot owner to opt in before Purview captures those interactions.
- **Other Microsoft 365 services**: configuration changes in the Microsoft 365 admin center, Power BI activity, and events from other integrated services

The breadth of captured events makes the audit log a critical resource for compliance and security investigations. For example, if a security incident is suspected, investigators can search the audit log to determine which files were accessed, by whom, and when. This information helps scope the impact of the incident and supports any required regulatory reporting or legal proceedings.

## Searching and accessing audit data

When an audited activity is performed, the system generates an audit record and stores it in the organization's unified audit log. Microsoft Purview provides several methods for searching and retrieving this data:

- **Audit log search tool in the Microsoft Purview portal.** Use the search tool to search for specific activities, for activities performed by specific users, and for activities that occurred within a date range. After searching, you can export the audit records to a CSV file for further analysis in Microsoft Excel or Excel Power Query.
- **Audit Search Graph API.** Microsoft Graph offers a unified API endpoint for accessing data from multiple Microsoft cloud services. The Audit Search Graph API allows programmatic access to the audit search experience through Microsoft Graph.
- **Search-UnifiedAuditLog cmdlet.** Use this Exchange Online PowerShell cmdlet to search for audit events or incorporate it into a script for automated reporting.
- **Office 365 Management Activity API.** This API provides programmatic access to audit records and lets organizations import auditing data into a security information and event management (SIEM) solution for broader threat detection and response workflows.

## Two auditing solutions: Standard and Premium

Microsoft Purview provides two auditing solutions:

- Audit (Standard)
- Audit (Premium)

### Audit (Standard)

Audit (Standard) is enabled by default for all organizations with the appropriate subscription and is available to users with the appropriate permissions. When an audited activity is performed, an audit record is generated and stored in the audit log for your organization.

Key capabilities of Audit (Standard) include:

- **Enabled by default.** Audit (Standard) is ready to use in most organizations without additional configuration.
- **Thousands of searchable audit events.** Searchable audited activities span most Microsoft 365 services.
- **Audit log search tool.** The built-in search tool in the Microsoft Purview portal lets you find specific activities, users, and date ranges.
- **180-day audit log retention.** Audit (Standard) retains records for 180 days—enough to search for activities within approximately the past six months.
- **Export to CSV.** After searching, you can export the results to a CSV file for further analysis.

### Audit (Premium)

Audit (Premium) builds on all the capabilities of Audit (Standard) and adds audit log retention policies, longer retention of audit records, high-value intelligent insights, and higher bandwidth access to the Office 365 Management Activity API.

- **Audit log retention policies.** Create customized audit log retention policies to retain audit records for up to one year, and up to 10 years for users with the required add-on license. Policies can target a specific service, specific audited activities, or specific users.
- **Longer retention of audit records.** Microsoft Entra ID, Exchange, OneDrive, and SharePoint audit records are retained for one year by default. Audit records for all other activities are retained for 180 days by default, or you can use audit log retention policies to configure longer retention periods.
- **Intelligent insights.** Audit records for intelligent insights provide visibility into events such as when mail items were accessed, replied to, or forwarded, and what a user searched for in Exchange Online and SharePoint Online. These insights help investigate possible security breaches and determine the scope of any incident.
- **Higher bandwidth to the Office 365 Management Activity API.** Audit (Premium) provides more bandwidth to access auditing logs, enabling organizations to pull audit data faster. This is especially valuable for large-scale investigations.

### Licensing

Licensing for Audit (Standard) or Audit (Premium) requires the appropriate organization-level subscription and corresponding per-user licensing. For additional information on licensing requirements, visit the Learn more section in the Summary unit.

## Copilot audit logging

Microsoft Purview captures audit events for both Microsoft 365 Copilot and Microsoft Security Copilot, but in slightly different ways.

### Microsoft 365 Copilot

When a user interacts with Microsoft 365 Copilot—entering a prompt or receiving an AI-generated response—the activity is automatically logged in the unified audit log as a `CopilotInteraction` event. This happens across Microsoft 365 apps such as Teams, Outlook, Word, Excel, and SharePoint, with no additional configuration required. Each audit record includes information about the Microsoft service where the interaction occurred and references to any files accessed during the interaction. This gives compliance and security teams visibility into how AI is being used across the organization.

### Microsoft Security Copilot

The audit logging feature in Microsoft Security Copilot uses Microsoft Purview to process and store admin actions, user actions, and Copilot responses. This includes data from any Microsoft and non-Microsoft integrations.

From the Microsoft Security Copilot portal—the standalone experience—Copilot owners can opt in to allow Microsoft Purview to access, process, copy, and store customer data from your Security Copilot services. Once this feature is enabled, and if your organization is already using Microsoft Purview, no further action is required. Audit logging is turned on by default for Microsoft 365 organizations. However, when setting up a new Microsoft 365 organization, you should verify the auditing status for your organization. Microsoft Purview stores your customer data in the region where your Microsoft 365 data is stored.
