Billing partners who provide constant cloud-operations management become eligible for a **Partner earned credit for services managed** on the customers' Azure tenant. Learn more about the benefit at [Partner earned credit](https://docs.microsoft.com/partner-center/partner-earned-credit). The rest of the unit assumes you have basic knowledge of the program and wish to capitalize on it for Fabrikam's benefit.

Partner earned credit means less costs for Fabrikam. When you receive **Partner earned credit for Services managed**, the credit is built into the invoiced prices and cost on the invoice. The price applied when computing the invoiced costs factors the credit. Fabrikam only receives an invoice for the costs after applying the Partner Credit.

To learn more about important eligibility conditions to receive partner earned credit, see [Important eligibility and calculation information](https://docs.microsoft.com/partner-center/partner-earned-credit-explanation#important-eligibility-and-calculation-information).

### Determine resources that have Partner Earned Credit applied

In Azure Cost Management, Fabrikam can use cost analysis to view costs that received the PEC benefits. Do the following steps.

1. In the Azure portal, sign into Fabrikam's tenant and select  **Cost Management + Billing**. Under  **Cost Management**, select  **Cost analysis**.
2. The Cost analysis view shows costs of the billing account for the partner. Select the scope of a **Billing Profile** or a specific **Customer** scope.
3. In a donut chart, select the drop-down list and select  **PartnerEarnedCreditApplied**  to drill into PEC costs.  
    :::image type="content" source="../media/04-partner-earned-credit-applied.png" alt-text="Example showing partner earned credits" lightbox="../media/04-partner-earned-credit-applied.png" :::

When the **PartnerEarnedCreditApplied** property is _True_, the associated cost has the benefit of the partner earned admin access.

When the **PartnerEarnedCreditApplied** property is _False_, the associated cost hasn't met the required eligibility for the credit. Or, the service purchased isn't eligible for partner earned credit.

Service usage data normally takes 8-24 hours to appear in Cost Management. For more information, see [Cost and usage data updates and retention](https://docs.microsoft.com/azure/cost-management-billing/costs/understand-cost-mgt-data#cost-and-usage-data-updates-and-retention). PEC credits appear within 48 hours from time of access in Azure Cost Management.

You can also group and filter by the **PartnerEarnedCreditApplied** property using the **Group by** options. Use the options to examine costs that do and don't have PEC.

:::image type="content" source="../media/04-partner-earned-credit-grouped.png" alt-text="Example showing partner earned credit filter and group options" lightbox="../media/04-partner-earned-credit-grouped.png" :::
