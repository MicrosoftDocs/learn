Microsoft Sentinel contains powerful query tools that can help you, as part of the Security Operations Center team, find and isolate security threats and unwanted activity in Contoso's environment.

## Hunt by using built-in queries

You can use the search and query tools in Microsoft Sentinel to hunt for security threats and tactics throughout your environment. These tools let you filter through large amounts of events and security data sources to identify potential threats or track down known or expected threats.

The **Hunting** page in Microsoft Sentinel has built-in queries that can guide your hunting process and help you pursue the appropriate hunting paths to uncover issues in your environment. Hunting queries can expose issues that aren't significant enough on their own to generate an alert but have happened often enough over time to warrant investigation.

:::image type="content" source="../media/3-hunting-page.png" alt-text="Screenshot that shows the Hunting page in Microsoft Sentinel." lightbox="../media/3-hunting-page.png":::

The **Hunting** page provides a list all hunting queries. You can filter and sort queries by name, provider, data source, results, and tactics. You can save queries by selecting the **Favorites** star icon for the query in the list.

>[!TIP]
>When a query is selected as a favorite, it runs automatically each time you open the **Hunting** page.

### Manage hunting queries

When you select a query from the list, the query details appear on a new pane that contains a description, code, and other information about the query. That information includes related entities and identified tactics. You can run a query interactively by selecting **Run Query** on the details pane.

### Hunt for threats by using the MITRE ATT&CK framework

Microsoft Sentinel uses the [MITRE ATT&CK](https://attack.mitre.org) framework to categorize and order queries by tactics. ATT&CK is a knowledge base of tactics and techniques that are used and observed in the global threat landscape. You can use MITRE ATT&CK to develop and inform your threat-hunting models and methods in Microsoft Sentinel. When you're threat hunting in Microsoft Sentinel, you can use the ATT&CK framework to categorize and run queries by using the MITRE ATT&CK tactics timeline.

>[!NOTE]
>You can select individual MITRE ATT&CK tactics from the timeline on the **Hunting** page.

:::image type="content" source="../media/3-attack-timeline.png" alt-text="Screenshot of the tactics timeline on the Hunting page in Microsoft Sentinel." :::

Selecting any tactic filters the available queries by the selected tactic. The following Hunting tactics are from the ATT&CK Enterprise and ICS (Industrial Control Systems) matrices:

- **Reconnaissance**. Tactics that the adversary uses to find information they can use to plan future operations.
- **Resource development**. Tactics that the adversary uses to establish resources they can use to support operations. Resources include infrastructure, accounts, or capabilities.
- **Initial access**. Tactics that the adversary uses to gain entry to a network, by exploiting vulnerabilities or configuration weaknesses in public-facing systems. An example is targeted spear-phishing.
- **Execution**. Tactics that result in an adversary running their code on a target system. For example, a malicious hacker might run a PowerShell script to download more attacker tools and/or scan other systems.
- **Persistence**. Tactics that allow an adversary to maintain access to a target system, even after restarts and credential changes. An example of a persistence technique is an attacker who creates a scheduled task that runs their code at a specific time or on restart.
- **Privilege escalation**. Tactics that an adversary uses to gain higher-level privileges on a system, such as local administrator or root.
- **Defense evasion**. Tactics that attackers use to avoid detection. Evasion tactics include hiding malicious code within trusted processes and folders, encrypting or obfuscating adversary code, or disabling security software.
- **Credential access**. Tactics deployed on systems and networks to steal usernames and credentials for reuse.
- **Discovery**. Tactics that adversaries use to obtain information about systems and networks that they want to exploit or use for their tactical advantage.
- **Lateral movement**. Tactics that allow an attacker to move from one system to another within a network. Common techniques include pass-the-hash methods of authenticating users and abuse of the Remote Desktop Protocol.
- **Collection**. Tactics that an adversary uses to gather and consolidate the information they were targeting as part of their objectives.
- **Command and control**. Tactics that an attacker uses to communicate with a system under their control. One example is an attacker communicating with a system over an uncommon or high-numbered port to evade detection by security appliances or proxies.
- **Exfiltration**. Tactics used to move data from the compromised network to a system or network that's fully under control of the attacker.
- **Impact**. Tactics that an attacker uses to affect the availability of systems, networks, and data. Methods in this category include denial-of-service attacks and disk-wiping or data-wiping software.
- **Impair Process Control**. Tactics the adversary uses to manipulate, disable, or damage physical control processes.
- **Inhibit Response Function**. Tactics the adversary uses to prevent your safety, protection, quality assurance, and operator intervention functions from responding to a failure, hazard, or unsafe state.
- **None**.

## Create custom queries to refine threat hunting

All Microsoft Sentinel hunting queries use Kusto Query Language (KQL) syntax used in Log Analytics. You can modify a query in the details pane and run the new query. Or you can save it as a new query that can be reused in your Microsoft Sentinel workspace.

You can also create your own custom queries by using KQL code to hunt for threats.

:::image type="content" source="../media/3-create-custom-query-page.png" alt-text="Screenshot that shows the page for creating a custom query in Microsoft Sentinel." :::

Custom queries allow you to define the following:

| Query parameter | Description |
|-----------------|-------------|
| Name | Provide a name for the custom query. |
| Description | Provide a description of your query's functionality. |
| Custom query | Your KQL hunting query. |
| Entity mapping | Map entity types to columns from your query result to populate your query results with more actionable information. You can also map entities by using code in your KQL query. |
| Tactics & techniques | Specify the tactics that your query is designed to expose. |

Custom queries are listed alongside built-in queries for management.

## Explore Microsoft Sentinel on GitHub

The [Microsoft Sentinel repository](https://github.com/Azure/Azure-Sentinel) contains out-of-the-box detections, exploration queries, hunting queries, workbooks, playbooks, and more to help you secure your environment and hunt for threats. Microsoft and the Microsoft Sentinel community contribute to this repo.

The repo contains folders with contributed content for several areas of Microsoft Sentinel functionality, including hunting queries. You can use the code from these queries to create custom queries in your Microsoft Sentinel workspace.

Choose the best response for the following question, then select **Check your answers**.
