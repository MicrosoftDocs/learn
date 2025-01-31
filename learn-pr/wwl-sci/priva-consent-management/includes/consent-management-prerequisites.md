Microsoft Priva Consent Management (preview) helps your organization create and manage consent models that are customizable and independent of specific regulations. This allows you to track consumer consent across your entire data estate. Once you've familiarized yourself with the benefits of Microsoft Priva Consent Management, the next step is to set up and manage your consent models. 

## Process overview

To effectively manage consent, follow these steps:

1. **Set up your tracker consent models**:
   - Create tracker categories to organize and manage different types of consent.
   - Optionally, design a custom layout to match your branding.
   - Add or import translations to support multiple languages.
   - Mark the model as complete to prepare it for publishing.

1. **Create a generic consent model**:
   - Skip creating tracker categories.
   - Complete the remaining steps as outlined for tracker consent models.

1. **Generate and deploy a package**:
   - Generate a package for your completed consent model.
   - Configure publishing profiles and deploy using manual downloads, Azure Storage, or content delivery networks (CDNs).

## How to access consent management

To access consent management:

1. Navigate to the Microsoft Priva portal.
1. Select the Consent Management tile from the top row of solutions.
1. If the tile isn't visible, select **View all solutions**, and under the **Privacy** heading, select **Consent Management**.

## Roles and permissions

Assigning the right roles to users in your organization is crucial for effective consent management:

|Role|Description|
|---|----------|
|Privacy Curator |Create consent models<br>Create layouts<br>Generate packages<br>Configure publishing profiles<br>Read reports|
|Privacy Reader |View consent models<br>View layouts<br>Read reports|

For more information on roles and how to assign them, see [Data governance roles and permissions in Microsoft Purview](/purview/data-governance-roles-permissions?azure-portal=true).

## Understand the consent management overview page

The **Overview** page in consent management features a set of setup tasks designed to help users get started efficiently. Completed tasks remain listed on the page for two weeks with a **Completed** status next to their name.

The **Create new** section lets you quickly start a consent model, layout, or publishing profile. These tasks can also be completed on the **Models and Layout** page and the **Packages and Publishing** page.

:::image type="content" source="../media/consent-management-overview.png" alt-text="Screenshot showing the Consent Management Overview page." lightbox="../media/consent-management-overview.png":::

## Create tracker categories

You can automatically link consent models to the tracker categories you create in Priva tracker scanning or in consent management. Set up tracker categories in advance to automatically link them with consent models. For more information on creating a tracker category, see [Create tracker categories and manage trackers in tracker scanning (preview)](/privacy/priva/tracker-scanning-tracker-categories?azure-portal=true).

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
