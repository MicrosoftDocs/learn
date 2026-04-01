
> [!NOTE]
> The standalone Microsoft Defender Threat Intelligence (Defender TI) product is being retired on August 1, 2026. Its capabilities are converging into Microsoft Defender XDR and Microsoft Sentinel, where threat intelligence features are accessible directly through the Microsoft Defender portal. Existing Defender TI customers have full access to their current experience until retirement.

Microsoft Defender Threat Intelligence (Defender TI) is a threat analysis and intelligence platform designed to help security analysts streamline triage, incident response, threat hunting, vulnerability management, and threat infrastructure analysis workflows.

Security analysts typically spend significant time collecting and correlating data from multiple, disconnected sources—DNS records, WHOIS information, malware databases, and more—before they can make an informed assessment about a suspicious IP address, domain, or host. Defender TI addresses this by aggregating and enriching these critical data sources into a single, unified interface, allowing analysts to focus on deriving insights rather than gathering raw data.

Defenders TI capabilities are accessible through the **Threat intelligence** node in the Microsoft Defender portal.

## Threat intelligence capabilities

### Threat analytics

Threat analytics helps you understand how emerging threats impact your organization's environment. Threat analytics reports provide an analysis of a tracked threat and extensive guidance on how to defend against it. Each report also incorporates data from your own network, indicating whether the threat is active and whether you have applicable protections in place.

The threat analytics dashboard surfaces the reports most relevant to your organization in three categories:

- **Latest threats—the most recently published or updated threat reports, along with the number of active and resolved alerts.
- **High-impact threats—threats with the highest number of active and resolved alerts in your organization.
- **Highest exposure—threats to which your organization has the highest exposure, calculated based on the severity of associated vulnerabilities and the number of devices in your organization that could be exploited.

### Intel profiles

Intel profiles are Microsoft's curated repository of knowledge on tracked threat actors, malicious tools, and vulnerabilities. This content is continuously updated by Microsoft's Threat Intelligence experts to provide relevant, actionable threat context that analysts can use to understand who might be targeting them and how.

### Intel explorer

The Intel explorer is where analysts can scan new featured articles and search by keyword, indicator, or CVE ID to begin intelligence gathering, triage, incident response, and hunting. 

Defender TI articles are narratives that provide insight into threat actors, tooling, attacks, and vulnerabilities. Each article links to actionable content and key indicators of compromise (IOCs) to help analysts take action. Defender TI also supports CVE ID searches, which return **vulnerability articles** that include a description of the CVE, affected components, tailored mitigation guidance, deep and dark web chatter references, and a Defender TI priority score that reflects which vulnerabilities should be remediated first based on exploitability, recency, and linkage to malware.

### Projects

Defender TI lets you create projects to organize indicators of interest and indicators of compromise (IOCs) from an investigation. A project contains a listing of all associated artifacts and a detailed history that retains names, descriptions, collaborators, and monitoring profiles.

## Defender TI in the Microsoft Defender portal

Threat intelligence capabilities are accessed through the **Threat intelligence** node on the navigation panel of the Microsoft Defender portal.

:::image type="content" source="../media/threat-intelligence.png" alt-text="A screenshot of the selectable options for threat intelligence on the left navigation panel of the Microsoft Defender portal.":::

# [Threat analytics](#tab/threat-analytics)
:::image type="content" source="../media/threat-analytics.png" lightbox="../media/threat-analytics.png" alt-text="A screenshot of the threat analytics dashboard.":::

# [Intel profiles](#tab/intel-profiles)
:::image type="content" source="../media/intel-profiles.png" lightbox="../media/intel-profiles.png" alt-text="A screenshot of the intel profiles page in threat intelligence.":::

# [Intel explorer](#tab/intel-explorer)
:::image type="content" source="../media/intel-explorer.png" lightbox="../media/intel-explorer.png" alt-text="A screenshot of the intel explorer page in threat intelligence.":::

# [Projects](#tab/projects)
:::image type="content" source="../media/projects.png" lightbox="../media/projects.png" alt-text="A screenshot of the projects page in threat intelligence.":::

---

## Microsoft Security Copilot integration

Microsoft Security Copilot integrates with Defender TI. With the Defender TI plugin enabled, Copilot delivers information about threat activity groups, indicators of compromise (IOCs), tools, and contextual threat intelligence. You can use prompts and promptbooks to investigate incidents, enrich threat hunting workflows with threat intelligence, or gain deeper knowledge of the global threat landscape.

Copilot includes two built-in promptbooks for Defender TI:

- **Vulnerability impact assessment—generates a report summarizing the intelligence for a known vulnerability, including steps on how to address it.
- **Threat actor profile—generates a report profiling a known threat actor group, including suggestions to defend against their common tools and tactics.

Copilot is also embedded directly in the Threat intelligence section of the Microsoft Defender portal. On any of the following pages, you can use available prompts or enter your own:

- Threat analytics
- Intel profiles
- Intel explorer
- Intel projects

:::image type="content" source="../media/copilot-threat-intelligence.png" lightbox="../media/copilot-threat-intelligence.png" alt-text="Screen capture of the Copilot prompts embedded in Defender TI in the Microsoft Defender portal.":::

### Threat Intelligence Briefing Agent

Security Copilot also includes the **Threat Intelligence Briefing Agent**, an autonomous AI agent that provides security operations teams with regular, customized threat intelligence briefings. The agent autonomously gathers and synthesizes relevant threat intelligence data from various sources and delivers concise, actionable insights to help analysts stay informed about emerging threats and trends. Rather than requiring analysts to manually review threat reports across multiple sources, the Threat Intelligence Briefing Agent surfaces the information most relevant to your organization on an ongoing basis.

