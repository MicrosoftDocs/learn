Before discussing the tools available to help you decide what to purchase, it's important to understand what reservations are and how they work. Reservations provide a billing discount only and don't affect the runtime state of your resources. After you purchase a reservation, the discount automatically applies to matching resources – no resource tagging or restarting is needed. At the end of your reservation term, the reservation expires and the discount stops applying unless you renew the reservation.

Assessing your consistent base resource usage before you purchase a reservation is key to maximizing your benefit. All reservations, except Azure Databricks, are applied on an hourly basis. If you purchase more reserved quantity than what you use on a consistent hourly basis, then your reservation will be underutilized. Unused reserved capacity doesn't carry over from one hour to the next and leads to waste.

There are multiple methods to determine what to purchase. This unit discusses the tools available that help you determine the best Azure Reservations purchases for your workloads.

## Use reservation purchase recommendations

Azure automatically analyzes your usage over last 7, 30, 60 days and pricing to provide you with reservation purchase recommendations. The recommendation is provided for the quantity that maximizes your savings.

To see purchase recommendations, sign in to the Azure portal. Navigate to Reservations, select Add and then select the product that you want to purchase reservations for. You’ll see recommended products quantities based on your usage pattern. If you change the scope, recommendations are updated for the new scope. Here’s an example showing recommendations.

:::image type="content" source="../media/2-select-product-recommended-quantity.png" alt-text="Screenshot showing recommended quantities." lightbox="../media/2-select-product-recommended-quantity.png" :::

You can group the recommendations by the smallest instance size in an instance size flexibility group by using the toggle option shown above.

When you select **See details** for a recommendation, you'’ll see the past usage pattern and your projected savings for a different quantity.

The following chart shows a sample usage pattern in yellow over last 29 days. The recommended quantity based on the usage pattern is shown in green.

:::image type="content" source="../media/2-usage-over-time-chart.png" alt-text="Screenshot showing usage over time and recommended quantity." lightbox="../media/2-usage-over-time-chart.png" :::

You can also see how your savings would change, if you purchase a different quantity on the **Savings by quantity** tab.

:::image type="content" source="../media/2-savings-by-quantity.png" alt-text="Screenshot showing the savings by quantity tab." lightbox="../media/2-savings-by-quantity.png" :::

You can also get the [reservation recommendations using API](https://docs.microsoft.com/rest/api/consumption/reservationrecommendations/list).

## View reservation recommendations in Azure Advisor

Azure shows recommendations for the single subscription scope based on the last 30 days of your utilization pattern.

To view purchase recommendations in Advisor:

In the Azure portal, navigate to **Advisor**.

:::image type="content" source="../media/2-advisor-recommendations.png" alt-text="Screenshot showing purchase recommendations in Advisor." lightbox="../media/2-advisor-recommendations.png" :::

## Use the Reservation Coverage report in the Cost Management Power BI app

Enterprise Agreement and Microsoft Customer Agreement customers can use the VM RI Coverage reports for VMs and purchase recommendations. This is a great tool to use to determine the different instance size groups that are currently used by your organization. It also allows you to see a breakdown of the total usage alongside the usage that's already covered by reserved instances if you have purchased Reservations in the past.

1. Get the [Cost Management App](https://appsource.microsoft.com/product/power-bi/costmanagement.azurecostmanagementapp).
2. Open to the VM RI Coverage report and set either Shared or Single scope, depending on which scope you want to purchase at.
3. View the coverage and recommendations for a region, instance size family, and size level. Make sure you select the following drill-down filter before you interact with the visuals.

![Example showing the Cost Management app you can view VM RI coverage](../media/2-ri-drill-down2.png)

To view details, select the drill-down filter highlighted in red as shown in the preceding image.

Once you've finished your analysis and determined both the type of reservation you want to purchase and the capacity included in your commitment, you're ready to continue to the next unit and make a purchase in the Azure portal.
