This unit will discuss solutions for:

1. Incident investigation and response
1. Threat intelligence
1. Threat hunting

### Tools and methods for investigation and response

The Microsoft Defender portal includes tools and methods to automate or otherwise assist in the triage, investigation, and resolution of incidents. These tools are presented in the following table:

| Tool/Method | Description |
| ----------- | ----------- |
| **[Manage](/defender-xdr/manage-incidents) and [investigate](/defender-xdr/investigate-incidents) incidents** | Incident management tasks happen throughout all stages of the incident lifecycle and help to optimize the time spent in your incident workflow and more quickly contain and address threats. For example, during the triage phase, tasks include assigning an owner, severity, and adding tags. Make sure that you prioritize your incidents according to severity and then work through them to investigate. The Microsoft Defender portal presents correlated alerts, assets, investigations, and evidence from across all your assets into an incident to give you a comprehensive look into the entire breadth of an attack, including the incident graph showing the attack's scope and how it spread. Use advanced hunting to search for threats, and get ahead of emerging threats with threat analytics. |
| **[Split incidents into tasks](/defender-xdr/split-incidents-into-tasks)** | Use tasks in the Microsoft Defender portal to investigate and resolve incidents collaboratively across your operations teams. Managing incidents with tasks helps to improve efficiency in incident response and ensure accountability for investigation outcomes. |
| **[Automatically investigate and resolve alerts](/defender-xdr/m365d-autoir)** | If enabled to do so, Microsoft Defender XDR can automatically investigate and resolve alerts from Microsoft 365 and Entra ID sources through automation and artificial intelligence. |
| **[Configure automatic attack disruption actions](/defender-xdr/automatic-attack-disruption)** | Use high-confidence signals collected from Microsoft Defender XDR and Microsoft Sentinel to automatically disrupt active attacks at machine speed, containing the threat and limiting the impact. |
| **[Configure Microsoft Sentinel automation rules](/azure/sentinel/automate-incident-handling-with-automation-rules)** | Use automation rules to automate triage, assignment, and management of incidents, regardless of their source. Help your team's efficiency even more by configuring your rules to apply tags to incidents based on their content, suppress noisy (false positive) incidents, and close resolved incidents that meet the appropriate criteria, specifying a reason and adding comments. |
| **[Proactively hunt with advanced hunting](/defender-xdr/advanced-hunting-overview)** | Use Kusto Query Language (KQL) to proactively inspect events in your network by querying the logs collected in the Defender portal. Advanced hunting supports a guided mode for users looking for the convenience of a query builder. |
| **[Harness AI with Microsoft Copilot for Security](/defender-xdr/security-copilot-in-microsoft-365-defender)** | Add AI to support analysts with complex and time-consuming daily workflows. For example, Microsoft Copilot for Security can help with end-to-end incident investigation and response by providing clearly described attack stories, step-by-step actionable remediation guidance and incident activity summarized reports, natural language KQL hunting, and expert code analysis&mdash;optimizing on SOC efficiency across data from all sources. <br><br>This capability is in addition to the other AI-based functionality that Microsoft Sentinel brings to the unified platform, in the areas of user and entity behavior analytics, anomaly detection, multi-stage threat detection, and more. |


## Threat Intelligence

> [!IMPORTANT]
> Microsoft Defender Threat Intelligence (Defender TI) will be discontinued and merged into Microsoft Defender for a powerful unified experience. Existing customers will continue to have full access to their current Defender TI experience until the product is retired on August 1, 2026. [Learn more](https://techcommunity.microsoft.com/blog/defenderthreatintelligence/mdti-is-converging-into-microsoft-sentinel-and-defender-xdr/4427991)

In today’s rapidly evolving threat landscape, organizations need threat intelligence (TI) that is woven seamlessly into every step of their security operations, delivered exactly when and where it matters most. That’s why Microsoft is converging Microsoft Defender Threat Intelligence (MDTI) directly into Defender XDR and Microsoft Sentinel, which will provide world-class, real-time TI within a unified SecOps experience. 

Finished Threat Intelligence: Defender XDR customers will have access to Microsoft’s comprehensive threat intelligence library via threat reports within [**threat analytics (TA)**](/defender-xdr/threat-analytics). This includes exclusive analyses of threat activity and the detailed content focused on threat actors, threat tooling, and vulnerabilities found in intel profiles. Customers can connect this intelligence to related incidents and affected assets, revealing endpoint vulnerabilities and recommended actions.

The convergence of MDTI’s finished intelligence into threat analytics also introduces threat actor-linked indicators of compromise (IOCs). Security operations and threat intelligence teams can use these IOCs—updated in real time as new evidence emerges from Microsoft researchers—to investigate specific attacker infrastructure and behavior, which supports more effective threat hunting and remediation.

Additionally, the convergence brings MITRE TTPs (tactics, techniques, and procedures) into threat analytics. Understanding TTPs equips organizations to design detections that specifically target the more persistent methods attackers use. By proactively focusing on TTPs, organizations move beyond simply blocking or alerting on IOCs, which helps achieve stronger, more resilient defenses and a proactive security posture.

## Hunting in the Microsoft Defender portal

The following table describes how you can make the most of the Defender portal's hunting tools across all stages of threat hunting:

| Hunting stage | Hunting tools |
| --- | --- |
| **Proactive** - Find the weak areas in your environment before threat actors do. Detect suspicious activity extra early. | - Regularly conduct end-to-end [hunts](/azure/sentinel/hunts) to proactively seek out undetected threats and malicious behaviors, validate hypotheses, and act on findings by creating new detections, incidents, or threat intelligence.<br><br> - Use the [MITRE ATT&CK map](/azure/sentinel/mitre-coverage#use-the-mitre-attck-framework-in-analytics-rules-and-incidents) to identify detection gaps, and then run predefined hunting queries for highlighted techniques.<br><br> - Insert new threat intelligence into proven queries to tune detections and confirm if a compromise is in process.<br><br> - Take proactive steps to build and test queries against data from new or updated sources.<br><br> - Use [advanced hunting](/defender-xdr/advanced-hunting-microsoft-defender) to find early-stage attacks or threats that don't have alerts. |
| **Reactive** - Use hunting tools during an active investigation. | - Use [livestream](/azure/sentinel/livestream) to run specific queries at consistent intervals to actively monitor events.<br><br> - Quickly pivot on incidents with the [**Go hunt**](/defender-xdr/advanced-hunting-go-hunt) button to search broadly for suspicious entities found during an investigation.<br><br> - Use [Security Copilot in advanced hunting](/defender-xdr/advanced-hunting-security-copilot) to generate queries at machine speed and scale. |
| **Post incident** - Improve coverage and insights to prevent similar incidents from recurring. | - Turn successful hunting queries into new [analytics and detection rules](/azure/sentinel/threat-detection), or refine existing ones.<br><br> - [Restore historical data](/azure/sentinel/restore) and [search large datasets](/azure/sentinel/search-jobs?tabs=defender-portal) for specialized hunting as part of full incident investigations. |

### Use the hunting dashboard

The hunting dashboard enables you to run all your queries, or a selected subset, in a single selection. In the Microsoft Sentinel portal, select **Hunting**.

The table shown lists all the queries written by Microsoft's team of security analysts and any extra query you created or modified. Each query provides a description of what it hunts for, and what kind of data it runs on. These queries are grouped by their MITRE ATT&CK **tactics**. The icons categorize the type of threat, such as initial access, persistence, and exfiltration. MITRE ATT&CK **techniques** are shown in the **Techniques** column and describe the specific behavior identified by the hunting query.

:::image type="content" source="../media/hunting-dashboard.png" alt-text="Screenshot showing the Microsoft Sentinel hunting dashboard." lightbox="../media/hunting-dashboard.png":::

Use the hunting dashboard to identify where to start hunting, by looking at result count, spikes, or the change in result count over a 24-hour period. Sort and filter by favorites, data source, MITRE ATT&CK tactic or technique, results, results delta, or results delta percentage. View queries that still need data sources connected, and get recommendations on how to enable these queries.

The following table describes detailed actions available from the hunting dashboard:

| Action | Description  |
| --------- | --------- |
| **See how queries apply to your environment**      | Select the **Run all queries** button, or select a subset of queries using the check boxes to the left of each row and select the **Run selected queries** button. <br><br>Running your queries can take anywhere from a few seconds to many minutes, depending on how many queries are selected, the time range, and the amount of data that is being queried.      |
| **View the queries that returned results**         | After your queries are done running, view the queries that returned results using the **Results** filter: <br>- Sort to see which queries had the most or fewest results. <br>- View the queries that are not at all active in your environment by selecting *N/A* in the **Results** filter. <br>- Hover over the info icon (**i**) next to the *N/A* to see which data sources are required to make this query active.  |
| **Identify spikes in your data**                   | Identify spikes in the data by sorting or filtering on **Results delta** or **Results delta percentage**. <br><br>This compares the results of the last 24 hours against the results of the previous 24-48 hours, highlighting any large differences or relative difference in volume.   |
| **View queries mapped to the MITRE ATT&CK tactic** | The **MITRE ATT&CK tactic bar**, at the top of the table, lists how many queries are mapped to each MITRE ATT&CK tactic. The tactic bar gets dynamically updated based on the current set of filters applied. <br><br>This enables you to see which MITRE ATT&CK tactics show up when you filter by a given result count, a high result delta, *N/A* results, or any other set of filters.        |
| **View queries mapped to MITRE ATT&CK techniques** | Queries can also be mapped to MITRE ATT&CK techniques. You can filter or sort by MITRE ATT&CK techniques using the **Technique** filter. By opening a query, you will be able to select the technique to see the MITRE ATT&CK description of the technique.        |
| **Save a query to your favorites**                 |   Queries saved to your favorites automatically run each time the **Hunting** page is accessed. You can create your own hunting query or clone and customize an existing hunting query template.      |
| **Run queries**                                    |   Select **Run Query** in the hunting query details page to run the query directly from the hunting page. The number of matches is displayed within the table, in the **Results** column. Review the list of hunting queries and their matches.     |
| **Review an underlying query**                     | Perform a quick review of the underlying query in the query details pane. You can see the results by clicking the **View query results** link (below the query window) or the **View Results** button (at the bottom of the pane). The query will open in the **Logs** (Log Analytics) blade, and below the query, you can review the matches for the query.       |