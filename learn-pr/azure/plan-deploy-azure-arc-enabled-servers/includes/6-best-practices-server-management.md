Following successful Arc-enablement of Wide World Importers' thousands of servers, continuing to ensure these servers are organized and managed from the Azure plane is essential. Establish an operational baseline using resource organization, monitoring, configuration governance, and update management. Use Azure Policy assignments to deploy and govern supported Arc integrations at scale, and verify the resulting service configuration.

## Organize Azure Arc-enabled servers

Organize Arc-enabled servers by using resource groups and tags. A Log Analytics workspace isn't required for Arc registration or tagging. Select a workspace when enabling Azure Monitor log collection, Microsoft Sentinel, or other features that require one.

As Azure resources, Arc-enabled servers can be tagged for organization. You should evaluate and develop an IT-aligned tagging strategy that can help reduce the complexity of managing your Azure Arc-enabled servers and simplify making management decisions.

To enable guest log collection, first connect the machine to Azure Arc. Follow the AMA deployment guidance for Arc-enabled servers to deploy Azure Monitor Agent (AMA), create a data collection rule (DCR) that specifies the required data sources and destination workspace, and associate the DCR with the Arc-enabled server. At scale, use the appropriate Azure Policy definitions to deploy the agent and DCR associations. Verify that the expected data arrives in the destination workspace before expanding the deployment. Consider setting up workspaces tied to Microsoft Sentinel for security and threat intelligence applications.

> [!NOTE]
> AMA and the Connected Machine agent have different responsibilities. Keep the Connected Machine agent installed. Installing AMA without a suitable DCR association doesn't configure log collection. Each optional service has its own operating-system and feature-support requirements; Arc compatibility alone doesn't establish compatibility with every extension.

## Ensure Arc-enabled server connectivity

Use a Resource Health alert to notify operators when an Azure Arc-enabled server becomes unavailable. The Connected Machine agent sends heartbeats every five minutes. If heartbeats stop, the server's status changes to Disconnected within 15 to 30 minutes, as described in Azure Arc agent status. This isn't an immediate operating-system or application-availability check.

Before creating alerts, confirm that you can read the target resources and have the monitoring permissions needed to create alert rules and configure their action groups at the intended scopes. Read access to an existing action group is also required to associate it. An Azure Connected Machine role alone doesn't grant monitoring-resource administration. Create the alert by completing the following steps:

1. Sign in to the Azure portal, search for **Service Health**, open **Resource Health**, and select **Add resource health alert**. Follow the Resource Health alert creation procedure.
1. On **Scope**, select the subscription and resource group containing the servers. Select **Azure Arc-enabled servers** as the resource type and the resources to monitor. Include future resources if the rule must cover servers added later.
1. On **Condition**, use the Resource Health signal and set **Current resource status** to **Unavailable**. Set **Previous resource status** to **All** to detect an unavailable state regardless of the preceding state. Review the event-status and reason-type filters for the incidents you intend to receive.
1. On **Actions**, select an existing action group with the required notification receivers, or create one using the action-group setup instructions.
1. Complete **Details**, review the target scope and conditions, and create the alert rule. Confirm that the saved rule is enabled and references the intended action group.
1. Save any action-group changes and complete any required receiver verification. Then use the action group's Test function to confirm delivery to the intended receivers. When a matching Resource Health event occurs, inspect the fired alert and notification to confirm the rule's event-to-notification path.

> [!NOTE]
> An action-group test checks notification delivery; it doesn't simulate an Arc agent disconnection or prove that an alert's scope and conditions match a real event. Don't disconnect production servers merely to test an alert. Use a disposable test server if an end-to-end disconnection exercise is required.

## Manage the Connected Machine agent

After initial deployment of the Azure Arc-enabled servers Connected Machine agent for Windows or Linux, you might need to reconfigure the agent, upgrade it, or remove it from the computer. You can easily manage these routine maintenance tasks manually or through automation, which reduces both operational error and expense.

Keep the Connected Machine agent up to date. Azure Advisor identifies servers running an older agent and recommends an upgrade. Review existing recommendations, then configure an alert for new recommendations using the Advisor alert creation procedure:

1. In the Azure portal, open **Advisor**, select **Alerts** under **Monitoring**, and select **New Advisor Alert**.
1. Select the subscription and, if appropriate, the resource group containing the servers. Configure the condition by **Recommendation type** and select **Upgrade to the latest version of the Azure Connected Machine agent**.
1. Select or create an action group with the intended notification receivers. You can reuse the action group configured for connectivity alerts.
1. Specify the alert name and the resource group in which to save the alert rule, enable the rule, and finish creating it. The rule's storage resource group isn't the same setting as the target scope. Confirm the saved configuration and test action-group delivery.

> [!NOTE]
> Advisor alerts notify you about new recommendation events; they don't replace reviewing existing recommendations or upgrading the agent. Follow the agent version-management guidance to select an appropriate manual or automated upgrade method.

## Begin using Azure services

Choose the services required for each workload: AMA and DCRs for telemetry, Change Tracking and Inventory for configuration-change visibility, Machine Configuration for supported guest settings, Azure Update Manager for patching, and the appropriate paid Microsoft Defender for Servers plan for server protection. Monitor compliance and deployment results, and respond to failed assignments or configuration drift. Use the following recommendations to organize and manage these services:

| Recommendation | Description |
|---|---|
| Apply tags to help organize machines | Evaluate and develop an IT-aligned tagging strategy that can help reduce the complexity of managing your Azure Arc-enabled servers and simplify making management decisions. |
| Design and deploy Azure Monitor Logs | Select an existing or new Log Analytics workspace, deploy AMA, configure DCR data sources and the destination workspace, and associate the DCRs with the servers. Verify that the expected data arrives in the workspace. |
| Develop an Azure Policy governance plan | Determine how you want to implement governance of hybrid servers and machines at the subscription or resource group scope with Azure Policy. |

> [!NOTE]
> Azure Automanage Best Practices is scheduled to retire on September 30, 2027. Its support and enforcement for legacy-agent-dependent services began being withdrawn in February 2025, and it doesn't configure AMA. For new deployments, use the applicable Azure Policy definitions and configure the required services directly. Existing users should plan the documented migration to Azure Policy.
