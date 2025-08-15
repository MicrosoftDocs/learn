Microsoft Purview Audit (Premium) enhances your ability to manage audit logs by extending how long they're retained. This capability is especially important for organizations that need to meet strict regulatory or internal compliance requirements.

## Audit log retention policy overview

In Microsoft Purview Audit (Premium), you can create and manage audit log retention policies that define how long audit records are kept. These policies can retain data for up to 10 years with the appropriate licensing.

Retention policies can be scoped by:

- All activities across one or more Microsoft 365 services
- Specific activities within a service, for all or selected users
- Priority level to control which policy applies when more than one could apply

## Default retention policy

Audit (Premium) provides a default retention policy that retains audit records from Microsoft Entra ID, Exchange, OneDrive, and SharePoint for one year. This default can't be modified, but you can create custom policies for other workloads or to set different durations for specific record types.

## Considerations for retention policies

Before creating a policy, keep in mind:

- **Required role**: You need the **Organization Configuration** role in the Microsoft Purview portal to create or edit policies.
- **Policy limit**: Each organization can have up to 50 retention policies.
- **Licensing**: Retention beyond 180 days requires Microsoft 365 E5, Office 365 E5, or an equivalent add-on license. Ten-year retention also requires a 10-year audit log retention add-on license.
- **Policy priority**: Custom policies override the default for covered records.
- **Data retention timing**: Retention is determined when the record is created. Policy or license changes affect only new records.

## Create an audit log retention policy

You can create retention policies in the Microsoft Purview portal.

1. Sign in to the [Microsoft Purview](https://purview.microsoft.com/) portal with an account that has the **Organization Configuration** role.
1. Go to **Solutions** > **Audit** > **Audit retention policies**.
1. Select **Create audit retention policy**, then complete the fields:

   - **Policy name**: Unique name for the policy
   - **Description**: Optional short description
   - **Users**: Apply to all users or specific ones
   - **Record type**: Choose the type of audit record; multiple types can't have activity-specific selections
   - **Duration**: Choose the retention period (7 days to 10 years; over 1 year requires specific licensing)
   - **Priority**: Set the priority, where lower numbers have higher priority
     :::image type="content" source="../media/audit-create-new-audit-retention-policy.png" alt-text="Screenshot showing the new audit retention policy flyout page.":::
1. Select **Save**.

## Manage policies in the Microsoft Purview Portal

Once created, policies appear in the **Audit retention policies** dashboard. You can view, edit, or delete them, and adjust priority as needed.

:::image type="content" source="../media/audit-log-retention-dashboard-priority.png" alt-text="Screenshot showing the priority column in the Audit retention policies dashboard.":::

## Manage retention policies using PowerShell

For more advanced management, use **[Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell?azure-portal=true)**.

- **Create policies in PowerShell** using the `New-UnifiedAuditLogRetentionPolicy` cmdlet. This example creates a policy named "Microsoft Teams Audit Policy" to retain all activities for 10 years with a priority of 100:

  ```powershell
  New-UnifiedAuditLogRetentionPolicy -Name "Microsoft Teams Audit Policy" -Description "10-year retention policy for Teams activities" -RecordTypes MicrosoftTeams -RetentionDuration TenYears -Priority 100
  ```

- **View policies in PowerShell** using the `Get-UnifiedAuditLogRetentionPolicy` cmdlet. This example displays the settings for all audit log retention policies in your organization and sorts policies from highest to lowest priority:

  ```powershell
  Get-UnifiedAuditLogRetentionPolicy | Sort-Object -Property Priority -Descending | FL Priority,Name,Description,RecordTypes,Operations,UserIds,RetentionDuration
  ```

- **Edit policies in PowerShell** using the `Set-UnifiedAuditLogRetentionPolicy` cmdlet:

  ```powershell
  Set-UnifiedAuditLogRetentionPolicy -Identity "Microsoft Teams Audit Policy" -RetentionDuration FiveYears
  ```

- **Delete policies in PowerShell** using the `Remove-UnifiedAuditLogRetentionPolicy` cmdlet. It might take up to 30 minutes for the policy to be removed from your organization:

  ```powershell
  Remove-UnifiedAuditLogRetentionPolicy -Identity "Microsoft Teams Audit Policy"
  ```

## Knowledge check

Choose the best response for this question.
