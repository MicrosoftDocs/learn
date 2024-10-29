As a global admin or admin agent, you can use Microsoft Cost Management to reconcile the pretax costs on your invoice.

:::image type="content" source="../media/03-example-invoice.png" alt-text="Screenshot that shows an example invoice with resource costs." lightbox="../media/03-example-invoice.png" :::

For more information about the details shown on your invoice, see [Terms in your Microsoft Customer Agreement invoice](/azure/cost-management-billing/understand/mca-understand-your-invoice).

## Reconcile the invoice by using cost analysis

You can use cost analysis to intuitively analyze the pretax costs that are on your invoice and estimate the costs for the current unbilled open period.

The following images are examples with fictitious costs.

1. To [analyze costs](/azure/cost-management-billing/costs/quick-acm-cost-analysis) on your invoice, select **Cost Management + Billing**, then select **Cost analysis**.
1. In **Cost analysis**, you can select the scope of the billing account. You can then select the appropriate billing profile that's associated with the invoice and the invoiced currency.  
    :::image type="content" source="../media/03-select-billing-account.png" alt-text="Screenshot that shows how to select a billing account scope in Cost Management." lightbox="../media/03-select-billing-account.png" :::
    :::image type="content" source="../media/03-select-billing-profile.png" alt-text="Sreenshot that shows how to select a billing profile under the account scope." lightbox="../media/03-select-billing-profile.png" :::
1. You can filter costs in a billing profile for a specific invoice by using the **InvoiceID**  filter. The filter shows the consumption and product purchase costs for a specific invoice.  
    :::image type="content" source="../media/03-invoice-id-filter.png" alt-text="Screenshot that shows costs filtered for a specific invoice." lightbox="../media/03-invoice-id-filter.png" :::

To drill into the pretax cost as summarized by product on the invoice PDF, select the **Product** filter.

You can also filter the costs for a specific customer, subscription, or resource on the invoice to see the attributed pretax costs for the invoice.

Partners can use the scope to reconcile to invoices. They can also use this scope to set budgets in the billing currency for the following items:

- _Customer_
- _Subscription_
- _Resource group_
- _Resource_
- _Azure service_
- _Meter_
- _ResellerMPNID_

## Reconcile the invoice by using the usage details download for costs on the invoice

To reconcile pretax costs on your invoice, use the CSV file for usage details. It shows granular daily usage for resources. This file is similar to the daily usage file in Partner Center.

1. To download the invoice and the associated usage details file, select **Cost Management + Billing**, then select **Invoices** under **Billing** on the left pane. Select the required invoice based on the billing period or the invoice ID.  
    :::image type="content" source="../media/03-invoices.png" alt-text="Screenshot that shows invoices in the Azure portal." lightbox="../media/03-invoices.png" :::
1. Download the following files as required:
    - PDF copy of the invoice.
    - Pretax Azure usage details download that gives you details of the usage that contributed to the invoice. For more information about usage terms, see [Data fields](/azure/cost-management-billing/costs/get-started-partners#data-fields).
    - Azure price sheet that provides the Azure pricing for the services on the invoice.
    - Azure price sheet for all services.  
    :::image type="content" source="../media/03-invoice-download.png" alt-text="Screenshot that shows an invoice in the Azure portal available for download." lightbox="../media/03-invoice-download.png" :::

The usage details download provides detailed pretax cost in billing currency and associated pricing as invoiced to the partner. The usage details file also provides the equivalent retail cost for on-demand Azure services. It's the same pricing shown in the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/).

You can also download the usage details for the current unbilled open period by selecting **Download pending usage**.  

:::image type="content" source="../media/03-invoices-download-pending-usage.png" alt-text="Screenshot that shows invoices where you can download pending usage." lightbox="../media/03-invoices-download-pending-usage.png" :::
