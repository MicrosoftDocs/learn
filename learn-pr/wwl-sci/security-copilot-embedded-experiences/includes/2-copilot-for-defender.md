
Microsoft Copilot for Security is embedded in Microsoft Defender XDR to enable security teams to quickly and efficiently investigate and respond to incidents. Microsoft Copilot for Microsoft Defender XDR supports the following features.

- Summarize incidents
- Guided responses
- Script analysis
- Natural language to KQL queries
- Incident reports
- Analyze files
- Device summary

There are also some options that are common across all these features, including the ability to provide feedback on prompt responses and seamlessly moving to the standalone experience.

As described in the introduction unit, in the embedded experience Copilot is able to invoke the product specific capabilities directly, providing processing efficiency. That said, to ensure access to these Microsoft Copilot for Security features, the Microsoft Defender XDR plugin needs to be enabled and this is done through the standalone experience. To learn more, refer to [Describe the features available in the standalone experience of Microsoft Copilot for Security](/training/modules/security-copilot-describe-core-features/2-describe-standalone-experience).

:::image type="content" source="../media/manage-plugins-microsoft-defender-xdr.png" lightbox="../media/manage-plugins-microsoft-defender-xdr.png" alt-text="Screen capture of the Manage plugins window that highlights the Microsoft Defender XDR plugin.":::

### Summarize incidents

To immediately understand an incident, you can use Microsoft Copilot in Microsoft Defender XDR to summarize an incident for you. Copilot creates an overview of the attack containing essential information for you to understand what transpired in the attack, what assets are involved, and the timeline of the attack. Copilot automatically creates a summary when you navigate to an incident's page. 

:::image type="content" source="../media/xdr-incident-summary-v5.png" lightbox="../media/xdr-incident-summary-v5.png" alt-text="Screen capture of Security Copilot embedded experience in Microsoft Defender XDR, showing an incident summary.":::

Incidents containing up to 100 alerts can be summarized into one incident summary. An incident summary, depending on the availability of the data, includes the following:

- The time and date when an attack started.
- The entity or asset where the attack started.
- A summary of timelines of how the attack unfolded.
- The assets involved in the attack.
- Indicators of compromise (IOCs).
- Names of threat actors involved.

### Guided responses

Copilot in Microsoft Defender XDR uses AI and machine learning capabilities to contextualize an incident and learn from previous investigations to generate appropriate response actions, which are shown as guided responses. The guided response capability of Copilot allows incident response teams at all levels to confidently and quickly apply response actions to resolve incidents with ease.

Guided responses recommend actions in the following categories:

- Triage - includes a recommendation to classify incidents as informational, true positive, or false positive
- Containment - includes recommended actions to contain an incident
- Investigation - includes recommended actions for further investigation
- Remediation - includes recommended response actions to apply to specific entities involved in an incident

Each card contains information about the recommended action, including why the action is recommended, similar incidents, and more. For example, the View similar incidents action becomes available when there are other incidents within the organization that are similar to the current incident. Incident response teams can also view user information for remediation actions such as resetting passwords. 

:::image type="content" source="../media/xdr-guided-responses-v2.png" lightbox="../media/xdr-guided-responses-v2.png" alt-text="Screen capture showing the information included in a guided response.":::

Not all incidents/alerts provide guided responses. Guided responses are available for incident types such as phishing, business email compromise, and ransomware. 

### Analyze scripts and codes

Most complex and sophisticated attacks like ransomware evade detection through numerous ways, including the use of scripts and PowerShell. Moreover, these scripts are often obfuscated, which adds to the complexity of detection and analysis. Security operations teams need to quickly analyze scripts and code to understand its capabilities and apply appropriate mitigation to attacks from progressing further within a network.

The script analysis capability of Copilot in Microsoft Defender XDR provides security teams added capacity to inspect scripts and code without using external tools. This capability also reduces complexity of analysis, minimizing challenges and allowing security teams to quickly assess and identify a script as malicious or benign.

You can access the script analysis capability in the alert timeline within an incident, for a timeline entry consisting of script or code. In the image that follows, the timeline shows a powershell.exe entry. 

> [!NOTE]
> Script analysis functions are continuously in development. Analysis of scripts in languages other than PowerShell, batch, and bash are being evaluated.

:::image type="content" source="../media/xdr-analyze-script-v4b.png" lightbox="../media/xdr-analyze-script-v4b.png" alt-text="Screen capture showing the option to analyze a PowerShell script.":::

Copilot analyzes the script and displays the results in the script analysis card. Users can select the Show code to see specific lines of code related to the analysis. To hide the code, users need only to select Hide code.

:::image type="content" source="../media/xdr-script-analysis-show-code-v2.png" lightbox="../media/xdr-script-analysis-show-code-v2.png" alt-text="Screen capture showing the lines of code related to the script analysis.":::

### Generate KQL queries

Copilot in Microsoft Defender XDR comes with a query assistant capability in advanced hunting.

Threat hunters or security analysts who aren't yet familiar with or have yet to learn KQL can make a request or ask a question in natural language (for instance, Get all alerts involving user admin123). Copilot then generates a KQL query that corresponds to the request using the advanced hunting data schema.

This feature reduces the time it takes to write a hunting query from scratch so that threat hunters and security analysts can focus on hunting and investigating threats.

To access the natural language to KQL query assistant, users with access to Copilot select advanced hunting from the left navigation pane of the Defender XDR portal.

:::image type="content" source="../media/xdr-advanced-hunting-v3.png" lightbox="../media/xdr-advanced-hunting-v3.png" alt-text="Screen capture showing the Copilot query assistant screen embedded in Defender XDR.":::

Using the prompt bar, the user can ask for a threat hunting query, using natural language, such as, "Give me all the devices that signed in within the last 10 minutes."

:::image type="content" source="../media/xdr-advanced-hunting-query-v2.png" lightbox="../media/xdr-advanced-hunting-query-v2.png" alt-text="Screen capture showing the KQL query generated from a natural language request.":::

The user can then choose to run the query by selecting Add and run. The generated query then appears as the last query in the query editor. To make further tweaks, select Add to editor.

The option to run the generated query can also be set automatically through the settings icon.

:::image type="content" source="../media/xdr-advanced-hunting-query-settings.png" lightbox="../media/xdr-advanced-hunting-query-settings.png" alt-text="Screen capture showing the option to run the generated query automatically.":::

### Create incident reports

A comprehensive and clear incident report is an essential reference for security teams and security operations management. However, writing a comprehensive report with the important details present can be a time-consuming task for security operations teams as it involves collecting, organizing, and summarizing incident information from multiple sources. Security teams can now instantly create an extensive incident report within the portal.

Utilizing Copilot's AI-powered data processing, security teams can immediately create incident reports with a click of a button in Microsoft Defender XDR.

While an incident summary provides an overview of an incident and how it happened, an incident report consolidates incident information from various data sources available in Microsoft Sentinel and Microsoft Defender XDR. The incident report also includes all analyst-driven steps and automated actions, the analysts involved in the response, and the comments from the analysts.

Copilot creates an incident report containing the following information:

- The main incident management actions' timestamps, including:
  - Incident creation and closure
  - First and last logs, whether the log was analyst-driven or automated, captured in the incident
- The analysts involved in incident response.
- Incident classification, including analysts' comments on how the incident was evaluated and classified.
- Investigation actions applied by analysts and noted in the incident logs
- Remediation actions done, including:
  - Manual actions applied by analysts and noted in the incident logs
  - Automated actions applied by the system, including Microsoft Sentinel Playbooks ran and Microsoft Defender XDR actions applied
- Follow up actions like recommendations, open issues, or next steps noted by the analysts in the incident logs.

To create an incident report, the user selects Generate incident report on the top right corner of the incident page or the icon in the Copilot pane.

:::image type="content" source="../media/xdr-incident-report.png" lightbox="../media/xdr-incident-report.png" alt-text="Screen capture showing the two options for generating an incident report.":::

The generated report depends on the incident information available from Microsoft Defender XDR and Microsoft Sentinel. By selecting the ellipses on the incident report card, the user can copy the report to the clipboard, post to an activity log, regenerate the report, or opt to open in the Copilot standalone experience.

:::image type="content" source="../media/xdr-incident-report-output.png" lightbox="../media/xdr-incident-report-output.png" alt-text="Screen capture showing the generated incident report and the drop-down menu of options available by selecting the ellipses.":::

### Analyze files

Sophisticated attacks often use files that mimic legitimate or system files to avoid detection. Copilot in Microsoft Defender XDR enables security teams to quickly identify malicious and suspicious files through AI-powered file analysis capabilities.

There are many ways to access the detailed profile page of a specific file. For example, you can use the search feature, select on a link from the Alert process tree, Incident graph, Artifact timeline, or select an event listed in the Device timeline.

In this example, you navigate to files through the incident graph of an incident with impacted files.  The incident graph shows the full scope of the attack, how the attack spread through your network over time, where it started, and how far the attacker went.

From the incident graph, selecting files displays the option to view files. Selecting view files opens a panel on the right side of the screen listing impacted files.

:::image type="content" source="../media/defender-xdr-files-v3.png" lightbox="../media/defender-xdr-files-v3.png" alt-text="Screen capture showing the incident graph of an incident, with files highlighted.":::

Selecting any file displays an overview of the file details and the option to analyze the file. Selecting Analyze opens the Copilot file analysis.

:::image type="content" source="../media/defender-xdr-file-analyze.png" lightbox="../media/defender-xdr-file-analyze.png" alt-text="Screen capture showing the file analyze option and the file analysis output from Copilot.":::

### Summarize devices

The device summary capability of Copilot in Defender enables security teams to get a device’s security posture, vulnerable software information, and any unusual behaviors. Security analysts can use a device’s summary to speed up their investigation of incidents and alerts.

There are many ways to access a device summary. In this example, you navigate to the device summary through the incident assets page. Selecting the assets tab for an incident displays all the assets. From the left navigation panel, select Devices then select a specific device name. From the overview page that opens on the right is the option to select Copilot.

:::image type="content" source="../media/defender-xdr-devices-v2.png" lightbox="../media/defender-xdr-devices-v2.png" alt-text="Screen capture showing the device summary option from the incident assets page.":::

:::image type="content" source="../media/defender-xdr-device-summary.png" lightbox="../media/defender-xdr-device-summary.png" alt-text="Screen capture showing the device summary from Copilot.":::

### Common functionality across key features

There are some options that are common across the features of Copilot for Microsoft Defender XDR.

#### Providing Feedback
As with the standalone experience, the embedded experience provides users a mechanism to provide feedback on the accuracy of the AI generated response. For any AI generated content, you can select the feedback prompt on the bottom right of the content window and select from the available options.

:::image type="content" source="../media/verify-for-accuracy-v2.png" lightbox="../media/verify-for-accuracy-v2.png" alt-text="Screen capture of the feedback icon for AI generated content and the three options. The options are confirmed, it looks great, off target, inaccurate, and potentially harmful, inappropriate.":::

#### Move to the Standalone experience

As an analyst using Microsoft Defender XDR, you're likely to spend a good amount time in Defender XDR, so the embedded experience is a great place to start a security investigation. Depending on what you learn you may determine that a deeper investigation is needed. In this scenario, you can easily transition to the standalone experience to pursue a more detailed, cross product investigation that brings to bear all the Copilot capabilities enabled for your role. 

For content generated through the embedded experience you can easily transition to the standalone experience. To move to the standalone experience, select the ellipses within the generated content window then choose Open in Security Copilot.

:::image type="content" source="../media/switch-to-standalone-experience.png" lightbox="../media/switch-to-standalone-experience.png" alt-text="Screen capture showing the option to open in Security Copilot, which is available by selecting the ellipses in the AI generated content window.":::