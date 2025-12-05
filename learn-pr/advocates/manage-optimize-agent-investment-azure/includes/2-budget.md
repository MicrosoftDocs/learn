By leveraging Cost Management budgets, Microsoft Foundry quotas, and Azure Monitor alerts, you can build a robust cost governance strategy for AI workloads. These tools empower you to forecast expenses, control
usage, and respond to cost anomalies, ultimately improving ROI and operational efficiency.

## Create and manage budgets in Microsoft Cost Management

Creating and managing budgets in Microsoft Cost Management is a key strategy for improving the ROI of AI agents by enabling proactive financial oversight and control. Budgets allow organizations to set spending limits for specific subscriptions, resource groups, or services, helping teams stay aligned with financial goals. By monitoring actual usage against these predefined thresholds, stakeholders can detect overspending early, adjust resource allocation, and avoid unexpected charges. Budget alerts also ensure that decision-makers are notified when costs approach or exceed limits, allowing for timely
intervention. This disciplined approach to cost tracking not only prevents waste but also ensures that AI investments are delivering value within acceptable financial boundaries.

### Steps

1. Navigate to **Cost Management + Billing** in the Azure portal.
1. Select **Budgets** under the **Cost Management** section.
1. Click **Add** to create a new budget.
1. Define the scope (subscription, resource group, etc.), set the budget amount, and choose the time period (monthly, quarterly, annually).
1. Configure alerts to notify stakeholders when spending reaches specific thresholds (for example, 80%, 100%). Budget alerts support automated actions through run books and web hooks.

### Benefits

- Prevents budget overruns.
- Enables financial accountability across teams.
- Supports forecasting and planning.

## Create and manage quotas in Microsoft Foundry

Creating and managing quotas in Microsoft Foundry is essential for improving the ROI of AI agents by ensuring controlled and efficient use of compute resources. Azure uses quotas and limits to prevent budget overruns due to fraud and to honor Azure capacity constraints. Quota management also supports scalability by allowing teams to request increases only when justified by performance or business needs. This disciplined approach helps align technical operations with financial goals, ensuring that AI agents deliver value without exceeding budget constraints.

### Steps

1. In the **AI Foundry portal**, go to **Management Center**.
1. Select **Quota** from the left menu.
1. Use the **Show all quota** toggle to view allocated and available quotas.
1. Group quotas by **Region**, **Model**, or **Quota Type** for better visibility.
1. To request more quota:
    - Click the **pencil icon** to edit existing allocations.
    - Use the **Request quota** button to submit a quota increase request.
1. Use the **Provisioned Throughput** calculator to estimate capacity needs.

### Best practices

- Use shared quota pools for testing.
- Request dedicated quota for production workloads.
- Monitor quota usage with interactive charts.

## Create and manage alerts in Azure Monitor

Creating and managing alerts in Azure Monitor is a crucial tactic for improving the ROI of AI agents by enabling real-time cost and performance oversight. Alerts allow teams to respond immediately to anomalies such as unexpected spikes in usage or degraded performance. By setting up automated notifications based on custom metrics, such as daily spend, quota consumption, or model latency, organizations can prevent costly incidents before they escalate. This proactive monitoring reduces downtime, optimizes resource allocation, and ensures that AI agents operate within defined financial and operational boundaries. Ultimately, Azure Monitor alerts help maintain control, reduce waste, and ensure that AI investments deliver consistent value.

### Steps

1. In the Azure portal, go to **Monitor**.
1. Select **Alerts** and click **New Alert Rule**.
1. Choose a **scope** (for example, subscription or resource group).
1. Define a **condition**, such as cost exceeding a certain amount.
1. Set up an **action group** to notify stakeholders via email, SMS, or webhook.
1. Review and create the alert rule.

> [!NOTE]
> You should use dynamic thresholds for metrics that vary a lot, such as latencies and error rates. Dynamic thresholds enable the alert to learn how a metric typical varies over time and reduce false positives.

### Use cases

- Alert when daily spend exceeds a threshold.
- Detect anomalies in usage patterns.
- Notify finance teams of budget breaches.
