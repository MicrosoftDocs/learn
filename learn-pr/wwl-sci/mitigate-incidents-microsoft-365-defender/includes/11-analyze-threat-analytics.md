Threat intelligence analysts often need to gather data from multiple feeds and tools before they can create a useful briefing. The (embedded) Security Copilot Threat Intelligence Briefing Agent in Microsoft Defender helps reduce that effort by generating a briefing in minutes based on recent threat actor activity and your organization's vulnerability context.

The briefing is designed to support CISOs, security managers, and analysts with prioritized, actionable intelligence. As the agent builds the briefing, it dynamically decides what to analyze next based on previous results.

Watch this video to see the Threat Intelligence Briefing Agent in action.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=07ffea67-4ebf-4f13-9a7e-dcc49bcaac93]

### Find the Threat Intelligence Briefing Agent in Threat analytics
In Microsoft Defender, open **Threat intelligence** > **Threat analytics**. The Threat Intelligence Briefing Agent appears as a banner at the top of the *Threat Analytics* dashboard page.

:::image type="content" source="../media/agent.png" alt-text="Screenshot of the Threat Intelligence Briefing Agent banner on top of the Threat Analytics dashboard page." lightbox="../media/agent.png":::

### Prerequisites for using the agent
Before you use the agent, make sure these requirements are in place:

- Microsoft Security Copilot is available in your environment.
- Required Security Copilot plugins:
    - Microsoft Threat Intelligence
    - Microsoft Threat Intelligence agents
- Optional plugin:
    - Microsoft Defender External Attack Surface Management
- The connected user account or agent identity has appropriate permissions, including:
    - Access to Defender Vulnerability Management data
    - Security Reader access to Threat analytics and results
    - Security Admin access for onboarding and configuration

### Run and review briefings
After prerequisites are complete, use the agent banner to run an up-to-date briefing or open the full briefing panel.

:::image type="content" source="../media/run-agent.png" alt-text="Screenshot of the Threat Intelligence Briefing Agent banner with the View full brief and Run agent buttons highlighted." lightbox="../media/run-agent.png":::

The full briefing panel summarizes threats, vulnerable exposures, and potential business impact. You can copy the briefing or download it as markdown for sharing.

:::image type="content" source="../media/full-brief.png" alt-text="Screenshot of the Threat Intelligence Briefing Agent side panel in Threat analytics with download and copy controls." lightbox="../media/full-brief.png":::

### Manage agent settings
Select **Manage agent** to review or update agent settings, such as schedule behavior and briefing preferences.

:::image type="content" source="../media/manage-agent.png" alt-text="Screenshot of the Threat Intelligence Briefing Agent side panel with the Manage agent button highlighted." lightbox="../media/manage-agent.png":::

You can also open settings from **System** > **Settings** > **Microsoft Defender XDR** > **Threat Intelligence Briefing Agent**.

:::image type="content" source="../media/settings.png" alt-text="Screenshot of the Threat Intelligence Briefing Agent settings page in the Defender portal." lightbox="../media/settings.png":::

### Assess output and provide feedback
Generated briefings are saved in Security Copilot under **Activity**, where you can inspect run status and review previous reports.

:::image type="content" source="../media/agent-activity.png" alt-text="Screenshot of the Threat Intelligence Briefing Agent activity page in the Security Copilot standalone portal." lightbox="../media/agent-activity.png":::

To evaluate agent reasoning and workflow transparency, open a generated report and select **View activity**.

:::image type="content" source="../media/view-agent-activity.png" alt-text="Screenshot of a Threat Intelligence Briefing Agent report with View activity highlighted." lightbox="../media/view-agent-activity.png":::

Use **thumbs up** or **thumbs down** in the briefing panel to provide feedback and help improve future agent output.

