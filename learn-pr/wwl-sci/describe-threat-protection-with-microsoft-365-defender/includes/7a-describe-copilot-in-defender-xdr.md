
Microsoft Defender XDR integrates with Microsoft Security Copilot. Integration with Security Copilot can be experienced through the standalone and embedded experiences.

### The standalone experience

For businesses that are onboarded to Microsoft Security Copilot, the integration is enabled through plugins accessed through the Copilot portal (the standalone experience). There are two separate plugins that support integration with Microsoft Defender XDR:

- Microsoft Defender XDR
- Natural language to KQL for Microsoft Defender XDR

:::image type="content" source="../media/defender-plugins.png" lightbox="../media/defender-plugins.png" alt-text="A screenshot of the Microsoft Defender XDR plugin and the Natural language to KQL for Microsoft Defender XDR plugin, in Microsoft Security Copilot.":::

***Microsoft Defender XDR plugin***

The Microsoft Defender XDR plugin includes capabilities that enable users to:

- Analyze files
- Generate an incident report
- Generate a guided response
- List incidents and related alerts
- Summarize the security state of the device
- more...

Microsoft Defender XDR capabilities in Copilot are built-in prompts that you can use, but you can also enter your own prompts based on the capabilities supported.

Copilot also includes a builtin promptbook for Microsoft Defender XDR incident investigation you can use to get a report about a specific incident, with related alerts, reputation scores, users, and devices.

***Natural language to KQL for Microsoft Defender plugin***

The Natural language to KQL for Microsoft Defender plugin enables query assistant functionality that converts any natural-language question in the context of threat hunting, into a ready-to-run Kusto Query Language (KQL) query. The query assistant saves security teams time by generating a KQL query that can then be automatically run or further tweaked according to the analyst’s needs.

### The embedded experience

With the plugin enabled, Copilot integration with Defender XDR can also be experienced through the embedded experience, which is referred to as Copilot in Microsoft Defender XDR.

Copilot in Microsoft Defender XDR enables security teams to quickly and efficiently investigate and respond to incidents, through the Microsoft Defender XDR portal. Copilot in Microsoft Defender XDR supports the following features.

- Summarize incidents
- Guided responses
- Script analysis
- Natural language to KQL queries
- Incident reports
- Analyze files
- Device and identity summaries

Users can also seamlessly pivot from the embedded experience to the standalone experience.

#### Summarize incidents

To immediately understand an incident, you can use Copilot in Microsoft Defender XDR to summarize an incident for you. Copilot creates an overview of the attack containing essential information for you to understand what transpired in the attack, what assets are involved, the timeline of the attack, and more. Copilot automatically creates a summary when you navigate to an incident's page. Incidents containing up to 100 alerts can be summarized into one incident summary.

:::image type="content" source="../media/xdr-incident-summary-v5.png" lightbox="../media/xdr-incident-summary-v5.png" alt-text="Screen capture of Security Copilot embedded experience in Microsoft Defender XDR, showing an incident summary.":::

#### Guided responses

Copilot in Microsoft Defender XDR uses AI and machine learning capabilities to contextualize an incident and learn from previous investigations to generate appropriate response actions, which are shown as guided responses. The guided response capability of Copilot allows incident response teams at all levels to confidently and quickly apply response actions to resolve incidents with ease.

Guided responses recommend actions in the following categories:

- Triage - includes a recommendation to classify incidents as informational, true positive, or false positive
- Containment - includes recommended actions to contain an incident
- Investigation - includes recommended actions for further investigation
- Remediation - includes recommended response actions to apply to specific entities involved in an incident

Each card contains information about the recommended action, including why the action is recommended, similar incidents, and more. For example, the View similar incidents action becomes available when there are other incidents within the organization that are similar to the current incident. Incident response teams can also view user information for remediation actions such as resetting passwords.

:::image type="content" source="../media/xdr-guided-responses-v2.png" lightbox="../media/xdr-guided-responses-v2.png" alt-text="Screen capture showing the information included in a guided response.":::

Not all incidents/alerts provide guided responses. Guided responses are available for incident types such as phishing, business email compromise, and ransomware. 

#### Analyze scripts and codes

The script analysis capability of Copilot in Microsoft Defender XDR provides security teams added capacity to inspect scripts and code without using external tools. This capability also reduces complexity of analysis, minimizing challenges and allowing security teams to quickly assess and identify a script as malicious or benign.

There are several ways you can access the script analysis capability. The image that follows shows the process tree for an alert that includes execution of a PowerShell script. Selecting the analyze button generates the Copilot script analysis.

:::image type="content" source="../media/script-analysis-v3.png" lightbox="../media/script-analysis-v3.png" alt-text="Screen capture showing the option to analyze a PowerShell script.":::

#### Generate KQL queries

Copilot in Microsoft Defender XDR comes with a query assistant capability in advanced hunting.

To access the natural language to KQL query assistant, users with access to Copilot select advanced hunting from the left navigation pane of the Defender XDR portal.

Copilot provides prompts you can use to start hunting for threats with Copilot, or you can write your own natural language question, in the prompt bar, to generate a KQL query. For example,"Give me all the devices that signed in within the last 10 minutes." Copilot then generates a KQL query that corresponds to the request using the advanced hunting data schema.

The user can then choose to run the query by selecting Add and run. The generated query then appears as the last query in the query editor. To make further tweaks, select Add to editor.

# [Generate a KQL query](#tab/generate-a-kql-query)
:::image type="content" source="../media/xdr-advanced-hunting-v3.png" lightbox="../media/xdr-advanced-hunting-v3.png" alt-text="Screen capture showing the Copilot query assistant screen embedded in Defender XDR.":::

# [Copilot query](#tab/copilot-query)
:::image type="content" source="../media/xdr-advanced-hunting-query-v2.png" lightbox="../media/xdr-advanced-hunting-query-v2.png" alt-text="Screen capture showing the KQL query generated from a natural language request.":::

---

#### Create incident reports

A comprehensive and clear incident report is an essential reference for security teams and security operations management. However, writing a comprehensive report with the important details present can be a time-consuming task for security operations teams as it involves collecting, organizing, and summarizing incident information from multiple sources. Security teams can now instantly create an extensive incident report within the portal.

While an incident summary provides an overview of an incident and how it happened, an incident report consolidates incident information from various data sources available in Microsoft Sentinel and Microsoft Defender XDR. The incident report also includes all analyst-driven steps and automated actions, the analysts involved in the response, the comments from the analysts, and more.

To create an incident report, the user selects Generate incident report on the top right corner of the incident page or the icon in the Copilot pane. Once the incident report is generated, selecting the ellipses on the incident report presents the user with the option to copy the report to the clipboard, post to an activity log, regenerate the report, or opt to open in the Copilot standalone experience.

# [Generate incident report](#tab/generate-incident-report)
:::image type="content" source="../media/xdr-incident-report.png" lightbox="../media/xdr-incident-report.png" alt-text="Screen capture showing the two options for generating an incident report.":::

# [Incident report](#tab/incident-report)
:::image type="content" source="../media/xdr-incident-report-output.png" lightbox="../media/xdr-incident-report-output.png" alt-text="Screen capture showing the generated incident report and the drop-down menu of options available by selecting the ellipses.":::

---

#### Analyze files

Sophisticated attacks often use files that mimic legitimate or system files to avoid detection. Copilot in Microsoft Defender XDR enables security teams to quickly identify malicious and suspicious files through AI-powered file analysis capabilities.

There are many ways to access the detailed profile page of a specific file. In this example, you navigate to files through the incident graph of an incident with impacted files. The incident graph shows the full scope of the attack, how the attack spread through your network over time, where it started, and how far the attacker went.

From the incident graph, selecting files displays the option to view files. Selecting view files opens a panel on the right side of the screen listing impacted files. Selecting any file displays an overview of the file details and the option to analyze the file. Selecting Analyze opens the Copilot file analysis.

# [Select file to analyze](#tab/select-file-to-analyze)
:::image type="content" source="../media/defender-xdr-files-v3.png" lightbox="../media/defender-xdr-files-v3.png" alt-text="Screen capture showing the incident graph of an incident, with files highlighted.":::

# [File analysis](#tab/file-analysis)
:::image type="content" source="../media/defender-xdr-file-analyze.png" lightbox="../media/defender-xdr-file-analyze.png" alt-text="Screen capture showing the file analyze option and the file analysis output from Copilot.":::

---

#### Summarize devices and identities

The device summary capability of Copilot in Defender enables security teams to get a device’s security posture, vulnerable software information, and any unusual behaviors. Security analysts can use a device’s summary to speed up their investigation of incidents and alerts.

There are many ways to access a device summary. In this example, you navigate to the device summary through the incident assets page. Selecting the assets tab for an incident displays all the assets. From the left navigation panel, select Devices then select a specific device name. From the overview page that opens on the right is the option to select Copilot.

Similarly, Copilot in Microsoft Defender XDR can summarize identities.

# [Device summary](#tab/device-summary)
:::image type="content" source="../media/device-summary.png" lightbox="../media/device-summary.png" alt-text="Screen capture showing the device summary from Copilot.":::

# [Identity summary](#tab/identity-summary)
:::image type="content" source="../media/identity-summary.png" lightbox="../media/identity-summary.png" alt-text="Screen capture showing the identity summary from Copilot.":::

---

#### Move to the Standalone experience

As an analyst using Microsoft Defender XDR, you're likely to spend a good amount time in Defender XDR, so the embedded experience is a great place to start a security investigation. Depending on what you learn you may determine that a deeper investigation is needed. In this scenario, you can easily transition to the standalone experience to pursue a more detailed, cross product investigation that brings to bear all the Copilot capabilities enabled for your role.

For content generated through the embedded experience you can easily transition to the standalone experience. To move to the standalone experience, select the ellipses within the generated content window then choose Open in Security Copilot.

:::image type="content" source="../media/switch-to-standalone-experience.png" lightbox="../media/switch-to-standalone-experience.png" alt-text="Screen capture showing the option to open in Security Copilot, which is available by selecting the ellipses in the AI generated content window.":::
