You've deployed your application on infrastructure and services that are as cost-effective as possible, but what do you do when your business, customer demand, or application changes? How do you ensure that your costs aren't growing out of control relative to the resources required to run them? How do you detect areas to improve efficiency in your environment? Architectures aren't static, applications and demand will shift over time, and cloud services will evolve to introduce new features and cost savings. 

## Track your cloud spend

In order to make intelligent decisions, you need data. By looking at where your money is going, you can start comparing that to utilization to uncover where you may have waste within your environment.

An export of your billing data is available at any time. Using your billing data, you can track where your costs are going and how they're allocated across your resources. The challenge is that the billing data shows cost but not utilization. You'll have data that indicates you're paying for that large VM, but how much are you actually using it?

Azure Cost Management gives you insights where your spend is going, as well as underutilized resources. Azure Cost Management tracks your total spend, cost by service, and cost over time. You can drill down into resource types and instances. You can also break down your costs by organization or cost center by tagging resources with those categories.

:::image type="content" source="../media/4-grouped-daily-accum-view.png" alt-text="Screenshot of Azure Cost Management":::

Azure Advisor also has a cost component. It recommends VM resizing, buying reserved instances when more cost effective than pay-as-you-go instances. It identifies unused ExpressRoute circuits and idle virtual network gateways. Advisor makes additional recommendations in the areas of performance, high availability, and security.

The important part is to take time to review your spend and evaluate where your money is going. Identify areas of inefficiency to ensure you're operating as efficiently as possible.

## Conduct cost reviews

After you have your Azure services running, regularly check costs to track your Azure spending. You can use cost analysis to understand where costs originated for your Azure usage.

:::image type="content" source="../media/4-cost-analysis.png" alt-text="Screenshot of cost analysis in the Azure portal":::

Take time as an organization to regularly meet and review billing and expenditures related to cloud services. Review expenditures with the technical and business stakeholders for each application. This brings increased visibility to the costs associated with an application, and the decisions made from a cost perspective. 

## Respond to cost alerts

One of the key features of Azure Cost Management is the ability to configure alerts around spending. These alerts can provide immediate visibility into spending that may be exceeding your budget, allowing you to take necessary steps to address these costs. There are three types of cost alerts: budget alerts, credit alerts, and department spending quota alerts.

*Budget alerts* notify you when spending, based on usage or cost, reaches or exceeds the amount defined in the alert condition of the budget. Budgets in Cost Management help you plan for and drive organizational accountability. With budgets, you can account for the Azure services you consume or subscribe to during a specific period. They help you inform others about their spending to proactively manage costs, and to monitor how spending progresses over time. When the budget thresholds you've created are exceeded, alerts can be sent to the approprate teams. Budgets can be set at varying levels, from resource groups to subscriptions, to enterprise agreements.

*Credit alerts* notify you when your Azure credit monetary commitments are consumed. Monetary commitments are for organizations with Enterprise Agreements.

*Department spending quota alerts* notify you when department spending reaches a fixed threshold of the quota. Spending quotas are configured in the EA portal. Whenever a threshold is met it generates an email to department owners and is shown in cost alerts.

## Report anomalies

Anytime during data collection, cost reviews, or cost alerts that an anomaly in spending is identified, report it to the necessary stakeholders. Active engagement on cost can ensure that you identify a potential for cost overrun before it becomes problematic. Transparency with stakeholders is important so they can fully understand any technical or business decisions that led to or are outcomes of any abnormal cloud costs.
