
Microsoft Security Copilot can be accessed through the dedicated site https://securitycopilot.microsoft.com/.  This dedicated site is also referred to as the standalone experience.  It is through the standalone experience that users access the landing page or portal to the platform.

There are some key landmarks on the Security Copilot landing page (portal) to which the user can navigate.

:::image type="content" source="../media/landing-page-landmarks.png" lightbox="../media/landing-page-landmarks.png" alt-text="Screen capture of the landing page for the standalone experience of Microsoft Security Copilot.":::

### Home page

The home page is accessed by selecting the home icon located on the top left corner of the Security Copilot landing page.

:::image type="content" source="../media/home-icon-home-page-v2.png" lightbox="../media/home-icon-home-page-v2.png" alt-text="Screen capture of home menu icon and a screen capture of the home page.":::

From the home page, the user can navigate as follows:

- Back to the landing page by selecting the Home icon.
- My sessions, which lists past sessions created. The user can manage past sessions with search and filter options along with the ability to rename, duplicate, or delete sessions as needed.

    :::image type="content" source="../media/my-sessions.png" lightbox="../media/my-sessions.png" alt-text="Screen capture listing a user's session.":::

- Settings, which include theme preferences along with data and privacy settings.

    :::image type="content" source="../media/preferences-and-privacy.png" lightbox="../media/preferences-and-privacy.png" alt-text="Screen capture showing the options available on the settings page, which include tabs for preferences and data and privacy.":::

- The tenant for which Security Copilot is provisioned. The tenant, which is provisioned for Security Copilot doesn't need to be the tenant your security analyst logs in from.  In the screenshot that follows, security analyst Angus MacGregor uses a Fabrikam account to log in. Security Copilot is provisioned in the Contoso tenant.  By selecting the down arrow, Angus MacGregor is able to select the Contoso tenant.

    :::image type="content" source="../media/tenant-switcher-v3.png" lightbox="../media/tenant-switcher-v3.png" alt-text="Screen capture showing the tenant switching window, with multiple tenants listed.":::

### Plugins

The manage plugins icon is located on the bottom left corner of the home page. To extend the capabilities of Security Copilot, Microsoft has preinstalled a group of plugins - for Microsoft security services and other commonly used services and websites that you can use. You can also add your own custom plugins.  The subsequent unit provides more details on plugins.

:::image type="content" source="../media/plugin-icon-plugin-list.png" lightbox="../media/plugin-icon-plugin-list.png" alt-text="Screen capture showing the plugin icon and the plugin window showing a subset of the plugins.":::

### Help

The help icon on the bottom right of the home page.  From the help page, users can link to documentation, frequently access questions (FAQs), an interactive tour to review key features, and more.

:::image type="content" source="../media/help-to-help-list.png" lightbox="../media/help-to-help-list.png" alt-text="Screen capture showing the help icon and the help window.":::

### Prompt bar

The prompt bar is on the bottom center of the home page. You use the prompt bar to tell Security Copilot what insights you want from your security data, in natural language, then select the run (the icon at the far right of the prompt bar). For those that are relatively new to the security analyst role and engaging with AI, effective prompting may take some practice. For this reason, Security Copilot provides suggestions for prompts and promptbooks that provide a series of preselected prompts.

:::image type="content" source="../media/prompt-bar.png" lightbox="../media/prompt-bar.png" alt-text="Screen capture showing the prompt bar.":::

Even though the prompt bar is at the bottom of the landing page, it really is the center piece of Security Copilot. This is where the user spends their time.  Prompts are the primary input Security Copilot needs to generate answers that can help users in their security-related tasks.  Good prompting is key to getting good results.  To help, Security Copilot provides suggestions and promptbooks.

#### Prompt suggestions

Prompt suggestions are specific, single prompts that you can use in Security Copilot. You can see the available prompt suggestions by typing  forward slash (the "/" symbol) at the prompt bar. The prompt suggestions that are available are determined by the plugins that are enabled.

:::image type="content" source="../media/prompt-suggestions.png" lightbox="../media/prompt-suggestions.png" alt-text="Screen capture showing the available prompt suggestions.":::

Prompt suggestions typically require more input to get a useful response, but Security Copilot will provide that guidance.  As an example, the image that follows shows the information that the user should include for the “GetDefenderIncidents” prompt suggestion.

:::image type="content" source="../media/get-defender-incidents-prompt-suggestion.png" lightbox="../media/get-defender-incidents-prompt-suggestion.png" alt-text="Screen capture showing the required inputs for the Get Defender incident prompt suggestions.":::

#### Promptbooks

Promptbooks are a collection of prompts that have been put together to accomplish specific security-related tasks. Each promptbook requires a specific input (for example, a code snippet or a threat actor name) and then runs a series of prompts in sequence, with one prompt building on the one before it.

You can find the different promptbooks by typing an asterisk (the "*" symbol) at the prompt bar. Then, select a promptbook to open it.

:::image type="content" source="../media/promptbooks.png" lightbox="../media/promptbooks.png" alt-text="Screen capture showing the available promptbooks.":::

#### Feedback

Whether you use promptbooks, prompt suggestions, or your own prompt, providing feedback about your satisfaction with the generated response can help Microsoft in improving Security Copilot. You can find the feedback buttons at the left-hand side of the bottom of every response.

Users can select:

- Looks right
- Needs improvement
- Inappropriate

For each option, the user can enter additional information.  The image that follows shows the options for a response that needs improvement.

:::image type="content" source="../media/feedback-needs-improvement.png" lightbox="../media/feedback-needs-improvement.png" alt-text="Screen capture showing the information a user can provide for a response that needs improvement.":::

#### Process log

Once a prompt is executed, the process log appears that provides information for the steps completed. For example, the process log can provide information on what skill (capability) was selected. This is important because it enables the user to determine whether the response has been generated from a trusted source.

:::image type="content" source="../media/process-log-v2b.png" lightbox="../media/process-log-v2b.png" alt-text="Screen capture showing process log, which shows the selected skill and that a safety check was run on the composed message.":::

#### Pin board

The pin board enables users to keep track of important responses in a session. Users can pin individual or multiple prompt-response pairs.  To select one or more individual items, the user selects the check box next to the item then selects the pin icon. To select all the prompt-response pairs in the session, the user selects checkbox at the top of the session window then selects the pin icon. Upon selecting the pin icon, the pin board window opens in a split view with the session.  The pin board includes a summary tab that summarizes the session and a pinned items tab that lists the prompt and a collapsed view of the response that users can expand.  Users can also edit the title of the session on the pin board.

:::image type="content" source="../media/pin-mapping-to-pin-board.png" lightbox="../media/pin-mapping-to-pin-board.png" alt-text="Screen capture showing the pin icon.  When a prompt response is selected along with the pin icon opens the pin board.":::

The contents of the pin board can be shared so that people in your organization with Security Copilot access can view this session.  Additionally, the contents of the pin board can be exported to Microsoft Word, sent via email, or copied.

:::image type="content" source="../media/share-pinned-item-v2.png" lightbox="../media/share-pinned-item.png" alt-text="Screen capture showing the window that is displayed when a user selects the option to share the pinned item.":::

:::image type="content" source="../media/export-pinned-item-v3.png" lightbox="../media/export-pinned-item-v2.png" alt-text="Screen capture showing the options for exporting a pinned item.":::
