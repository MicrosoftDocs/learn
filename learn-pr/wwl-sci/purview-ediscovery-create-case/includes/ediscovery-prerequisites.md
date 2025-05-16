Before you can create cases or start investigations in Microsoft Purview eDiscovery, you need to complete a few setup tasks. These tasks ensure users have the right access and that core tools are available across your tenant.

## Choose the right licensing level

Microsoft Purview eDiscovery includes both **standard** and **premium** features, and the level of access you need depends on how you plan to use the tool. Most organizations using review sets, analytics, or exporting content for legal review will need access to premium eDiscovery features.

- **Standard eDiscovery** features are included with Microsoft 365 and Office 365 E1, E3, and E5 plans. It supports case creation, content search, holds, and basic exports.
- **Premium eDiscovery** features add capabilities like review sets, analytics, optical character recognition (OCR), and better export controls. It requires additional licensing.

Only users whose data is being investigated need Premium eDiscovery licensing. Reviewers and administrators don't need a license unless their own data is part of the case.

You can assign:

- Microsoft 365 E5 or Office 365 E5
- Microsoft 365 E3 with the eDiscovery and Audit add-on
- Office 365 E3 with the eDiscovery and Audit add-on

For more detail on what's included with each level, see [Microsoft Purview eDiscovery features and capabilities](/purview/edisc#features-and-capabilities?azure-portal=true).

### Understand billing for AI data in eDiscovery

Microsoft Purview eDiscovery uses a combination of licensing and pay-as-you-go billing, depending on the type of data being processed.

- **Microsoft 365 data**, including Copilot in Word, Excel, and PowerPoint, is included in your enterprise subscription.
- **Non-Microsoft 365 AI data**, such as Copilot in Microsoft Fabric or connected AI apps, is billed separately based on how it's processed.

You're only billed for storing or exporting non-Microsoft 365 AI data in certain ways, such as:

- Adding this data to a review set
- Exporting it directly from a case
- Exporting it with the Microsoft Graph API

Searches, holds, and case management activities are **not billed** for non-Microsoft 365 AI data.

If your organization collects this type of data, you'll need to configure an Azure subscription for billing. You can also filter out this data from searches if needed.

For more information, including example ItemClasses and exclusion filters, see [Billing for eDiscovery with non-Microsoft 365 AI data](/purview/purview-billing-models#pay-as-you-go-billing-model?azure-portal=true).

## Assign permissions

Access to eDiscovery features is managed through role groups in Microsoft Purview. The two primary roles are:

- **eDiscovery Managers**: Can create and manage their own cases and perform tasks like running searches, placing holds, and reviewing results.
- **eDiscovery Administrators**: Has organization-wide access to all cases and can manage global settings like analytics and guest access.

To assign these roles:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true), then select **Settings** > **Roles and scopes** > **Role groups**.
1. Select the **eDiscovery Manager** role group, then select **Edit**.
1. Choose users to add to either the **eDiscovery Managers** or **eDiscovery Administrators** role group.
1. Review your settings then save your changes.

To assign these permissions with PowerShell or for more information, see [Assign eDiscovery permissions in the Microsoft Purview portal](/purview/ediscovery-assign-permissions?azure-portal=true).

## Verify that required enterprise apps are enabled

Certain Microsoft 365 apps must be enabled for eDiscovery to work correctly. These apps allow eDiscovery to access the content and features it needs to search and analyze across workloads.

To check that they're enabled:

1. Go to the [Microsoft Entra admin center](https://entra.microsoft.com/?azure-portal=true).
1. Navigate to **Applications** > **Enterprise applications**.
1. Use the search bar to confirm these apps are enabled in your tenant:

   | App name | App ID |
   |-----|-----|
   | ComplianceWorkbenchApp | 92876b03-76a3-4da8-ad6a-0511ffdf8647 |
   | MicrosoftPurviewEDiscovery | b26e684c-5068-4120-a679-64a5d2c909d9 |
   | Microsoft Exchange Online Protection | 00000007-0000-0ff1-ce00-000000000000 |
   | Office365Zoom | 0d38933a-0bbd-41ca-9ebd-28c4b5ba7cb7 |

If these aren't enabled, some views and actions in eDiscovery might not work as expected.

## Configure global eDiscovery settings

Several global settings are available in **Settings** > **eDiscovery** in the Microsoft Purview portal. These settings apply across all eDiscovery cases in the tenant and control things like tagging structures, analytics, and access permissions.

You must be a member of the **eDiscovery Administrators** role group to modify these global settings.

Review and configure these settings to ensure your environment is ready for case management and analysis:

- **Guest access**: Enables external users, such as legal counsel or consultants, to be added to cases as reviewers. You'll need to confirm B2B collaboration is allowed in your Microsoft Entra settings. Once guest access is turned on, you can invite external participants to individual cases.
- **Analytics**: Turns on attorney-client privilege detection. This model helps identify documents that might be privileged based on content and participant analysis. You can also upload a list of attorney email addresses to improve detection accuracy.
- **Tag templates**: Allows reuse of tagging structures across multiple cases and review sets. This helps maintain consistency in how documents are reviewed.
- **Historical versions (preview)**: Enables searching across version history in SharePoint sites. This allows you to surface prior versions of documents that might be relevant to an investigation.

   :::image type="content" source="../media/ediscovery-settings.png" alt-text="Screenshot showing the eDiscovery settings page in Microsoft Purview." lightbox="../media/ediscovery-settings.png":::

While optional, these settings can streamline your workflows and improve consistency across cases.

Use the **Configure permissions and global settings** interactive guide to walk through setting up eDiscovery roles and global settings.

[:::image type="content" source="../media/guide-configure-permissions.png" alt-text="Illustration showing the opening page to the Configure permissions and global settings interactive guide.":::](https://mslearn.cloudguides.com/guides/Configure%20permissions%20and%20global%20settings%20with%20Microsoft%20Purview%20eDiscovery?azure-portal=true)