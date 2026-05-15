Contoso Financial Services' SOC handles roughly 200 incidents per week. Most require the same initial steps: assign the incident to the right team, add a category tag, and check whether the source analytics rule tends toward false positives. These steps don't require judgment—they require consistency. The two problems aren't complexity or ambiguity; they problems are repetition and latency. Microsoft Sentinel addresses both through two automation layers that you choose between based on what the response actually requires.

## Distinguish automation rules from playbooks

**Automation rules** are Microsoft Sentinel's native, no-code incident management layer. They run entirely inside Microsoft Sentinel without invoking an external workflow engine, which makes them fast and easy to audit. An automation rule evaluates a set of conditions against an incident when it's created or updated, then executes a sequence of actions from a fixed set: assign an owner, change severity, add a tag, add a comment, assign analyst tasks, suppress the incident, close it, or run a playbook. You configure automation rules once in the **Automation** page of the Microsoft Defender portal, and they apply automatically to every matching incident.

**Playbooks** are Azure Logic Apps workflows that use the Microsoft Sentinel connector to interact with your workspace. Unlike automation rules—which only take actions built into Microsoft Sentinel—playbooks reach outside the Microsoft Sentinel environment. A playbook can query a threat intelligence API, call the Microsoft Defender for Endpoint isolation endpoint, post an adaptive card to Teams, or write a record to an external ticketing system. Playbooks run when triggered by a Microsoft Sentinel incident or alert, either automatically through an automation rule or manually from an incident's action menu.

The key distinction is scope. Automation rules manage incidents *within* Microsoft Sentinel. Playbooks extend the response *beyond* Microsoft Sentinel into connected services and external systems.

> [!NOTE]
> When your Microsoft Sentinel workspace is onboarded to the Defender portal, incident creation is managed by Defender Extended Detection and Response (XDR). In this configuration, disable incident creation in your Microsoft Sentinel analytics rules to avoid duplicate incidents. Incident-triggered playbooks still work correctly—you trigger them through automation rules rather than through the analytics rule directly.

## Identify when to use automation rules

Automation rules are the right choice when the response is one of Microsoft Sentinel's built-in operations and doesn't require external API calls or conditional branching. Common scenarios for Contoso include:

- **Routing by source**: Automatically assign all incidents from the trading platform analytics rules to the trading security team owner.
- **Suppressing known noise**: Close incidents from a specific analytics rule that consistently produces false positives during a scheduled maintenance window. The rule's expiration setting re-enables it automatically when the window ends.
- **Standardizing tags**: Add a "PCI-in-scope" tag to every incident involving a cardholder data environment system, so the compliance team's incident filter always returns complete results.
- **Triggering a playbook**: Run a Logic Apps playbook as one action within the automation rule, combining Sentinel-native steps with external integration steps in a single coordinated flow.

Automation rules evaluate in priority order. If multiple rules match the same incident, they execute in sequence from lowest to highest priority number, giving you control over exactly which actions run first.

## Identify when to use playbooks

Playbooks are the right choice when the response workflow requires any of the following:

- calling an external API
- making a decision based on data retrieved at runtime
- performing actions across multiple connected services
- building a response pattern that needs version control and reusability

Contoso's security team identified three playbook use cases during their automation planning session:

1. **Incident enrichment**: When a high-severity incident is created, a playbook queries a threat intelligence service for each IP entity in the incident, then adds the reputation score as a comment before the analyst opens the case.
2. **Machine isolation**: If a confirmed malware incident includes a named host entity, the playbook calls the Defender for Endpoint API to isolate the machine, then posts a Teams message to the on-call analyst with the incident URL.
3. **Compliance notification**: When a SharePoint audit alert triggers a Microsoft Sentinel incident, the playbook posts a formatted incident summary to the compliance team's Teams channel and creates a record in Contoso's external compliance tracking system.

None of these workflows are possible with automation rules alone—they all require external API calls or runtime data retrieval.

For Logic Apps plan selection, use the **Consumption plan** for most Microsoft Sentinel playbooks. Consumption plan Logic App is event-driven, cost nothing when idle, and integrate directly with the Microsoft Sentinel connector.

## Combine both tiers into a unified response workflow

You don't have to choose one tier exclusively. The most effective Microsoft Sentinel automation architecture combines both: an automation rule handles the immediate, no-code steps the moment an incident is created, then triggers a playbook for the steps that require external integration.

For Contoso's high-severity trading platform incidents, the workflow looks like this. An automation rule fires immediately when the incident is created, assigns it to the trading security team, adds the "trading-platform" and "PCI-in-scope" tags, and triggers the enrichment playbook. The playbook runs asynchronously—querying threat intelligence, posting the enriched summary to Teams, and adding a comment to the incident. By the time an analyst opens the case, it's already tagged, assigned, enriched, and notified.
