Microsoft Security Copilot agents in Microsoft Purview are AI-powered assistants that help security and compliance teams manage data security tasks. These agents work within the Microsoft Purview embedded experience, handling alert triage for Data Loss Prevention (DLP) and Insider Risk Management, as well as sensitive data discovery across the Microsoft 365 ecosystem.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Purview is continually growing. This unit is designed to provide a high-level overview of a few of the Security Copilot agents in Microsoft Purview. For more information, see training that relates to Microsoft Purview.

### Microsoft Security Copilot agents in Microsoft Purview

The following Microsoft Security Copilot agents are available in Microsoft Purview. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability.

#### Triage Agent in Insider Risk Management

The [Triage Agent in Insider Risk Management](/purview/copilot-in-purview-triage-irm-agent-get-started) helps security teams by evaluating alerts based on user risk and activity risk. The agent then sorts the triaged alerts into categories that are presented in the insider risk management solution on the **Alerts** tab. To determine the category for each alert, the agent evaluates the following risk factors:

- **Activity risk**: Identifies activities with the highest risk of exfiltration and reports historical alert insights.
- **User risk**: Attributes of the user that can affect prioritization, such as priority user group configuration or number of currently active cases.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs as the administrator who turned on the agent. Agent authentication expires after 90 days and must be renewed. |
| **License** | Both the standard per user licensing model and the pay-as-you-go billing model. Microsoft Purview Insider Risk Management with Microsoft 365 E3/E5/A5/F5/G5. |
| **Permissions** | Access policy configurations and settings in Insider Risk Management; read activities and events in Microsoft Purview; read file content and metadata involved in Insider Risk Management alerts; store user feedback and apply feedback when evaluating Insider Risk Management alerts. |
| **Plugins** | Microsoft Purview. |
| **Products** | Security Copilot and Insider Risk Management. |
| **Role-based access** | **View activity**: Insider Risk Management Analysts, Insider Risk Management Investigators, or Insider Risk Management role group. **Manage**: All roles needed to view activity, plus the Purview Content Analyst role in the Purview Agent Management role group. |
| **Trigger** | Runs on a selected schedule or on one alert at a time. |

#### Alert Triage Agent in Data Loss Prevention (preview)

The [Alert Triage Agent in Data Loss Prevention](/purview/copilot-in-purview-triage-dlp-agent-get-started) helps security teams by evaluating alerts based on sensitivity risk, exfiltration risk, and policy risk. The agent then sorts the triaged alerts into categories that are presented in the DLP solution on the **Alerts** page. For devices, you must set up evidence collection for file activities on devices and enable evidence collection in the DLP policy rule configuration. To determine the category for each alert, the agent evaluates the following risk factors:

- **Sensitivity risk**: The primary risk factor, covering sensitive content based on Microsoft-provided sensitive information types (SITs), trainable classifiers, and default sensitivity labels.
- **Exfiltration risk**: Exfiltration of sensitive data shared externally.
- **Policy risk**: Policy mode and rules with actions that affect alert prioritization.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs as the administrator who turned on the agent. Agent authentication expires after 90 days and must be renewed. |
| **License** | Both the standard per user licensing model and the pay-as-you-go billing model. Microsoft Purview Data Loss Prevention with Microsoft 365 E3/E5/A5/F5/G5. |
| **Permissions** | Access policy configurations and settings in DLP; read activities and events in Microsoft Purview; read file content and metadata involved in DLP alerts; store user feedback and apply feedback when evaluating DLP alerts. |
| **Plugins** | Microsoft Purview. |
| **Products** | Security Copilot and Data Loss Prevention. |
| **Role-based access** | **View activity**: Insider Risk Management Analysts, Insider Risk Management Investigators, or Insider Risk Management role group. **Manage**: All roles needed to view activity, plus the Purview Content Analyst role in the Purview Agent Management role group. |
| **Trigger** | Runs on a selected schedule or on one alert at a time. |

#### How the triage agents categorize alerts

Both the DLP and Insider Risk Management triage agents sort triaged alerts into four categories:

- **Needs attention**: Alerts that the agent evaluated as posing the greatest risk to your organization.
- **Less urgent**: Alerts that the agent evaluated as posing a lower risk.
- **Not categorized**: Alerts the agent wasn't able to successfully triage, which can happen due to server errors, unsupported alert types, or processing issues.
- **All**: All alerts the agent has triaged.

The triage agents can run automatically on a set schedule or manually on one alert at a time. When deployed, you configure the alert timeframe the agent uses to decide which alerts to triage—ranging from only new alerts to alerts generated in the last 30 days.

#### Data Security Posture Agent (preview)

The [Data Security Posture Agent](/purview/copilot-in-purview-posture-agent-get-started) uses natural language prompts to help you discover sensitive data across your organization. Instead of relying on keyword- or filter-based search tools, the agent uses large language models (LLMs) to understand user intent and searches content across your Microsoft 365 ecosystem—including documents in SharePoint and OneDrive, messages in Teams, emails in Exchange, and Copilot interactions.

The agent is designed for preinvestigation checks rather than formal cases. When a prompt is processed, the agent returns a count of matched items along with any applied sensitivity labels and a risk-level assessment based on how closely the content matches the prompt. The **View Insights** option provides a report that includes a summary, risk assessment, findings, labeled or unlabeled items, and top unlabeled items.

In Data Security Investigations, the Posture Agent extends these capabilities to help proactively discover exposed credentials at scale across your tenant. The agent automates credential scanning across Microsoft 365 data locations, produces AI-generated risk assessments, and tracks tasks on a Kanban-style task board for streamlined review and remediation.

Key capabilities include:

- **Natural language search**: Find sensitive data using intent-based prompts rather than keywords, sensitive information types, or classifiers.
- **Risk-level assessments**: Each matched item includes a risk level based on content relevance to the prompt.
- **Exportable insight reports**: Download reports as Word documents for further analysis and sharing.
- **Credential scanning**: In Data Security Investigations, automates discovery of exposed credentials across the tenant.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Supports agent identity (recommended) or the organizational user account of the admin who deploys the agent. |
| **License** | Both the standard per user licensing model and the pay-as-you-go billing model. Microsoft 365 E5 with Security Compute Units (SCUs) provisioned. |
| **Permissions** | Requires roles from multiple groups: Purview Content Analyst; Compliance Admin, Security Reader, or Data Security AI viewer; Data Classification Content viewer and List viewer; Security Copilot Contributor or Owner. |
| **Plugins** | Microsoft Purview. |
| **Products** | Security Copilot and Data Security Posture Management. |
| **Role-based access** | Permissions for deploying, running, and viewing results require one role from each of four permission groups. |
| **Trigger** | Runs on demand when a user submits a natural language prompt. |


