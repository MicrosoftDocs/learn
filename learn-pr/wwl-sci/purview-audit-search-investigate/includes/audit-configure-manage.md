Before anyone runs an audit search, the tenant has to be set up. Setup means confirming auditing is on and assigning the roles that let people search the log. For Audit (Premium) tenants, setup also includes enabling Advanced Auditing per user. In large or delegated-admin environments, someone also scopes which users each searcher can see.

Even if you don't run setup yourself, know what setup shapes. Per-user Advanced Auditing decides whether the Premium events an investigation looks for exist at all. Admin-unit scoping decides which users your searches can return. In the healthcare compliance team's investigation, both matter. Without Advanced Auditing on the physician's account, the message-level events aren't there to find. Without the right role scope, the team might not see logs for users in the affected clinic.

## Setup that applies to every tenant

### Confirm auditing is enabled

Audit logging is enabled by default for Microsoft 365 tenants, recording user and admin activities and retaining them for 180 days unless longer retention is configured. For new organizations, verify auditing is active.

> [!NOTE]
> The PowerShell examples throughout this module use the `ExchangeOnlineManagement` module. Install it once with `Install-Module ExchangeOnlineManagement`, then connect with `Connect-ExchangeOnline` before running any command.

To check status in Exchange Online PowerShell:

```powershell
Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled
```

If the result is `False`, enable auditing before continuing. In the Microsoft Purview portal, select **Audit**. If a banner prompts you to start recording activity, select it. Enablement can take up to 60 minutes to take effect. To enable via PowerShell instead:

```powershell
Connect-ExchangeOnline
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
```

Turning auditing off is rare and only available in PowerShell:

```powershell
Connect-ExchangeOnline
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $false
```

### Assign permissions to search the audit log

Authorized staff need the **Audit Logs** or **View-Only Audit Logs** role in the Microsoft Purview portal. These roles are included in the **Audit Reader** and **Audit Manager** role groups:

- **Audit Manager**: search and export audit logs, and manage audit settings including enabling or disabling logging.
- **Audit Reader**: search and export audit logs, without changing audit settings.

## Additional setup for Audit (Premium)

Two more pieces apply if your tenant has Audit (Premium) and you want to use its high-value events.

### Enable Advanced Auditing for the users who need it

Audit (Premium) events like `MailItemsAccessed`, `Send`, `SearchQueryInitiatedExchange`, and `SearchQueryInitiatedSharePoint` require the **Microsoft 365 Advanced Auditing** service plan turned on for each user. Microsoft 365 E5, Office 365 E5, and E5 Compliance licensing include the service plan, but it isn't turned on automatically. Someone still has to enable it per user for those events to start logging.

1. In the **Microsoft 365 admin center**, go to **Users** > **Active users**, then select a user.
1. On the user properties page, select **Licenses and apps**. Verify the user is licensed for Audit (Premium).
1. In **Apps**, make sure **Microsoft 365 Advanced Auditing** is selected. If not, select it and save changes.

Assignment typically propagates in 15 to 30 minutes, and full logging can take up to 24 hours to begin. Records exist only from the enablement date forward.

### Re-enable customized mailbox audit events

Skip this section for most tenants. It only applies if someone previously customized the mailbox actions audited on user or shared mailboxes. When that happened, new Audit (Premium) events released by Microsoft aren't added automatically, so you have to re-enable them.

To restore the search-query events on a mailbox, run this in Exchange Online PowerShell:

```powershell
Set-Mailbox <user> -AuditOwner @{Add="SearchQueryInitiated"}
```

> [!NOTE]
> In multi-geo tenants, run the command in the region where the user's mailbox is hosted. If the event was enabled in another region before, remove it there and then add it again in the correct region.

## Scope audit access with administrative units

Skip this section if your tenant is small or centrally administered. It applies when you delegate audit search to different teams or regions and need to restrict what each team can see.

Use **administrative units** to restrict which users' audit logs someone can search:

- **Unrestricted admins**, the default assignment with no admin unit, can search all audit logs, including logs from nonuser and system accounts.
- **Restricted admins**, meaning admins assigned one or more admin units, can search only audit logs for users in their assigned admin units.

A few audit activities are visible only to unrestricted admins, including Azure Information Protection `Discover`, Dynamics 365 `CrmDefaultActivity`, Endpoint data loss prevention (DLP) file events, Exchange `Set-Mailbox` and `Set-MailboxPlan`, and Microsoft Forms `ViewRuntimeForm`. To search for these activities, use an unrestricted admin account or the `Search-UnifiedAuditLog` cmdlet.
