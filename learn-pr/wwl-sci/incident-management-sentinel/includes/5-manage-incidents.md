
After you start using Microsoft Sentinel to generate incidents, you and the Contoso IT team can investigate the incidents. Microsoft Sentinel has advanced investigation and analysis tools you can use to gather information and determine remediation steps.

## Review incidents

To identify and resolve security issues, first investigate any incidents. The Microsoft Sentinel **Overview** page provides a list of the most recent incidents for quick reference. For more details and a complete overview of incidents, use the **Incidents** page, which displays all incidents in the current workspace and details about those incidents.

The **Incidents** page provides a complete list of incidents in Microsoft Sentinel. The page also provides basic incident information. Information includes severity, ID, title, alerts, product names, created time, last update time, owner, and status. You can sort by any incident column and filter the incident list by name, severity, status, product name, or owner.

:::image type="content" source="../media/5-incidents-page.png" alt-text="Screenshot of a list of incidents in Microsoft Sentinel." lightbox="../media/5-incidents-page.png":::

From this page, you can take various steps to investigate incidents.

> [!IMPORTANT]
> Azure Active Directory (Azure AD) users who investigate incidents must be members of the Directory Reader role.

## Examine incident details

Select any incident on the **Incidents** page to display more information about the incident in the right pane. This pane provides a description of the incident and lists the related evidence, entities, and tactics. The pane also contains links to associated workbooks and the analytics rule that generated the incident. This information can help you clarify the nature, context, and course of action for the incident.

:::image type="content" source="../media/5-incident-details.png" alt-text="Screenshot of the incident details pane." :::

In the incident details pane, select **View full details** to open the **Incident** page and see more details about the incident. You can use these details to better understand the context of the incident. For example, in a brute force attack incident, you might go to the Log Analytics query for the alert to determine the number of attacks.

## Manage incident ownership, status, and severity

Each incident Microsoft Sentinel creates has attached metadata that you can view and manage. This information lets you:

- Assign and track incident ownership.
- Set and track the status of an incident from creation to resolution.
- Set and review severity.

:::image type="content" source="../media/5-incident-settings.png" alt-text="The screenshot displays the section of the Incidents page where you can assign ownership, status, and severity." :::

### Ownership

In a typical environment, each incident should be assigned an owner from the security team. The incident owner is responsible for overall incident management, including investigation and status updates. You can change ownership at any time to assign the incident to another security team member for further investigation or escalation.

### Status

Every new incident created in Microsoft Sentinel is assigned a status of **New**. As you review and respond to incidents, manually change the status to reflect the current state of the incident. For incidents under investigation, set the status to **Active**. When an incident is fully resolved, set the status to **Closed**. 

When you set the status to **Closed**, you're prompted to choose one of the following resolutions:

- **True Positive - Suspicious activity**
- **Benign Positive - Suspicious but expected**
- **False Positive - Incorrect alert logic**
- **False Positive - Inaccurate data**
- **Undetermined**

### Severity

The rule or Microsoft security source that generated the incident initially sets the severity. In most cases, incident severity remains unchanged, but you might change the severity if you decide that the incident is more or less severe than initially classified. Severity options are **Informational**, **Low**, **Medium**, and **High**.

## Use the investigation graph

You can further investigate an incident by selecting **Investigate** on the **Incident** page. This action opens the investigation graph, a visual tool that helps to identify entities involved in the attack and the relationships between those entities. If the incident involves multiple alerts over time, you can also review the alert timeline and correlations between alerts.

:::image type="content" source="../media/5-investigation-graph.png" alt-text="The screenshot shows the investigation graph." lightbox="../media/5-investigation-graph.png":::

### Review entity details

You can select each entity on the graph to observe more information about the entity. This information includes relationships to other entities, account usage, and data flow information. For each information area, you can go to the related events in Log Analytics and add the related alert data into the graph.

### Review incident details

You can select the incident item on the graph to observe incident metadata related to the incident's security and environment context.
