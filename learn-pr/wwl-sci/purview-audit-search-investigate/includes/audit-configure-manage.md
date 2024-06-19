Microsoft Purview Audit (Standard) and Audit (Premium) provide capabilities to search for audit records of user and admin activities across various Microsoft 365 services. While Audit (Standard) is enabled by default, offering immediate access to audit logs, the full scope of features in Audit (Premium) requires specific configurations to effectively manage organizational audit capabilities.

Following our assessment of Microsoft Purview Audit's tools in our network of healthcare facilities, the IT compliance team is now tasked with configuring both Audit (Standard) and Audit (Premium). Their objective is to ensure all access and modifications to patient data are accurately logged to meet health data protection regulations.

Here you learn to:

- Verify and setup necessary licenses and permissions for Audit (Standard) and Audit (Premium).
- Understand and manage user roles for accessing and manipulating audit logs.
- Configure advanced auditing features in Audit (Premium) to capture detailed insights.
- Navigate the procedures to turn auditing on or off and understand the implications of these settings.

## Configure Audit in Microsoft Purview

### Step 1: Verify organization subscription and user licensing

Make sure that your organization has the necessary subscriptions and licenses before using Audit features.

**Audit (Standard)**, essential for basic auditing, is included in:

- **Microsoft 365**: E3, E5, F1, F3
- **Office 365**: E1, E3, E5, F3

  This allows organizations to meet basic compliance and auditing requirements without the need for complex licensing.

**Audit (Premium)**, suitable for organizations with strict compliance needs, requires subscriptions to higher-tier plans that include extensive security and compliance tools:

- **Microsoft 365**: E5, E5 Compliance, F5 Compliance, F5 Security + Compliance
- **Office 365**: E5

  These plans support advanced auditing features like extended data retention and detailed analytical insights, crucial for compliance management and forensic investigations.

### Step 2: Assign permissions to search the audit log

It's important to give appropriate permissions to allow authorized staff, like admins and investigation teams, to view and manage audit logs.

Assign _View-Only Audit Logs_ or _Audit Logs_ roles in the Microsoft Purview compliance portal to admins and investigation team members. These roles enable searching or exporting the audit log and are commonly included in the _Audit Reader_ and _Audit Manager_ role groups.

- **Audit Manager**: Grants permissions to search, export, and manage audit settings, including the ability to enable or disable logging.
- **Audit Reader**: Allows searching and exporting the audit log without the ability to change audit settings.

> [!NOTE]
> Steps 3-5 are only applicable to Audit (Premium).

### Step 3: Set up Audit (Premium) for users

Audit (Premium) offers advanced features, such as logging intelligent insights, which require additional setup like assigning E5 licenses and enabling specific service plans.

1. Navigate to the Microsoft 365 admin center, and select **Users** > **Active users**, and select a user.
1. On the user properties page, select **Licenses and apps**. Ensure that the user has an E5 license or an appropriate add-on license listed under **Licenses**.
1. Expand the **Apps** section, and ensure the **Microsoft 365 Advanced Auditing** checkbox is checked. If the checkbox isn't checked, select it, then select **Save changes**.

Audit logging for _MailItemsAccessed_ and _Send_ activates within 24 hours. Additional steps are required to start logging other Audit (Premium) events like _SearchQueryInitiatedExchange_ and _SearchQueryInitiatedSharePoint_.

### Step 4: Enable Audit (Premium) events

You can log user searches in Exchange Online and SharePoint Online by enabling specific audit events.

Enable the _SearchQueryInitiatedExchange_ and _SearchQueryInitiatedSharePoint_ events by running this PowerShell command:

```powershell
Set-Mailbox <user> -AuditOwner @{Add="SearchQueryInitiated"}
```

### Step 5: Set up audit retention policies in Audit (Premium)

You can configure Audit (Premium) to create audit log retention policies tailored to your organization's compliance needs.

### Step 6: Search for audited events

With auditing configured for your organization, you're ready to search the audit log within the Microsoft Purview compliance portal.

## Turn auditing on or off

Audit logging in Microsoft 365 is activated by default, which records user and admin activities and retains them for 180 days. When setting up a new Microsoft 365 organization,  it's important to verify that auditing is enabled as expected. The retention for audit records depends on your organization's policies and the licenses you have.

To verify that auditing is turned on for your organization, you can run this command in Exchange Online PowerShell:

```powershell
Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled
```

If auditing isn't enabled, enabling auditing is necessary for capturing and retaining audit records.

### Turn on auditing

To enable auditing:

1. Navigate to the Microsoft Purview compliance portal and select **Audit**.
1. If auditing isn't enabled, a banner is displayed prompting you to **Start recording user and admin activity**. Select this banner to enable auditing.
  It might take 60 minutes to start recording activities.

You can also enable auditing by running PowerShell:

1. Connect and authenticate to Exchange Online PowerShell:

   ```powershell
   Connect-ExchangeOnline
   ```

1. Run this PowerShell command to enable auditing:

   ```powershell
   Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
   ```

### Turn off auditing

You have to use Exchange Online PowerShell to turn off auditing.

1. Connect and authenticate to Exchange Online PowerShell:

   ```powershell
   Connect-ExchangeOnline
   ```

1. Run this PowerShell command to disable auditing:

   ```powershell
   Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $false
   ```

## Knowledge check

Choose the best response for the question below, then select **Check your answers**.
