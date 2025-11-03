
Microsoft Security Copilot can be accessed through the dedicated site https://securitycopilot.microsoft.com. This dedicated site is also referred to as the standalone experience. It is through the standalone experience that users access the landing page or portal to the platform. To ensure that the users can access the features of Copilot, they need to have the appropriate role permissions. For more information on role-based access control for Copilot, see the Assign roles section of [Understand authentication in Microsoft Security Copilot](/security-copilot/authentication?assign-roles).

There are some key landmarks on the Copilot landing page (portal) to which the user can navigate.

- Home menu
- Workspaces
- Prompts to try
- Prompt bar


:::image type="content" source="../media/copilot-landing-page-new-anchors-highlighted-v2.png" lightbox="../media/copilot-landing-page-new-anchors-highlighted-v2.png" alt-text="Screen capture of the landing page for the standalone experience of Microsoft Security Copilot.":::

### Home menu

The home menu is accessed by selecting the hamburger icon located on the top left corner of the Copilot landing page.

:::image type="content" source="../media/home-menu-icon-home-menu-options-agents-v2.png" lightbox="../media/home-menu-icon-home-menu-options-agents-v2.png" alt-text="Screen capture showing the hamburger icon and the page it opens when selected.":::

From the home menu, the user can navigate as follows:

- Active Agents, which are AI-powered assistants built into Microsoft Security Copilot available for you to choose from. Depending on your role, you can either set them up or access the agent to run it. This page lists Microsoft and non-Microsoft agents that offer significant benefits for security teams and IT operations by automating routine tasks and freeing up valuable time for teams to concentrate on strategic initiatives and complex problem-solving.

    :::image type="content" source="../media/agent-list-v3.png" lightbox="../media/agent-list-v3.png" alt-text="Screen capture showing the active agents window.":::

- Promptbooks, which includes builtin and custom promptbooks. Information about each promptbook is provided, including the description, the number of prompts, the owner, and more. Selecting the Get started button opens the promptbook so you can start using it. You can also select the ellipses for more options.

    :::image type="content" source="../media/promptbooks-new-home-screen.png" lightbox="../media/promptbooks-new-home-screen.png" alt-text="Screen capture listing the promptbook library.":::

- Build (preview) takes users to the page where You can extend Security Copilot by building custom agents tailored to your organization's specific security and operational needs. Security Copilot empowers developers to build, test, and publish agents to Security Copilot.   Additional information on Microsoft Security Copilot agents is covered in the training module [Describe Microsoft Security Copilot agents](/training/modules/security-copilot-describe-agents/).

    :::image type="content" source="../media/build-agents-home-screen.png" lightbox="../media/build-agents-home-screen.png" alt-text="Screen capture of the build your own agents window that includes the options to build an agent from scratch or upload a YAML manifest.":::

- History enables users to access their past sessions. For each session, you can view a summary of that session, pin prompts and responses to the pin board, edit prompts, and delete prompts. Currently sessions are kept until they're manually deleted. When a session is deleted, all data associated with that session is marked as deleted and the time to live (TTL) is set to 30 days. After that TTL expires, queries can't access that data. Logs, which contain session data aren't affected when a session is deleted via the in-product UX. These logs have a retention period of up to 90 days.

    :::image type="content" source="../media/history-failed-logins.png" lightbox="../media/history-failed-logins.png" alt-text="Screen capture listing a user's past session.":::

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
      - Decide which new and existing plugins are available to everyone in your organization, and which are restricted to owners only.
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
  - Manage workspaces, where owners can create new workspaces, configure them by assigning access and permissions, and fine-tune settings such as owner roles and plugin configurations. Workspaces are described in more detail in the subsequent unit.
  
       :::image type="content" source="../media/workspace-manage.png" lightbox="../media/workspace-manage.png" alt-text="A screenshot of the manage workspaces page that lists the available workspaces.":::

  - Usage monitoring, which provides a dashboard showing how SCUs are consumed over a period of time by your Microsoft Security Copilot workloads. The usage monitoring dashboard provides visibility, for a selected workspace, into the number of units used, the specific plugins employed during sessions, and the initiators of those sessions. The dashboard also allows you to apply filters and export usage data seamlessly. The dashboard includes up to 90 days of data. When an analyst is in the middle of an investigation and the usage is nearing the provisioned capacity limit (90%), a notification is displayed to the analyst while entering the prompt. The notification informs the analyst to contact the owner to increase the capacity or limit the number of prompts to avoid disruptions. These notifications are also shown in the Security Copilot embedded experiences.
  
    When the provisioned capacity is crossed, the analyst sees an error message stating that due to high usage in organization, they cannot submit additional prompts. The analyst is asked to contact the owner to increase the provisioned SCUs.

    # [Usage monitoring](#tab/usage-monitoring)
    :::image type="content" source="../media/usage-monitoring-dashboard-new.png" lightbox="../media/usage-monitoring-dashboard-new.png" alt-text="Screen capture showing the usage monitoring dashboard.":::

    # [Usage monitoring filters](#tab/usage-monitoring-filters)
    :::image type="content" source="../media/usage-monitoring-filters.png" lightbox="../media/usage-monitoring-filters.png" alt-text="Screen capture showing the usage monitoring filters.":::

    ---

- Security Store, which is integrated into the standalone experience of Microsoft Security Copilot, is Microsoft Security’s new security-optimized storefront enabling organizations to find, try, buy, and deploy Microsoft and partner-built security solutions and agents. These solutions and agents integrate directly with Microsoft Security products such as Microsoft Defender, Microsoft Sentinel, Microsoft Entra, Purview, Intune and Security Copilot, offering a unified experience that simplifies procurement and accelerates time to value.

    :::image type="content" source="../media/security-store.png" lightbox="../media/security-store.png" alt-text="Screen capture showing the Security store landing page.":::

Selecting the ellipses on the bottom left corner of the navigation panel, allows users to view settings, access help options, and select a tenant for use with Copilot Studio.

:::image type="content" source="../media/ellipses-navigation-panel.png" lightbox="../media/ellipses-navigation-panel.png" alt-text="Screen capture showing the options available when a user selects the ellipses on the Copilot navigation panel.":::

- Settings, which include configurable preferences, data and privacy statements, and information about the App version.

  - The preferences settings allow users to configure the theme, language, and time zone. Copilot supports many languages. For detailed information, see [Supported languages](/security-copilot/supported-languages#supported-languages).

  - The data and privacy page provides links to the privacy statement, terms and conditions, and location information for where data is stored.
  
  - The About page provides information of the app version for Copilot.
  
    # [Preferences](#tab/preferences)
    :::image type="content" source="../media/preferences-with-workspaces.png" lightbox="../media/preferences-with-workspaces.png" alt-text="Screen capture showing the preferences that can be configured by any user.":::

    # [Data and privacy](#tab/data-privacy)
    :::image type="content" source="../media/settings-data-privacy.png" lightbox="../media/settings-data-privacy.png" alt-text="Screen capture showing the preferences that can be configured by any user.":::

    ---

- Help enables users to link to documentation and training. If you encounter issues or need to seek assistance, Security Copilot provides an advanced support experience. Depending on your role, the widget allows you to:

    - **Find solutions to common problems**. Anyone with access to Security Copilot can access the self help widget by selecting the help icon then selecting the Help tab. Type your question in the prompt bar and articles related to your search will be surfaced.

    - **Submit a support case to the Microsoft support team**. To open support cases, you must have, at a minimum, a Service Support Administrator OR Helpdesk Administrator role. You can also view your support history.

    # [Find solutions](#tab/find-solutions)
    :::image type="content" source="../media/help-icon-self-help.png" lightbox="../media/help-icon-self-help.png" alt-text="Screen capture showing the self-help prompt bar and articles related to the entered prompt.":::

    # [Get support](#tab/get-support)
    :::image type="content" source="../media/contact-support-tab.png" lightbox="../media/contact-support-tab.png" alt-text="Screen capture showing the form to get support from an agent.":::

    ---


- Tenant switcher. The tenant, which is provisioned for Copilot doesn't need to be the tenant your security analyst logs in from.  Also a user may have access to Security Copilot across multiple tenants. In the screenshot that follows, the user is provisioned only in the "Zava - Private" tenant. If the user had been provisioned in other tenants, they would be listed and the user would be able to select any of the available tenants.

    :::image type="content" source="../media/tenant-switcher-v4.png" lightbox="../media/tenant-switcher-v4.png" alt-text="Screen capture showing the tenant switching window, with multiple tenants listed.":::

### Workspaces

Copilot workspaces are separate work environments within the tenant in which your Copilot instance is operating. One way to think about Copilot workspaces is as separate rooms in a house. Each room is configured to be optimized for its function and the people that use that room. The same is true of Copilot workspaces. Admins set up, configure, and manage individual workspaces for specific team needs.

Selecting workspaces opens the drop-down menu where users can select available workspaces to which they have access and set their preferred workspace in cases where they have access to multiple workspaces. Owners will also have the option to manage workspaces, manage capacity usage, and create a new workspace.

More detailed information is provided in a subsequent unit, dedicated to Copilot workspaces.

:::image type="content" source="../media/workspace-anchor-v2.png" lightbox="../media/workspace-anchor-v2.png" alt-text="A screenshot showing workspace drop-down menu that can be selected from the main landing page.":::

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
