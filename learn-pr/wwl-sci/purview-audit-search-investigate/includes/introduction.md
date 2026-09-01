Microsoft Purview Audit records what users and administrators do across Microsoft 365 so you can answer questions about access, deletions, admin changes, and AI app activity.

Consider a network of healthcare facilities that manages a large amount of sensitive patient data daily. After noticing unusual access patterns to their electronic health record (EHR), they need to confirm all access is authorized and aligns with health data protection regulations. The compliance team uses Microsoft Purview Audit to **trace who accessed which records**, then hands those findings to the analysts who compare them to approved access patterns.

## Learning objectives

In this module you learn to:

- Describe how Microsoft Purview Audit records, retains, and exposes activity across Microsoft 365.
- Configure Audit (Standard) or Audit (Premium) for the users, services, and retention windows your compliance requirements call for.
- Run audit searches from the Microsoft Purview portal and PowerShell to surface evidence of user and admin activity.
- Extend the same search to Copilot and AI app activity across first-party, connected, and non-Microsoft record types.
- Investigate message-level access with Audit (Premium) events like MailItemsAccessed.
- Analyze and report on audit results by parsing exports and joining across record types.

## Learning prerequisites

- Working knowledge of Microsoft 365 services such as Exchange, SharePoint, OneDrive, and Teams.
- Familiarity with data management and compliance concepts.
- Can navigate the Microsoft Purview portal.

## Technical prerequisites

Which parts of this module you can act on depends on what's licensed and enabled in your tenant:

| Capability | Which parts of this module apply |
| --- | --- |
| [Audit (Standard)](/purview/audit-solutions-overview?azure-portal=true), on by default for eligible Microsoft 365 and Office 365 subscriptions | All units |
| [Audit (Premium)](/purview/audit-solutions-overview?azure-portal=true) with the **Microsoft 365 Advanced Auditing** service plan enabled per user | Audit log retention policies, intelligent insights like `MailItemsAccessed`, higher API bandwidth |
| **10-Year Audit Log Retention** add-on license, assigned per user | Long-term retention beyond one year |
| [Microsoft Purview pay-as-you-go billing](/purview/purview-billing-models?azure-portal=true) enabled, with the tenant linked to an active Azure subscription | Audit records for user interactions with non-Microsoft AI apps, captured under the `AIAppInteraction` record type |
| **Audit Logs** or **View-Only Audit Logs** role, granted through the **Audit Manager** or **Audit Reader** role group in the Microsoft Purview portal | Running any search or export in the portal or with `Search-UnifiedAuditLog` |

For current licensing details, see [Microsoft Purview auditing solutions](/purview/audit-solutions-overview?azure-portal=true#licensing-requirements).
