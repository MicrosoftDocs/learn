You started this module with a healthcare compliance team facing an electronic health record (EHR) access pattern that needed answers. You now have the audit skills that team relied on: knowing what Microsoft Purview Audit records, how long it retains those records, and how to search them from the portal and PowerShell for regular activity, Copilot and AI app activity, and message-level access.

Here's what you covered:

- How Microsoft Purview Audit records, retains, and exposes activity across Microsoft 365, and where Audit (Standard) and Audit (Premium) differ.
- Configuring a tenant for audit, including per-user Advanced Auditing where Audit (Premium) is in use.
- Planning audit log retention to match compliance requirements.
- Running audit searches from the Microsoft Purview portal and with `Search-UnifiedAuditLog` to surface evidence of user and admin activity.
- Extending the same search to Copilot and AI app activity across first-party, connected, and non-Microsoft record types.
- Investigating message-level access with Audit (Premium) events like `MailItemsAccessed`.
- Analyzing and reporting on audit results by parsing exports and joining across record types.

## Where audit fits in your compliance stack

Audit is one tool in the Microsoft Purview investigation and compliance stack. It's built for searching records of past activity. It isn't the tool for real-time monitoring, alerting, applying holds, preventing actions, or scoring behavior. Those jobs belong to other tools you pair audit with:

- **eDiscovery** preserves content, applies legal holds, and lets you review the actual body of messages, files, or Copilot prompts. Audit only surfaces that an interaction happened.
- **Data Loss Prevention (DLP)** and the **Microsoft Purview Browser Extension** extend visibility into non-Microsoft AI apps and websites. The `AIAppInteraction` records that show up in audit search rely on that visibility being deployed first.
- **Data Security Posture Management (DSPM)** registers connected AI apps in your tenant. Without that registration, the `ConnectedAIAppInteraction` records you filter on in audit search stay sparse or empty.
- **Insider Risk Management (IRM)** turns behavioral signals into risk scores. Some signals come from the same events audit records, but audit doesn't do the scoring.
- **Microsoft Defender** and **Microsoft Sentinel** cover real-time detection, alerting, and response. Audit is where an investigator goes after an alert fires to reconstruct what happened.

## When you get back to your tenant

Use this quick reference to map common investigation questions to the audit filters that answer them:

| To investigate | Filter on |
| --- | --- |
| Who deleted specific email messages | Record type `ExchangeItem`, operations `HardDelete`, `SoftDelete`, `MoveToDeletedItems` |
| Which files a user shared externally | Record type `SharePointSharingOperation`, operations like `SharingSet`, `AnonymousLinkCreated` |
| Which files a user accessed or downloaded | Record type `SharePointFileOperation`, operations `FileAccessed`, `FileDownloaded` |
| Which specific messages a user opened, when your tenant has Audit (Premium) | Operation `MailItemsAccessed` scoped to the user's mailbox |
| Whether a user used first-party Copilot | Record type `CopilotInteraction` |
| Whether a user used a Copilot Studio agent or Entra-registered AI app | Record type `ConnectedAIAppInteraction`. Requires DSPM onboarding. |
| Whether a user used a non-Microsoft AI website | Record type `AIAppInteraction`. Requires Purview Browser Extension plus DLP. |
| Admin permission or configuration changes | Record type `AzureActiveDirectory` and service-specific admin record types |

Before your first real search, confirm three things:

1. Auditing is on for your tenant. Run `Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled` in Exchange Online PowerShell.
1. You have the **Audit Reader** or **Audit Manager** role in the Microsoft Purview portal.
1. For any Audit (Premium) event, **Microsoft 365 Advanced Auditing** is enabled on the user whose activity you're investigating, and was enabled during the time window you care about.

## Resources

- [Learn about auditing solutions in Microsoft Purview](/purview/audit-solutions-overview?azure-portal=true)
- [Get started with auditing solutions](/purview/audit-get-started?azure-portal=true)
- [Search the audit log](/purview/audit-search?azure-portal=true)
- [Manage audit log retention policies](/purview/audit-log-retention-policies?azure-portal=true)
- [Export, configure, and view audit log records](/purview/audit-log-export-records?azure-portal=true)
- [Turn auditing on or off](/purview/audit-log-enable-disable?azure-portal=true)

## Use cases and scenarios

Explore how Microsoft Purview Audit can help investigate specific scenarios:

- [Search the audit log to investigate common support issues](/purview/audit-troubleshooting-scenarios?azure-portal=true)
- [Search the audit log for events in Microsoft Teams](/purview/audit-teams-audit-log-events?azure-portal=true)
- [Use sharing auditing in the audit log](/purview/audit-log-sharing?azure-portal=true)
- [Use Microsoft Purview Audit (Premium) to investigate compromised accounts](/purview/audit-log-investigate-accounts?azure-portal=true)
- [Use a PowerShell script to search the audit log](/purview/audit-log-search-script?azure-portal=true)
