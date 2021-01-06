In addition to assessing and addressing problems with their security configuration, Contoso must also monitor for new problems and threats, and then respond appropriately.

## Azure Sentinel as a SIEM and SOAR solution

Azure Sentinel is both a Security Information and Event Management (SIEM) and Security Orchestration, Automation and Response (SOAR) solution that's designed for hybrid environments.

> [!Note]
> SIEM solutions provide storage and analysis of logs, events, and alerts that other systems generate. You can configure these solutions to raise their own alerts. SOAR solutions support the remediation of vulnerabilities and the overall automation of security processes.

Azure Sentinel uses built-in and custom detections to alert you to potential security threats such as attempts to access Contoso&#39;s resources from outside its infrastructure or when data from Contoso appears to be sent to a known malicious IP address. You can also create incidents based on these alerts.

## Azure Sentinel playbooks

You can create security playbooks in Azure Sentinel to respond to alerts. *Security playbooks* are collections of procedures based on Azure Logic Apps that run in response to an alert. You can run these security playbooks manually in response to your investigation of an incident or you can configure an alert to run a playbook automatically.

With the ability to respond to incidents automatically, you can automate some of your security operations and make your Service Organization Controls (SOC) more productive.

For example, to address Contoso's concerns, you can develop a workflow with defined steps that can block a suspicious username from accessing resources from a non-secure IP address. Alternatively, you can configure the playbook to perform a simple operation such as notifying the SecOps team about a high-level security alert.

## Azure Logic Apps

Azure Logic Apps is a cloud service that automates the operation of your business processes. You use a graphical design tool called the *Logic Apps Designer* to arrange prebuilt components into the sequence you need. You can also use the code view and write your automated process in the JSON file.

## Logic Apps Connector

Logic apps use connectors to connect to hundreds of services. A *connector* is a component that provides an interface to an external service.

> [!NOTE]
> An Azure Sentinel data connector and a Logic Apps connector are not the same thing. An Azure Sentinel data connector connects Azure Sentinel with Microsoft security products and security ecosystems for non-Microsoft solutions. A Logic Apps connector is a component that provides an API connection for an external service and allows integration of events, data, and actions across other apps, services, systems, protocols, and platforms. 

## What are triggers and actions

Azure Logic Apps use triggers and actions, which are defined as follows:

- A *trigger* is an event that occurs when a specific set of conditions is satisfied. Triggers activate automatically when conditions are met. For example, a security incident occurs in Azure Sentinel, which is a trigger for an automated action.
- An *action* is an operation that performs a task in the Logic Apps workflow. Actions run when a trigger activates, another action completes, or a condition is met.

## Azure Sentinel Logic Apps connector

An Azure Sentinel playbook uses an Azure Sentinel Logic Apps connector. It provides the triggers and actions that can start the playbook and perform defined actions.
Currently, there are two triggers from Azure Sentinel Logic Apps connector:

- When a response to an Azure Sentinel alert is triggered
- When Azure Sentinel incident creation rule is triggered

> [!Note]
> Because Azure Sentinel Logic App connector is in preview, the features described in this module might change in the future.

The following table lists all the current actions for the Azure Sentinel connector.

| Name | Description |
| --- | --- |
| Add comment to incident | Adds comments to the selected incident. |
| Add labels to incident | Adds labels to the selected incident. |
| Alert - Get incident | Returns the incident associated with the selected alert. |
| Change incident description | Changes the description for the selected incident. |
| Change incident severity | Changes the severity for the selected incident. |
| Change incident status | Changes the status for the selected incident. |
| Change incident title (V2) | Changes the title for the selected incident. |
| Entities - Get Accounts | Returns a list of accounts associated with the alert. |
| Entities - Get FileHashes | Returns a list of File Hashes associated with the alert. |
| Entities - Get Hosts | Returns a list of hosts associated with the alert. |
| Entities - Get IPs | Returns a list of IPs associated with the alert. |
| Entities - Get URLs | Returns a list of URLs associated with the alert. |
| Remove labels from incident | Removes the labels for the selected incident. |

> [!Note]
> Actions that have **(V2)** or a higher number provide a new version of the action and might differ from the old functionality of the action.

Some actions require integration with actions from another connectors. For example, if Contoso wants to identify all suspicious accounts returned in the alert from the defined entities, you must combine the **Entities - Get Accounts** action with the **For Each** action. Similarly, to get all individual hosts in an incident that detect suspicious hosts, you must combine the **Entities - Get Accounts** action with the **For Each** action.
