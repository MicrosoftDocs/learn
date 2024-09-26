Microsoft Purview Audit provides essential tools to log and investigate interactions with Microsoft Copilot for Microsoft 365, ensuring these activities meet high security and compliance standards. As organizations increasingly use AI tools like Copilot in their work processes, it's important to establish strong auditing practices to protect confidential data and comply with data protection laws.

With increases in AI-assisted data handling at our network of healthcare facilities, the IT compliance team is using Microsoft Purview Audit to examine Copilot interactions. Their goal is to detect and investigate any unusual or unauthorized activity, reinforcing the security measures necessary for compliance.

Here you learn how to:

- Identify the types of Copilot interactions that can be audited.
- Perform audits for Copilot activities using Microsoft Purview Audit.
- Analyze audit logs to detect and address potential security incidents involving Copilot interactions.

Copilot for Microsoft 365 is used across various services, enabling dynamic user interactions with data through AI-driven prompts and responses. The interactions logged in Microsoft Purview audit logs are critical for maintaining operational efficiency and data integrity.

## Copilot activities

Microsoft Purview Audit logs various interactions from Copilot for Microsoft 365, offering insights into how users engage with the tool. These logs include the services involved and the files accessed, which are essential for ensuring that usage complies with organizational standards and regulations.

|Friendly name|Operation|Description|
|:-----|:-----|:-----|
|Interacted with Copilot|CopilotInteraction|A user, or admin or system on behalf of a user, entered prompts in Copilot.|

## Search the audit log for Copilot interactions

The audit log captures Copilot interactions, which are crucial for compliance. To perform an audit:

1. Sign in to either the Microsoft Purview portal or the Microsoft Purview compliance portal.
1. Navigate to the Audit solution:
   - In the **Microsoft Purview portal**: Select the Audit solution card. If it's not visible, select **View all solutions** then select **Audit**.
   - In the **Microsoft Purview compliance portal**: Select **Audit** from the left pane.
1. Select **New Search** tab at the top of the **Audit** page.
1. Configure your search on the **New Search** tab:
   1. Set the **Start date** and **End date**.
   1. Enter relevant keywords in the **Keyword Search**.
   1. Select administrative units from the **Admin Units** dropdown if needed.
   1. Select activities related to Copilot under **Activities - friendly names** by navigating to **Copilot activities** and selecting **Interacted with Copilot**. You can also use the search bar to find activities related to Copilot by entering _Copilot_.
   :::image type="content" source="../media/audit-copilot-new-search-activities.png" alt-text="Screenshot showing Interacted with Copilot selected under Activities - friendly names." lightbox="../media/audit-copilot-new-search-activities.png":::
   1. Search for detailed activities under **Activities - operations names** by entering _CopilotInteraction_ as the operation name for Copilot activities.
   1. Select record types linked to Copilot activities in the **Record types** dropdown. Enter _Copilot_ in the search box above the list for easier selection.
   :::image type="content" source="../media/audit-copilot-new-search-record-type.png" alt-text="Screenshot showing CopilotInteraction selected under Record types." lightbox="../media/audit-copilot-new-search-record-type.png":::
   1. Name your search for future reference.
   1. Enter specific users or leave this field blank to include all users.
   1. Enter names for specific files, folders, or sites, or leave this field blank to include all.
1. Select **Search** to start your search job.

## Scenario: Enhancing data security in healthcare with Copilot interaction logs

As Copilot's role in managing healthcare-related documentation expands, securely logging all interactions with patient data becomes increasingly important. The IT compliance team ensures that each interaction with healthcare documents and data through Copilot is thoroughly logged, aligning with health regulations and organizational data protection policies.

### Responsibilities for the IT compliance team

- **Compliance verification**: Logs are reviewed to ensure all data interactions adhere to healthcare regulations.
- **Identifying anomalies**: The team actively searches for unauthorized actions that might indicate security risks.
- **Audit management**: Audit settings are adjusted to ensure comprehensive logging of Copilot's data interactions.

### Technical actions for the IT compliance team

- **Configure audit settings**: Configure Microsoft Purview Audit to capture all relevant Copilot interactions.
- **Review logs regularly**: Periodically examine the logs to identify any anomalies or unauthorized access.
- **Update security measures**: Enhance security protocols based on insights gained from log analysis to strengthen data protections.
