Before you can determine what to purchase, it's important to understand what reservations are and how they work. Reservations provide a billing discount only, and don't affect the runtime state of your resources. After you purchase a reservation, the discount automatically applies to matching resources. No resource tagging or restarting is needed. At the end of your reservation term, the reservation expires, and the discount stops applying unless you renew the reservation.

Before you purchase a reservation, assess your consistent base resource usage in order to maximize your benefit. All reservations, except Azure Databricks, are applied on an hourly basis. If you purchase more reserved quantity than what you use on a consistent hourly basis, then your reservation is underutilized. Unused reserved capacity doesn't carry over from one hour to the next, and leads to waste.

There are multiple methods to determine what to purchase. This unit describes the tools available to help you determine the best Azure Reservations for your workloads.

## Use reservation purchase recommendations

Azure automatically analyzes your usage over the last 7, 30, and 60 days, and provides purchase recommendations to maximize your savings.

To see purchase recommendations, sign in to the Azure portal. Navigate to **Reservations**, select **Add**, and then select the product that you want to purchase reservations for. The page shows recommended product quantities based on your usage pattern. If you change the scope, recommendations are updated for the new scope. The following example shows recommendations.

:::image type="content" source="../media/2-select-product-recommended-quantity.png" alt-text="Screenshot showing recommended quantities." lightbox="../media/2-select-product-recommended-quantity.png" :::

You can group the recommendations by the smallest instance size in an *instance flexibility group* by using the toggle option shown in the previous example.

When you select **See details** for a recommendation, you see the past usage pattern and your projected savings for a different quantity.

The following chart shows a sample usage pattern in yellow over the last 29 days. The recommended quantity based on the usage pattern is shown in green.

The prices depicted are only examples. They're not intended to imply actual costs.

:::image type="content" source="../media/2-usage-over-time-chart.png" alt-text="Screenshot showing usage over time and recommended quantity." lightbox="../media/2-usage-over-time-chart.png" :::

You can also see how your savings would change if you purchase a different quantity on the **Savings by quantity** tab.

:::image type="content" source="../media/2-savings-by-quantity.png" alt-text="Screenshot showing the savings by quantity tab." lightbox="../media/2-savings-by-quantity.png" :::

You can also get the [reservation recommendations using an API](/rest/api/consumption/reservationrecommendations/list).

## View reservation recommendations in Azure Advisor

Azure shows recommendations for the single subscription scope based on the last 30 days of your utilization pattern.

To view purchase recommendations in Advisor, navigate to **Advisor** in the Azure portal.

:::image type="content" source="../media/2-advisor-recommendations.png" alt-text="Screenshot showing purchase recommendations in Azure Advisor." lightbox="../media/2-advisor-recommendations.png" :::

## Use the Reservation Coverage report in the Cost Management app

Enterprise Agreement and Microsoft Customer Agreement customers can use the VM RI Coverage report for VMs and purchase recommendations. This is a great tool for determining the different instance size groups that are currently used by your organization. It also lets you see a breakdown of the total usage alongside the usage that's already covered by reserved instances if you purchased reservations in the past.

1. Get the [Cost Management App for Power BI](https://appsource.microsoft.com/product/power-bi/costmanagement.azurecostmanagementapp).

1. Open the VM RI Coverage report, and set either Shared or Single scope, depending on which scope you want to purchase at.

1. View the coverage and recommendations for a region, instance size family, and size level. Make sure you select the following drill-down filter before you interact with the visuals.

    :::image type="content" source="../media/2-ri-drill-down.png" alt-text="Screenshot of the Cost Management app to view reserved instances coverage.":::

To view details, select the drill-down filter highlighted in red.

After you've finished your analysis, and determined both the type of reservation you want to purchase and the capacity included in your commitment, you're ready to continue to the next unit, and make a purchase in the Azure portal.
