This unit covers some of the key reports that you might want to create or use to analyze and perform reporting after you buy a reservation.

It's important to understand two concepts: actual cost data and amortized cost data.

- *Actual cost data* shows the resource usage costs as zero when reservation is applied to the usage. This data also has reservation transactions in it. For example, if a resource’s on-demand cost is $1 per hour and a reservation applies to it, the cost shows as zero in the actual cost data.
- *Amortized cost data* provides the effective cost of a resource when a reservation applies to it. For example, if a resource’s on-demand cost is $1 per hour, and a reservation provides 50% discount to the resource, then the effective cost will show as $0.5 per hour in the amortized data.

You can review reservation savings in Power BI. Amortized cost data is only available to Enterprise Agreement and Microsoft Customer Agreement customers.

## Chargeback data

The following sections describe different ways to prepare for reservation chargebacks.

### Chargeback with cost analysis

Cost analysis shows charges as they appear on your bill. The charges are shown as actual costs or amortized over the course of your reservation period.

1. In the Azure portal, navigate to cost analysis for your scope. For example, **Cost Management + Billing** > **Cost Management** > **Cost analysis**.

1. Change the view from **Actual cost** to **Amortized cost**.

    :::image type="content" source="../media/7-change-amortized-cost.png" alt-text="Screenshot showing Amortized cost selection.":::

1. Apply the following filters:

    - Select **Reservation** for **Pricing Model**.
    - Select **Reservation name** for **Reservation**.

1. Select filters and views as follows. The view shows the monetary value of the reservation consumption by a subscription, resource group, or resource. You can use the view to charge back for reservation use.

    :::image type="content" source="../media/7-set-cost-analysis-filters.png" alt-text="Screenshot showing cost analysis filters.":::

## Create a chargeback report from usage details data

You can create a chargeback report to charge internal cost centers using amortized data. In amortized data, the cost of a reservation is the consumption value based on the discounted price for the instances covered by reservations. Amortized cost data provides the monetary value of a reservation's utilization for:

- Resources, such as a VM
- Resource group
- Tags
- Subscription

To view amortized data, navigate to **Cost Management + Billing** > **Exports**, and select **Amortized Data** in the dimension. You can also get the amortized data [by using APIs](/azure/cost-management-billing/reservations/understand-reserved-instance-usage-ea#get-azure-consumption-and-reservation-usage-data-using-api).

### Chargeback with Power BI

Enterprise Agreement and Microsoft Customer Agreement customers can view the RI Chargeback report in the Power BI Cost Management App. Review the reservation transactions, subscription names, and resource groups to help identify teams using resources.

1. Get the [Cost Management App](https://appsource.microsoft.com/product/power-bi/costmanagement.azurecostmanagementapp).

1. Review the RI Chargeback report.

## Unused reservation cost

The unused reservation view in cost analysis shows the monetary value of underutilized reservations. Use the report to view reservation waste so you can prioritize fixing it.

1. In cost analysis, change the view from actual cost to amortized cost.

1. Set up your cost analysis view with the following selections:

    - Set **Charge type** to **unusedreservation**.
    - Set **Group by** to **Reservation**.
    - Set **Granularity** to **Monthly**.
    - Set the chart type to **Table**.

    :::image type="content" source="../media/7-unused-reservation-selections.png" alt-text="Screenshot showing selections in cost analysis to view unused reservations.":::

The same unused reservation information is in usage details data. To view it, get amortized data and then apply a filter on **Charge type** = **unusedreservation** to get the reservation waste.

The same data is available in the [Cost Management App](https://appsource.microsoft.com/product/power-bi/costmanagement.azurecostmanagementapp).