
Microsoft Copilot for Security integrates with various sources, including Microsoft's own security products, non-Microsoft vendors, open-source intelligence feeds, websites, and knowledge bases to generate guidance that’s specific to your organization. 

One of the mechanisms by which Copilot integrates to these various sources is through plugins. Plugins extend Copilot’s capabilities. In this unit, you'll explore the Microsoft plugins.

### Microsoft plugins

Microsoft plugins give Copilot access to information and capabilities from within your organization's Microsoft products. The image that follows shows only a subset of the available Microsoft plugins and the order in which the plugins are listed may vary from what is displayed in the product.

:::image type="content" source="../media/microsoft-plugins.png" lightbox="../media/microsoft-plugins.png" alt-text="Screen capture of the Manage plugins window that shows the Microsoft services.":::

Generally speaking, Microsoft plugins in Copilot use the OBO (on behalf of) model – meaning that  Copilot knows that a customer has licenses to specific products and is automatically signed into those products. Copilot can then access the specific products when the plugin is enabled and, where applicable, parameters are configured. Some Microsoft plugins that require setup, as noted by the settings icon or the set up button, may include configurable parameters that are used for authentication in-lieu of the OBO model.

To view the system capabilities supported by the enabled plugins, you select the prompt icon located in the prompt bar and select "See all system capabilities." System capabilities are specific, single prompts that you can use in Copilot. Selecting a system capability typically requires more input to get a useful response, but Copilot provides that guidance.

:::image type="content" source="../media/prompts-to-system-capabilities.png" lightbox="../media/prompts-to-system-capabilities.png" alt-text="Screen capture of the prompt icon that when selected opens the window to select system capabilities.":::

The sections that follow provide brief descriptions for many of the available Microsoft plugins. Microsoft Copilot for Security is continually adding support for Microsoft products.

#### Azure Firewall (Preview)

Azure Firewall is a cloud-native and intelligent network firewall security service that provides best of breed threat protection for your cloud workloads running in Azure. It's a fully stateful firewall as a service with built-in high availability and unrestricted cloud scalability.

The Azure Firewall integration with Copilot helps analysts perform detailed investigations of the malicious traffic intercepted by the intrusion detection and prevention system (IDPS) and/or the threat intelligence capabilities of the firewalls across their environment.

To use the Azure Firewall integration with Copilot:

- The Azure Firewalls to be used with Copilot for Security must be configured with resource specific structured logs for IDPS and these logs must be sent to a Log Analytics workspace.
- The users using the Azure Firewall plugin in Copilot for Security must have the appropriate Azure role-based access control (RBAC) roles to access the Firewall and associated Log Analytics workspace.
- The Azure Firewall plugin in Copilot for Security must be turned on.

Copilot includes built-in system prompts, but you can also enter your own prompts based on the capabilities supported.

:::image type="content" source="../media/azure-firewall-capabilities.png" lightbox="../media/azure-firewall-capabilities.png" alt-text="Screen capture of the Azure Firewall capabilities that can be run in the standalone experience.":::

Example prompts include:

- Has there been any malicious traffic intercepted by my Firewall \<Firewall name>?
- What are the top 20 IDPS hits from the last seven days for Firewall \<Firewall name> in resource group \<resource group name>?
- If I want to make sure all my Firewalls are protected against attacks from signature ID \<ID number>, how do I do this?

#### Azure Web Application Firewall (Preview)

Azure Web Application Firewall (WAF) integration in Copilot for Security enables deep investigation of Azure WAF events. It can help you investigate WAF logs triggered by Azure WAF in a matter of minutes and provide related attack vectors using natural language responses at machine speed. It provides visibility into your environment’s threat landscape. It allows you to retrieve a list of most frequently triggered WAF rules and identify the top offending IPaddresses in your environment.

Copilot for Security integration is supported on both Azure WAF integrated with Azure Application Gateway and Azure WAF integrated with Azure Front Door.

To use the Azure WAF integration in Copilot, the Azure WAF plugin in Copilot for Security must be turned on and configured.

The preview standalone experience in Azure WAF can help you with:

- Providing a list of top Azure WAF rules triggered in the customer environment and generating deep context with related attack vectors.
- Providing a list of malicious IP addresses in the customer environment and generating related threats.
- Summarizing SQL injection(SQLi) attacks.
- Summarizing Cross-site scripting(XSS) attacks.

:::image type="content" source="../media/azure-web-application-firewall-capabilities.png" lightbox="../media/azure-web-application-firewall-capabilities.png" alt-text="Screen capture of the Azure Web Application Firewall capabilities that can be run in the standalone experience.":::

Example prompts include:

- Was there a SQL injection attack in my global WAF in the last day?
- What were the top global WAF rules triggered in the last 24 hours?
- Summarize list of malicious IP addresses in my Azure Front Door WAF in the last six hours?

#### Azure AI Search (Preview)

The Azure AI Search plugin allows you to connect your company’s knowledge bases or repositories to Microsoft Copilot for Security. Details on this plugin and connections to knowledge bases are described in a subsequent unit of this module.

#### Microsoft Entra

Microsoft Entra is a family of multicloud identity and network access solutions that enables organizations to protect any identity and secure access to any resource. It provides a unified platform for identity and network access management, making it easier to secure identities and access to resources across multicloud and hybrid environments.

Copilot for Security integrates with Microsoft Entra. With the Entra plugin enabled, security analysts can instantly get a risk summary, steps to remediate, and recommended guidance for each identity at risk, in natural language. Analysts can use Copilot to guide in the creation of a lifecycle workflow to streamline the process of creating and issuing user credentials and access rights. These and many other Entra capabilities are supported by Copilot.

The screen capture that follows shows only a subset of the capabilities supported by the Entra plugin.

:::image type="content" source="../media/entra-skills.png" lightbox="../media/entra-skills.png" alt-text="Screen capture of the Entra capabilities that can be run in the standalone experience.":::

Copilot integration with Microsoft Entra can be experienced through the standalone or embedded experiences. The scenarios supported through the embedded experience are described in more detail in the module titled, "Describe Microsoft Copilot in Microsoft Defender XDR."

#### Microsoft Intune

Microsoft Intune is a cloud-based endpoint management solution. It manages user access to organizational resources and simplifies app and device management across your many devices, including mobile devices, desktop computers, and virtual endpoints.

Copilot for Security integrates with Microsoft Intune. If Microsoft Intune is available in the same tenant as Copilot and the plugin is enabled, Copilot will be able to get information about your devices, apps, compliance & configuration policies, and policy assignments managed in Intune.

Capabilities supported by the Intune plugin enable a user to:

- Compare different security baselines.
- Get a summary of an existing policy.
- Get policy assignment scope.
- Get the differences or comparisons between two devices.
- Quickly gather details for a device by asking about it.
- Get detailed information about a user's device enrollments and device compliance for troubleshooting or a security investigation.
- And more

To utilize the Microsoft Intune plugin, the user would need to be assigned an Intune service-specific role like the Intune Endpoint Security Manager role in addition to the role permission that grants access to Copilot.

Some sample prompts include:

- What Intune apps are assigned the most?
- How many devices were enrolled in Intune in the last 24 hours?
- What is the hardware configuration difference between the DeviceA and DeviceB devices?

The screen capture that follows shows only a subset of the capabilities supported by the Intune plugin.

:::image type="content" source="../media/intune-skills.png" lightbox="../media/intune-skills.png" alt-text="Screen capture of the Intune prompt suggestions that can be run in the standalone experience.":::

For more information, visit [Microsoft Copilot for Security and Intune](/mem/intune/fundamentals/security-copilot).

#### Microsoft Defender XDR

Microsoft Defender XDR is a unified pre- and post-breach enterprise defense suite that natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks.

There are two separate plugins in Copilot that relate to Microsoft Defender XDR (the user interface may still show Microsoft 365 Defender):

- Microsoft Defender XDR
- Natural language to KQL for Microsoft Defender XDR

The role permission that grants the user access to Copilot determines the level of access to Microsoft Defender XDR data. There are no additional role permissions required to use the Microsoft Defender XDR plugin or the Natural language to Defender XDR KQL plugin.

***Microsoft Defender XDR***

The Microsoft Defender XDR plugin includes capabilities that enable users to:

- Summarize incidents quickly
- Take action on incidents through guided responses.
- Create incident reports
- Get incident guided responses
- Get Defender device summaries
- Analyze files
- more...

The screen capture that follows shows only a subset of the capabilities supported by the Microsoft Defender XDR plugin.

:::image type="content" source="../media/defender-xdr-skills.png" lightbox="../media/defender-xdr-skills.png" alt-text="Screen capture of the Defender XDR capabilities that can be run in the standalone experience.":::

Copilot also includes a builtin promptbook for Microsoft Defender XDR incident investigation you can use to get a report about a specific incident, with related alerts, reputation scores, users, and devices.

With the plugin enabled, Copilot integration with Defender XDR can be experienced through the standalone or embedded experiences. The scenarios supported through the embedded experience are described in more detail in the module titled, "Describe Microsoft Copilot in Microsoft Defender XDR."

***Natural language to KQL for Microsoft Defender***

The Natural language to KQL for Microsoft Defender (NL2KQLDefender) plugin enables query assistant functionality that converts any natural-language question in the context of threat hunting, into a ready-to-run KQL query. The query assistant saves security teams time by generating a KQL query that can then be automatically run or further tweaked according to the analyst’s needs.

#### Microsoft Defender External Attack Surface Management (Defender EASM)

Microsoft Defender External Attack Surface Management (Defender EASM) continuously discovers and maps your digital attack surface to provide an external view of your online infrastructure. This visibility enables security and IT teams to identify unknowns, prioritize risk, eliminate threats, and extend vulnerability and exposure control beyond the firewall. Attack Surface Insights are generated by using vulnerability and infrastructure data to showcase the key areas of concern for your organization.

If you use Defender EASM in the same tenant as Copilot and enable the plugin, Copilot can surface insights from Defender EASM about an organization's attack surface. You can use the system features built into Copilot and use prompts to get more information. This information can help you understand your security posture and mitigate vulnerabilities.

Capabilities supported by the Defender EASM plugin include:

- Get attack surface summary.
- Get attack surface insights.
- Get assets affected by CVEs by priority or CVE ID.
- Get assets by CVSS score.
- Get expired domains.
- Get expired SSL certificates.
- Get SHA1 certificates.
- more...

Some example prompts include:

- Is my external attack surface impacted by CVE-2023-21709?
- Get assets affected by high priority CVSSs in my attack surface.
- How many assets have critical CVSSs for my organization?

The screen capture that follows shows only a subset of the capabilities supported by the EASM plugin.

:::image type="content" source="../media/defender-skills.png" lightbox="../media/defender-skills.png" alt-text="Screen capture of the EASM system capabilities that can be run in the standalone experience.":::

To use this plugin, it's necessary to configure parameters to identify your organization's subscription to Defender EASM.

:::image type="content" source="../media/easm-settings-icon-to-parameters.png" lightbox="../media/easm-settings-icon-to-parameters.png" alt-text="Screen capture of the EASM plugin settings that must be configured.":::

For more information, visit [Microsoft Copilot for Security and Defender EASM](/azure/external-attack-surface-management/easm-copilot).

#### Microsoft Defender Threat Intelligence

Microsoft Defender Threat Intelligence (Defender TI) is a platform that streamlines triage, incident response, threat hunting, vulnerability management, and cyber threat intelligence analyst workflows when conducting threat infrastructure analysis and gathering threat intelligence.

Copilot for Security integrates with Microsoft Defender TI. With the Defender TI plugin enabled, Copilot delivers information about threat activity groups, indicators of compromise (IOCs), tools, and contextual threat intelligence. You can use the prompts and promptbooks to investigate incidents, enrich your hunting flows with threat intelligence information, or gain more knowledge about your organization's or the global threat landscape.

The screen capture that follows shows only a subset of the capabilities supported by the Defender TI plugin.

:::image type="content" source="../media/defender-threat-intelligence-skills.png" lightbox="../media/defender-threat-intelligence-skills.png" alt-text="Screen capture of the Defender TI system capabilities that can be run in the standalone experience.":::

Copilot also includes builtin promptbooks that deliver information from Defender TI, including:

- Vulnerability impact assessment - Generates a report summarizing the intelligence for a known vulnerability, including steps on how to address it.
- Threat actor profile - Generates a report profiling a known activity group, including suggestions to defend against their common tools and tactics.

:::image type="content" source="../media/threat-intelligence-promptbooks.png" lightbox="../media/threat-intelligence-promptbooks.png" alt-text="Screen capture of the Defender TI promptbooks that can be run in the standalone experience.":::

Some sample prompts include:

- Show me the latest threat articles.
- Get threat articles associated with the finance industry.
- Share the technologies that are susceptible to the vulnerability - CVE-2021-44228.
- Summarize the vulnerability CVE-2021-44228.

For more information, visit [Microsoft Copilot for Security and Microsoft Defender Threat Intelligence](/defender/threat-intelligence/security-copilot-and-defender-threat-intelligence).

#### Microsoft Purview

Microsoft Purview is a comprehensive set of solutions that can help your organization govern, protect, and manage data, wherever it lives. Microsoft Purview solutions provide integrated coverage and help address the fragmentation of data across organizations, the lack of visibility that hampers data protection and governance, and the blurring of traditional IT management roles.

The Purview plugin in Copilot for Security, enables you to gain valuable data and user risk insights to help identify the source of an attack and any sensitive data that may be at risk.

The screen capture that follows shows only a subset of the capabilities supported by the Purview plugin.

:::image type="content" source="../media/purview-skills.png" lightbox="../media/purview-skills.png" alt-text="Screen capture of the Purview capabilities.":::

With the plugin enabled, Copilot integration with Purview can be experienced through the standalone or embedded experiences. In either case and because Microsoft  Copilot assumes the permissions of the user when it tries to access the data to answer the queries, you need to have the required permissions to access the data. Also, your organization must be licensed and onboarded to the applicable Microsoft Purview solutions.

In the standalone experience, the capabilities enabled by the Purview plugin can be run as a prompt by selecting that capability and entering the required input.

Copilot capabilities can also be experienced directly from within Purview solutions, through the embedded experience. The scenarios supported through the embedded experience are described in more detail in the module titled, "Describe Microsoft Copilot in Microsoft Purview."

#### Microsoft Sentinel (Preview)

Microsoft Sentinel delivers intelligent security analytics and threat intelligence across the enterprise. With Microsoft Sentinel, you get a single solution for attack detection, threat visibility, proactive hunting, and threat response.

There are two separate plugins in Copilot that relate to Sentinel:

- Microsoft Sentinel ({review})
- Natural language to Microsoft Sentinel KQL (Preview)

:::image type="content" source="../media/sentinel-skills-v3.png" lightbox="../media/sentinel-skills-v3.png" alt-text="Screen capture of the Sentinel and NL2KQK in Sentinel plugin.":::

***Microsoft Sentinel (Preview)***

To utilize the Sentinel plugin, the user would need to be assigned a role permission that grants access to Copilot and a Sentinel specific role like Microsoft Sentinel Reader to access incidents in the workspace.

The Sentinel plugin also requires the user to configure the Sentinel workspace, the subscription name, and the resource group name.

:::image type="content" source="../media/sentinel-plugin-settings-v2.png" lightbox="../media/sentinel-plugin-settings-v2.png" alt-text="Screen capture of the Sentinel plugin settings page.":::

The Sentinel plugin capabilities are focused on incidents and workspaces. Additionally, Copilot includes a promptbook for Microsoft Sentinel incident investigation. This promptbook includes prompts for getting a report about a specific incident, along with related alerts, reputation scores, users, and devices.

:::image type="content" source="../media/sentinel-promptbook.png" lightbox="../media/sentinel-promptbook.png" alt-text="Screen capture of the Sentinel promptbook that can be run in the standalone experience.":::

:::image type="content" source="../media/sentinel-promptbook-incident-investigation.png" lightbox="../media/sentinel-promptbook-incident-investigation.png" alt-text="Screen capture of the Sentinel promptbook prompts.":::

***Natural language to Microsoft Sentinel KQL (Preview)***

The natural language to Sentinel KQL (NL2KQLSentinel) plugin converts any natural-language question in the context of threat hunting, into a ready-to-run KQL query. This saves security teams time by generating a KQL query that can then be automatically run or further tweaked according to the analyst’s needs.
