Microsoft Priva Consent Management (preview) allows your organization to build customizable, regulatory-independent consent models. These models can be deployed across multiple regions, supporting your compliance requirements without needing site-specific models.

A consent model defines how an organization collects, manages, and stores user consent for data processing. It ensures users are informed about what data is collected and how it will be used. It also provides them with the option to agree or decline. Implementing a consent model helps organizations:

- Adhere to data protection regulations
- Build trust through transparency
- Empower users to make informed choices
- Reduce legal risks and potential reputational damage

## Types of consent models

Consent management supports two types of consent models:

- **Tracker consent model**: Manages cookies and other tracking technologies. This model controls whether cookies are turned on or off based on user consent. It helps meet regulatory requirements that mandate explicit consent for tracking user behavior online.
- **Generic consent model**: Handles other types of user consent not related to cookies. Organizations can use this model to manage consent for data processing activities that don't involve web tracking.

Choosing the right model depends on how your organization collects and processes user data.

## Implicit and explicit consent types

When setting up consent models, you need to determine whether consent should be explicit or implicit:

- **Explicit consent (opt-in)**: Requires users to affirmatively accept trackers. Nonessential trackers are off by default until the user explicitly grants permission.
- **Implicit consent (opt-out)**: Assumes user consent by default. Nonessential trackers are on by default, and users must take action to opt out.

**Explicit consent** is required in many jurisdictions with strict data protection laws, while **implicit consent** might be permitted in regions with less stringent regulations.

## Models and layout page

The **Models and layout** page is the central location for creating and managing consent models and layouts.

### Consent models tab

Displays all consent models, including details such as:

- **Type**: Tracker or generic
- **Consent type**: Explicit or implicit
- **Status**: Draft, in progress, complete, published

Selecting a model opens its details page, where you can edit, preview, manage translations, and view associated tracker categories.

### Layouts tab

Displays built-in and custom layouts that define the look and feel of the consent experience. You can edit, preview, and associate layouts with consent models.

### Tracker categories tab

Lists tracker categories that help organize different types of trackers. Categories can be created in Priva Tracker Scanning or directly in Consent Management.

## Built-in layouts in consent management

Consent models use layouts to determine how consent experiences appear on a website. Consent management includes built-in system layouts that define how users interact with consent banners, preferences, and pop-ups.

:::image type="content" source="../media/built-in-layout.png" alt-text="Screenshot of built-in consent management layouts, including Preference Layout, Banner Layout, Footer Link Layout, and Single Page Layout." lightbox="../media/built-in-layout.png":::

- **Preference Layout**: Allows users to modify tracker category selections.
- **Banner Layout**: Displays a consent banner with a hyperlink to a second page.
- **Footer Link Layout**: Shows a footer banner with a hyperlink to a second page.
- **Single Page Layout**: Uses a floating pop-up with Accept or Decline options.

When setting up a consent model, you can select one of these layouts. If none of these meet your needs, you can create a custom layout.

## Create a custom layout

Custom layouts allow you to personalize the consent experience to align with your organization's branding and website design. While built-in layouts are available, custom layouts provide a higher level of control and flexibility.

**Steps to create a layout**:

1. Go to the **Models and layout** page.
1. Select the **Layouts** tab, then **New layout**.
1. Enter the **Name**, **Description**, and **Contacts** for the layout.
1. Choose a layout template and customize it.
1. Add components and pages as needed.
1. Save the layout and mark it as complete.

Once a layout is marked complete, it becomes available for use in consent models.

### Create a tracker consent model

To create a tracker consent model:

1. Go to the **Models and layout** page.
1. Select **New consent model** and choose **Tracker consent**.
1. Enter the name, description, owner, target regions, and default language.
1. Select a layout and preview its design.
1. Add banner and preferences text to communicate consent options clearly.
1. Customize the model's appearance and style settings.
1. Preview, save, and close the model.

Once created, the consent model appears in the **Consent models** tab, where you can add translations and manage its settings.

## Add translations

Translations ensure your consent model is accessible to users in different languages. You can add translations using:

- **Manual translation**: Add translations individually for each language.
- **Import translations**: Use a downloadable template to import multiple translations.
- **Auto translation**: Generate machine-based translations for selected languages.

## Preview the consent model

Before deploying a consent model, preview it to verify its content and design:

- **Live preview**: Shows how the model will appear on your website.
- **Mockup preview**: Displays a simple version of the model with translation options.

## Mark as complete

Once you've configured the layout, content, and translations, review all settings. When the model is finalized, select Mark as complete.

A **completed** consent model can be added to a deployment package for use on websites.

## Version history

Consent models retain a version history, allowing you to:

- Access the last **two versions** of a consent model.
- Restore or promote a previous version if needed.

After marking a consent model as complete, create a package to **publish and deploy** it on your website.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
