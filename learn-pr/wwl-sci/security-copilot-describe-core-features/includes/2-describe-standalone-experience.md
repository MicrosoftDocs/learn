
Microsoft Security Copilot can be accessed through the dedicated site https://securitycopilot.microsoft.com. This dedicated site is also referred to as the standalone experience. It is through the standalone experience that users access the landing page or portal to the platform. To ensure that the users can access the features of Copilot, they need to have the appropriate role permissions. For more information on role-based access control for Copilot, see the Assign roles section of [Understand authentication in Microsoft Security Copilot](/security-copilot/authentication?assign-roles).

There are some key landmarks on the Copilot landing page (portal) to which the user can navigate.

- Home menu
- Prompts to try
- Prompt bar
- Help

:::image type="content" source="../media/copilot-landing-page-new-anchors-highlighted.png" lightbox="../media/copilot-landing-page-new-anchors-highlighted.png" alt-text="Screen capture of the landing page for the standalone experience of Microsoft Security Copilot.":::

### Home menu

The home menu is accessed by selecting the hamburger icon located on the top left corner of the Copilot landing page.

:::image type="content" source="../media/home-menu-icon-home-menu-options.png" lightbox="../media/home-menu-icon-home-menu-options.png" alt-text="Screen capture showing the hamburger icon and the page it opens when selected.":::

From the home menu, the user can navigate as follows:

- Back to the landing page by selecting the Home icon.
- My sessions, which list past sessions created. The user can manage past sessions with search and filter options along with the ability to rename, duplicate, or delete sessions as needed. Currently sessions are kept on the My sessions page until they're manually deleted. When a session is deleted, all data associated with that session is marked as deleted and the time to live (TTL) is set to 30 days. After that TTL expires, queries can't access that data. Logs, which contain session data aren't affected when a session is deleted via the in-product UX. These logs have a retention period of up to 90 days.

    :::image type="content" source="../media/my-sessions-v2.png" lightbox="../media/my-sessions-v2.png" alt-text="Screen capture listing a user's session.":::

- The promptbook library, which includes promptbooks builtin and custom promptbooks. Information about each promptbook is provided, including the description, the required inputs, the number of prompts, the owner, and more. From the promptbook library you can run the selected promptbook by selecting the run icon. You can also select the ellipses for more options.

    :::image type="content" source="../media/promptbook-library-v2.png" lightbox="../media/promptbook-library-v2.png" alt-text="Screen capture listing the promptbook library.":::

- Owner specific options, for users configured as owners:

  - Owner settings. These settings include the option to switch Security Compute Units (SCUs) capacity, configure data sharing options to help improve Copilot, allow logging audit data in Microsoft Purview, and configure who can upload files.

    # [Capacity](#tab/capacity)
    :::image type="content" source="../media/owner-settings-capacity.png" lightbox="../media/owner-settings-capacity.png" alt-text="Screen capture showing the owner settings, specifically focused on capacity information.":::

    # [Improve Copilot](#tab/improve-copilot)
    :::image type="content" source="../media/owner-settings-improve-copilot.png" lightbox="../media/owner-settings-improve-copilot.png" alt-text="Screen capture showing the owner settings, specifically focused on data sharing options.":::

    # [Audit logging](#tab/audit-logging)
    :::image type="content" source="../media/owner-settings-logging-audit-data.png" lightbox="../media/owner-settings-logging-audit-data.png" alt-text="Screen capture showing the owner settings, specifically focused on the audit logging option.":::

    # [File upload](#tab/file-upload)
    :::image type="content" source="../media/owner-settings-file-upload.png" lightbox="../media/owner-settings-file-upload.png" alt-text="Screen capture showing the owner settings, specifically focused on the file upload option.":::

---

  - Plugin settings. Owners configure the following:
      - Select who can add and manage their own custom plugins. The available options are Contributors and owners or owners only.
      - Select who can add and manage custom plugins for everyone in the organization. The available options are Contributors and owners or owners only.
      - Decide which new and existing plugins will be available to everyone in your organization, and which will be restricted to owners only.
      - Allow Security Copilot to access data from your Microsoft 365 services. If you choose not to allow Copilot access, users won't be able to use specific plugins, like Microsoft Purview, or connect any future sources of org knowledge that are housed in Microsoft 365 services.
  
    # [Plugin settings](#tab/plugin-settings)
    :::image type="content" source="../media/plugin-settings-no-restrictions.png" lightbox="../media/plugin-settings-no-restrictions.png" alt-text="Screen capture showing the plugin settings page.":::

    # [Restrict plugin access](#tab/restrict-plugin-access)
    :::image type="content" source="../media/plugin-settings-restricted.png" lightbox="../media/plugin-settings-restricted.png" alt-text="Screen capture showing the plugin settings page with restricted access enabled.":::

    ---

  - Role assignments, where admins can view and manage existing role assignments for the Copilot Owner and Copilot Contributor roles. This includes the option to add the recommended roles group.
  
    # [Role assignment](#tab/role-assignment)
    :::image type="content" source="../media/role-assignments-new-edited.png" lightbox="../media/role-assignments-new-edited.png" alt-text="Screen capture showing the role assignment page.":::
  
    # [Recommended roles](#tab/recommended-roles)
    :::image type="content" source="../media/recommended-microsoft-security-roles-origin-list-updated.png" lightbox="../media/recommended-microsoft-security-roles-origin-list-updated.png" alt-text="Screen capture showing the recommended Microsoft Security roles. These include Microsoft Entra, Microsoft Purview, and Microsoft Defender roles.":::

    ---

  - Usage monitoring, which provides a dashboard showing how SCUs are consumed over a period of time by your Microsoft Security Copilot workloads. The usage monitoring dashboard provides visibility into the number of units used, the specific plugins employed during sessions, and the initiators of those sessions. The dashboard also allows you to apply filters and export usage data seamlessly. The dashboard includes up to 90 days of data. When an analyst is in the middle of an investigation and the usage is nearing the provisioned capacity limit (90%), a notification is displayed to the analyst while entering the prompt. The notification informs the analyst to contact the owner to increase the capacity or limit the number of prompts to avoid disruptions. These notifications are also shown in the Security Copilot embedded experiences.
  
    When the provisioned capacity is crossed, the analyst sees an error message stating that due to high usage in organization, they cannot submit additional prompts. The analyst is asked to contact the owner to increase the provisioned SCUs.

    :::image type="content" source="../media/usage-monitoring-dashboard-new.png" lightbox="../media/usage-monitoring-dashboard-new.png" alt-text="Screen capture showing the usage monitoring dashboard.":::

- Settings, which include configurable preferences, data and privacy statements, and information about the App version.

  - The preferences settings allow users to configure the theme, language, and time zone. Copilot supports many languages. For detailed information, see [Supported languages](/security-copilot/supported-languages#supported-languages).

  - The data and privacy page provides links to the privacy statement, terms and conditions, and location information for where data is stored.
  
  - The About page provides information of the app version for Copilot.
  
    # [Preferences](#tab/preferences)
    :::image type="content" source="../media/settings-preferences.png" lightbox="../media/settings-preferences.png" alt-text="Screen capture showing the preferences that can be configured by any user.":::

    # [Data and privacy](#tab/data-privacy)
    :::image type="content" source="../media/settings-data-privacy.png" lightbox="../media/settings-data-privacy.png" alt-text="Screen capture showing the preferences that can be configured by any user.":::

    ---

- Tenant switcher. The tenant, which is provisioned for Copilot doesn't need to be the tenant your security analyst logs in from. In the screenshot that follows, security analyst Angus MacGregor uses a Fabrikam account to sign in. Copilot is provisioned in the Contoso tenant. By selecting the down arrow, Angus MacGregor is able to select the Contoso tenant.

    :::image type="content" source="../media/tenant-switcher-v3.png" lightbox="../media/tenant-switcher-v3.png" alt-text="Screen capture showing the tenant switching window, with multiple tenants listed.":::

### Prompts to try

Prompts are the primary input Security Copilot needs to generate answers that can help you in your security-related tasks. Promptbooks are a series of prompts that have been put together to accomplish specific security-related tasks.

To help introduce the concept of prompting in Security Copilot, a set of prompts and promptbooks are immediately available on the home screen.

You can apply filters to find prompts or promptbooks that are most relevant to you. Narrow down search results by applying multiple filters to better suit your role or scenario.

Customize your search by selecting filters based on:

- Roles - Examples include: CISO, SOC analyst, threat intel analyst, and IT administrator.
- Plugins - Examples include: Microsoft Defender XDR, Microsoft Threat Intelligence, and Natural language to KQL for advanced hunting.

You can also use the search function to look up prompts or promptbooks by title.
     


# [Prompts](#tab/prompts)
:::image type="content" source="../media/copilot-landing-page-prompts-to-try.png" lightbox="../media/copilot-landing-page-prompts-to-try.png" alt-text="Screen capture showing the Copilot landing page with prompts to try.":::

# [Promptbooks](#tab/promptbooks)
:::image type="content" source="../media/copilot-landing-page-promptbooks.png" lightbox="../media/copilot-landing-page-promptbooks.png" alt-text="Screen capture showing the Copilot landing page with promptbooks to try.":::

# [Filter by role](#tab/filter-by-role)
:::image type="content" source="../media/copilot-landing-page-new-prompts-role-filter.png" lightbox="../media/copilot-landing-page-new-prompts-role-filter.png" alt-text="Screen capture showing the Copilot landing page with the role filter drop-down menu shown.":::

# [Filter by plugin](#tab/filter-by-plugin)
:::image type="content" source="../media/copilot-landing-page-new-prompts-plugin-filter.png" lightbox="../media/copilot-landing-page-new-prompts-plugin-filter.png" alt-text="Screen capture showing the Copilot landing page with the plugin filter drop-down menu shown.":::

---

### Prompt bar

You use the prompt bar to tell Copilot what insights you want from your security data, in natural language, then select the run icon.

:::image type="content" source="../media/prompt-bar-new.png" lightbox="../media/prompt-bar-new.png" alt-text="Screen capture showing the prompt bar.":::

In addition to the run icon, the prompt bar include two other icons:

- Prompt icon
- Sources icon

#### Prompt icon

Select the prompt icon located inside the prompt bar, to open a window where you search for and access promptbooks and system capabilities.

:::image type="content" source="../media/prompt-icon-mapping.png" lightbox="../media/prompt-icon-mapping.png" alt-text="Screen capture showing the prompt icon and the window it opens that shows promptbooks and system capabilities, when selected. ":::

System capabilities, often referred to as prompt suggestions, are specific, single prompts that you can use in Copilot. The list displayed when you select the prompt icon is a small subset of all the available system capabilities available to you. To view all the system capabilities available to you, select See all system capabilities. The list displayed may vary, depending on the plugins you enabled. There are some capabilities that aren't tied to a specific plugin and as such are available, independent of the enabled plugins, to users with access to Copilot.

Selecting a system capability (prompt suggestion) typically requires more input to get a useful response, but Copilot provides that guidance. As an example, the image that follows shows the information that the user must include to analyze a script or command.

:::image type="content" source="../media/system-capability-example.png" lightbox="../media/system-capability-example.png" alt-text="Screen capture showing the required input for the Analyze a script or command prompt suggestion.":::

#### Sources icon

Copilot integrates with security-specific sources using plugins and files.

- Plugins - Copilot currently supports plugins for Microsoft's own security products, non-Microsoft products, open-source intelligence feeds,  industry information from the public web, and custom plugins.

- Files - Connections to an organization's knowledge bases gives Copilot more context, resulting in responses that are more relevant, specific, and customized to the user. Uploading a file is one approach that Copilot uses to connect to an organization's knowledge base.

You access and manage sources through the sources icon that is included in the prompt bar. The Manage sources window lists the plugins tab (the default view) and the files tab.

:::image type="content" source="../media/manage-sources-icon-mapping-v3.png" lightbox="../media/manage-sources-icon-mapping-v3.png" alt-text="Screen capture showing the sources icon that when selected allows the user to select plugins or files. The default view opens to the plugins page.":::

Refer to subsequent units in this module for detailed information on plugins and connection to knowledge bases.

### Help

The help icon is located on the bottom right of the Copilot landing page.

:::image type="content" source="../media/help-icon-help-list.png" lightbox="../media/help-icon-help-list.png" alt-text="Screen capture showing the help icon and the help window.":::

By selecting the help icon, you can link to documentation and training, or if you encounter issues or need to seek assistance, Security Copilot provides a modern and advanced support experience. Depending on your role, the widget allows you to:

- **Find solutions to common problems**. Anyone with access to Security Copilot can access the self help widget by selecting the help icon then selecting the Help tab. Type your question in the prompt bar and articles related to your search will be surfaced.

- **Submit a support case to the Microsoft support team**. To open support cases, you must have, at a minimum, a Service Support Administrator OR Helpdesk Administrator role. You can also view your support history.

# [Find solutions](#tab/find-solutions)
:::image type="content" source="../media/help-icon-self-help.png" lightbox="../media/help-icon-self-help.png" alt-text="Screen capture showing the self-help prompt bar and articles related to the entered prompt.":::

# [Get support](#tab/get-support)
:::image type="content" source="../media/contact-support-tab.png" lightbox="../media/contact-support-tab.png" alt-text="Screen capture showing the form to get support from an agent.":::

---
