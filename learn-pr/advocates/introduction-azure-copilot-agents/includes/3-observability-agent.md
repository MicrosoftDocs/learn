An Azure Monitor alert tells you which condition fired. The Observability agent helps you investigate *why* by comparing metrics, logs, and traces across the affected resources. A fired alert doesn't start an investigation by default.

## Investigate a fired alert

Suppose an API latency alert fires shortly after a deployment in a [supported region](/azure/azure-monitor/aiops/observability-agent-overview#regions). You can investigate on demand without provisioning a dedicated agent resource.

> [!IMPORTANT]
> Both chat with monitoring data and deep investigations consume [Azure Agent Credits (AAC)](/azure/azure-monitor/aiops/observability-agent-billing). The charges go to the monitored resource's subscription.

Before starting, decide which resources you're authorized to share with the agent. Your permissions and the investigation scope limit what it can read, but you [can't exclude a single telemetry table or field](/azure/azure-monitor/aiops/observability-agent-governance-faq#can-i-control-which-data-is-shared-with-the-llm) from a resource in scope. If a resource contains data you can't share this way, leave it out or investigate it outside the agent. Don't paste secrets into chat.

The agent uses [Microsoft-managed encryption keys for conversations](/azure/azure-monitor/aiops/observability-agent-overview#current-limitations). If your policy requires customer-managed keys for this conversation, don't start agent chat or a deep investigation. Query the approved telemetry directly instead.

Closing an unsaved chat ends immediate access to it in that session. It doesn't immediately erase the conversation: the service can [retain prompts and responses for up to 30 days](/azure/azure-monitor/aiops/observability-agent-governance-faq#how-does-the-observability-agent-retain-data).

To [investigate on demand](/azure/azure-monitor/aiops/observability-agent-deep-investigations), start from the fired alert:

1. In **Azure Monitor > Alerts**, open the fired alert. If **Investigate** is available, select it. The temporary chat proposes a deep investigation scoped to that alert; it doesn't create an issue. You don't need to request another investigation.

   If **Investigate** isn't available and only the affected application's data is approved for sharing, open **Logs** in that Application Insights resource and select [**Observability Agent**](/azure/azure-monitor/aiops/observability-agent-chat#start-chat-from-the-logs-page). A shared [Log Analytics workspace](/azure/azure-monitor/logs/manage-access#compare-access-modes) can include other applications' telemetry that you have permission to read. Use workspace chat only if that scope is approved. Give the agent the API and alert time as context, not as an access restriction. If the agent or an approved chat scope isn't available, query the approved telemetry directly.
1. If you started from **Logs**, stay in ordinary chat if it answers your question. Otherwise, ask for a deep investigation. On either path, review the proposed resources and time window before starting the investigation. Include time before the deployment for comparison and add the deployment time as context. Include the database alongside the API only if both are approved.

   If the alert or issue workflow prompts for a [subscription-to-workspace association](/azure/azure-monitor/aiops/issues-how-to#associate-an-amw-with-a-subscription), have a **Contributor** on the target subscription review the scope and the intended Azure Monitor workspace before confirming. Confirming this one-time association can start the investigation. If no association is needed, confirm the reviewed scope when you're ready to start.
1. Follow the progress in the chat as the agent gathers available signals. In the report, compare request latency with dependency failures and database metrics. If database timeouts rose as the API slowed down, the report might identify slow database calls as a *likely cause*. Open traces for slow requests and check how much time they spent waiting for the database before deciding whether to roll back the deployment.

The report can use only telemetry that was collected in the selected time window and that you have permission to read. For example, [configure Application Insights to collect dependency telemetry](/azure/azure-monitor/aiops/observability-agent-best-practices) before you need to follow a request from the API to the database. If those traces are missing, record the gap rather than treating it as evidence that the database was healthy.

You don't need a fired alert to ask a question. Choose the approved **Logs** scope as above. For example, in the API's Application Insights resource, ask, “Which dependencies timed out during yesterday's deployment?”

## Save the findings for the next responder

:::image type="content" source="../media/observability-scope-handoff.svg" alt-text="Diagram that shows how an alert or Logs chat leads to an investigation, and how saving an issue changes who can read the findings.":::

An [Azure Monitor issue (preview)](/azure/azure-monitor/aiops/observability-agent-overview#run-a-deep-investigation) keeps the findings after chat ends. The subscription association supplies a default **Azure Monitor workspace**, not the Log Analytics workspace where you queried the logs. After the deep investigation finishes, select [**Create issue**](/azure/azure-monitor/aiops/issues-how-to#create-an-issue-from-an-investigation). If the dialog offers more than one associated workspace, choose the one approved for this incident. You need **Issue Contributor**, **Monitoring Contributor**, or **Contributor** on the workspace you select.

> [!IMPORTANT]
> Before saving, check who can read the workspace selected in the dialog and which [issue actions](/azure/azure-monitor/aiops/issues-overview#issue-actions) it has configured. Readers of that workspace can see the findings even if you don't send them a link. Creating the issue can notify recipients or trigger connected automation.

Review the name, severity, and impact time. Select **I understand**, then **Create** to save the issue in the selected workspace. Changing the saved issue's impact time later starts a new investigation.

Open the issue under **Monitor > Issues** and select **Copy link** to hand it off to the next responder. The link doesn't grant access; the responder needs access to the workspace.

## Choose when to investigate in the background

For background triage in public preview, you provision an Observability Agent resource. The [portal creation guide](/azure/azure-monitor/aiops/observability-agent-resource-create-portal) lists **Monitoring Contributor** on the agent's resource group for the person creating the agent. If creation is denied, identify the failed action. With your administrator, compare that action with the [current role definition](/azure/role-based-access-control/built-in-roles/monitor#monitoring-contributor) and [check your effective access](/azure/role-based-access-control/check-access) at the scope where it failed. Don't request **Owner** as a workaround.

In the portal, open **Observability Agents > Create**. Choose an Azure Monitor workspace in the agent's region. Under **Operations**, select a supported Application Insights resource in the **same subscription as the agent**. To attach an existing user-assigned managed identity, you need separate permission, such as [Managed Identity Operator](/azure/role-based-access-control/built-in-roles/identity#managed-identity-operator) on that identity.

Interactive investigations use your permissions. **Monitoring Contributor** doesn't let you grant roles. For background investigations, ask an [administrator authorized to assign roles at each scope](/azure/role-based-access-control/role-assignments-portal#prerequisites) to grant the following [runtime roles to the agent's managed identity](/azure/azure-monitor/aiops/observability-agent-resource-create-portal#identity-requirements), not to your user account:

- **Monitoring Reader** on each subscription that contains alert rules or application resources the agent needs to read.
- **Issue Contributor** on the destination Azure Monitor workspace where the agent saves issues.

For a user-assigned identity, have the administrator grant and verify these roles before you create the agent. For a system-assigned identity, have the administrator do this after creation, when the identity exists.

**Before selecting Create**, review [autonomous operations](/azure/azure-monitor/aiops/observability-agent-autonomous-operations) under **Operations**. Both **Allow the agent to run autonomously** and **Investigation** are on by default. In public preview, [alert correlation itself isn't billed, but a deep investigation it starts is billable](/azure/azure-monitor/aiops/observability-agent-billing#autonomous-operations).

- For automatic triage, leave the defaults on. The agent can group related alerts into an issue and start a deep investigation.
- To group the API's latency and dependency alerts but let the on-call responder decide whether to spend credits investigating, keep **Correlation + issue creation** enabled and clear **Investigation**.
- To stop all background work for this resource, turn off **Allow the agent to run autonomously**.

The agent doesn't mitigate the workload itself. Check the destination workspace's issue actions before enabling background issue creation: those actions can notify recipients or run automation when the agent creates an issue, even with **Investigation** turned off.

Once the settings match your choice, select **Create**. Authorized users can still investigate on demand with any of these settings.
