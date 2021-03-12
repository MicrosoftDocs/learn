You can update Incident management information, view all related information, or jump to investigation pages for the associated data.

## Incident management information

Selecting an incident from the Incidents queue brings up the Incident management pane where you can open the incident page for details.

You can assign incidents to yourself, change the status and classification, rename, or comment on them to keep track of their progress.

> [!TIP]
> For additional visibility at a glance, incident names are automatically generated based on alert attributes such as the number of endpoints affected, users affected, detection sources or categories. This allows you to quickly understand the scope of the incident. For example: Multi-stage incident on multiple endpoints reported by multiple sources.

### Assign incidents

If an incident has not been assigned yet, you can select Assign to me to assign the incident to yourself. Doing so assumes ownership of not just the incident, but also all the alerts associated with it.

## Set status and classification

### Incident status

You can categorize incidents as Active or Resolved by changing their status as your investigation progresses. This helps you organize and manage how your team can respond to incidents. For example, your security operations analyst can review the urgent Active incidents for the day, and decide to assign them to herself for investigation.  Alternatively, your security operations analyst might set the incident as Resolved if the incident has been remediated.

### Classification

You can choose not to set a classification, or decide to specify whether an incident is true or false. Doing so helps the team see patterns and learn from them.

### Add comments

You can add comments and view historical events about an incident to see previous changes made to it. Whenever a change or comment is made to an alert, it is recorded in the Comments and history section. Added comments instantly appear on the pane.

## Incident investigation

To analyze incident details, the investigation page includes the following tabs:

- alerts

- devices

- investigations

- evidence

- graph

:::image type="content" source="../media/incident-alert.png" alt-text="Image of alerts tab with incident details page showing the reasons the alerts were linked together in that incident":::

### Alerts

You can investigate the alerts and see how they were linked together in an incident. Alerts are grouped into incidents based on the following reasons:

- Automated investigation - The automated investigation triggered the linked alert while investigating the original alert

- File characteristics - The files associated with the alert have similar characteristics

- Manual association - A user manually linked the alerts

- Proximate time - The alerts were triggered on the same device within a certain timeframe

- Same file - The files associated with the alert are exactly the same

- Same URL - The URL that triggered the alert is exactly the same

### Devices

You can also investigate the devices that are part of, or related to, a given incident.

### Investigations

Select Investigations to see all the automatic investigations launched by the system in response to the incident alerts.

### Evidence

Microsoft Defender for Endpoint automatically investigates all the incidents' supported events and suspicious entities in the alerts, providing you with autoresponse and information about the important files, processes, services, and more.

Each of the analyzed entities will be marked as infected, remediated, or suspicious.

### Incident graph

Visualizing associated cybersecurity threats

Microsoft Defender for Endpoint aggregates the threat information into an incident so you can see the patterns and correlations coming in from various data points. You can view such correlation through the incident graph.

The Graph tells the story of the cybersecurity attack. For example, it shows you the entry point, which indicator of compromise or activity was observed on which device, etc.

You can select the circles on the incident graph to view the details of the malicious files, associated file detections, how many instances have there been worldwide, whether it’s been observed in your organization, if so, how many instances.

