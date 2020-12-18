Azure Sentinel contains powerful query tools that can help you, as part of the Security operations center team, find and isolate security threats and unwanted activity within Contoso's environment.

## Hunt using built-in queries

Azure Sentinel provides powerful hunting search and query tools to hunt for security threats and tactics throughout your environment. Hunting queries enable you to filter through large amounts of events and security data sources to identify potential threats or track down known or expected threats.

You can use the built-in queries in Azure Sentinel's Hunting page to guide your hunting process and pursue the appropriate hunting paths to uncover issues within your environment. Hunting queries can expose issues that aren't significant enough on their own to generate an alert but have occurred frequently enough over time to warrant investigation.

:::image type="content" source="../media/3-hunting-page.png" alt-text="The Hunting page in Azure Sentinel" :::

The hunting page provides a list all hunting queries. You can filter and sort queries by query name, provider, data source, results, and tactics. You can save queries by selecting the Favorites star icon for the query in the list.

>[!TIP]
>When a query is selected as a favorite, it runs automatically each time you open the hunting page.

### Manage hunting queries

When you select a query from the list, the query details display in a new pane. The query details pane contains a description of the query, query code, and other information about the query including related entities and identified tactics. You can run a query interactively by selecting **Run Query** in the details pane.

### Hunt for threats using the MITRE ATT&CK framework

Azure Sentinel uses the MITRE ATT&CK framework to categorize and order queries by tactics. ATT&CK is a knowledge base of tactics and techniques used and observed in the global threat landscape. You can use MITRE ATT&CK to develop and inform your threat hunting models and methods in Azure Sentinel. When threat hunting in Azure Sentinel, you can use the ATT&CK framework to categorize and run queries using the MITRE ATT&CK tactics timeline.

>[!NOTE]
>You can select individual MITRE ATT&CK tactics from the timeline on the Hunting page.

:::image type="content" source="../media/3-attack-timeline.png" alt-text="The MITRE ATT&CK timeline on the Hunting page in Azure Sentinel" :::

Selecting any tactic will filter the available queries by the selected tactic. Tactics include:

- **Initial access**. Tactics used by the adversary to gain entry to a network, such as targeted spear-phishing, exploiting vulnerabilities or configuration weaknesses in public-facing systems.
- **Execution**. Tactics that result in an adversary running their code on a target system. For example, a malicious hacker may run a PowerShell script to download additional attacker tools and/or scan other systems.
- **Persistence**. Tactics that allow an adversary to maintain access to a target system, even following reboots and credential changes. An example of a persistence technique would be an attacker creating a scheduled task that runs their code at a specific time or on reboot.
- **Privilege escalation**. Tactics leveraged by an adversary to gain higher-level privileges on a system, such as local administrator or root.
- **Defense evasion**. Tactics used by attackers to avoid detection. Evasion tactics include hiding malicious code within trusted processes and folders, encrypting or obfuscating adversary code, or disabling security software.
- **Credential access**. Tactics deployed on systems and networks to steal usernames and credentials for reuse.
- **Discovery**. Tactics used by adversaries to obtain information about systems and networks that they are wanting to exploit or use for their tactical advantage.
- **Lateral movement**. Tactics that allow an attacker to move from one system to another within a network. Common techniques include “Pass-the-Hash” methods of authenticating users and the abuse of the remote desktop protocol.
- **Collection**. Tactics used by an adversary to gather and consolidate the information they were targeting as part of their objectives.
- **Command and control**. Tactics leveraged by an attacker to communicate with a system under their control. One example is that an attacker may communicate with a system over an uncommon or high-numbered port to evade detection by security appliances or proxies.
- **Exfiltration**. Tactics used to move data from the compromised network to a system or network fully under control of the attacker.
- **Impact**. Tactics used by an attacker to impact the availability of systems, networks, and data. Methods in this category would include denial of service attacks and disk- or data-wiping software.

## Create custom queries to refine threat hunting

All Azure Sentinel hunting queries use Kusto Query Language (KQL) syntax used in Log Analytics. You can modify a query in the details pane and run the new query or save it as a new query that can be reused within your Azure Sentinel workspace.

You can also create your own custom queries using KQL code to hunt for threats.

:::image type="content" source="../media/3-create-custom-query-page.png" alt-text="The Create custom query page in Azure Sentinel" :::

Custom queries enable you to define the following:

| Query parameter | Description |
|----------------------------------|------------------------------------------------------|
| Name | The name of the custom query |
| Description | A description of your query's functionality |
| Entity mapping | You can map entity types to columns from your query result to populate your query results with more actionable information. Entities can also be mapped using code in your KQL query. |
| Tactics | You can specify the tactics that your query is designed to expose |

Custom queries are listed alongside built-in queries for management.

## Explore the Azure Sentinel repository on GitHub

The Azure Sentinel repository contains out of the box detections, exploration queries, hunting queries, workbooks, playbooks and much more to help you secure your environment and hunt for threats. Microsoft and the Azure Sentinel community contribute to this repo.

The repo contains folders with contributed content for several areas of Azure Sentinel functionality, including hunting queries. You can use the code from these queries to create custom queries in your Azure Sentinel workspace.

Choose the best response for each of the questions below. Then select “Check your answers.”
