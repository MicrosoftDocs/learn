Microsoft Security Copilot supports non-Microsoft plugins, including third party plugins from vendors including ServiceNow and Splunk, plugins that give Security Copilot access to industry information from the public web, and custom plugins that give Security Copilot access to information and capabilities that you develop or that use OpenAI’s API.

:::image type="content" source="../media/non-microsoft-plugins-resized.png" lightbox="../media/non-microsoft-plugins-resized.png" alt-text="Screen capture of the non-Microsoft plugins.":::


#### Third party  plugins

Third party integration - Give Security Copilot access to information and capabilities from services beyond Microsoft that your organization uses. Currently supported third party plugins include:

- ServiceNow
- Splunk

Access to these plugins requires additional setup that includes authentication.  The type of authentication required is determined by the plugin provided.  For example, the ServiceNow plugin gives users the option to select from a Basic sign-in or OAuth authorization.

:::image type="content" source="../media/service-now-plugin-authentication.png" lightbox="../media/service-now-plugin-authentication.png" alt-text="Screen capture of the authentication options for the ServiceNow plugin.":::

:::image type="content" source="../media/service-now-oauth.png" lightbox="../media/service-now-oauth.png" alt-text="Screen capture of the authentication settings for the ServiceNow plugin when using oauth authentication.":::

For third party products, the flow is that customers will need to provide their credentials when they set up those plugins, which indicate that they need to have an account and license to be integrating those plugins in.

#### Websites

The websites plugins give Security Copilot access to industry information from the public web.   Currently, only the public web plugin is supported but additional website plugins are expected.

The website plugins are accessed using anonymous authentication.

#### Custom

The Security Copilot platform enables developers and users to write their own plugins that can be invoked to perform specialized tasks. There are two types of custom plugins:

- Custom Security Copilot plugins that you develop
- Custom plugins developed with OpenAI’s API.

Regardless of the approach, every Security Copilot plugin requires a YAML or JSON formatted manifest file (for example: plugin.yaml or plugin.json) which describes metadata about the skill set and how to invoke the skills.

:::image type="content" source="../media/custom-plugin-v2.png" lightbox="../media/custom-plugin-v2.png" alt-text="Screen capture of the manage plugins window, highlighting the custom plugins.":::

:::image type="content" source="../media/custom-plugin-options.png" lightbox="../media/custom-plugin-v2.png" alt-text="Screen capture showing the two types of custom plugins.":::

Once a custom plugin is added, it can be turned on or off, updated, or deleted.  

To Learn more about custom plugins, see [Plugins overview Microsoft Security Copilot](/security-copilot/plugin_overview).
