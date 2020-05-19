Now that you have learned how to create a budget, it is time to try creating your first one on your own. You should have determined your most expensive resource in a previous exercise. If this resource starts accruing more cost, you could see a significantly higher bill at the end of the month. In this exercise, you create a budget to help ensure that costs are monitored. When costs exceed the budget, email alerts are sent to people responsible.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

## Access the Azure portal

To start, sign in to the Azure portal using the following step.

- Sign in to the [Azure portal](https://portal.azure.com) and enter your credentials.
Navigate to Budgets

## Navigate to budgets

Next, in the Azure portal, navigate to budgets.

1. In the portal search box, type *Subscriptions*.
1. In the list of services, select **Subscriptions**.
1. In the list of subscriptions, select the subscription that you analyzed in the previous exercise. The subscription contains your most expensive resource.
1. In the Cost Management area, select **Budgets**.


## Configure your budget

Next, create a budget.

1. Select **+Add** in the Budgets area, then select **Add filter**.
1. Select the Filter list item, select **ResourceID**.
1. Select the selection list and then select your most expensive resource that you identified in the pervious exercise.
    A suggested budget is shown. The budget is associated with your selection.
1. Name your budget. For example, *MyFirstBudget*.
1. Set the **Reset period** to **Monthly**.
1. Examine the **Budget amount** recommendation based on your filter. Then, analyze the **View of monthly cost data** graph to determine if the threshold meets your needs.
1. Optionally, change the budget amount to any value that you like.
1. When you've decided on a budget amount, select **Next**.

## Configure a budget alert threshold

Lastly, configure a budget threshold and specify an email address for alert notification.

1. Configure the alert condition for *90%* of the budget. Don't specify an action group.
1. Type your email address in the **Alert recipients (email)** section.
1. Examine the **View of monthly cost data** graph and verify that the alert threshold is correct.
1. Select **Create**.
