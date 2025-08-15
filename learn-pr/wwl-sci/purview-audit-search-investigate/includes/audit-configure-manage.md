Microsoft Purview Audit (Standard) and Audit (Premium) let you search for audit records of user and admin activities across Microsoft 365 services. Audit (Standard) is enabled by default, offering immediate access to audit logs. Audit (Premium) requires extra configuration to unlock its extended capabilities.

## Configure audit in Microsoft Purview

To use Microsoft Purview Audit effectively, you need to confirm that your organization meets the licensing and permission requirements, then configure any additional features based on your edition. The following steps guide you through the process.

### Step 1: Verify subscription and licensing

Confirm your organization has the necessary subscriptions and licenses before using Audit features.

**Audit (Standard)** is included in:

- **Microsoft 365**: E3, E5, F1, F3
- **Office 365**: E1, E3, E5, F3

**Audit (Premium)** requires:

- **Microsoft 365**: E5, E5 Compliance, F5 Compliance, F5 Security + Compliance
- **Office 365**: E5

Audit (Premium) supports advanced features such as extended retention and intelligent insights for compliance investigations.

### Step 2: Assign permissions to search the audit log

Permissions are required for authorized staff, such as administrators or investigation teams, to view and manage audit logs.

Assign the **Audit Logs** or **View-Only Audit Logs** roles in the Microsoft Purview portal. These roles are included in the **Audit Reader** and **Audit Manager** role groups.

- **Audit Manager**: This role lets you search and export audit logs, and manage audit settings, including enabling or disabling logging.
- **Audit Reader**: This role lets you search and export audit logs but doesn't allow changes to audit settings.

> [!NOTE]
> Steps 3-5 apply only to Audit (Premium).

### Step 3: Set up Audit (Premium) for users

Audit (Premium) features such as logging intelligent insights require specific licensing and service plan activation.

1. In the **Microsoft 365 admin center**, go to **Users** > **Active users**, then select a user.
1. On the user properties page, select **Licenses and apps**. Verify the user has an E5 or the appropriate add-on license.
1. In **Apps**, make sure **Microsoft 365 Advanced Auditing** is selected. If not, select it and save changes.

Premium logging for events like **MailItemsAccessed** and **Send** begins within 24 hours. Further configuration is needed for events such as **SearchQueryInitiatedExchange** and **SearchQueryInitiatedSharePoint**.

### Step 4: Enable Audit (Premium) events

You can log user searches in Exchange Online and SharePoint Online by enabling specific audit events.

Enable **SearchQueryInitiatedExchange** and **SearchQueryInitiatedSharePoint** events with PowerShell:

```powershell
Set-Mailbox <user> -AuditOwner @{Add="SearchQueryInitiated"}
```

> [!NOTE]
> In multi-geo tenants, run `Set-Mailbox -AuditOwner @{Add="SearchQueryInitiated"}` in the region where the user's mailbox is hosted. If it was enabled in another region before, remove it there and then add it again in the correct region.

### Step 5: Set up audit retention policies in Audit (Premium)

Create audit log retention policies to meet compliance requirements. Policies can be scoped by service, activity type, or user and set for durations up to 10 years with the required add-on license.

### Step 6: Search for audited events

Once auditing is configured, search the audit log in the Microsoft Purview portal to investigate activity.

## Turn auditing on or off

Audit logging is enabled by default for Microsoft 365 tenants, recording user and admin activities and retaining them for 180 days unless longer retention is configured. For new organizations, verify that auditing is active.

To check status in PowerShell:

```powershell
Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled
```

If auditing is disabled, enable it to begin capturing audit records.

### Turn on auditing

1. In the Microsoft Purview portal, select **Audit**.
1. If a banner prompts you to start recording activity, select it to enable auditing. It might take up to 60 minutes to start recording.

Or enable via PowerShell:

```powershell
Connect-ExchangeOnline
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
```

### Turn off auditing

Auditing can only be disabled with PowerShell:

```powershell
Connect-ExchangeOnline
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $false
```

## Knowledge check

Choose the best response for this question.
