Connector policies in Power Platform don't help when sensitive data lives in non-Microsoft cloud apps like Box, Dropbox, or Google Workspace. To detect and protect sensitive content in those apps, you extend DLP coverage through Microsoft Defender for Cloud Apps.

Once you connect these apps to Defender for Cloud Apps, you have two options for creating policies. File policies offer cloud-app-specific governance like quarantine and link revocation. Purview DLP policies provide the same rule engine and reporting you use for Exchange and SharePoint.

## Compare DLP approaches for cloud apps

You can create DLP policies for non-Microsoft cloud apps in two ways:

- Create file policies in the Microsoft Defender portal under Cloud Apps
- Create DLP policies in the Microsoft Purview portal and scope them to the **Instances** location

These two approaches serve different purposes:

| | File policies (Defender portal) | DLP policies (Microsoft Purview portal) |
| :--- | :--- | :--- |
| **Best for** | Governance actions specific to cloud apps, such as quarantining files or revoking shared links | Consistent policy rules across multiple locations using sensitive information types |
| **Reporting** | Matches logged in Defender for Cloud Apps | Matches appear in standard Purview DLP reports |

If you need to protect files in SharePoint Online or OneDrive specifically, use the dedicated SharePoint Online or OneDrive locations in your DLP policies instead.

## Enable file monitoring

Defender for Cloud Apps must have file monitoring enabled before it can scan files in connected apps. This setting may already be on in your tenant, but verify before creating file policies:

1. Navigate to the **Microsoft Defender** portal at [https://security.microsoft.com/](https://security.microsoft.com/?azure-portal=true).

1. Select **Settings**, then select **Cloud Apps**.

1. Under **Information Protection**, select **Files**.

1. Select **Enable file monitoring** if not already enabled, then select **Save**.

With file monitoring enabled, you're ready to create file policies.

> [!IMPORTANT]
> When you create the first file policy in a tenant, Microsoft Entra service principal permissions are automatically granted. If the automatic grant fails, for example because of restricted tenant settings, resolve the permissions issue before creating file policies. After you create the first file policy, this prerequisite no longer applies.

## Create a DLP policy scoped to Instances

If you prefer centralized reporting through the Purview portal, you can create a DLP policy scoped to connected cloud app instances instead of using file policies. First, connect your non-Microsoft cloud apps to Defender for Cloud Apps. Once connected, those apps appear as selectable instances when you create a DLP policy.

To create the policy:

1. In the Microsoft Purview portal, go to **Data loss prevention** > **Policies** > **+ Create policy**.
1. Select **Custom** > **Custom policy** and configure the policy name and scope.
1. On the **Locations** page, toggle the **Instances** location to on. To target a specific app, select **Edit** > **Specific instances** and choose the apps to include. If you don't select specific instances, the policy applies to all connected apps.
1. Create a rule with the conditions and sensitive information types you want to detect. Under **Actions**, select **Restrict Third Party Apps** and choose the appropriate actions for each app.

The available actions vary by app because each cloud app API supports different capabilities. For the full DLP policy creation workflow, see [Create and deploy data loss prevention policies](/purview/dlp-create-deploy-policy?azure-portal=true).

Matches from Instances-scoped policies appear in the Purview DLP alerts dashboard and Activity explorer, not in Defender for Cloud Apps. For investigation steps, see [Investigate data loss prevention alerts](/purview/dlp-alerts-dashboard-get-started?azure-portal=true).
