
Microsoft Sentinel integrates with Microsoft Security Copilot.

For businesses that are onboarded to Microsoft Security Copilot, the integration is enabled through plugins accessed through the Copilot portal. Sentinel provides two plugins to integrate with Security Copilot:

- Microsoft Sentinel (Preview)
- Natural language to KQL for Microsoft Sentinel (Preview)

:::image type="content" source="../media/sentinel-plugins.png" alt-text="Screen capture showing the Microsoft Sentinel plugins.":::

***Microsoft Sentinel (Preview) plugin***. To utilize the Sentinel plugin, the user would need to be assigned a role permission that grants access to Copilot and a Sentinel specific role like Microsoft Sentinel Reader to access incidents in the workspace.

The Sentinel plugin requires the user to configure the Sentinel workspace, the subscription name, and the resource group name.

:::image type="content" source="../media/sentinel-plugin-configuration.png" lightbox="../media/sentinel-plugin-configuration.png" alt-text="Screen capture showing the Microsoft Sentinel plugin configuration parameters.":::

The Sentinel plugin capabilities are focused on incidents and workspaces. The Microsoft Sentinel capabilities in Copilot are built-in prompts that you can use, but you can also enter your own prompts based on the capabilities supported.

:::image type="content" source="../media/sentinel-prompts.png" alt-text="Screen capture showing the Microsoft Sentinel capabilities.":::

Additionally, Copilot includes a promptbook for Microsoft Sentinel incident investigation. This promptbook includes prompts for getting a report about a specific incident, along with related alerts, reputation scores, users, and devices.

The Microsoft Sentinel incident investigation promptbook is not only a great starting point for your investigation, it's also a starting point for creating effective prompts.

:::image type="content" source="../media/sentinel-promptbook.png" alt-text="Screen capture showing the Microsoft Sentinel incident investigation promptbook.":::

***Natural language to Microsoft Sentinel KQL (Preview) plugin***. The natural language to Sentinel KQL (NL2KQLSentinel) plugin converts any natural-language question in the context of threat hunting, into a ready-to-run KQL query. This saves security teams time by generating a KQL query that can then be automatically run or further tweaked according to the analyst’s needs. The Natural language to KQL for Microsoft Sentinel (Preview) plugin generates and runs KQL hunting queries using Microsoft Sentinel data. This capability is available in the standalone experience and the advanced hunting section of the Microsoft Defender portal.

### Microsoft Sentinel with Copilot in Defender

The integration of Microsoft Sentinel with Copilot can be experienced through both the standalone experience and the embedded experience using the Defender portal.  The embedded experience that is accessed through the Defender portal uses the unified security operations platform with your Microsoft Sentinel data.

***Incidents*** - Microsoft Sentinel incidents are now unified with Defender XDR incidents, so you can use Copilot in Microsoft Defender for incident summary, guided responses and incident reports of Sentinel incidents.

# [Unified incidents](#tab/unified-incidents)

:::image type="content" source="../media/unified-incidents.png" lightbox="../media/unified-incidents.png" alt-text="Screen capture of unified incidents list in the Defender portal.":::

# [Sentinel incident summary](#tab/sentinel-incident-summary)

:::image type="content" source="../media/copilot-incident-summary.png" lightbox="../media/copilot-incident-summary.png" alt-text="Screen capture of the Copilot incident summary for a Sentinel incident, shown in the Defender portal.":::

***Advanced hunting*** - With the Natural language to KQL for Microsoft Sentinel (Preview) plugin enabled, you can generate and run KQL hunting queries using, Microsoft Sentinel data, in the advanced hunting section of the Microsoft Defender portal.

:::image type="content" source="../media/advanced-hunting.png" lightbox="../media/advanced-hunting.png" alt-text="Screen capture of Copilot hunting queries in the Defender portal.":::