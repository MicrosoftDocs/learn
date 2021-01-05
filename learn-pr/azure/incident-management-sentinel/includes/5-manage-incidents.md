
After you start using Azure Sentinel to generate incidents, you and the IT team at Contoso will want to investigate those incidents. You can use the advanced investigation and analysis tools to gather information and determine remediation steps.

## Investigate incidents

To identify and resolve security issues at Contoso, you'll first want to investigate any incidents. The **Overview** page in Azure Sentinel provides a list of the most recent incidents for quick reference. For more details and a complete overview of the incidents at Contoso, you'll use the **Incidents** page, which displays all incidents in the current workspace and details about those incidents.

:::image type="content" source="../media/5-incidents-page.png" alt-text="The screenshot displays a list of incidents in Azure Sentinel.":::

From this page, you can take various steps to investigate incidents.

> [!IMPORTANT]
> Azure Active Directory users who investigate incidents must be members of the Directory Reader role.

### Review incidents

The **Incidents** page provides a complete list of incidents in Azure Sentinel. It also provides basic incident information, including severity, ID, title, alerts, product names, created time, last update time, owner, and status. You can sort by any incident column and filter the incident list by name, severity, status, product name, or owner.

Selecting any incident will display more information about the incident in the **Details** column. This information can help you clarify the nature, context, and course of action for an incident.

### Examine incident details

The **Incident details** page provides a description of the incident and lists the evidence, entities, and tactics related to the incident. It also contains links to associated workbooks and the analytic rule that generated the incident.

:::image type="content" source="../media/5-incident-details.png" alt-text="The screenshot displays the page for incident details." :::

You can reference all these details to better understand the context of the incident. For example, in a brute force attack incident, you might go to the Log Analytics query for the alert to determine the number of attacks made.

### Manage incident ownership, status, and severity

Each incident created in Azure Sentinel has manageable metadata attached to it. This information can help you:

- Set and track the status of an incident from creation to resolution.
- Set and review severity.
- Assign and track ownership for the incident.

:::image type="content" source="../media/5-incident-settings.png" alt-text="The screenshot displays the section of the Incidents page where you can assign ownership, status, and severity." :::

#### Ownership

In a typical environment, each incident should be assigned an owner from your security team. The incident owner is responsible for overall management of the incident, including investigation and status updates. You can change ownership at any time to assign the incident to another security team member for further investigation or escalation.

#### Status

Every new incident that's created in Azure Sentinel is assigned a status of **New**. As you review and respond to incidents at Contoso, you'll manually change the status to reflect the current state of the incident. For incidents under investigation, set the status to **Active**. When an incident is fully resolved, set the status to **Closed**. 

When you set the status to **Closed**, you'll be prompted to choose one of the following from a drop-down list:

- **True Positive**: suspicious activity
- **Benign Positive**: suspicious but expected
- **False Positive**: incorrect alert logic
- **False Positive**: incorrect data
- **Undetermined**

#### Severity

Incident severity is set by the rule or Microsoft security source from which the incident is generated. In most cases, incident severity remains unchanged. But you might manually set the severity if you decide that the incident is more or less severe than initially classified. Severity options include **Informational**, **Low**, **Medium**, and **High**.

### Perform deep analysis with an investigation graph

You can further investigate an incident by selecting **Investigate** on the **Incident details** page. This action opens the investigation graph, a visual tool that helps to identify entities involved in the attack and the relationships between those entities. If the incident involves multiple alerts over time, you can also review the alert timeline and correlations between alerts.

:::image type="content" source="../media/5-investigation-graph.png" alt-text="The screenshot shows the investigation graph.":::

#### Review entity details

You can select each entity on the graph to observe more information about the entity. This information includes relationships to other entities, account usage, and data flow information. For each information area, you can go to the related events in Log Analytics and add the related alert data into the graph.

#### Review incident details

You can select the incident item on the graph to observe important incident metadata related to the incident's security and environment context.

Choose the best response for each of the following questions. Then select **Check your answers**.
