
Every security program includes multiple workflows for incident response. These processes might include notifying relevant stakeholders, launching a change management process, and applying specific remediation steps. Security experts recommend that you automate as many steps of those procedures as possible. Automation reduces overhead. It can also improve your security by ensuring the process steps are done quickly, consistently, and according to your predefined requirements.

## General incident response workflow

Consider these steps for your incident response workflow:

1. For each incident, begin an [attack and alert investigation and analysis](/microsoft-365/security/defender/investigate-incidents?view=o365-worldwide&preserve-view=true)
2. Perform containment to reduce any additional impact of the attack and eradicate the security threat.
3. Recover from the attack by restoring your tenant resources to the state they were in before the incident.
4. Resolve the incident or escalate to a triage team member if the situation requires some human judgment.
 
## Incident response best practices

With these recommendations, responding to incidents can be done
effectively from technical and operations perspectives.

For the technical aspects of incident response, here are some goals to
consider:

- **Try to identify the scope of the attack operation** - Most adversaries use multiple persistence mechanisms.
- **Identify the objective of the attack, if possible** - Persistent attackers will frequently return for their objective (data/systems) in a future attack.

For security operations (SecOps) aspects of incident response, here are some goals to consider:

- **Staying focused** - Confirm you keep the focus on business-critical data, customer impact, and getting ready for remediation.
- **Providing coordination and role clarity** - Establish distinct roles for operations in support of the crisis team and confirm that technical, legal, and communications teams are keeping each other informed.
- **Keeping your business perspective** - You should always consider the impact on business operations by both adversary actions and your response actions.

## Recovery best practices

Recovering from incidents can be done effectively from both technical and operations perspectives with these recommendations.

For the technical aspects of recovering from an incident, here are some goals to consider:

- **Limit response scope** - Limit your response scope so that recovery operation can be executed within 24 hours or less. Plan a weekend to account for contingencies and corrective actions.
- **Avoid distractions** - Defer long-term security investments like implementing large and complex new security systems or replacing anti-malware solutions until after the recovery operation. Anything that does not have a direct and immediate impact on the current recovery operation is a distraction.

For the operations aspects of recovering from an incident, here are some goals to consider:

- **Have a clear plan and limited scope** - Work closely with your technical teams to build a clear plan with limited scope. While plans may change based on adversary activity or new information, you should work diligently to limit scope expansion and take on additional tasks.
- **Have clear plan ownership** - Recovery operations involve many people doing many different tasks at once, so designate a project lead for the operation for clear decision-making and definitive information to flow among the crisis team.
- **Maintain stakeholder communications** - Work with communication teams to provide timely updates and active expectation management for organizational stakeholders.

## Workflow Automation

There are a few key technologies to be used for workflow automation in Azure:

* **Azure Logic Apps** - Azure Logic Apps is a cloud-based platform for creating and running automated *workflows* that integrate your apps, data, services, and systems. With this platform, you can quickly develop highly scalable integration solutions for your enterprise and business-to-business (B2B) scenarios. As a member of Azure Integration Services, Azure Logic Apps simplifies the way that you connect legacy, modern, and cutting-edge systems across cloud, on premises, and hybrid environments. For more information on Azure Logic Apps, see [Overview for Azure Logic Apps](/azure/logic-apps/logic-apps-overview).

* **Microsoft Defender for Cloud** - the workflow automation feature of Microsoft Defender for Cloud can trigger Logic Apps on security alerts, recommendations, and changes to regulatory compliance. For more information on creating workflow automation with Defender for Cloud, see [Automate responses to Defender for cloud triggers](/azure/defender-for-cloud/workflow-automation)

* **Microsoft Graph security** - With Azure Logic Apps and the Microsoft Graph Security connector, you can improve how your app detects, protects, and responds to threats by creating automated workflows for integrating Microsoft security products, services, and partners. For example, you can create Microsoft Defender for Cloud playbooks that monitor and manage Microsoft Graph Security entities, such as alerts. For more information on the integration, see [Improve threat protection by integrating security operations with Microsoft Graph Security & Azure Logic Apps](/azure/connectors/connectors-integrate-security-operations-create-api-microsoft-graph-security).

* **Microsoft Sentinel** -- Sentinel provides both automation rules and playbooks. Automation rules help you triage incidents by changing incident attributes or running playbooks. Playbooks are collections of procedures that can be run from Microsoft Sentinel in response to an alert or incident.

In Microsoft 365, if your organization is using Microsoft 365 Defender, you can leverage **automated investigation and response (AIR)** capabilities. Depending on how AIR capabilities are configured for your organization, remediation actions are taken automatically or only upon approval by your security operations team. All actions, whether pending or completed, are listed in the Action center. AIR features help your security operations team by:

- Determining whether a threat requires action.
- Taking (or recommending) any necessary remediation actions.
- Determining whether and what other investigations should occur.
- Repeating the process as necessary for other alerts.

For more information on creating automated workflows with various combinations of technologies, see the following articles:

* [Creating a workflow using Defender for Cloud and Azure Logic Apps](/azure/defender-for-cloud/workflow-automation#create-a-logic-app-and-define-when-it-should-automatically-run)
* [Improve threat protection by integrating security operations with Microsoft Graph Security & Azure Logic Apps](/azure/connectors/connectors-integrate-security-operations-create-api-microsoft-graph-security)
* [Tutorial: Use playbooks with automation rules in Microsoft Sentinel](/azure/sentinel/tutorial-respond-threats-playbook)