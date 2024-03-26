Contoso has been emailing you repeatedly about its costs in recent weeks. You decide that it's best to allow Contoso to see and manage its own costs in the Azure portal.

Contoso has already been onboarded to the Microsoft Customer Agreement. You can now turn on a policy to allow Contoso to view its Azure consumption costs computed at pay-as-you-go retail rates. The same rates are shown in the Azure Pricing Calculator. Enabling the policy will keep Fabrikam's discounted costs hidden from Contoso while giving Contoso the capability to control its Azure spending.

> [!NOTE]
> The price displayed to customers is the retail price in the Pricing Calculator. It doesn't include the partner earned credit, global Azure service discounts, the tier, and other discounts that are issued only to the partner.

When you make cost visible for Contoso, any user with Azure Resource Manager access to Contoso's subscription can manage and analyze costs at pay-as-you-go rates. Both Fabrikam resellers and Contoso employees who have the appropriate role-based access control (RBAC) access to the Azure subscriptions can view costs.

## Enable the policy to view Azure usage charges

To enable cost visibility for Contoso, follow these steps:

1. In the Azure portal, sign in to Fabrikam's tenant and select **Cost Management + Billing**. Select the relevant Microsoft Partner Agreement billing account, then select **Customers**. The list of customers is associated with the billing account.
1. In the list of customers, select **Contoso**.  
    :::image type="content" source="../media/05-billing-account-customers.png" alt-text="Screenshot that shows a list of customers." lightbox="../media/05-billing-account-customers.png" :::
1. Under **Settings**, select **Policies**.
1. The current cost visibility policy is shown for **Azure Usage** charges associated with the subscriptions for Contoso.  
    :::image type="content" source="../media/05-view-customer-cost-policy.png" alt-text="Screenshot that shows the cost visibility policy." lightbox="../media/05-view-customer-cost-policy.png" :::

When the cost visibility policy is set to **No**, Microsoft Cost Management isn't available for subscription users associated with Contoso. Unless Fabrikam enables it, the policy is disabled by default for all subscription users.

When the cost visibility policy is set to **Yes**, subscription users associated with Contoso's tenant can see usage charges at pay-as-you-go rates. When the policy is enabled, all services that have subscription usage show costs at pay-as-you-go rates.

## View Contoso's costs in its tenant

To view costs in Contoso's tenant, open **Cost Management + Billing**. Select **Cost analysis**, and then change the scope to one of Contoso's subscriptions to start reviewing costs. Anyone with RBAC access to Contoso's subscriptions can see these views.

:::image type="content" source="../media/05-view-costs-in-tenant.png" alt-text="Screenshot that shows subscription costs for the tenant." lightbox="../media/05-view-costs-in-tenant.png" :::

Cost analysis, budgets, and alerts are available for the subscription and resource group RBAC scopes at pay-as-you-go rate-based costs for Azure consumption services.

Amortized views and actual costs for reserved instances in the RBAC scopes show zero charges. Customers can't see Azure reservation purchases made by Fabrikam. The purchases roll up into Fabrikam's billing account only. Reserved instance and other purchase costs, like Azure Marketplace and SaaS, are shown only in Fabrikam's billing hierarchy scopes where the purchases were made.
