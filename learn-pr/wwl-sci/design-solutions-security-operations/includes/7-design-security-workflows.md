This unit will discuss solutions for:

1. Incident management and response
1. Threat intelligence
1. Threat hunting

## Incident management and response

The Microsoft Defender portal brings together a unified set of security services to reduce your exposure to security threats, improve your organizational security posture, detect security threats, and investigate and respond to breaches. These services collect and produce signals that are displayed in the portal. The two main kinds of signals are:

- Alerts: Signals that result from various threat detection activities. 

- Incidents: Containers that include collections of related alerts and tell the full story of an attack.

The correlation engines and algorithms in the Microsoft Defender portal automatically aggregate and correlate related alerts together to form incidents that represent these larger attack stories.

The Microsoft Defender portal includes tools and methods to automate or otherwise assist in the triage, investigation, and resolution of incidents. These tools are presented in the following table:

| Tool/Method | Description |
| ----------- | ----------- |
| [Manage](/defender-xdr/manage-incidents) and [investigate](/defender-xdr/investigate-incidents) incidents | Incident management tasks happen throughout all stages of the incident lifecycle and help to optimize the time spent in your incident workflow and more quickly contain and address threats. For example, during the triage phase, tasks include assigning an owner, severity, and adding tags. Make sure that you prioritize your incidents according to severity and then work through them to investigate. The Microsoft Defender portal presents correlated alerts, assets, investigations, and evidence from across all your assets into an incident to give you a comprehensive look into the entire breadth of an attack, including the incident graph showing the attack's scope and how it spread. Use advanced hunting to search for threats, and get ahead of emerging threats with threat analytics. |
| [Split incidents into tasks](/defender-xdr/split-incidents-into-tasks) | Use tasks in the Microsoft Defender portal to investigate and resolve incidents collaboratively across your operations teams. Managing incidents with tasks helps to improve efficiency in incident response and ensure accountability for investigation outcomes. |
| [Automatically investigate and resolve alerts](/defender-xdr/m365d-autoir) | If enabled to do so, Microsoft Defender XDR can automatically investigate and resolve alerts from Microsoft 365 and Entra ID sources through automation and artificial intelligence. |
| [Configure automatic attack disruption actions](/defender-xdr/automatic-attack-disruption) | Use high-confidence signals collected from Microsoft Defender XDR and Microsoft Sentinel to automatically disrupt active attacks at machine speed, containing the threat and limiting the impact. |
| [Configure Microsoft Sentinel automation rules](/azure/sentinel/automate-incident-handling-with-automation-rules) | Use automation rules to automate triage, assignment, and management of incidents, regardless of their source. Help your team's efficiency even more by configuring your rules to apply tags to incidents based on their content, suppress noisy (false positive) incidents, and close resolved incidents that meet the appropriate criteria, specifying a reason and adding comments. |
| [Proactively hunt with advanced hunting](/defender-xdr/advanced-hunting-overview) | Use Kusto Query Language (KQL) to proactively inspect events in your network by querying the logs collected in the Defender portal. Advanced hunting supports a guided mode for users looking for the convenience of a query builder. |
| [Harness AI with Microsoft Copilot for Security](/defender-xdr/security-copilot-in-microsoft-365-defender) | Add AI to support analysts with complex and time-consuming daily workflows. For example, Microsoft Copilot for Security can help with end-to-end incident investigation and response by providing clearly described attack stories, step-by-step actionable remediation guidance and incident activity summarized reports, natural language KQL hunting, and expert code analysis&mdash;optimizing on SOC efficiency across data from all sources. <br><br>This capability is in addition to the other AI-based functionality that Microsoft Sentinel brings to the unified platform, in the areas of user and entity behavior analytics, anomaly detection, multi-stage threat detection, and more. |

## Threat Intelligence

Cyber threat intelligence (CTI) is information describing existing or potential threats to systems and users. This intelligence takes many forms, from written reports detailing a particular threat actor's motivations, infrastructure, and techniques, to specific observations of IP addresses, domains, file hashes, and other artifacts associated with known cyber threats. CTI is used by organizations to provide essential context to unusual activity, so security personnel can quickly take action to protect their people, information, and assets. CTI can be sourced from many places, such as open-source data feeds, threat intelligence-sharing communities, commercial intelligence feeds, and local intelligence gathered in the course of security investigations within an organization.

For security information and event management (SIEM) solutions like Microsoft Sentinel, the most common forms of CTI are threat indicators, also known as Indicators of Compromise (IoC) or Indicators of Attack (IoA). Threat indicators are data that associate observed artifacts such as URLs, file hashes, or IP addresses with known threat activity such as phishing, botnets, or malware. This form of threat intelligence is often called tactical threat intelligence because it can be applied to security products and automation in large scale to detect potential threats to an organization and protect against them. In Microsoft Sentinel, you can use threat indicators to help detect malicious activity observed in your environment and provide context to security investigators to help inform response decisions

Integrate threat intelligence (TI) into Microsoft Sentinel through the following activities:

- Import threat intelligence into Microsoft Sentinel by enabling data connectors to various TI platforms and feeds.

- View imported threat intelligence using queries or advanced search.

- Detect threats and generate security alerts and incidents using the built-in Analytics rule templates based on your imported threat intelligence.

- Visualize key information about your imported threat intelligence in Microsoft Sentinel with the Threat Intelligence workbook.

Microsoft enriches all imported threat intelligence indicators with GeoLocation and WhoIs data, which is displayed together with other indicator details.

Threat Intelligence also provides useful context within other Microsoft Sentinel experiences such as Hunting and Notebooks.

## Hunting in the Microsoft Defender portal

The Defender portal provides effective hunting tools for every stage of threat hunting with unified security operations services.

| Hunting tool | Description |
|---|---|
|[Advanced hunting](/defender-xdr/advanced-hunting-microsoft-defender) | View and query data sources available from Defender portal services and share queries with your team. Use all your existing Microsoft Sentinel workspace content, including queries and functions. |
|[Microsoft Sentinel hunting](/azure/sentinel/hunting) | Hunt for security threats across data sources. Use specialized search and query tools like **hunts**, **bookmarks, and **livestream**. |
|[Go hunt](/defender-xdr/advanced-hunting-go-hunt) | Quickly pivot an investigation to entities found within an incident. |
|[Hunts](/azure/sentinel/hunts) | An end-to-end, proactive threat hunting process with collaboration features. |
|[Bookmarks](/azure/sentinel/bookmarks) | Preserve queries and their results, adding notes and contextual observations.|
|[Livestream](/azure/sentinel/livestream) | Start an interactive hunting session and use any Log Analytics query. |
|[Hunting with summary rules](/azure/sentinel/summary-rules#quickly-find-a-malicious-ip-address-in-your-network-traffic) | Use summary rules to save costs hunting for threats in verbose logs.|
|[MITRE ATT&CK map](/azure/sentinel/mitre-coverage#use-the-mitre-attck-framework-in-analytics-rules-and-incidents) | When creating a new hunting query, select specific tactics and techniques to apply.|
|[Restore historical data](/azure/sentinel/restore) | Restore data from archived logs to use in high performing queries. |
|[Search large data sets](/azure/sentinel/search-jobs?tabs=defender-portal) | Search for specific events in logs up to seven years ago using KQL. |
|[Infrastructure chaining](/defender/threat-intelligence/infrastructure-chaining) | Hunt for new connections between threat actors, group similar attack activity and substantiate assumptions.|
|[Threat explorer](/defender-office-365/threat-explorer-threat-hunting) | Hunt for specialized threats related to email. |

The following table describes how you can make the most of the Defender portal's hunting tools across all stages of threat hunting:

| Hunting stage | Hunting tools |
| --- | --- |
| **Proactive** - Find the weak areas in your environment before threat actors do. Detect suspicious activity extra early. | - Regularly conduct end-to-end **hunts** to proactively seek out undetected threats and malicious behaviors, validate hypotheses, and act on findings by creating new detections, incidents, or threat intelligence.<br><br> - Use the **MITRE ATT&CK map** to identify detection gaps, and then run predefined hunting queries for highlighted techniques.<br><br> - Insert new threat intelligence into proven queries to tune detections and confirm if a compromise is in process.<br><br> - Take proactive steps to build and test queries against data from new or updated sources.<br><br> - Use **advanced hunting** to find early-stage attacks or threats that don't have alerts. |
| **Reactive** - Use hunting tools during an active investigation. | - Use **livestream** to run specific queries at consistent intervals to actively monitor events.<br><br> - Quickly pivot on incidents with the **Go hunt** button to search broadly for suspicious entities found during an investigation.<br><br> - Use **Security Copilot in advanced hunting** to generate queries at machine speed and scale. |
| **Post incident** - Improve coverage and insights to prevent similar incidents from recurring. | - Turn successful hunting queries into new **analytics and detection rules**, or refine existing ones.<br><br> - **Restore historical data** and **search large datasets** for specialized hunting as part of full incident investigations. |
