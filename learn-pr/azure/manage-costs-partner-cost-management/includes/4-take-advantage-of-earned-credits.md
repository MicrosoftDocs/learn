Billing partners who provide constant cloud-operations management become eligible for a *partner earned credit for services managed* on the customers' Azure tenant. Learn more about the benefit at [Partner earned credit](/partner-center/partner-earned-credit). The rest of the unit assumes you have basic knowledge of the program and want to use it for Fabrikam's benefit.

Partner earned credit means less costs for Fabrikam. When you receive a partner earned credit for services managed, the credit is built into the invoiced prices and cost on the invoice. The price applied when Azure computes the invoiced costs factors in the credit. Fabrikam receives an invoice for the costs only after it applies the partner credit.

To learn more about important eligibility conditions to receive partner earned credit, see [Eligibility](/partner-center/partner-earned-credit-explanation#eligibility).

## Determine resources that have the partner earned credit applied

In Microsoft Cost Management, Fabrikam can use cost analysis to view costs that received partner earned credits. Take the following steps:

1. In the Azure portal, sign into Fabrikam's tenant and select **Cost Management + Billing**. Under  **Cost Management**, select **Cost analysis**.
2. The **Cost analysis** view shows costs of the billing account for the partner. Select the scope of **Billing Profile** or a specific **Customer** scope.
3. In a donut chart, select the drop-down list and select **PartnerEarnedCreditApplied** to drill into costs related to partner earned credit.  
    :::image type="content" source="../media/04-partner-earned-credit-applied.png" alt-text="Screenshot that shows partner earned credits." lightbox="../media/04-partner-earned-credit-applied.png" :::

When the **PartnerEarnedCreditApplied** property is **True**, the associated cost has the benefit of the partner earned admin access.

When the **PartnerEarnedCreditApplied** property is **False**, the associated cost hasn't met the required eligibility for the credit, or the purchased service isn't eligible for partner earned credit.

Service usage data normally takes 8 to 24 hours to appear in Cost Management. For more information, see [Cost and usage data updates and retention](/azure/cost-management-billing/costs/understand-cost-mgt-data#cost-and-usage-data-updates-and-retention). Partner earned credits appear within 48 hours from time of access in Cost Management.

You can also group and filter by the **PartnerEarnedCreditApplied** property by using the **Group by** options. Use the options to examine costs that do and don't have partner earned credit.

:::image type="content" source="../media/04-partner-earned-credit-grouped.png" alt-text="Screenshot that shows partner earned credit filter and group options." lightbox="../media/04-partner-earned-credit-grouped.png" :::
