
Threat intelligence analysts struggle with balancing a breadth of threat intelligence ingestion with the analysis of which threat intelligence poses the biggest threats to their organization and/or industry. Similarly, vulnerability intelligence analysts battle correlating their asset inventory with Common Vulnerabilities and Exposures (CVE) information to prioritize the investigation and remediation of the most critical vulnerabilities associated with their organization.

Microsoft Defender Threat Intelligence addresses these challenges by aggregating and enriching critical data sources and displaying them in an innovative, easy-to-use interface. Analysts can then correlate indicators of compromise (IOCs) with related articles, actor profiles, and vulnerabilities. Defender TI also lets analysts collaborate with fellow Defender TI-licensed users within their tenant on investigations.

Microsoft Defender Threat Intelligence functionality includes:

- Threat analytics
- Intel Profiles
- Intel Explorer
- Projects

#### Threat analytics

Threat analytics helps you, as an analyst, understand how emerging threats impact your organization's environment.

Threat analytics reports provide an analysis of a tracked threat and extensive guidance on how to defend against that threat. It also incorporates data from your network, indicating whether the threat is active and if you have applicable protections in place. You can filter and search on reports, but Defender TI also provides a dashboard. 

The threat analytics dashboard highlights the reports that are most relevant to your organization. It summarizes the threats into three categories:

- Latest threats - Lists the most recently published or updated threat reports, along with the number of active and resolved alerts.
- High-impact threats - Lists the threats that have the highest impact to your organization. This section lists threats with the highest number of active and resolved alerts first.
- Highest exposure - Lists threats to which your org has the highest exposure. Your exposure level to a threat is calculated using two pieces of information: how severe the vulnerabilities associated with the threat are, and how many devices in your organization could be exploited by those vulnerabilities.

Each report provides an overview, an analyst report, related incidents, impacted assets, endpoints exposure, and recommended actions.

#### Intel profiles

Intel profiles are a definitive source of Microsoft's shareable knowledge on tracked threat actors, malicious tools, and vulnerabilities. This content is curated and continuously updated by Microsoft's Threat Intelligence experts to provide relevant and actionable threat context.

#### Intel explorer

The intel explorer is where analysts can quickly scan new featured articles and perform a keyword, indicator, or CVE ID search to begin their intelligence gathering, triage, incident response, and hunting efforts.

Microsoft Defender Threat Intelligence articles are narratives that provide insight into threat actors, tooling, attacks, and vulnerabilities. The articles summarize different threats and also link to actionable content and key IOCs to help users take action.

Defender TI offers CVE-ID searches to help users identify critical information about the CVE. CVE-ID searches result in Vulnerability Articles.

#### Intel Projects

Microsoft Defender Threat Intelligence (Defender TI) lets you create projects to organize indicators of interest and indicators of compromise (IOCs) from an investigation. Projects contain a listing of all associated artifacts and a detailed history that retains the names, descriptions, collaborators, and monitoring profiles.

### Microsoft Defender Threat Intelligence in the Microsoft Defender portal

Microsoft Defender TI is experienced through the Microsoft Defender portal.

The Threat intelligence node on the navigation panel of the Microsoft Defender portal is where you can find the Microsoft Defender Threat Intelligence functionality.

:::image type="content" source="../media/threat-intelligence.png" alt-text="A screenshot of the selectable options for threat intelligence on the left navigation panel of the Microsoft Defender portal.":::

To view a screen capture from each of the categories, select the tab from the image that follows. In each case, there's a side panel that shows the embedded Microsoft Security Copilot capability.

# [Threat analytics](#tab/threat-analytics)
:::image type="content" source="../media/threat-analytics.png" lightbox="../media/threat-analytics.png" alt-text="A screenshot of the threat analytics dashboard.":::

# [Intel profiles](#tab/intel-profiles)
:::image type="content" source="../media/intel-profiles.png" lightbox="../media/intel-profiles.png" alt-text="A screenshot of the intel profiles page in threat intelligence.":::

# [Intel explorer](#tab/intel-explorer)
:::image type="content" source="../media/intel-explorer.png" lightbox="../media/intel-explorer.png" alt-text="A screenshot of the intel explorer page in threat intelligence.":::

# [Projects](#tab/projects)
:::image type="content" source="../media/projects.png" lightbox="../media/projects.png" alt-text="A screenshot of the projects page in threat intelligence.":::

---

### Microsoft Security Copilot integration with Microsoft Threat Intelligence

Security Copilot integrates with Microsoft Defender TI. With the Defender TI plugin enabled, Copilot delivers information about threat activity groups, indicators of compromise (IOCs), tools, and contextual threat intelligence. You can use the prompts and promptbooks to investigate incidents, enrich your hunting flows with threat intelligence information, or gain more knowledge about your organization's or the global threat landscape.

Microsoft Defender Threat Intelligence capabilities in Copilot are built-in prompts that you can use, but you can also enter your own prompts based on the capabilities supported. The image that follows shows only a subset of the capabilities supported.

:::image type="content" source="../media/copilot-capabilities.png" lightbox="../media/copilot-capabilities.png" alt-text="Screen capture of the Defender TI system capabilities that can be run in the standalone experience.":::

Copilot also includes a builtin promptbook that deliver information from Defender TI, including:

- Vulnerability impact assessment - Generates a report summarizing the intelligence for a known vulnerability, including steps on how to address it.
- Threat actor profile - Generates a report profiling a known activity group, including suggestions to defend against their common tools and tactics.

Copilot integration with Defender TI can also be experienced through the embedded experience. You can experience Security Copilot's capability to look up threat intelligence in the following pages of the Microsoft Defender portal:

- Threat analytics
- Intel profiles
- Intel explorer
- Intel projects

For each of these pages, you can use one of the available prompts or you can enter your own prompt.

:::image type="content" source="../media/copilot-threat-intelligence.png" lightbox="../media/copilot-threat-intelligence.png" alt-text="Screen capture of the Copilot prompts embedded in Defender TI in the Microsoft Defender portal.":::
