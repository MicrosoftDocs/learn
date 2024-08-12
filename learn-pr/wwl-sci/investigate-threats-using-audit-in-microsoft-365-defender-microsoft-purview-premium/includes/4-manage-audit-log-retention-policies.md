
Organizations can create and manage audit log retention policies in the Microsoft Purview compliance portal. Audit log retention policies are part of the Microsoft Purview Audit (Premium) solution. An audit log retention policy lets an organization specify how long it wants to retain audit logs. Audit logs can be retained for up to 10 years. Retention policies can be created based on the following criteria:

- All activities in one or more Microsoft 365 services.
- Specific activities (in a Microsoft 365 service) performed by all users or by specific users.
- A priority level that specifies which policy takes precedence when multiple policies exist in an organization.

### Default audit log retention policy

Microsoft Purview Audit (Premium) provides a default audit log retention policy for all organizations. This policy retains all Exchange Online, SharePoint Online, OneDrive for Business, and Microsoft Entra audit records for one year. The default policy retains audit records that contain the value of Exchange, SharePoint, OneDrive, AzureActiveDirectory for the Workload property (which is the service in which the activity occurred).

> [!NOTE]
> The default audit log retention policy can't be modified.

The default audit log retention policy only applies to audit records for activity performed by users who are assigned either:

- an Office 365 or Microsoft 365 E5 license
- a Microsoft 365 E5 Compliance or E5 eDiscovery and Audit add-on license

If an organization has non-E5 users or guest users, their corresponding audit records are retained for 90 days.

### Before you create an audit log retention policy

Organizations must satisfy the following requirements before they can create an audit log retention policy:

- The persons in an organization who are given the responsibility of creating and modifying audit log retention policies must be assigned the **Organization Configuration** role in the Microsoft Purview compliance portal.
- An organization can have a maximum of 50 audit log retention policies.
- To retain an audit log for longer than 90 days (and up to one year), the user who generates the audit log (by performing an audited activity) must be assigned an Office 365 E5 or Microsoft 365 E5 license or have a Microsoft 365 E5 Compliance or E5 eDiscovery and Audit add-on license.
- To retain audit logs for 10 years, the user who generates the audit log must also be assigned a 10-year audit log retention add-on license in addition to an E5 license.
- All custom audit log retention policies that are created by an organization take priority over the default retention policy. For example, let's assume you create an audit log retention policy for Exchange mailbox activity that has a retention period that's shorter than one year. In this scenario, the audit records for Exchange mailbox activities will be retained for the shorter duration specified by the custom policy.

### Create an audit log retention policy

Complete the following steps to create a custom audit log retention policy:

1. Sign into the **Microsoft Purview compliance** portal with a user account that's assigned the **Organization Configuration** role.
1. In the **Microsoft Purview compliance** portal, select **Audit** on the navigation pane.
1. On the **Audit** page, select the **Audit retention policies** tab.
1. On the **Audit retention policies** tab, select **Create audit retention policy**, and then complete the following fields on the **New audit retention policy** window that appears:
    
    :::image type="content" source="../media/create-audit-log-retention-policy-49ced9e7.png" alt-text="Screenshot showing the New audit retention policy window with several of the settings highlighted.":::
    
    
    
    1. **Policy name**. The name of the audit log retention policy. This name must be unique in the organization. It can't be changed after the policy is created.
    1. **Description**. The description of the policy. While this field is optional, it's helpful to provide information about the policy. For example, the record type or workload, users specified in the policy, and the duration.
    1. **Users**. Select one or more users to whom the policy will be applied. The policy applies to all users if you leave this field blank. If you leave the **Record type** blank, then you must select a user.
    1. **Record type**. The audit record type to which the policy will be applied. If you leave this property blank, you must select a user in the **Users** field. You can select a single record type or multiple record types:
         - **Single record type**. If you select a single record type, the **Activities** field is dynamically displayed. You can use the drop-down list to select activities from the selected record type to apply the policy to. If you don't choose specific activities, the policy applies to all activities of the selected record type.
         - **Multiple record type**. If you select multiple record types, you won't have the ability to select activities. The policy applies to all activities of the selected record types.
    1. **Duration**. The amount of time to retain the audit logs that meet the criteria of the policy.
    1. **Priority**. This value determines the order in which audit log retention policies in the organization are processed. A lower value indicates a higher priority. Valid priorities are numerical values between 1 and 10,000. A value of 1 is the highest priority, and a value of 10,000 is the lowest priority. For example, a policy with a value of 5 takes priority over a policy with a value of 10. As previously explained, any custom audit log retention policy takes priority over the organization's default policy.
1. Select **Save** to create the new audit log retention policy.

The new policy is displayed in the list on the **Audit retention policies** tab.

### Manage audit log retention policies in the Microsoft Purview compliance portal

Audit log retention policies are listed on the **Audit retention policies** tab (also called the *dashboard*). You can use the dashboard to view, edit, and delete audit retention policies.

#### View policies in the dashboard

Audit log retention policies are listed in the dashboard. One advantage of viewing policies in the dashboard is that you can select the **Priority** column to list the policies in the priority in which they're applied. As previously explained, a lower value indicates a higher priority.

:::image type="content" source="../media/audit-retention-policies-42023.png" alt-text="Screenshot showing the Audit retention policies tab on the Audit page with the priority column highlighted for each policy." lightbox="../media/audit-retention-policies-42023.png":::

You can also select a policy to display its settings on the policy detail pane that appears.

> [!NOTE]
> The default audit log retention policy for your organization isn't displayed in the dashboard.

#### Edit policies in the dashboard

To edit a policy, select it to display the policy detail pane. You can modify one or more setting and then save your changes.

> [!IMPORTANT]
> If you use the **New-UnifiedAuditLogRetentionPolicy** cmdlet to create a policy, it's possible to create an audit log retention policy for record types or activities that aren't available in the **Create audit retention policy** tool in the Microsoft Purview compliance portal. In this case, you won't be able to edit the policy (for example, change the retention duration or add and remove activities) from the **Audit retention policies** dashboard. You'll only be able to view and delete the policy in the Microsoft Purview compliance portal. To edit the policy, you'll have to use the [Set-UnifiedAuditLogRetentionPolicy](/powershell/module/exchange/set-unifiedauditlogretentionpolicy?azure-portal=true) cmdlet in the Security and Compliance PowerShell module.

> [!TIP]
> A message is displayed at the top of the policy detail pane for policies that have to be edited using PowerShell.

#### Delete policies in the dashboard

To delete a policy, select the trash can (Delete) icon. Then confirm that you want to delete the policy. While the policy is removed from the dashboard, it may take up to 30 minutes for a deleted policy to be removed from an organization.

### Create and manage audit log retention policies in PowerShell

Organizations can also use the Security and Compliance PowerShell module to create and manage audit log retention policies. One reason to use PowerShell is to create a policy for a record type or activity that isn't available in the Microsoft Purview compliance portal.

#### Create an audit log retention policy in PowerShell

Follow these steps to create an audit log retention policy in PowerShell:

1. In **Windows PowerShell**, connect to the **Security and Compliance PowerShell** module.
1. Run the following command to create an audit log retention policy:
    
    ```powershell
    New-UnifiedAuditLogRetentionPolicy -Name "Microsoft Teams Audit Policy" -Description "One year retention policy for all Microsoft Teams activities" -RecordTypes MicrosoftTeams -RetentionDuration TenYears -Priority 100
    ```
    
    This example creates an audit log retention policy named "Microsoft Teams Audit Policy" with these settings:
    
    
     - A description of the policy.
     - Retains all Microsoft Teams activities (as defined by the **RecordType** parameter).
     - Retains Microsoft Teams audit logs for 10 years.
     - Assigns a priority of 100 to the policy.

Here's another example of creating an audit log retention policy. This policy:

- Retains audit logs for the "User logged in" activity for six months.
- It does so for the user `admin@contoso.onmicrosoft.com`.
- Assigns a priority of 25 to the policy.

```powershell
New-UnifiedAuditLogRetentionPolicy -Name "SixMonth retention for admin logons" -RecordTypes AzureActiveDirectoryStsLogon -Operations UserLoggedIn -UserIds admin@contoso.onmicrosoft.com -RetentionDuration SixMonths -Priority 25
```

#### View policies in PowerShell

Use the **Get-UnifiedAuditLogRetentionPolicy** cmdlet in the Security and Compliance PowerShell module to view audit log retention policies.

Here's a sample command to display the settings for all audit log retention policies in an organization. This command sorts the policies from the highest to lowest priority.

```powershell
Get-UnifiedAuditLogRetentionPolicy | Sort-Object -Property Priority -Descending | FL Priority,Name,Description,RecordTypes,Operations,UserIds,RetentionDuration
```

> [!NOTE]
> The **Get-UnifiedAuditLogRetentionPolicy** cmdlet doesn't return the default audit log retention policy for an organization.

#### Edit policies in PowerShell

Use the **Set-UnifiedAuditLogRetentionPolicy** cmdlet in the Security and Compliance PowerShell module to edit an existing audit log retention policy.

#### Delete policies in PowerShell

Use the **Remove-UnifiedAuditLogRetentionPolicy** cmdlet in the Security and Compliance PowerShell module to delete an audit log retention policy. It may take up to 30 minutes for a deleted policy to be removed from an organization.

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”
