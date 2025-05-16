After you complete initial setup, you can begin creating and managing eDiscovery cases in the Microsoft Purview portal. Each case serves as a secure workspace that brings together related investigation tasks such as searches, holds, review sets, and exports. Cases help isolate and track the details of a specific legal, compliance, or security matter.

Before using the investigation tools, you need to create a case. From there, you can organize, manage, and monitor case activity in the Microsoft Purview portal.

## Create a case

Creating a case gives you a dedicated environment for your investigation. You must have the correct eDiscovery permissions to perform this task.

To create a case:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true) and sign in as a user with eDiscovery permissions.
1. Select **Solutions** > **eDiscovery** to go to the **Cases** page.
1. Select **Create case**.
1. Enter a **Case name** and optional **Case description**.
1. Select **Create**.

   :::image type="content" source="../media/create-ediscovery-case.png" alt-text="Screenshot showing case creation in Microsoft Purview eDiscovery." lightbox="../media/create-ediscovery-case.png":::

After the case is created, the user who created it is automatically added as a member. Members can access the case and complete tasks based on their assigned roles.

## View and organize existing cases

Once you create a case, it appears on the **Cases** dashboard. This dashboard shows all existing cases across your organization, along with details such as:

- Case name
- Status (Active, Closed, and other states)
- Type (Standard or Premium)
- Created and modified timestamps
- Last modified by
- Optional case number and description

You can adjust the dashboard to meet your needs. Choose which columns to show, apply filters based on case type or status, group by properties such as last modified user, and export the full case list as a `.csv` file.

To prioritize a case for quick access, mark it as a favorite by selecting the star icon next to its name. The correct terminology is **marking as a favorite**, not pinning.

## Use Security Copilot to summarize a case (preview)

Security Copilot provides a summary of case activity using AI-generated natural language. This helps you review case progress without navigating every tab.

You can use it to:

- Review status updates and outstanding tasks at a glance
- Prepare for case meetings or reporting
- Identify priorities based on recent actions

Copilot summarizes key areas, including:

- Case information such as creation date, status, and last modified user
- Data sources included in the investigation
- Searches, holds, and review sets
- Exports and case-related jobs
- Case settings like optical character recognition (OCR) and near-duplicate detection

   :::image type="content" source="../media/ediscovery-security-copilot-summary.png" alt-text="Screenshot showing Security Copilot being used in an eDiscovery case." lightbox="../media/ediscovery-security-copilot-summary.png":::

Security Copilot is available to users assigned the **eDiscovery Administrator** or **eDiscovery Manager** role. It must be enabled in your environment. Select **Summarize this case** to generate or refresh the summary in the Copilot pane.

## Manage case settings

Each case includes settings for metadata, access, and investigation behavior. To update settings, open the case and select **Case settings**. You can:

- Edit the name, number, or description
- View the license level for the case (Standard or Premium)
- Manage access for users, role groups, and guests
- Configure advanced features such as OCR or analytics

   :::image type="content" source="../media/ediscovery-case-settings.png" alt-text="Screenshot showing the case settings in an eDiscovery case." lightbox="../media/ediscovery-case-settings.png":::

You can also close or delete a case from this area.

- Closing a case turns off all holds associated with it. A 30-day delay hold applies to content that was previously held.
- Reopening a case doesn't restore holds automatically. You must manually turn them back on.
- Deleting a case permanently removes all associated data. This includes hold policies, searches, review sets, and exports. Deleted cases can't be recovered.

To close or delete a case:

1. Go to the **Case settings** page from an eDiscovery case.
1. Select the **Case details** tab.
1. Select **Actions** then choose to close or delete the case.

To delete a case, you must first remove all hold policies, even those that are currently turned off.

Use the **Create and configure a case** interactive guide to walk through case eDiscovery creation and management.

[:::image type="content" source="../media/guide-create-case.png" alt-text="Illustration showing the opening page to the Create and configure a case interactive guide." lightbox="../media/guide-create-case.png":::](https://mslearn.cloudguides.com/guides/Create%20and%20configure%20a%20case%20with%20Microsoft%20Purview%20eDiscovery?azure-portal=true)
