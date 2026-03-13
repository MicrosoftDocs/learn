Microsoft Security Copilot agents in Microsoft Purview help triage Microsoft Purview Data Loss Prevention (DLP) and Microsoft Purview Insider Risk Management alerts. These agents are AI-powered assistants that work seamlessly with Microsoft security products to help security teams evaluate and categorize alerts.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Purview is continually growing. This unit is designed to provide a high-level overview of a few of the Security Copilot agents in Microsoft Purview. For more information, see training that relates to Microsoft Purview.

### Microsoft Security Copilot agents in Microsoft Purview

The following Microsoft Security Copilot agents are available in Microsoft Purview. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability.

#### Triage Agent in Insider Risk Management

The [Triage Agent in Insider Risk Management](/purview/copilot-in-purview-agents) helps security teams by evaluating alerts based on user risk, file risk, and activity risk. The agent then sorts the triaged alerts into categories that are presented in the insider risk management solution on the **Alerts** tab.

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

The [Alert Triage Agent in Data Loss Prevention](/purview/copilot-in-purview-agents) helps security teams by evaluating alerts based on the sensitivity risk, exfiltration risk, and policy risk. The agent then sorts the triaged alerts into categories that are presented in the DLP solution on the **Alerts** page.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs as the administrator who turned on the agent. Agent authentication expires after 90 days and must be renewed. |
| **License** | Both the standard per user licensing model and the pay-as-you-go billing model. Microsoft Purview Data Loss Prevention with Microsoft 365 E3/E5/A5/F5/G5. |
| **Permissions** | Access policy configurations and settings in DLP; read activities and events in Microsoft Purview; read file content and metadata involved in DLP alerts; store user feedback and apply feedback when evaluating DLP alerts. |
| **Plugins** | Microsoft Purview. |
| **Products** | Security Copilot and Data Loss Prevention. |
| **Role-based access** | **View activity**: Insider Risk Management Analysts, Insider Risk Management Investigators, or Insider Risk Management role group. **Manage**: All roles needed to view activity, plus the Purview Content Analyst role in the Purview Agent Management role group. |
| **Trigger** | Runs on a selected schedule or on one alert at a time. |


