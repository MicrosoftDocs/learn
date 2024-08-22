
Microsoft Copilot for Security can be accessed through the dedicated site https://securitycopilot.microsoft.com. This dedicated site is also referred to as the standalone experience. It is through the standalone experience that users access the landing page or portal to the platform. To ensure that the users can access the features of Copilot, they need to have the appropriate role permissions. For more information on role-based access control for Copilot, see the Assign roles section of [Understand authentication in Microsoft Copilot for Security](/security-copilot/authentication?assign-roles).

There are some key landmarks on the Copilot landing page (portal) to which the user can navigate.

- Home menu
- Continue your last session
- Get started using these promptbooks
- Prompt bar
- Help

:::image type="content" source="../media/copilot-standalone-landing-page-landmarks-marked-up.png" lightbox="../media/copilot-standalone-landing-page-landmarks-marked-up.png" alt-text="Screen capture of the landing page for the standalone experience of Microsoft Copilot for Security.":::

### Home menu

The home menu is accessed by selecting the hamburger icon located on the top left corner of the Copilot landing page.

:::image type="content" source="../media/home-icon-home-page-v4.png" lightbox="../media/home-icon-home-page-v4.png" alt-text="Screen capture showing the hamburger icon and the page it opens when selected.":::

From the home menu, the user can navigate as follows:

- Back to the landing page by selecting the Home icon.
- My sessions, which list past sessions created. The user can manage past sessions with search and filter options along with the ability to rename, duplicate, or delete sessions as needed. Currently sessions are kept on the My sessions page until they're manually deleted. When a session is deleted, all data associated with that session is marked as deleted and the time to live (TTL) is set to 30 days. After that TTL expires, queries can't access that data. Logs, which contain session data aren't affected when a session is deleted via the in-product UX. These logs have a retention period of up to 90 days.

    :::image type="content" source="../media/my-sessions-v2.png" lightbox="../media/my-sessions-v2.png" alt-text="Screen capture listing a user's session.":::

- The promptbook library, which includes promptbooks builtin and custom promptbooks. Information about each promptbook is provided, including the description, the required inputs, the number of prompts, the owner, and more. From the promptbook library you can run the selected promptbook by selecting the run icon. You can also select the ellipses for more options.

    :::image type="content" source="../media/promptbook-library-v2.png" lightbox="../media/promptbook-library-v2.png" alt-text="Screen capture listing the promptbook library.":::

- Owner specific options, for users configured as owners:

  - Owner settings, which include a link to manage the billing in Azure, the option to change the Security Compute Units (SCUs), and configuration of data sharing options.

    :::image type="content" source="../media/owner-settings-updated-v2.png" lightbox="../media/owner-settings-updated-v2.png" alt-text="Screen capture showing the owner settings.":::

  - Role assignments, where admins can view existing role assignments and assign Copilot roles to users.
  
    :::image type="content" source="../media/role-assignment.png" lightbox="../media/role-assignment.png" alt-text="Screen capture showing the role assignment settings.":::
  
  - Usage monitoring, which provides a dashboard showing how SCUs are consumed over a period of time by your Microsoft Copilot for Security workloads. When an analyst is in the middle of an investigation and the usage is nearing the provisioned capacity limit (90%), a notification is displayed to the analyst while entering the prompt. The notification informs the analyst to contact the owner to increase the capacity or limit the number of prompts to avoid disruptions. These notifications are also shown in Copilot for Security embedded experiences.
  
    When the provisioned capacity is crossed, the analyst sees an error message stating that due to high usage in organization, they cannot submit additional prompts. The analyst is asked to contact the owner to increase the provisioned SCUs.

    :::image type="content" source="../media/usage-monitoring.png" lightbox="../media/usage-monitoring.png" alt-text="Screen capture showing the usage monitoring dashboard.":::

- Settings, which include configurable preferences, data and privacy statements, and information about the App version.

  - The preferences settings allow users to configure the theme, language, and time zone. Copilot supports many languages. For detailed information see [Supported languages](/security-copilot/supported-languages#supported-languages).
   
    For users with owner role permissions, the preferences page includes more configuration options. Owners can configure options plugins, file upload, and the response debugging level.

    :::image type="content" source="../media/settings-preferences-all-user-settings-v2.png" lightbox="../media/settings-preferences-all-user-settings-v2.png" alt-text="Screen capture showing the preferences that can be configured by any user.":::

    :::image type="content" source="../media/settings-preferences-owner-specific-settings.png" lightbox="../media/settings-preferences-owner-specific-settings.png" alt-text="Screen capture showing the preferences that can be configured by owners.":::

  - The data and privacy page provides links to the privacy statement, terms and conditions, and location information for where data is stored.
  
  -  The About page provides information of the app version for Copilot.

- Tenant switcher. The tenant, which is provisioned for Copilot doesn't need to be the tenant your security analyst logs in from. In the screenshot that follows, security analyst Angus MacGregor uses a Fabrikam account to sign in. Copilot is provisioned in the Contoso tenant. By selecting the down arrow, Angus MacGregor is able to select the Contoso tenant.

    :::image type="content" source="../media/tenant-switcher-v3.png" lightbox="../media/tenant-switcher-v3.png" alt-text="Screen capture showing the tenant switching window, with multiple tenants listed.":::

### Continue your last session

The landing page for the standalone experience provides a brief summary of your last few sessions. Selecting any of your past sessions takes you to that session. Similarly, you can select to view all your past sessions, which takes you to the My sessions page, described earlier in this unit.

:::image type="content" source="../media/continue-last-session-mark-up.png" lightbox="../media/continue-last-session-mark-up.png" alt-text="Screen capture showing a brief summary of your last few sessions.":::

### Get started using these promptbooks

Copilot for Security comes with prebuilt promptbooks, a collection of prompts that have been put together to accomplish specific security-related tasks. Each promptbook requires a specific input (for example, a code snippet or a threat actor name) and then runs a series of prompts in sequence, with one prompt building on the one before it.

The landing page of the standalone experience displays cards for a subset of the available promptbooks. Each card includes the title of the promptbook, a brief description, the owner, and the number of prompts in the promptbook.

:::image type="content" source="../media/landing-page-promptbooks-mark-up.png" lightbox="../media/landing-page-promptbooks-mark-up.png" alt-text="Screen capture showing cards for promptbooks on the Copilot landing page.":::

Select the title of the promptbook to open a page with more detailed information for the promptbook, including the input required to run the promptbook and a list of the prompts included. From this page, you can start a new session.

:::image type="content" source="../media/promptbook-example.png" lightbox="../media/promptbook-example.png" alt-text="Screen capture showing information for the Vulnerability Impact Assessment promptbook.":::

For a complete listing of all the available promptbooks, select View promptbook library.

Watch this short video for a summary on using promptbooks.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=7bb51c3d-ba80-430e-b3bc-2eed3942cf70]

### Prompt bar

You use the prompt bar to tell Copilot what insights you want from your security data, in natural language, then select the run icon.

:::image type="content" source="../media/prompt-bar-new.png" lightbox="../media/prompt-bar-new.png" alt-text="Screen capture showing the prompt bar.":::

### Prompts

Good prompting is key to getting good results. For those that are relatively new to the security analyst role and engaging with AI, effective prompting may take some practice. For this reason, Copilot provides suggestions for prompts and promptbooks that provide a series of preselected prompts.

Select the prompts icon located inside the prompt bar, to open a window where you search for and access promptbooks and system capabilities.

:::image type="content" source="../media/prompt-icon-mapping.png" lightbox="../media/prompt-icon-mapping.png" alt-text="Screen capture showing the prompt icon and the window it opens that shows promptbooks and system capabilities, when selected. ":::

#### Promptbooks

As an alternative to accessing promptbooks via the promptbook library, you can access promptbooks by selecting the prompt icon in the prompt bar.

Refer to the section Get started using these promptbooks, described earlier in this unit.

#### System capabilities

System capabilities, often referred to as prompt suggestions, are specific, single prompts that you can use in Copilot. The list displayed when you select the prompt icon is a small subset of all the available system capabilities available to you. To view all the system capabilities available to you, select See all system capabilities. The list displayed may vary, depending on the plugins you enabled. There are some capabilities that aren't tied to a specific plugin and as such are available, independent of the enabled plugins, to users with access to Copilot.

Selecting a system capability (prompt suggestion) typically requires more input to get a useful response, but Copilot provides that guidance. As an example, the image that follows shows the information that the user must include to analyze a script or command.

:::image type="content" source="../media/system-capability-example.png" lightbox="../media/system-capability-example.png" alt-text="Screen capture showing the required input for the Analyze a script or command prompt suggestion.":::

### Sources

Copilot integrates with security-specific sources using plugins and files.

- Plugins - Copilot currently supports plugins for Microsoft's own security products, non-Microsoft products, open-source intelligence feeds,  industry information from the public web, and custom plugins.

- Files - Connections to an organization's knowledge bases gives Copilot more context, resulting in responses that are more relevant, specific, and customized to the user. Uploading a file is one approach that Copilot uses to connect to an organization's knowledge base.

You access and manage sources through the sources icon that is included in the prompt bar. The Manage sources window lists the plugins tab (the default view) and the files tab.

:::image type="content" source="../media/manage-sources-icon-mapping-v3.png" lightbox="../media/manage-sources-icon-mapping-v3.png" alt-text="Screen capture showing the sources icon that when selected allows the user to select plugins or files. The default view opens to the plugins page.":::

Refer to subsequent units in this module for detailed information on plugins and connection to knowledge bases.

### Help

The help icon is located on the bottom right of the Copilot landing page. 

:::image type="content" source="../media/help-to-help-list.png" lightbox="../media/help-to-help-list.png" alt-text="Screen capture showing the help icon and the help window.":::

By selecting the help icon, you can link to documentation, or if you encounter issues or need to seek assistance, Copilot for Security provides a modern and advanced support experience. Depending on your role, the widget allows you to:

- Find solutions to common problems.
- Submit a support case to the Microsoft support team.


***Find solutions to common problems***. Anyone with access to Copilot for Security can access the self help widget by selecting the help icon then selecting the Help tab. Type your question in the prompt bar and articles related to your search will be surfaced.

:::image type="content" source="../media/help-icon-self-help.png" lightbox="../media/help-icon-self-help.png" alt-text="Screen capture showing the self-help prompt bar and articles related to the entered prompt.":::

***Submit a support case to the Microsoft support team***. To open support cases, you must have, at a minimum, a Service Support Administrator OR Helpdesk Administrator role. You can also view your support history.

:::image type="content" source="../media/contact-support-tab.png" lightbox="../media/contact-support-tab.png" alt-text="Screen capture showing the form to get support from an agent.":::

Watch this short video for a tour of Microsoft Copilot for Security.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=3b45ed29-1738-40e8-bc87-696d420155f8]
