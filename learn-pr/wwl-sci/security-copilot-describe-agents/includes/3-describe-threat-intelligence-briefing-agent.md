
Threat intelligence analysts often face challenges in delivering actionable intelligence due to the time-consuming processes of collecting, filtering, and analyzing data from various sources. These delays can make reports obsolete as threats evolve rapidly.

The Threat Intelligence Briefing Agent addresses these challenges by applying dynamic automation and deep generative AI to produce customized, context-rich reports within minutes. It integrates signals from tools like Microsoft Defender External Attack Surface Management and Microsoft Defender for Endpoint to provide situational awareness for CISOs and managers, while offering a solid foundation for analysts to enhance threat defense strategies.

### Information about the agent and prerequisites

The Threat Intelligence Briefing Agent, which is available through the standalone experience in Security Copilot, is characterized as follows:

- **Trigger**: The agent can be triggered manually or set to run at scheduled intervals.
- **Permissions**: This agent can read data from Defender External Attack Surface Management and Defender Vulnerability Management.
- **Identity**: Connection to an existing user account.
- **Products**: Microsoft Security Copilot with provisioned capacity is necessary to run the agent.
- **Plugins**: The Microsoft Threat Intelligence plugin is mandatory, while optional plugins like Defender External Attack Surface Management and Defender Vulnerability Management add more context to the output.
- **Role-based access**: Owners and contributors can view generated reports within the agent library page.

### Set up

Follow these steps to configure the Threat Intelligence Briefing Agent:

1. Navigate to the **Agents** page in the Microsoft Security Copilot portal and select **View details** under the Threat Intelligence Briefing Agent.
2. Review the agent details and select **Set up**.
3. Connect a user account by selecting **Next** and choosing the appropriate account.
4. Specify parameters to customize the output, such as:
   - Number of insights to research.
   - Look-back period for threats.
   - Email address for report delivery.
   - Geographical region and industry scope.0
5. After setup, access the agent overview page to run the agent manually or schedule it to run automatically.

# [Step 1 - Agents](#tab/agents)
:::image type="content" source="../media/agents-copilot-v2.png" lightbox="../media/agents-copilot-v2.png" alt-text="Screen capture showing the navigation flow to access the Agents page in Microsoft Security Copilot. ":::

# [Step 2 - Details page](#tab/details-page)
:::image type="content" source="../media/threat-intelligence-agent-view-details.png" lightbox="../media/threat-intelligence-agent-view-details.png" alt-text="Screenshot of Threat Intelligence Briefing Agent details page.":::

# [Step 3 - Set up](#tab/set-up-agent)
:::image type="content" source="../media/threat-intelligence-agent-setup1.png" lightbox="../media/threat-intelligence-agent-setup1.png"alt-text="Screenshot of Threat Intelligence Briefing Agent set up page that provides information on the permissions and identity needed to run the agent.":::

# [Step 4 - Parameters](#tab/parameters)
:::image type="content" source="../media/threat-intelligence-agent-setup2.png" lightbox="../media/threat-intelligence-agent-setup2.png" alt-text="Screenshot of Threat Intelligence Briefing Agent set up parameters page.":::

# [Step 5 - Run](#tab/run)
:::image type="content" source="../media/threat-intelligence-agent-first-run.png" lightbox="../media/threat-intelligence-agent-first-run.png" alt-text="Screenshot of Threat Intelligence Briefing Agent overview page.":::

---

### Generate and review threat intelligence reports

Once the agent runs, the generated reports appear under **Activity** in the Threat Intelligence Briefing Agent page. Each report includes:

- A summary of relevant threat information.
- Detailed technical analysis of actively exploited vulnerabilities.
- Potential organizational impacts.

Select a report to assess its content and view the agent’s progress by clicking **View activity**.

# [Generated reports](#tab/generated-reports)
:::image type="content" source="../media/threat-intelligence-agent-generated-reports.png" lightbox="../media/threat-intelligence-agent-generated-reports.png" alt-text="Screenshot of Threat Intelligence Briefing Agent's list of generated reports.":::

# [Report](#tab/report)
:::image type="content" source="../media/threat-intelligence-agent-report.png" lightbox="../media/threat-intelligence-agent-report.png" alt-text="Screenshot of a Threat Intelligence Briefing Agent report.":::

# [Activity](#tab/activity)
:::image type="content" source="../media/threat-intelligence-agent-activity2.png" lightbox="../media/threat-intelligence-agent-activity2.png" alt-text="Screenshot of a Threat Intelligence Briefing Agent activity diagram.":::

---

### Feedback

Feedback helps improve the agent’s performance and relevance. To provide feedback:

1. Select the thumbs up or thumbs down button on the report.
2. Add comments in the text box that appears.
3. Select **Submit** to finalize your feedback.

Feedback ensures the agent continues to deliver high-quality, actionable insights tailored to your organization’s needs.
