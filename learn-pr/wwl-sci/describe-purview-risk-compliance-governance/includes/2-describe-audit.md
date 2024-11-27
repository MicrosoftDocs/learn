
Auditing solutions in Microsoft Purview help organizations effectively respond to security events, forensic investigations, internal investigations, and compliance obligations. Thousands of user and admin operations performed in dozens of Microsoft 365 services and solutions, and also Security Copilot (if enabled) are captured, recorded, and retained in your organization's unified audit log. Audit records for these events are searchable by security ops, IT admins, insider risk teams, and compliance and legal investigators in your organization. This capability provides visibility into the activities performed across your Microsoft 365 organization.

Microsoft Purview provides two auditing solutions:

- Audit (Standard)
- Audit (Premium)

#### Audit (Standard)
Audit (Standard) is turned on by default for all organizations with the appropriate subscription and available to users with the appropriate permissions. When an audited activity is performed by a user or admin, an audit record is generated and stored in the audit log for your organization. In Audit (Standard), records are retained for 180 days. You can retrieve audit logs that occur in most of the Microsoft 365 services in your organization by using the following methods:

- The audit log search tool in the Microsoft Purview portal.
- The Office 365 Management Activity API
- The Search-UnifiedAuditLog cmdlet in Exchange Online PowerShell

After you search the audit log, you can export the audit records returned by the search, to a CSV file, enabling further analysis using Microsoft Excel or Excel Power Query.

#### Audit (Premium)

Audit (Premium) builds on the capabilities of Audit (Standard) by providing audit log retention policies, longer retention of audit records, high-value intelligent insights, and higher bandwidth access to the Office 365 Management Activity API.

- Audit log retention policies. You can create customized audit log retention policies to retain audit records for longer periods of time up to one year (and up to 10 years for users with required add-on license).
- Longer retention of audit records. Microsoft Entra ID, Exchange, OneDrive, and SharePoint audit records are retained for one year by default. Audit records for all other activities are retained for 180 days by default, or you can use audit log retention policies to configure longer retention periods.
- Audit (Premium) intelligent insights. Audit records for intelligent insights can help your organization conduct forensic and compliance investigations by providing visibility to events such as when mail items were accessed, or when mail items were replied to and forwarded, or when and what a user searched for in Exchange Online and SharePoint Online. These intelligent insights can help you investigate possible breaches and determine the scope of compromise.
- Higher bandwidth to the Office 365 Management Activity API. Audit (Premium) provides organizations with more bandwidth to access auditing logs through the Office 365 Management Activity API.

#### Licensing

Licensing for Audit (Standard) or Audit (Premium) requires the appropriate organization-level subscription and corresponding per-user licensing. For additional information on licensing requirements, visit the Learn more section in the Summary and resources unit.

#### Audit log in Microsoft Purview for Security Copilot

The audit logging feature in Security Copilot uses Microsoft Purview to process and store admin actions, user actions, and Copilot responses. This includes data from any Microsoft and non-Microsoft integrations.

From the Microsoft Security Copilot portal (the standalone experience), Copilot owners can opt in to allow Microsoft Purview to access, process, copy, and store customer data from your Security Copilot services. Once this feature is enabled in Copilot, if your organization is already using Microsoft Purview, no further actions is required. Audit logging is turned on by default for Microsoft 365 organizations. However, when setting up a new Microsoft 365 organization, you should verify the auditing status for your organization. If your organization isn't already using Microsoft Purview, then Audit logging needs to be provisioned. See [Turn auditing on or off](/purview/audit-log-enable-disable) to learn more.

Microsoft Purview stores your customer data in the region where your Microsoft 365 data is stored. See [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security) to learn more.
