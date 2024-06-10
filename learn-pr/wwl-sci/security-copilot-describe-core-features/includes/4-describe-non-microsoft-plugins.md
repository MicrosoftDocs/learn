Microsoft Copilot for Security supports non-Microsoft plugins to extend Copilot's capabilities. These plugins are categorized as:

- Other
- Websites
- Custom

#### Other plugins

Other plugins give Copilot access to information and capabilities from services beyond Microsoft that your organization uses.

:::image type="content" source="../media/plugins-other.png" lightbox="../media/plugins-other.png" alt-text="Screen capture of the non-Microsoft plugins.":::

The list of Other plugins currently supported is long and continually growing. The list that follows is only a subset of non-Microsoft Plugins currently in preview with Copilot.

- CIRCL Hash Lookup (Preview)
- Copilot for Security Plugin for ServiceNow (Preview)
- Copilot for Security Plugin for Splunk (Preview)
- CrowdSec Threat Intelligence (Preview)
- GreyNoise Community (Preview)
- GreyNoise Enterprise (Preview)

Access to these plugins assumes an account and license to the specific service and a setup that includes authentication. The type of authentication required is determined by the plugin provided. For example, the CrowdSec Threat Intelligence plugin requires an access identifier for API authentication.

:::image type="content" source="../media/crowd-sec-threat-intelligence-authentication.png" lightbox="../media/crowd-sec-threat-intelligence-authentication.png" alt-text="Screen capture of the authentication settings for the CrowdSec Threat Intelligence plugin.":::

#### Websites

The websites plugins give Copilot access to industry information from the public web. Currently, the public web plugin is supported. More website plugins are expected.

The website plugins are accessed using anonymous authentication.

:::image type="content" source="../media/plugins-websites.png" lightbox="../media/plugins-websites.png" alt-text="Screen capture of the website plugins.":::

#### Custom

The Microsoft Copilot for Security platform enables developers and users to write their own plugins that can be invoked to perform specialized tasks.

:::image type="content" source="../media/plugins-custom.png" lightbox="../media/plugins-custom.png" alt-text="Screen capture of the custom plugins.":::

There are two types of custom plugins:

- Custom Copilot plugins that you develop
- Custom plugins developed with OpenAI’s API.

Regardless of the approach, every Copilot plugin requires a YAML or JSON formatted manifest file (for example: plugin.yaml or plugin.json) which describes metadata about the skill set and how to invoke the skills.

Owner settings, described in a previous unit, determines who can add and manage their own custom plugins and who can add and manage custom plugins for everyone in the organization. For Copilot users with the contributor role, availability of the option to set "Who can use this plugin" is dependent on how the owner settings for custom plugins are configured.

:::image type="content" source="../media/custom-plugin-options-v2.png" lightbox="../media/custom-plugin-options-v2.png" alt-text="Screen capture showing the two types of custom plugins.":::

Once a custom plugin is added, it can be turned on or off, updated, or deleted.

To Learn more about custom plugins, see [Plugins overview Microsoft Copilot for Security](/security-copilot/plugin_overview).

Watch this short video, for a summary on setting up non-Microsoft and custom plugins.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=4114bf13-6aa1-46c2-b448-22d982e07538]