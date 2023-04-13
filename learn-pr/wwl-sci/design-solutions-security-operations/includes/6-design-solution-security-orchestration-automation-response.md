## SOAR overview

SIEM/SOC teams are typically inundated with security alerts and incidents on a regular basis, at volumes so large that available personnel are overwhelmed. This results all too often in situations where many alerts are ignored and many incidents aren't investigated, leaving the organization vulnerable to attacks that go unnoticed.

One way to manage this problem is to automate any recurring and predictable enrichment, response, and remediation tasks that are the responsibility of your Security Operations Center and personnel (SOC/SecOps). This frees up time and resources for more in-depth investigation of, and hunting for, advanced threats.

## Microsoft Sentinel as a SOAR solution

Microsoft Sentinel, in addition to being a Security Information and Event Management (SIEM) system, is also a platform for Security Orchestration, Automation, and Response (SOAR). Automation takes a few different forms in Microsoft Sentinel, from automation rules that centrally manage the automation of incident handling and response, to playbooks that run predetermined sequences of actions to provide powerful and flexible advanced automation to your threat response tasks.
<!--
[](https://learn.microsoft.com/azure/sentinel/automation#automation-rules)
-->

### Automation rules

Automation rules allow users to centrally manage the automation of incident handling. Besides letting you assign playbooks to incidents and alerts, automation rules also allow you to automate responses for multiple analytics rules at once, automatically tag, assign, or close incidents without the need for playbooks, create lists of tasks for your analysts to perform when triaging, investigating, and remediating incidents, and control the order of actions that are executed. Automation rules also allow you to apply automations when an incident is **updated** (now in **Preview**), as well as when it's created. This new capability will further streamline automation use in Microsoft Sentinel and will enable you to simplify complex workflows for your incident orchestration processes.

Learn more with this [complete explanation of automation rules](https://learn.microsoft.com/azure/sentinel/automate-incident-handling-with-automation-rules).

<!--
[](https://learn.microsoft.com/azure/sentinel/automation#playbooks)
-->

### Playbooks

A playbook is a collection of response and remediation actions and logic that can be run from Microsoft Sentinel as a routine. A playbook can help automate and orchestrate your threat response, it can integrate with other systems both internal and external, and it can be set to run automatically in response to specific alerts or incidents, when triggered by an analytics rule or an automation rule, respectively. It can also be run manually on-demand, in response to alerts, from the incidents page.

Playbooks in Microsoft Sentinel are based on workflows built in [Azure Logic Apps](https://learn.microsoft.com/azure/logic-apps/logic-apps-overview), a cloud service that helps you schedule, automate, and orchestrate tasks and workflows across systems throughout the enterprise. This means that playbooks can take advantage of all the power and customizability of Logic Apps' integration and orchestration capabilities and easy-to-use design tools, and the scalability, reliability, and service level of a Tier 1 Azure service.

Learn more with this [complete explanation of playbooks](https://learn.microsoft.com/azure/sentinel/automate-responses-with-playbooks).

