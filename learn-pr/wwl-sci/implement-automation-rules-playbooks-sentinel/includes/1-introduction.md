Contoso Financial Services spent three months building a Microsoft Sentinel workspace and connecting data sources across their hybrid infrastructure. Events are flowing in from Azure Activity logs, Linux trading platforms, and Windows servers—the SOC finally has visibility. What they're discovering now is a problem familiar to every growing operations team: the data is there, but the volume of incidents is outpacing the team's capacity to triage them manually.

Analysts are spending 40% of their shift on repetitive, low-judgment tasks—assigning incidents to the right team, suppressing known-benign alerts during maintenance windows, and copying incident details into their ticketing system. High-severity alerts from the trading platform sit unacknowledged while the team clears a backlog of informational events. The analyst shortage isn't a people problem; it's a workflow problem.

Microsoft Sentinel addresses this with two automation layers designed to work together. Automation rules handle the lightweight, no-code tier: tagging incidents by category, assigning them to the right owner, suppressing noise during known maintenance windows, and closing incidents that match established benign patterns—all without running a workflow engine. Playbooks, built on Azure Logic Apps, handle everything that requires more: querying external threat intelligence APIs, calling the Defender for Endpoint isolation API, posting adaptive notification cards to Teams, and synchronizing incident status with external ticketing systems.

By the end of this module, you'll create automation rules that take over Contoso's incident triage layer, activate a prebuilt notification playbook from Content Hub, and author a custom Logic Apps playbook that gives the SOC a reusable, version-controlled response workflow they can extend as their environment grows.

## Learning objectives

After completing this module, you'll be able to:

- Explain the difference between automation rules and playbooks in Microsoft Sentinel.
- Create automation rules to automate incident management tasks.
- Configure and activate a prebuilt playbook from the Microsoft Sentinel Content Hub.
- Author a custom Logic Apps playbook and connect it to an automation rule.
