Microsoft Security Copilot integrates with various sources, including Microsoft's own security products, non-Microsoft vendors, open-source intelligence feeds, websites, and knowledge bases to generate guidance that's specific to your organization.

One of the mechanisms by which Copilot integrates with these various sources is through plugins. Plugins extend Copilot's capabilities. In this unit, you explore the different categories of plugins available in Security Copilot.

### Plugin categories

Plugins in Security Copilot are organized into the following categories:

- **Microsoft** – Plugins from Microsoft security products and services.
- **Other** – Plugins from non-Microsoft security services.
- **Websites** – Plugins providing access to public web information.
- **Custom** – Plugins you or your organization develop.

### Microsoft plugins

Microsoft plugins give Copilot access to information and capabilities from within your organization's Microsoft products. Security Copilot includes many preinstalled Microsoft plugins. The image that follows shows only a subset of the available Microsoft plugins and the order in which the plugins are listed may vary from what is displayed in the product.

If a Copilot owner has restricted plugin access, then those plugins that have been set to restricted show greyed out and restricted.

# [Plugins](#tab/plugins)
:::image type="content" source="../media/microsoft-plugins.png" lightbox="../media/microsoft-plugins.png" alt-text="Screen capture of plugins page, showing Microsoft plugins.":::

# [Restricted plugins](#tab/restricted-plugins)
:::image type="content" source="../media/restricted-plugins.png" lightbox="../media/restricted-plugins.png" alt-text="Screen capture of the Manage plugins window that shows the Microsoft services.":::

---

For a complete list of all available Microsoft plugins, refer to the [Plugins overview in Microsoft Security Copilot](/copilot/security/plugin-overview) documentation.

> [!NOTE]
> Products that integrate with Security Copilot as plugins need to be purchased separately.

### Key concepts for plugins

There are several key concepts related to plugins that are important for understanding how they work within Security Copilot.

#### Authentication

Microsoft plugins in Copilot generally use the on-behalf-of (OBO) authentication model. This means Copilot knows that a customer has licenses to specific products and is automatically signed into those products. Copilot can then access those products when the plugin is enabled. Some plugins that require setup, as noted by a settings icon or setup button, may include configurable parameters that are used for authentication in lieu of the OBO model.

Non-Microsoft plugins each define their own authentication requirements, which may include API keys, OAuth credentials, or other service-specific credentials.

#### Plugin management

Owners control plugin availability across the organization. By default, all Owners and Contributors have access to preinstalled Microsoft and non-Microsoft plugins. When an owner restricts plugin access, they can set availability to:

- All users
- Owners only

Once access is restricted, new preinstalled plugins are made available to Owners only until configured otherwise. Restricting access is an immediate change that impacts all users of Security Copilot, including embedded experiences.

Some plugins, like Microsoft Sentinel and Azure AI Search, require additional setup. Any plugin with a gear icon or **Set up** button is configured per user.

#### System capabilities

Each enabled plugin exposes system capabilities—specific, single prompts that you can use in Copilot. To view the system capabilities supported by the enabled plugins, select the prompt icon in the prompt bar, and select "See all system capabilities." Selecting a system capability typically requires more input to get a useful response, but Copilot provides guidance.

:::image type="content" source="../media/prompts-to-system-capabilities.png" lightbox="../media/prompts-to-system-capabilities.png" alt-text="Screen capture of the prompt icon that when selected opens the window to select system capabilities.":::

### Examples of Microsoft plugins

The sections that follow provide descriptions of two Microsoft plugins to illustrate the types of capabilities that plugins provide. Microsoft Security Copilot is continually adding support for Microsoft products, and for each plugin the list of capabilities is also growing.

#### Microsoft Defender XDR

Microsoft Defender XDR is a unified pre- and post-breach enterprise defense suite that natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks.

There are two separate plugins in Copilot that relate to Microsoft Defender XDR:

- **Microsoft Defender XDR** – Provides capabilities to summarize incidents, take action on incidents through guided responses, create incident reports, get device summaries, analyze files and scripts, and more.
- **Natural language to KQL for Microsoft Defender XDR** – Converts any natural-language question in the context of threat hunting into a ready-to-run KQL query. This saves security teams time by generating a KQL query that can then be automatically run or further tweaked according to the analyst's needs.

The role permission that grants the user access to Copilot determines the level of access to Microsoft Defender XDR data. There are no additional role permissions required to use the Microsoft Defender XDR plugin or the Natural language to Defender XDR KQL plugin.

Microsoft Defender XDR capabilities in Copilot are built-in prompts that you can use, but you can also enter your own prompts based on the capabilities supported.

:::image type="content" source="../media/defender-xdr-skills.png" lightbox="../media/defender-xdr-skills.png" alt-text="Screen capture of the Defender XDR capabilities that can be run in the standalone experience.":::

Some sample prompts include:

- Summarize incident {incident number}.
- Give me the guided responses for incident {incident number}.
- What devices are involved in incident {incident number}?

Copilot also includes a built-in promptbook for Microsoft Defender XDR incident investigation that you can use to get a report about a specific incident, with related alerts, reputation scores, users, and devices.

With the plugin enabled, Copilot integration with Defender XDR can also be experienced through the embedded experience. The scenarios supported through the embedded experience are described in more detail in the module titled, "Describe the embedded experiences of Microsoft Security Copilot."

#### Microsoft Sentinel

Microsoft Sentinel delivers intelligent security analytics and threat intelligence across the enterprise. With Microsoft Sentinel, you get a single solution for attack detection, threat visibility, proactive hunting, and threat response.

There are two separate plugins in Copilot that relate to Microsoft Sentinel:

- **Microsoft Sentinel** – Provides capabilities focused on incidents and workspaces. It enables analysts to get information about incidents, associated alerts, and workspace data.
- **Natural language to Microsoft Sentinel KQL** – Converts any natural-language question in the context of threat hunting into a ready-to-run KQL query, saving security teams time by generating queries that can then be automatically run or further tweaked.

:::image type="content" source="../media/sentinel-skills-v3.png" lightbox="../media/sentinel-skills-v3.png" alt-text="Screen capture of the Microsoft Sentinel and NL2KQL in Microsoft Sentinel plugin.":::

To use the Microsoft Sentinel plugin, the user needs a role permission that grants access to Copilot and a Microsoft Sentinel-specific role like Microsoft Sentinel Reader to access incidents in the workspace. The Microsoft Sentinel plugin also requires the user to configure the Microsoft Sentinel workspace, the subscription name, and the resource group name.

:::image type="content" source="../media/sentinel-plugin-settings-v2.png" lightbox="../media/sentinel-plugin-settings-v2.png" alt-text="Screen capture of the Microsoft Sentinel plugin settings page.":::

Some sample prompts include:

- Get me the top 5 high severity Microsoft Sentinel incidents.
- Show the most recent incident from Microsoft Sentinel.
- Get Microsoft Sentinel incidents that were assigned to me.

Copilot also includes a promptbook for Microsoft Sentinel incident investigation. This promptbook includes prompts for getting a report about a specific incident, along with related alerts, reputation scores, users, and devices.

### Non-Microsoft plugins

Beyond Microsoft products, Security Copilot also supports non-Microsoft plugins.

#### Other plugins

Other plugins give Copilot access to information and capabilities from non-Microsoft security services your organization uses. The list of supported plugins is continually growing and includes integrations with services like ServiceNow, Splunk, CrowdSec, and GreyNoise.

:::image type="content" source="../media/plugins-other.png" lightbox="../media/plugins-other.png" alt-text="Screen capture of the non-Microsoft plugins.":::

Access to these plugins requires an account and license to the specific service. Each plugin requires its own authentication setup, which may include API keys or other credentials.

#### Website plugins

Website plugins give Copilot access to industry information from the public web. These plugins use anonymous authentication and don't require additional configuration.

:::image type="content" source="../media/plugins-websites.png" lightbox="../media/plugins-websites.png" alt-text="Screen capture of the website plugins.":::

#### Custom plugins

The Security Copilot platform enables developers and users to create their own plugins to perform specialized tasks. There are two types of custom plugins:

- Custom Copilot plugins you develop.
- Custom plugins developed with OpenAI's API.

Every custom plugin requires a YAML or JSON formatted manifest file that describes metadata about the skill set and how to invoke the skills. Owner settings determine who can add and manage custom plugins for themselves and for others in the organization.

:::image type="content" source="../media/custom-plugin-options-v2.png" lightbox="../media/custom-plugin-options-v2.png" alt-text="Screen capture showing the two types of custom plugins.":::

To learn more about custom plugins, see [Create your own custom plugins](/copilot/security/custom-plugins).
