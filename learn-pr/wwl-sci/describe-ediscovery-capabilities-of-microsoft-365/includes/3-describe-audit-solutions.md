
Auditing solutions in Microsoft Purview help organizations effectively respond to security events, forensic investigations, internal investigations, and compliance obligations. Thousands of user and admin operations performed in dozens of Microsoft 365 services and solutions are captured, recorded, and retained in your organization's unified audit log. Audit records for these events are searchable by security ops, IT admins, insider risk teams, and compliance and legal investigators in your organization. This capability provides visibility into the activities performed across your Microsoft 365 organization.

Microsoft Purview provides two auditing solutions: Audit (Standard) and Audit (Premium).

:::image type="content" source="../media/purview-audit-inline.png" lightbox="../media/purview-audit-expanded.png" alt-text="A table that shows the two Microsoft Purview audit solutions: Audit (Standard) and Audit (Premium).":::

- **Audit (Standard)**. Audit (Standard) provides you with the ability to log and search for audited activities and power your forensic, IT, compliance, and legal investigations. Audit (Standard) is turned on by default for all organizations with the appropriate subscription. You can search for a wide-range of audited activities that occur in most of the Microsoft 365 services in your organization. Audit records can also be retrieved using the Office 365 Management Activity API. You can export the audit records returned by the search, to a CSV file, enabling further analysis using Microsoft Excel or Excel Power Query. In Audit (Standard), records are retained for 90 days. 

- **Audit (Premium)**. Audit (Premium) builds on the capabilities of Audit (Standard).  Audit (Premium) provides audit log retention policies and longer retention of audit records. It provides intelligent insights that can help you investigate possible breaches and determine the scope of compromise. Audit (Premium) also provides organizations with more bandwidth to access auditing logs through the Office 365 Management Activity API.

It can take anywhere from 30 minutes to 24 hours after an event occurs for the corresponding audit log record to be returned in the results of an audit log search.

Licensing for Audit (Standard) or Audit (Premium) requires the appropriate organization-level subscription and corresponding per-user licensing. For additional information on licensing requirements, visit the Learn more section in the Summary and resources  unit.

Admins and members of investigation teams must be assigned the View-Only Audit Logs or Audit Logs role in Exchange Online to search the audit log. By default, these roles are assigned to the Compliance Management and Organization Management role groups on the Permissions page in the Exchange admin center.
