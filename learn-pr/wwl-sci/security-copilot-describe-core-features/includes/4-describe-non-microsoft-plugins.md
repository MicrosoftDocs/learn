Microsoft Copilot for Security supports non-Microsoft plugins to extend Copilot's capabilities.  These plugins are categorized as:

- Other
- Websites
- Custom

:::image type="content" source="../media/non-microsoft-plugins-resized.png" lightbox="../media/non-microsoft-plugins-resized.png" alt-text="Screen capture of the non-Microsoft plugins.":::

#### Other plugins

Other plugins give Copilot access to information and capabilities from services beyond Microsoft that your organization uses. Other plugins currently supported include:

- ServiceNow
- Splunk

Access to these plugins assumes an account and license to the specific service and a setup that includes authentication.  The type of authentication required is determined by the plugin provided.  For example, the ServiceNow plugin gives you the option to select from a Basic sign-in or OAuth authorization.

:::image type="content" source="../media/service-now-plugin-authentication.png" lightbox="../media/service-now-plugin-authentication.png" alt-text="Screen capture of the authentication options for the ServiceNow plugin.":::

:::image type="content" source="../media/service-now-oauth.png" lightbox="../media/service-now-oauth.png" alt-text="Screen capture of the authentication settings for the ServiceNow plugin when using oauth authentication.":::

#### Websites

The websites plugins give Copilot access to industry information from the public web.   Currently, only the public web plugin is supported but additional website plugins are expected.

The website plugins are accessed using anonymous authentication.

#### Custom

The Microsoft Copilot for Security platform enables developers and users to write their own plugins that can be invoked to perform specialized tasks. There are two types of custom plugins:

- Custom Copilot plugins that you develop
- Custom plugins developed with OpenAI’s API.

Regardless of the approach, every Copilot plugin requires a YAML or JSON formatted manifest file (for example: plugin.yaml or plugin.json) which describes metadata about the skill set and how to invoke the skills.

:::image type="content" source="../media/custom-plugin-v2.png" lightbox="../media/custom-plugin-v2.png" alt-text="Screen capture of the manage plugins menu, highlighting the custom plugins.":::

:::image type="content" source="../media/custom-plugin-options.png" lightbox="../media/custom-plugin-v2.png" alt-text="Screen capture showing the two types of custom plugins.":::

Once a custom plugin is added, it can be turned on or off, updated, or deleted.  

To Learn more about custom plugins, see [Plugins overview Microsoft Copilot for Security](/security-copilot/plugin_overview).
