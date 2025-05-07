
Threat intelligence analysts often face challenges in delivering actionable intelligence due to the time-consuming processes of collecting, filtering, and analyzing data from various sources. These delays can make reports obsolete as threats evolve rapidly.

The Threat Intelligence Briefing Agent addresses these challenges by leveraging dynamic automation and deep generative AI to produce customized, context-rich reports within minutes. It integrates signals from tools like Microsoft Defender External Attack Surface Management and Microsoft Defender for Endpoint to provide situational awareness for CISOs and managers, while offering a solid foundation for analysts to enhance threat defense strategies.

:::image type="content" source="../media/agents-library-ti.png" alt-text="Screenshot of Microsoft Security Copilot agent library page.":::

### Identify prerequisites for using the Threat Intelligence Briefing Agent

To use the Threat Intelligence Briefing Agent effectively, certain permissions, integrations, and plugins are required:

- **Permissions**: Access to Defender External Attack Surface Management and Defender Vulnerability Management.
- **Identity**: Connection to an existing user account.
- **Products**: Microsoft Security Copilot is necessary to run the agent.
- **Plugins**: The Microsoft Threat Intelligence plugin is mandatory, while optional plugins like Defender External Attack Surface Management and Defender Vulnerability Management add more context to the output.
- **Role-based access**: Owners and contributors can view generated reports within the agent library page.

The agent can be triggered manually or set to run at scheduled intervals.

### Set up the Threat Intelligence Briefing Agent in Microsoft Security Copilot

Follow these steps to configure the Threat Intelligence Briefing Agent:

1. Navigate to the **Agents** page in the Microsoft Security Copilot portal and select **View details** under the Threat Intelligence Briefing Agent.

:::image type="content" source="../media/2-ti-brief-agent-view-details.png" alt-text="Screenshot of Threat Intelligence Briefing Agent details page.":::

2. Review the agent details and select **Set up**.
3. Connect a user account by selecting **Next** and choosing the appropriate account.

:::image type="content" source="../media/3-ti-brief-agent-setup.png" alt-text="Screenshot of Threat Intelligence Briefing Agent set up page.":::

4. Specify parameters to customize the output, such as:
   - Number of vulnerabilities to research.
   - Look-back period for threats.
   - Email address for report delivery.
   - Geographical region and industry scope.

:::image type="content" source="../media/4-ti-brief-agent-setup.png" alt-text="Screenshot of Threat Intelligence Briefing Agent set up parameters page.":::

5. After setup, access the agent overview page to run the agent manually or schedule it to run automatically.

:::image type="content" source="../media/5-ti-agent-run-first.png" alt-text="Screenshot of Threat Intelligence Briefing Agent overview page.":::

### Generate and review threat intelligence reports

Once the agent runs, the generated reports appear under **Activity** in the Threat Intelligence Briefing Agent page. Each report includes:

- A summary of relevant threat information.
- Detailed technical analysis of actively exploited vulnerabilities.
- Potential organizational impacts.

Select a report to assess its content and view the agent’s progress by clicking **View activity**.

:::image type="content" source="../media/8-ti-brief-agent-page.png" alt-text="Screenshot of Threat Intelligence Briefing Agent sample report.":::

### Provide feedback on Threat Intelligence Briefing Agent outputs
Feedback helps improve the agent’s performance and relevance. To provide feedback:

1. Select the thumbs up or thumbs down button on the report.
2. Add comments in the text box that appears.
3. Click **Submit** to finalize your feedback.

Feedback ensures the agent continues to deliver high-quality, actionable insights tailored to your organization’s needs.

:::image type="content" source="../media/agent-activity-map.png" alt-text="Screenshot of the activity map.":::

