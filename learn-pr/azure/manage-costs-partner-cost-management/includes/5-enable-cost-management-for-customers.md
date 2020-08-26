Contoso has been emailing you repeatedly about its costs in recent weeks. You decided it would be best to allow them to see and manage their own costs in the Azure portal. Contoso has already been onboarded to the Microsoft Customer Agreement. You're now able to turn on a policy to allow them to view their Azure consumption costs computed at pay-as-you-go retail rates. The same rates shown in the Azure Pricing Calculator. Enabling the policy will keep Fabrikam's discounted costs hidden from Contoso while giving them the capabilities to control their Azure spending.

> [!NOTE]
> The price displayed to customers is the retail price in Pricing Calculator. It doesn't include the Partner Earned Credit, Global Azure Service Discounts, Tier, and other discounts that are issued only to the partner.

When you make cost visible for Contoso, any user with Azure Resource Manager access to Contoso's subscription can manage and analyze costs at Pay-As-You-Go rates. Both Fabrikam resellers and Contoso employees that have the appropriate RBAC access to the Azure subscriptions can view costs.

## Enable the policy to view Azure usage charges

To enable cost visibility for Contoso, follow the steps outlined below.

1. In the Azure portal, sign into Fabrikam's tenant and select **Cost Management + Billing**. Select the relevant Microsoft Partner Agreement billing account, and then select **Customers**. The list of customers is associated with the billing account.
1. In the list of customers, select **Contoso**.  
    :::image type="content" source="../media/05-billing-account-customers.png" alt-text="Example showing a list of customers" lightbox="../media/05-billing-account-customers.png" :::
1. Under **Settings**, select **Policies**.
 1. The current cost visibility policy is shown for **Azure Usage** charges associated to the subscriptions for Contoso.  
    :::image type="content" source="../media/05-view-customer-cost-policy.png" alt-text="Example showing cost visibility policy" lightbox="../media/05-view-customer-cost-policy.png" :::

When the policy is set to **No**, Azure Cost Management isn't available for subscription users associated to Contoso. Unless enabled by Fabrikam, the cost visibility policy is disabled by default for all subscription users.

When the cost policy is set to **Yes**, subscription users associated to Contoso's tenant can see usage charges at Pay-As-You-Go rates.

When the cost visibility policy is enabled, all services that have subscription usage show costs at Pay-As-You-Go rates.

## View Contoso's costs in their tenant

To view costs in Contoso's tenant, open **Cost Management + Billing**. Select **Cost analysis** and then change the scope to one of Contoso's subscriptions to start reviewing costs. Anyone with RBAC access to Contoso's subscriptions can see these views.

:::image type="content" source="../media/05-view-costs-in-tenant.png" alt-text="Example showing subscription costs for the tenant" lightbox="../media/05-view-costs-in-tenant.png" :::

Cost analysis, budgets, and alerts are available for the subscription and resource group RBAC scopes at pay-as-you-go rate-based costs for Azure consumption services.

Amortized views and actual costs for reserved instances in the RBAC scopes show zero charges. Customers can't see Azure reservation purchases made by Fabrikam. The purchases roll up into Fabrikams billing account only. Reserved instance and other purchase costs like Marketplace and SaaS are only shown in Fabrikam's Billing hierarchy scopes where the purchases were made.