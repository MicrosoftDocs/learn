Microsoft Azure is a global cloud provider, meaning you can provision resources anywhere in the world. You can provision resources rapidly to meet a sudden demand, to test out a new feature, or accidentally. If you accidentally provision new resources, you may not be aware of them until it’s time for your invoice. Cost Management is a service that helps avoid those situations.

## What is Cost Management?

Cost Management provides the ability to quickly check Azure resource costs, create alerts based on resource spend, and create budgets that can be used to automate management of resources.

:::image type="content" source="../media/cost-management-overview.png" alt-text="Diagram showing the three pillars of Azure Cost Management: Cost Analysis for viewing costs by region, resource, or service; Cost Alerts for budget, credit, and department spending quota notifications; and Budgets for setting spending limits and automating actions at thresholds.":::

Cost analysis is a feature within Cost Management that provides a quick visual for your Azure costs. Using cost analysis, you can quickly view the total cost in a variety of different ways, including by billing cycle, region, resource, and so on.

You use cost analysis to explore and analyze your cloud costs. You can view aggregated costs by subscription, resource group, or service to understand where costs accrue and identify spending trends. You can also see accumulated costs over time to estimate monthly, quarterly, or yearly cost trends against a budget.

Common tasks with Cost Management include spotting a sudden spend increase after a deployment, identifying idle resources in nonproduction subscriptions, and validating whether tagging and budgets are working as expected.

## Cost alerts

Cost alerts provide a single location to quickly check on all of the different alert types that may show up in the Cost Management service. The three types of alerts that may show up are:

 -  Budget alerts
 -  Credit alerts
 -  Department spending quota alerts.

### Budget alerts

Budget alerts notify you when spending reaches or exceeds a threshold you define. You can create budgets in the Azure portal or through the Azure Consumption API.

In the Azure portal, budgets are defined by cost. If you use the Azure Consumption API, you can also define budgets by consumption usage. Budget alerts are generated automatically whenever the budget alert conditions are met. You can view all cost alerts in the Azure portal. Whenever an alert is generated, it appears in cost alerts, and an alert email is also sent to the people in the alert recipients list of the budget.

For example, you might set an alert at 80% of a monthly dev/test budget so your team can investigate and right-size resources before costs exceed target.

### Credit alerts

Credit alerts notify you when your Azure credit monetary commitments are consumed. Monetary commitments are for organizations with Enterprise Agreements (EAs). Credit alerts are generated automatically at 90% and at 100% of your Azure credit balance. Whenever an alert is generated, it's reflected in cost alerts, and in the email sent to the account owners.

### Department spending quota alerts

Department spending quota alerts are specific to Enterprise Agreement customers. They notify you when department spending reaches a fixed threshold of the quota. Spending quotas are configured in the EA portal. Whenever a threshold is met, it generates an email to department owners, and appears in cost alerts. For example, 50 percent or 75 percent of the quota.

## Budgets

A budget is where you set a spending limit for Azure. You can set budgets based on a subscription, resource group, service type, or other criteria. When you set a budget, you will also set a budget alert. When the budget hits the budget alert level, it will trigger a budget alert that shows up in the cost alerts area. If configured, budget alerts will also send an email notification that a budget alert threshold has been triggered.

You can also configure budgets to trigger automation that suspends or modifies resources when a spending threshold is reached. For instance, you can automate shutdown of nonproduction resources when a budget threshold is reached.

