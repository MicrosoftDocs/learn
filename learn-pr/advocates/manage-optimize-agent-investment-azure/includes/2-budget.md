By leveraging Cost Management budgets, Microsoft Foundry quotas, and Azure Monitor alerts, you can build a robust cost governance strategy for AI workloads. These tools empower you to forecast expenses, control
usage, and respond to cost anomalies, ultimately improving ROI and operational efficiency.

## Create and manage budgets in Microsoft Cost Management

Microsoft Cost Management budgets compare accumulated costs with an amount that you define. They can notify stakeholders when actual or forecasted costs cross configured thresholds, but they don't stop resources, consumption, or billing. Create a budget at a supported Cost Management scope, such as a management group, subscription, resource group, or supported billing scope for your agreement. Use filters to narrow the evaluated costs to a service, resource group, resource, or tag. A service, resource, or tag is a filter within a supported scope, not a budget scope.

### Steps

1. In the Azure portal, open the scope that should own the budget, such as a management group, subscription, or resource group, and then select **Budgets**. You can also open **Cost Management + Billing** and use the **Scope** selector to move to an available scope.
1. Select **Add**. Confirm the **Scope**, and add any required filters. For available filter fields, see [Group and filter properties](/azure/cost-management-billing/costs/group-filter#group-and-filter-properties).
1. Enter the budget name and amount. Select the **Reset period**, such as **Monthly**, **Quarterly**, or **Annually**, and set the expiration date. The reset period determines when evaluated cost starts again at zero; the expiration date determines when the budget stops evaluating costs and is deleted.
1. Select **Next**. Configure at least one threshold and corresponding email recipient. For each threshold, set **Type** to:
    - **Actual** to compare accrued cost with the budget amount.
    - **Forecasted** to notify recipients when projected cost is expected to exceed the threshold.
1. Optional: For a subscription or resource-group budget, attach an Azure Monitor action group to a notification condition. Action groups aren't supported for other budget scopes. Treat any runbook, function, logic app, or webhook as a separately designed, authorized, and tested remediation workflow; the budget itself doesn't enforce spending. For an example, see [Azure billing and cost management budget scenario](/azure/cost-management-billing/manage/cost-management-budget-scenario).
1. Review and create the budget.

> [!IMPORTANT]
> Cost and usage data is typically available within 8-24 hours, and budgets evaluate that data every 24 hours. Notifications are normally sent within an hour after an evaluation finds that a threshold is met. Don't rely on a budget for real-time protection or as a hard spending cap.

### Benefits

- Establishes financial accountability at an appropriate organizational or billing scope.
- Provides actual-cost and forecast-based early warning.
- Can start a separately configured response workflow at supported scopes.

## Create and manage quotas in Microsoft Foundry

Microsoft Foundry quota governs model rate limits and deployment-capacity allocation; it isn't an accumulated-spend limit. For standard Azure OpenAI deployments, quota is assigned per subscription, region, model, and deployment type in tokens per minute (TPM). Assigning TPM to a deployment sets its TPM rate limit and a corresponding requests-per-minute limit. The token estimate used for rate limiting isn't the token count used for billing.

For provisioned deployments, PTU quota is a no-cost policy limit. A provisioned deployment holds dedicated capacity and is billed for the number of deployed PTUs, whether or not requests are being made. Quota can constrain deployment scale or request throughput, but it doesn't replace Cost Management budgets and alerts, and having PTU quota doesn't guarantee that model capacity is currently available.

### Required access

- To view quota allocations, assign **Cognitive Services Usages Reader** at subscription scope.
- To edit allocations in the Foundry portal, assign **Cognitive Services Contributor** together with **Cognitive Services Usages Reader**.
- To request quota increases, use **Owner** or **Contributor** at subscription scope.

### Steps

1. Sign in to Microsoft Foundry, make sure the **New Foundry** toggle is on, and open the project to manage.
1. In the upper-right navigation, select **Manage**, and then select **Quota** in the left pane.
1. Select the appropriate tab:
    - **Token per minute** for TPM allocations used by standard deployments.
    - **Provisioned throughput unit** for PTU allocations used by provisioned deployments and for capacity-estimation tools.
1. Select a deployment to open its details pane. Under **Affiliated deployments using shared quota**, select the pencil icon in the **Actions** column to reduce an unused allocation or increase an allocation when quota is available.
1. For a standard deployment, select **Request quota** where that action is supported for the model and region. After an allocation edit or an approved increase, allow up to 15 minutes for the change to propagate, and then refresh the **Quota** page.
1. For provisioned throughput sizing, open the capacity calculator from the **Quota** page. Enter the **Model**, **Version**, **Peak calls per min**, **Tokens in prompt call**, **Tokens in model response**, and **Cache rate**. Treat the result as an estimate and validate it with representative workload tests. For the sizing method, see [Determine PTU sizing for a workload](/azure/foundry/openai/how-to/provisioned-throughput-sizing).

### Best practices

- Use shared quota only for temporary test endpoints; request dedicated quota for production endpoints.
- Reallocate unused TPM before requesting an increase.
- Verify model capacity before creating or scaling a provisioned deployment because quota doesn't guarantee capacity.
- Track and govern financial cost separately in Microsoft Cost Management.

## Create and manage alerts for cost and operational signals

Cost, platform metrics, and quota are separate signal types. Use the service that owns each signal instead of treating daily spend or quota allocation as native Azure Monitor platform metrics.

### Cost Management budgets and anomaly alerts

- Use [Cost Management budgets](/azure/cost-management-billing/costs/tutorial-acm-create-budgets) for actual-cost and forecasted-cost threshold notifications.
- Use [Cost Management anomaly alerts](/azure/cost-management-billing/understand/analyze-unexpected-charges#create-an-anomaly-alert) for unexpected daily cost patterns. In the Azure portal, open **Cost Management**, select a subscription scope, select **Cost alerts** > **+ Add**, set **Alert type** to **Anomaly**, add the required recipients, and create the rule.
- Cost Management alerts aren't Azure Monitor metric alert rules and aren't real-time spending enforcement.

### Azure Monitor platform-metric alerts

1. In the Azure portal, select **Monitor** > **Alerts** > **+ Create** > **Alert rule**.
1. Select the Foundry resource, Azure OpenAI resource, or another supported Azure resource that emits the metric you want to monitor.
1. On **Condition**, select a supported platform metric from **Signal name**:
    - Foundry Models signals include **Model Requests**, **Input Tokens**, **Output Tokens**, **Total Tokens**, supported latency metrics such as **Time To Response**, and **Provisioned Utilization**.
    - Azure OpenAI signals include **Azure OpenAI Requests**, **Processed Prompt Tokens**, **Generated Completion Tokens**, supported latency metrics such as **Time to Response** and **Time to Last Byte**, and **Provisioned-managed Utilization V2**.
1. Configure the aggregation, threshold, evaluation frequency, and lookback period. Use a static threshold unless the selected signal supports a dynamic threshold and has enough representative history.
1. On **Actions**, optionally select or create an action group for notifications or automation.
1. Enter the alert rule details, select **Review + create**, and then select **Create**.

### Quota and API-derived data

- View and change quota allocations in Microsoft Foundry under **Manage** > **Quota**, or use the applicable management API.
- Quota allocation and daily cost don't automatically become Azure Monitor metric signals. If an Azure Monitor alert is required for API-derived data, build a collection process and publish a custom metric against an Azure resource, or send the data to Azure Monitor Logs, before creating an alert rule. See [Send metrics to Azure Monitor by using a REST API](/azure/azure-monitor/metrics/metrics-store-custom-rest-api).

> [!IMPORTANT]
> Use dynamic thresholds only for a supported signal with representative history and when significant-deviation detection is appropriate. A dynamic-threshold rule doesn't alert until it has at least three days and 30 samples, and it needs at least three weeks of history to learn weekly seasonality. Dynamic thresholds can miss slow drift, aren't available for every metric, and can't be used in alert rules that monitor multiple conditions. Use a static threshold when detection must start immediately or must detect gradual change.

### Use cases

- Notify finance or workload owners about actual or forecasted budget thresholds: Cost Management budget alert.
- Detect an unexpected daily cost pattern: Cost Management anomaly alert.
- Detect request, token, supported latency, availability, or provisioned-utilization conditions: Azure Monitor platform-metric alert.
- Inspect or change quota allocation: Microsoft Foundry **Manage** > **Quota** or the applicable management API.
