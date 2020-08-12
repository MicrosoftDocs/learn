As a global admin or admin agent, you can use Azure Cost Management to reconcile the pre-tax costs on your invoice.

:::image type="content" source="../media/03-example-invoice.png" alt-text="Example showing a sample invoice with resource costs" lightbox="../media/03-example-invoice.png" :::

For more information about the details shown on your invoice, see [Terms in your invoice](https://docs.microsoft.com/azure/cost-management-billing/understand/mca-understand-your-invoice). 

## Reconcile the invoice using Cost Analysis

You can use Cost Analysis to intuitively analyze the pre-tax costs that are on your invoice and estimate the current unbilled open period costs.

The following images are examples with fictitious costs.

1. To [analyze costs](https://docs.microsoft.com/azure/cost-management-billing/costs/quick-acm-cost-analysis) on your invoice, select Cost Management +Billing and then select Cost Analysis.
1. In Cost Analysis, you can select the scope of the billing account and then select the appropriate billing profile associated to the invoice and the invoiced currency.  
    :::image type="content" source="../media/03-select-billing-account.png" alt-text="Example showing how to select a billing account scope in Cost Management" lightbox="../media/03-select-billing-account.png" :::
    :::image type="content" source="../media/03-select-billing-profile.png" alt-text="Example showing how to select a billing profile under the account scope" lightbox="../media/03-select-billing-profile.png" :::
1. You can filter costs in a billing profile for a specific invoice using the  **InvoiceID**  filter. The filter shows the consumption and product purchase costs for a specific invoice.  
    :::image type="content" source="../media/03-invoice-id-filter.png" alt-text="Example showing costs filtered for a specific invoice" lightbox="../media/03-invoice-id-filter.png" :::

To drill to the pre-tax cost as summarized by product on the invoice PDF, select the Product filter.

You can also filter the costs for a specific customer, subscription, or resource on the invoice to see the attributed pre-tax costs for the invoice.

Partners can use the scope to reconcile to invoices. They can also use this scope to set budgets in the billing currency for the following items:

- _Customer_
- _Subscription_
- _Resource group_
- _Resource_
- _Azure service_
- _Meter_
- _ResellerMPNID_

## Reconcile the invoice using the usage details download for costs on the invoice

Use the usage details CSV download file to reconcile pre-tax costs on your invoice. It shows granular daily usage for resources. This file is similar to the daily usage file in the Partner Center.

1. To download the invoice and the associated usage details file, select **Cost Management +Billing** and then select **Invoices** on the Billing navigation on the left pane. Select the required invoice based on the billing period or the invoice ID.  
    :::image type="content" source="../media/03-invoices.png" alt-text="Example showing invoices in the Azure portal" lightbox="../media/03-invoices.png" :::
1. Download the following files as required. The files available are listed below.
    - PDF copy of the invoice
    - Pre-tax Azure usage details download that gives you details of the usage that contributed to the invoice. For more information about usage terms, see [Data fields](https://docs.microsoft.com//azure/cost-management-billing/costs/get-started-partners#data-fields).
    - Azure price sheet that provides the Azure pricing for the services on the invoice
    - Azure price sheet for all services  
    :::image type="content" source="../media/03-invoice-download.png" alt-text="Example showing an invoice in the Azure portal available for download" lightbox="../media/03-invoice-download.png" :::

The usage details download provides detailed pre-tax cost in billing currency and associated pricing as invoiced to the partner. The usage details file also provides the equivalent retail cost for on-demand Azure services. It's the same pricing shown in the [Azure pricing calculator](https://azure.microsoft.com/pricing/calculator/).

You can also download the usage details for the current unbilled open period by selecting **Download pending usage**.  

:::image type="content" source="../media/03-invoices-download-pending-usage.png" alt-text="Example showing invoices where you can download pending usage" lightbox="../media/03-invoices-download-pending-usage.png" :::

