Trackers and tracker categories are essential components of Microsoft Priva Tracker Scanning. They enable your organization to identify and organize tracking technologies across websites, ensuring better compliance with privacy practices and supporting user consent preferences. Tracker categories also integrate with [Microsoft Priva Consent Management (preview)](/privacy/priva/consent-management) to ensure only consented trackers are active, helping organizations build trust and comply with privacy standards.

## Tracker management overview

The **Tracker management** page in tracker scanning is your central hub for managing and categorizing trackers. It's divided into the following sections:

- **Trackers tab**: Displays all trackers identified through scans or added manually. You can edit tracker properties, assign categories, and view details about each tracker.
- **Tracker categories tab**: Allows you to create, view, and manage tracker categories, including translations.
- **Common tracker database tab**: Serves as a reference inventory of widely used non-Microsoft trackers, which can be mapped to your organization's tracker categories.
- **Tracker library**: A curated list of approved trackers used across your organization for proactive compliance.

:::image type="content" source="../media/tracker-management.png" alt-text="Screenshot showing the menu for the tracker management options in Tracker Scanning." lightbox="../media/tracker-management.png":::

Each tracker or tracker category includes detailed information, such as its name, description, owner, and associated websites.

### Create tracker categories

Tracker categories help group trackers based on their purpose, such as advertising, analytics, or functional tasks. Setting up categories ensures that trackers are organized and ready for use in consent models.

To create a tracker category:

1. Navigate to the **Tracker management** page and select the **Tracker categories** tab.
1. Select **New tracker category**.
1. Provide the following details in the **Add tracker category** flyout pane:
   - **Category name**: Enter a public-facing name for the category (for example, Advertising, Functional). This name appears in consent banners.
   - **Use guidelines**: Add internal-facing guidance about the appropriate use of trackers in this category.
   - **Owner**: Assign a user responsible for managing the category.
   - **Essential status**: Check the **Essential** box if trackers in this category must always deploy, regardless of user consent.
1. Select **Save** to create the category.

Categories marked as **Essential** deploy by default, while nonessential categories require user consent to be activated. You can also add translations to tracker categories to support multilingual environments.

#### Add translations to categories

Language translations ensure that tracker categories are accessible to users in multiple regions. To add a translation:

1. On the **Tracker management** page, go to the **Tracker categories** tab and select a tracker category.
1. Select **New translation** and choose an option:
   - **Manual translation**
   - **Import translations**
   - **Auto translation**
1. Follow the process to add translations for each language needed.

### Categorize trackers

Categorizing trackers is a critical step for enabling consent model interactions in Microsoft Priva Consent Management. Proper categorization ensures that when users interact with consent banners or privacy settings, only trackers that have been consented to remain active. This step also supports building a complete inventory of tracking technologies used on your websites.

To categorize a tracker:

1. Navigate to the **Trackers** tab on the **Tracker management** page.
1. Select a tracker from the list to open its details page.
1. On the tracker's details page, select **Categorize**.
1. In the **Categorize** flyout pane, choose a category and select **Apply**.

Once categorized, the tracker's category is reflected in all future scans. Each tracker can only be assigned to one category at a time.

### Manually add trackers

Some trackers might not be detected during scans and need to be added manually. This ensures all relevant trackers are included in your inventory.

To add a tracker manually:

1. On the **Trackers** tab of the **Tracker management** page, select **New tracker**.
1. Provide the following details:
   - **Basic details**: Enter the tracker's name, description, and the domain of the website using the tracker.
   - **Owner**: Assign a user responsible for the tracker.
   - **Tracker category**: Select the category to which the tracker belongs.
1. Select **Save** to add the tracker.

The tracker is added to your list and can be managed like other trackers detected through scans.

### Manage the tracker library

The **Tracker library** is a curated list of approved trackers used across your organization. It supports proactive compliance by ensuring that web engineers use preapproved trackers instead of open-source or unapproved options.

To promote a tracker to the library:

1. Navigate to the **Tracker library** page and select **Manage promoted trackers**.
1. Use the **Your trackers** tab to find trackers discovered through scans or added manually. Alternatively, use the **Common trackers** tab to select trackers from the common tracker database.
1. Select the trackers to promote, then select **Add**.

Promoted trackers appear in the library but can be removed without being deleted from the system.

### Common tracker database

The **Common tracker database** is a reference list of non-Microsoft trackers commonly used on websites. While these trackers aren't initially categorized with your organization's tracker categories, they can be mapped as needed.

:::image type="content" source="../media/common-tracker-database.png" alt-text="Screenshot showing common tracker database in tracker management." lightbox="../media/common-tracker-database.png":::

To map common trackers to your organization's categories:

1. On the **Common tracker database** tab, select **Map categories**.
1. In the **Map tracker categories** flyout pane, use the dropdown menu to map each default category (denoted as **System**) to a category created by your organization.
1. Select **Save** to apply the changes.

The **User-defined category** column now reflects the mapped categories, ensuring consistency across your tracker inventory.

Managing trackers and tracker categories in Microsoft Priva Tracker Scanning is crucial for maintaining an organized inventory of tracking technologies and ensuring compliance with privacy standards. By creating tracker categories, categorizing trackers, and using tools like the tracker library and common tracker database, your organization can streamline tracking practices and support responsible data usage.
