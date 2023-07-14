Now that Contoso can see its costs, it's increasingly important that Fabrikam keeps those costs in line. Microsoft Cost Management has a budgeting tool that helps both Fabrikam and Contoso create their own budgets that alert as spending increases. You can create cost thresholds for Fabrikam to use that apply to Contoso specifically, or to any other customer. The budgets will evaluate based on costs that accrue at Fabrikam's discounted rates.

Similarly, either you or Contoso can create budgets within Contoso's tenant. The budgets will monitor costs as they accrue at pay-as-you-go rates. Given Contoso's recent interest in the costs, you plan to set up some initial budgets for it. You want to encourage Contoso to alter the thresholds and alerts as needed.

## Create a budget for Contoso by using Fabrikam's discounted rates

To create a budget for Contoso, go to **Cost Management + Billing** and select Contoso from your list of available customers.

:::image type="content" source="../media/06-customer-list.png" alt-text="Screenshot that shows the list of customers." lightbox="../media/06-customer-list.png" :::

From there, select **Budgets** on the menu and select **Add**. The budget you're creating will evaluate at the Contoso customer scope within Fabrikam's billing hierarchy. It will evaluate costs based on Fabrikam's discounted partner rates.

In the **Create budget** window, make sure that the scope shown is correctly identified as Contoso. Choose any filters that you want to add. Filters allow you to create budgets on specific costs, such as resource groups in a subscription or a service like Azure Virtual Machines. Any filter that you can use in cost analysis can also be applied to a budget.

After you've identified your scope and filters, enter a budget name. Then, choose a monthly, quarterly, or annual budget reset period. This reset period determines the time window that the budget analyzes. The cost that the budget evaluates starts at zero at the beginning of each new period.

When you create a quarterly budget, it works in the same way as a monthly budget. The difference is that the budget amount for the quarter is evenly divided among the three months of the quarter. An annual budget amount is evenly divided among all 12 months of the calendar year.

Next, identify the expiration date when the budget becomes invalid and stops evaluating your costs.

Based on the fields chosen in the budget so far, a graph is shown to help you select a threshold to use for your budget. The suggested budget is based on the highest forecasted cost that Contoso might incur in future periods. You can change the budget amount.

:::image type="content" source="../media/06-create-budget-wizard.png" alt-text="Screenshot that shows creating a budget and setting its evaluation period." lightbox="../media/06-create-budget-wizard.png" :::

After you configure the budget amount, select **Next** to configure budget alerts. Budgets require at least one cost threshold (percentage of budget) and a corresponding email address. You can optionally include up to five thresholds and five email addresses in a single budget. When a budget threshold is met, email notifications are normally received in less than 20 hours.

If you want to receive emails, add azure-noreply@microsoft.com to your approved senders list so that emails don't go to your junk email folder.

In the following example, an email alert is generated and sent to admin@fabrikam.com when 90 percent of the budget is reached.

:::image type="content" source="../media/06-create-budget-alert.png" alt-text="Screenshot that shows creating a budget with alert conditions." lightbox="../media/06-create-budget-alert.png" :::

## Create budgets for Contoso to monitor its own costs

The budget and corresponding alert emails created in the previous section use Fabrikam's discounted partner rates. The budget can send emails to people within the Fabrikam organization.

Contoso wants to get similar emails, so you plan to create a budget for Contoso on each of its subscriptions. The budget will send emails as pay-as-you-go costs increase. To create budgets and notifications, you need to have an account with RBAC access to the subscriptions in Contoso's tenant.

To create a budget, sign in to the Azure portal with an account that has the required permissions in the Contoso tenant. Select the **Subscriptions** area to view each of Contoso's subscriptions to which you have access.

:::image type="content" source="../media/06-subscription-list.png" alt-text="Screenshot that shows Contoso accessing its own subscription." lightbox="../media/06-subscription-list.png" :::

From there, select a subscription and select **Budgets** from the corresponding menu that appears. The budget creation process within the Contoso tenant follows the same process described in the previous section. If you're looking to create more fine-grained budgets for Contoso, you can also configure budgets at the resource-group scope.
