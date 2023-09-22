Now that you've learned how to create a budget, it's time to create your first one on your own. You should have determined your most expensive resource in a previous exercise. If this resource starts accruing more cost, you could see a higher bill at the end of the month. In this exercise, you create a budget to help ensure that costs are monitored. When costs exceed the budget, email alerts are sent to people responsible.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Access the Azure portal

To start, sign in to the Azure portal using the following step.

- Enter your credentials and sign in to the [Azure portal](https://portal.azure.com).

## Navigate to Budgets

Next, in the Azure portal, we go to **Budgets**.

1. In the portal search box, enter *Subscriptions*.

1. In the list of services, select **Subscriptions**.

1. In the list of subscriptions, select the subscription that you analyzed in the previous exercise. The subscription contains your most expensive resource.

1. In the menu, under **Cost Management**, select **Budgets**. The **Budgets** pane appears.

## Configure your budget

Next, create a budget.

1. From the top menu, select **Add**, and then, under **Budget scoping**, select **Add filter**.

1. From the Filter dropdown list, select **ResourceId**.

1. In the selection dropdown list, select your most expensive resource that you identified in the previous exercise. A suggested budget appears. The budget is associated with your selection.

1. Name your budget (for example: *MyFirstBudget*).

1. Set the **Reset period** to **Monthly**.

1. Examine the **Budget Amount** recommendation based on your filter. Then, analyze the **View of monthly cost data** graph to determine if the threshold meets your needs.

1. Optionally, change the budget amount to any value that you like.

1. When you've decided on a budget amount, select **Next**.

## Configure a budget alert threshold

Lastly, configure a budget threshold, and specify an email address for alert notification.

1. Configure the alert condition for *90%* of the budget. Don't specify an action group.

1. Enter your email address in the **Alert recipients (email)** section.

1. Examine the **View of monthly cost data** graph, and verify that the alert threshold is correct.

1. Select **Create**.
