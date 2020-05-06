You've deployed your application using infrastructure and services that are as cost-effective as possible, but what do you do when your business, customer demand, or application changes? How do you ensure that your costs aren't growing out of control relative to the resources that are required to run them? How do you detect areas to improve efficiency in your environment? Architectures aren't static, resource demands will shift over time, and cloud services will evolve to introduce new features and cost savings. 

## Track your cloud spend

In order to make intelligent decisions, you need data. By analyzing where your money is going, you can compare your costs to your utilization in order to discover where you may have waste within your environment.

An export of your billing data is available at any time. Using your billing data, you can track where your costs are going, and how they're allocated across your resources. However, one challenge for you is that the billing data shows your costs, but not your utilization. You'll have data that indicates you're paying for a large VM, but how much are you actually using it?

Azure Cost Management gives you insights where your spend is going, as well as underutilized resources. Azure Cost Management tracks your total spend, cost by service, and cost over time. You can drill down into resource types and instances. You can also break down your costs by organization or cost center by tagging resources with those categories.

:::image type="content" source="../media/4-grouped-daily-accum-view.png" alt-text="Screenshot of Azure Cost Management":::

Azure Advisor also has a cost component. It recommends VM resizing when necessary, identifies unused ExpressRoute circuits and idle virtual network gateways, or advises when to consider buying reserved instances when that may be more cost effective than using pay-as-you-go instances. Azure Advisor makes additional recommendations in the areas of performance, high availability, and security.

The important part is to take time to review your spend and evaluate where your money is going. Effective analysis will help you identify areas of inefficiency and ensure you're operating as efficiently as possible.

<!-- TODO: You use "inefficiency" and "efficiently" within a few words of each other; you should try to find something that doesn't sound redundant. -->

## Conduct cost reviews

After you have your Azure services running, you should regularly check your costs to track your Azure spending. You can use cost analysis to understand where the costs originated for your Azure usage.

:::image type="content" source="../media/4-cost-analysis.png" alt-text="Screenshot of cost analysis in the Azure portal":::

Take time as an organization to regularly meet and review billing and expenditures that are related to cloud services, and review the respective expenditures with the technical and business stakeholders for each application. This brings increased visibility to the costs that are associated with an application, and the decisions made from a cost perspective. 

## Respond to cost alerts

One of the key features of Azure Cost Management is the ability to configure alerts that are based on spending. These alerts can provide immediate visibility into spending that may be exceeding your budget, which allows you to take necessary steps to address these costs. There are three types of cost alerts: *budget alerts*, *credit alerts*, and *department spending quota alerts*.

- *Budget alerts* notify you when spending, based on usage or cost, reaches or exceeds the amount defined in the alert condition of the budget. Budgets in Azure Cost Management help you plan for and drive organizational accountability. With budgets, you can account for the Azure services that you consume or subscribe to during a specific period. They help you to proactively inform others about their spending, and to monitor how spending progresses over time. When the budget thresholds that you've created are exceeded, alerts can be sent to the appropriate teams. Budgets can be set at varying levels, from resource groups to subscriptions, to enterprise agreements.

- *Credit alerts* notify you when your Azure credit monetary commitments are consumed. Monetary commitments are for organizations with Enterprise Agreements.

<!-- TODO: You use "enterprise agreements" in the first bullet point and "Enterprise Agreements" in the second; they should be consistent. -->

- *Department spending quota alerts* notify you when department spending reaches a fixed threshold of the quota. Spending quotas are configured in the Enterprise Agreements portal. When a threshold is met, it generates an email to department owners and is shown in cost alerts.

<!-- TODO: What does "it" mean in "it generates an email?" Azure Cost Management? -->

## Report anomalies

When an anomaly in spending is identified through your data collection, cost reviews, or cost alerts, you should report it to the necessary stakeholders. Active engagement on cost can ensure that you identify a potential for cost overrun before it becomes problematic. Transparency with stakeholders is important so they can fully understand any technical or business decisions that were the cause of any abnormal cloud costs.
