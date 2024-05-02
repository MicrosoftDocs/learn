Microsoft Purview Audit (Premium) enhances the ability to manage audit logs by extending their retention. For healthcare facilities managing sensitive patient data, maintaining audit records for required periods is essential to comply with healthcare regulations.

As our network of healthcare facilities continues to maintain high standards of data protection, the IT compliance team is using Audit (Premium) to ensure that all audit logs are retained for the required periods. This commitment supports ongoing security evaluations and compliance with health data protection standards, providing a reliable foundation for any necessary compliance reviews or investigations.

Here you learn to:

- Understand both default and customizable retention policies available in Audit (Premium).
- Configure audit log retention policies through the Microsoft Purview portal and compliance portal.
- Manage retention policies to ensure they meet compliance needs and organizational security policies.

## Audit log retention policy overview

In Microsoft Purview Audit (Premium), you can create and manage audit log retention policies that define how long to retain audit logs, supporting compliance with regulatory requirements. This capability allows for retention periods up to 10 years and is accessible through both the Microsoft Purview portal and the Microsoft Purview compliance portal.

Audit log retention policies in Audit (Premium) allow organizations to set retention times based on:

- All activities across one or more Microsoft 365 services.
- Specific activities within a Microsoft 365 service, performed by all or specific users.
- A priority level that determines which policy takes precedence when multiple policies are in place.

## Default retention policy

Audit (Premium) automatically provides a default retention policy for every organization, retaining all audit records from Exchange Online, SharePoint, OneDrive, and Microsoft Entra for one year. This policy includes records associated with Microsoft Entra ID, Exchange, OneDrive, and SharePoint workloads. While this default policy can't be modified, you can create custom policies to set different retention durations for specific workloads or record types.

## Considerations for setting audit log retention policies

Keep these considerations in mind before setting up your audit log retention policies in Microsoft Purview Audit (Premium):

- **Required role**: Only users with the _Organization Configuration_ role in the Microsoft Purview portal or compliance portal can create or edit audit retention policies.
- **Policy limit**: Each organization can have up to 50 audit log retention policies.
- **License requirements**:
  - For retaining audit logs beyond the default 180 days, users must have an Office 365 E5, Microsoft 365 E5, or a similar E5 add-on license. This enables retention of up to one year.
  - For 10-year retention, users must also have a 10-year audit log retention add-on license.
- **Policy priority**: Custom policies override the default policy. For instance, if a custom policy specifies a shorter retention period than the default for certain records, the custom period applies.
- **Data retention timing**: The duration an audit log is retained is set when the data is first logged, based on the user's license and applicable policies. Subsequent changes to policies or licenses affect only new data, not already logged data.

## Create and manage audit log retention policies

In Microsoft Purview Audit (Premium), you can set up audit log retention policies through both the Microsoft Purview portal and the Microsoft Purview compliance portal. These policies determine how long audit logs are retained, supporting your organization's compliance with regulatory requirements.

### Steps to create an audit log retention policy

Whether you're using the Microsoft Purview portal or the Microsoft Purview compliance portal, the steps to create an audit retention policy are similar:

1. Sign in to either the Microsoft Purview portal or the Microsoft Purview compliance portal with a user account that has the _Organization Configuration_ role.
1. To navigate to the Audit solution:
   - In the **Microsoft Purview portal**: Select the Audit solution card. If it's not visible, select **View all solutions** then select **Audit**.
   - In the **Microsoft Purview compliance portal**: Select **Audit** from the left pane, then the **Audit retention policies tab**.
1. Select **Create audit retention policy**. Here, you need to fill out these fields on the flyout page:
   1. **Policy name**: Enter a unique name for the policy.
   1. **Description**: Provide an optional, brief description of the policy.
   1. **Users**: Specify which users the policy applies to. Leave blank to cover all users.
   1. **Record type**: Select the type of audit record the policy applies to. If you select multiple record types, you can't choose specific activities.
   1. **Duration**: Set how long to retain the logs, with options ranging from seven days to 10 years. Note: Retaining logs for more than one year requires specific licensing.
   1. **Priority**: Set the priority, where a lower number means higher priority, to determine the order of policy application.
  
   :::image type="content" source="../media/audit-create-new-audit-retention-policy.png" alt-text="Screenshot showing the new audit retention policy flyout page.":::

1. After filling out the necessary fields, select **Save**.

Your new policy appears in the policy list under **Policies** if it was created in the Microsoft Purview portal. If you created your audit retention policy in the Microsoft Purview compliance portal, the new policy appears on the **Audit retention policies tab**.

### Manage policies in the compliance portal

Policies can be viewed, edited, or deleted within the **Audit retention policies** dashboard. Priority adjustments and settings modifications can be made through the portal interface or using PowerShell for more advanced configurations.

  :::image type="content" source="../media/audit-log-retention-dashboard-priority.png" alt-text="Screenshot showing the priority column in the Audit retention policies dashboard.":::

### Advanced management using PowerShell

PowerShell commands provide flexibility for creating, viewing, editing, and deleting retention policies, especially for complex setups. For policy management in PowerShell use **[Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell)**.

- **Create policies in PowerShell** using the `New-UnifiedAuditLogRetentionPolicy` cmdlet. This example creates a policy named "Microsoft Teams Audit Policy" to retain all activities for 10 years with a priority of 100:

   ```powershell
   New-UnifiedAuditLogRetentionPolicy -Name "Microsoft Teams Audit Policy" -Description "One year retention policy for all Microsoft Teams activities" -RecordTypes MicrosoftTeams -RetentionDuration TenYears -Priority 100
   ```

- **View policies in PowerShell** using the `Get-UnifiedAuditLogRetentionPolicy` cmdlet. This example displays the settings for all audit log retention policies in your organization and sorts policies from highest to lowest priority:

   ```powershell
   Get-UnifiedAuditLogRetentionPolicy | Sort-Object -Property Priority -Descending | FL Priority,Name,Description,RecordTypes,Operations,UserIds,RetentionDuration
   ```

- **Edit policies in PowerShell** using the `Set-UnifiedAuditLogRetentionPolicy` cmdlet.
- **Delete policies in PowerShell** using the `Remove-UnifiedAuditLogRetentionPolicy` cmdlet. It might take up to 30 minutes for the policy to be removed from your organization.

## Knowledge check

Choose the best response for the question below, then select **Check your answers**.
