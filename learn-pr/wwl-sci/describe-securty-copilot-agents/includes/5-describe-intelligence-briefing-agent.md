The intelligence briefing agent in Microsoft Security Copilot is a powerful tool designed to streamline threat intelligence gathering and reporting. It automates the process of collecting, analyzing, and correlating threat data, enabling security engineers to focus on actionable insights rather than manual data aggregation.

## Define the intelligence briefing agent in Microsoft Security Copilot
The intelligence briefing agent is a feature within Microsoft Security Copilot that generates threat intelligence reports based on the latest threat actor activities and vulnerabilities. By leveraging dynamic automation and generative AI, it creates customized, context-rich reports in minutes. These reports provide situational awareness for CISOs and managers and serve as a starting point for threat intelligence analysts.

This agent addresses common challenges faced by security teams, such as the time-intensive nature of gathering and analyzing threat data. It dynamically decides which intelligence to include, ensuring the generated reports remain relevant and actionable.

> [!NOTE]
> The intelligence briefing agent is particularly effective when integrated with Microsoft Defender External Attack Surface Management and Microsoft Defender for Endpoint.

## Identify key components of the intelligence briefing agent
To operate effectively, the intelligence briefing agent relies on several key components:

- **Triggers**: The agent can run at scheduled intervals or be triggered manually.
- **Permissions**: It requires access to data from Defender External Attack Surface Management and Defender Vulnerability Management.
- **Identity**: A connection to an existing user account is necessary.
- **Plugins**: The Microsoft Threat Intelligence plugin is required, while optional plugins like Defender External Attack Surface Management and Defender Vulnerability Management add more context.
- **Role-based access**: Owners and contributors can view the generated reports within the Microsoft Security Copilot portal.

These components ensure the agent can gather and process the necessary data to produce comprehensive threat intelligence reports.

## Explain the benefits of using the intelligence briefing agent
The intelligence briefing agent offers several advantages for security engineers:

- **Time savings**: Automates the collection and correlation of threat data, reducing the time spent on manual tasks.
- **Enhanced threat analysis**: Provides detailed technical analysis and contextual information, enabling better decision-making.
- **Customizable outputs**: Allows users to specify parameters such as region, industry, and email recipients, tailoring the reports to organizational needs.

By automating these processes, the agent empowers security teams to respond more quickly and effectively to emerging threats.

## Describe the integration of the intelligence briefing agent with Microsoft Defender
The intelligence briefing agent integrates seamlessly with Microsoft Defender products to enhance its capabilities. It uses signals and insights from Defender External Attack Surface Management and Defender for Endpoint to deliver accurate and enriched threat intelligence. This integration ensures that the reports are not only timely but also highly relevant to the organization's specific threat landscape.

> [!TIP]
> Integration with Microsoft Defender products provides additional context, making the intelligence briefing agent a valuable tool for proactive threat management.

## Outline the setup process for the intelligence briefing agent
Setting up the intelligence briefing agent involves the following steps:

1. Navigate to the **Agents** page in the Microsoft Security Copilot portal and select **View details** under the Threat Intelligence Briefing Agent.
   :::image type="content" source="../media/agents-library-ti.png" alt-text="Screenshot of Microsoft Security Copilot agent library page.":::
2. Review the agent details and select **Set up**.
   :::image type="content" source="../media/2-ti-brief-agent-view-details.png" alt-text="Screenshot of Threat Intelligence Briefing Agent details page.":::
3. Connect a user account to the agent and wait for the setup to complete.
   :::image type="content" source="../media/3-ti-brief-agent-setup.png" alt-text="Screenshot of Threat Intelligence Briefing Agent set up page.":::
4. Customize the output parameters, such as the number of vulnerabilities to research, look-back days, and email recipients, then select **Finish**.
   :::image type="content" source="../media/4-ti-brief-agent-setup.png" alt-text="Screenshot of Threat Intelligence Briefing Agent set up parameters page.":::
5. Run the agent by selecting **Run agent** on the overview page. Choose between scheduling it to run at set intervals or running it on demand.
   :::image type="content" source="../media/5-ti-agent-run-first.png" alt-text="Screenshot of Threat Intelligence Briefing Agent overview page.":::

Once set up, the agent generates reports that appear under the **Activity** section. Users can assess the output, view the agent's activity map, and provide feedback to improve future reports.