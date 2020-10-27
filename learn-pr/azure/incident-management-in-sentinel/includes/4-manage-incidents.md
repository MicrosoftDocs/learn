Once Sentinel is generating incidents, the next step is to investigate
those incidents. Azure Sentinel includes advanced investigation and analysis tools that help you understand what is happening and take remediation steps.

## Investigating incidents

The primary step in identifying and resolving security issues at Contoso will begin with incident investigation. The Overview page in Azure Sentinel provides a list of the most recent incidents for quick reference. For more details and a complete view of the incidents at Contoso, you will use the Incidents page, which shows all incidents in the current workspace and details about those incidents.

:::image type="content" source="../media/4-incidents-page.png" alt-text="The screenshot depicts the Incidents page in Azure Sentinel." border="false":::

> [!IMPORTANT]
> Azure Active Directory users investigating incidents must be members of the Directory Reader role.

### View incidents

The Incidents page provides a complete list of incidents in Sentinel along with basic incident information, including severity incident id, title, alerts, product names, created time, last update time, owner, and status. You can sort by aby incident column and filter the incident list na,e bu severity, status, product name, or owner.

Selecting any incident will display more information about the incident in the details column. THis information can help you clarify the nature, context, and course of action for an incident.

### Manage incident ownership, status, and severity

Each incident created in Sentinel has manageable metadata attached to it. This information can help you set and track the status of an incident from creation to resolution, set and view severity, and assign and track ownership for the incident.

:::image type="content" source="../media/4-incident-settings.png" alt-text="The screenshot depicts the section of the incidents page where you can assign ownership, status, and severity." border="false":::

#### Ownership

In typical environment, each incident should be assigned an owner from you security team. The incident owner is responsible for overall management of the incident, including investigation and status updates. You can change ownership at anytime. Escalation is a common reason to reassign an incident to a new owner.

#### Status

Every new incident that is created in Sentinel is assigned a status of **New**. As you view and respond to incidents at Contoso, you will manually change the status to reflect the current state of the incident. You should set the status of incidents under investigation to **Active**. When an incident has be fully resolved, you should set status to **Closed**. When you set status to closed, you will be prompted to choose one of the following from the drop-down list:

- True Positive - suspicious activity
- Benign Positive - suspicious but expected
- False Positive - incorrect alert logic
- False Positive - incorrect data
- Undetermined

#### Severity

Incident severity is typically set by the rule or Microsoft security source from which the incident is generated. In most cases, incident severity will remain unchanged, but you might manually set severity if further investigation or context leads you to believe that the incident is more or less severe than initially classified. Severity options include **Informational, Low, Medium, and High**.

### Examine incident details

The details pane also identifies important context about the incident. It provides a description of the incident and lists the evidence, entities, and tactics related to the incident. It also contains links to associated workbooks and the analytic rule that generated the incident.

:::image type="content" source="../media/4-incident-details.png" alt-text="The screenshot depicts the incident details page." border="false":::

All of these details can be referenced to better understand the context of the incident. For example, in a brute force attack incident you might navigate to the Log Analytics query for the alert to determine the number of attacks made.

### Perform deep analysis with investigation graph

You can perform further investigation into an incident by selecting **Investigate** in the incident details page. This action opens the investigation graph, a visual tool that helps to identify entities involved in the attack and the relationships between those entities. If the incident involves multiple alerts over time, you can also view the alert timeline and correlations between alerts

:::image type="content" source="../media/4-investigation-graph.png" alt-text="The screenshot depicts the incident details page." border="false":::

#### Viewing entity details

You can select each entity on the graph to observe more information about the entity. This information provides complete contextual entity information, including relationships to other entities, account usage, and data flow information. For each information area, you can navigate to the related events in Log Analytics and add the related alert data into the graph.

#### Viewing incident details

You can select the incident item on the graph to observe important incident metadata related to the incident's security and environment context.
