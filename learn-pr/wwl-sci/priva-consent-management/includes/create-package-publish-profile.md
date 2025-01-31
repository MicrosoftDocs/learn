Before deploying a consent model, organizations need a way to group multiple models together for efficient management. A consent model package serves as the container that holds one or more consent models, ensuring they apply correctly across different websites and endpoints.

By creating a **consent model package**, you can:

- **Standardize** how consent models are deployed across multiple sites.
- **Group explicit** and implicit consent models based on regulatory needs.
- **Streamline management** by applying changes to multiple models at once.

## Create a consent model package

A consent model package ensures that models are deployed consistently across all necessary locations. Follow these steps to create one:

1. Navigate to the **Packages and publishing** page in consent management and select the Packages tab.
1. Select **New package**.
1. On the **Basic details** page, enter a **Package name**, a **Description**, and select a **Consent model type**:

   - **Tracker consent**: Optionally, enable tracker blocking and unknown tag blocking.
   - **Generic consent**: Group models together and enable consent sharing if needed.

1. Select one or more consent models to include in the package and select **Next**.
1. Choose a fallback consent model for unknown visitor conditions on the **Default consent model** page.
1. Select **Create** to finish setting up the package.

Once created, the package appears in the Packages tab. The status updates from Active to Complete when the configuration file is ready.

## Edit an existing consent model package

After creating a package, you might need to update it. Editing a package allows you to add or remove consent models as your organization's needs change.

To edit a package:

1. Go to the **Packages and publishing** page.
1. Select the **Packages** tab and choose the package you want to edit.
1. Select **Edit**, make the necessary changes, and save.

When a package is modified, the system regenerates the configuration file to reflect the updates.

## Create a publishing profile

A **publishing profile** connects different websites to consent models, ensuring that the correct models apply based on visitor conditions. There are two types of publishing profiles:

- **Storage profile**: Uses an Azure Storage account to store and distribute consent configurations.
- **CDN profile**: Uses a Content Delivery Network (CDN) like Azure or Cloudflare to distribute consent models to websites.

### Create a storage profile

1. On the **Packages and publishing** page, select the **Profiles** tab and select **New profile**.
1. Choose **Storage** and select **Next**.
1. Enter the **Profile Name**, **Description**, and **Contact details**.
1. Select **Azure** as the provider and enter the **Client Credential** name and **Azure Storage subpath**.
1. Select **Save and close**.

### Create a CDN profile

1. On the **Packages and publishing** page, select the **Profiles** tab and select **New profile**.
1. Choose **CDN** and select **Next**.
1. Enter the **Profile Name**, **Description**, and **Contact details**.
1. Select **Azure** or **Cloudflare** as the provider.
1. Enter the **Public endpoint URL** and **Purge URL**.
1. Associate websites and packages with the profile and select **Save and close**.

## Publish and manage profiles

Once a profile is created and its status is Complete, you can:

1. Generate a deployment snippet to apply it to a website.
1. Publish the profile to a CDN for wider distribution.

This ensures that consent models are deployed consistently across multiple websites and that updates are automatically applied when consent models change.
