In addition to assessing and addressing problems with their security configuration, Contoso must also monitor for new problems and threats, and respond appropriately. Azure Sentinel is both a Security Information and Event Management (SIEM) and Security Orchestration, Automation and Response (SOAR) solution that&#39;s designed for hybrid environments.

> [!Note]

> SIEM solutions provide storage and analysis of logs, events, and alerts that other systems generate, and you can configure these solutions to raise their own alerts. SOAR solutions support the remediation of vulnerabilities and the overall automation of security processes.

Sentinel uses built-in and custom detections to alert you to potential security threats, for example, attempts to access Contoso&#39;s organization from outside their infrastructure or when data from Contoso appears to be sent to a known malicious IP address. It also enables you to create incidents based on these alerts.

## What are Azure Sentinel Playbooks

Sentinel enables you use security playbooks to respond to alerts. _Security playbooks_ are collections of procedures based on Azure Logic Apps that run in response to an alert. You can run these security playbooks manually in response to your investigation of an incident, or you can configure an alert to run a playbook automatically.

With the ability to respond to incidents automatically, you can automate some of your security operations and make your SOC more productive.

For example, Contoso can develop workflow with defined steps, that can block a suspicious username, access of resources from non-secure IP address, or a simple operation, notifying SecOps teams about high-level security alert.

## What are Azure Logic Apps

Azure Logic Apps is a cloud service that automates the execution of your business processes. You use a graphical design tool called the _Logic Apps Designer_ to arrange pre-made components into the sequence you need.

![](RackMultipart20201028-4-vhhntv_html_1bd4b89b520a5e8c.png)

## What is a Logic Apps Connector

Logic apps use connectors to connect to hundreds of services. A _connector_ is a component that provides an interface to an external service.

## What are triggers and actions

Logic apps use triggers and actions

- A _trigger_ is an event that occurs when a specific set of conditions is satisfied. Triggers activate automatically when conditions are met. For example, a security incident occurs in Azure Sentinel, that is a trigger for an automated action.
- An _action_ is an operation that executes a task in the Logic Apps workflow. Actions run when a trigger activates, or another action completes.

## What is Azure Sentinel Logic Apps connector

Sentinel playbooks use Azure Sentinel Logic Apps connector. It provides triggers and actions that can start the playbook and execute defined actions.

At the time of the writing of this article, there are two triggers from Azure Sentinel Logic Apps connector:

- When a response to an Azure Sentinel alert is triggered
- When Azure Sentinel incident creation rule was triggered

> [!Note]

> Azure Sentinel Logic App connector is in preview, so the features might change in the future.

The following table lists all the current actions for the Azure Sentinel connector:

| Name | Description |
| --- | --- |
| Add comment to incident | Add comments to selected incident |
| Add labels to incident | Add labels to selected incident |
| Alert - Get incident | Returns the incident associated with selected alert |
| Change incident description | Changes description to selected incident |
| Change incident severity | Changes severity to selected incident |
| Change incident status | Changes status to selected incident |
| Change incident title (V2) | Changes title to selected incident |
| Entities - Get Accounts | Returns a list of accounts associated with the alert. |
| Entities - Get FileHashes | Returns a list of File Hashes associated with the alert. |
| Entities - Get Hosts | Returns a list of hosts associated with the alert. |
| Entities - Get IP s | Returns a list of IPs associated with the alert. |
| Entities - Get URLs | Returns a list of URLs associated with the alert. |
| Remove labels from incident | Removes labels to selected incident |
<!-- Remove extra space between "IP" and "s", it should be "IPs" -->
> [!Note]

> Actions that have **(V2)** or higher number provide new version of the action and may differ from the old functionality of the action.

Some actions require integration with actions from another connectors. For example, if Contoso wants to identify all suspicious accounts returned in the alert from the defined Entities, they must combine action **Entities - Get Accounts** with **For Each** action. Similarly, to get all individual hosts in an incident that detect suspicious hosts, they must combine **Entities - Get Accounts** with **For Each** action.
