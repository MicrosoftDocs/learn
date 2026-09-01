Microsoft Purview Audit records much of what users and administrators do in Microsoft 365. That includes sending mail, sharing a file, changing a setting, and prompting Copilot. You investigate incidents and answer compliance questions by searching those records. Coverage isn't uniform across every service, and some workloads log less than others, so an empty result doesn't always mean the activity didn't happen.

To run useful searches, you first need a working model of how audit records are created, stored, and retrieved.

## Vocabulary that carries through every search

Two terms show up in every audit search you'll run. _Record type_ is the category the activity belongs to, like `SharePointFileOperation` or `Copilot`. _Operation_ is the specific action, like `FileAccessed` or `CopilotInteraction`. Those are the filter values you'll reach for again and again.

## One log, many services

All Microsoft 365 workloads write to the same unified audit log. Exchange, SharePoint, OneDrive, Teams, Microsoft Entra ID, and Microsoft Copilot all go to the same place. One search interface answers questions that span mail, files, admin changes, and AI app activity at the same time.

## Two things that shape what your searches can find

- **Enablement timing**. Records exist only from the moment auditing was turned on. That applies at both the tenant level and, for Audit (Premium) events like `MailItemsAccessed`, at the per-user level. Turning auditing on today doesn't backfill yesterday.
- **Retention**. Records age out on a schedule that depends on your tier and any retention policies you create. The default is 180 days for most activity.

## Where you work

The same audit log is exposed through the Microsoft Purview portal, the `Search-UnifiedAuditLog` cmdlet in Exchange Online PowerShell, and the Office 365 Management Activity and Audit Search Graph APIs.

## What the tiers change

Audit (Standard) covers thousands of activities across Microsoft 365 with 180-day default retention. Audit (Premium) adds the capabilities most investigations lean on: retention policies, longer default retention for key workloads, high-value events like `MailItemsAccessed` that show which specific messages a user opened, and higher bandwidth for the Management Activity API.

| Capability | Audit (Standard) | Audit (Premium) |
| --- | --- | --- |
| Search user and admin activity across Microsoft 365 | ✔ | ✔ |
| Default retention | 180 days | 180 days, or 1 year for Microsoft Entra ID, Exchange, SharePoint, and OneDrive |
| Audit log retention policies up to 10 years | | ✔ |
| High-value events, such as `MailItemsAccessed` | | ✔ |
| Higher Management Activity API bandwidth | | ✔ |

The tier your organization has decides which questions the audit log can answer. The interface you use to ask questions stays the same across both tiers.

For current licensing details, see [Microsoft Purview auditing solutions](/purview/audit-solutions-overview?azure-portal=true#licensing-requirements).

## What audit isn't

Audit is built for searching records of past activity. It isn't the tool for real-time monitoring, alerting, applying holds, preventing actions, or scoring behavior. Those jobs belong to other Microsoft Purview and Microsoft security tools that pair with audit in real investigations.
