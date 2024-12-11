<!-- ## Review and manage reservations -->

After you purchase a reservation, you can review it in the Azure portal. The reservation purchaser has owner access for both the reservation order and the reservation. As the purchaser, you can change the reservation scope. You can also exchange, refund, split, or merge the reservation.

By default, the following users can review and manage reservations:

- The person who buys a reservation and the account administrator of the billing subscription used to buy the reservation. These users are added to the reservation order. To review reservations that you have explicit access to in the Azure portal, navigate to Reservations.

- EA and Microsoft Customer Agreement billing administrators. Billing access is granted based on user role. To review and manage reservations in the Azure portal, navigate to **Cost Management + Billing**, and then select **Reservations Transactions**.

> [!NOTE]
> You can also manage reservation purchases programmatically.

You can delegate access management for a reservation order in the Azure portal by using the Reservation order with **Access control (IAM)**.

The reservation itself is a child object of the **Reservation Order**. When you want to grant permissions to a user, we recommend that you grant permissions to the reservation order. Access to the order allows users to make commercial transactions, such as an exchange or refund.

:::image type="content" source="../media/6-access-control-iam-small.png" alt-text="A screenshot depicting how to add role assignment using access control." border="true" lightbox="../media/6-access-control-iam.png":::

You can update the reservation scope from a shared scope to a single subscription, resource group, or vice-versa after the purchase. To update the reservation scope, select the reservation, select **Settings**, select **Configuration**, and then change the scope.

Changing the scope doesn't affect the reservation's end date, and no new billing transaction occurs.

Although not commonly done, splitting a reservation enables you to distribute instances for granular scope management. You can split a reservation by using Azure PowerShell, a command-line interface (CLI), or through the application program interface (API).

## Review reservation transactions

From the **Cost Management** window, billing administrators can review payments that were made using APIs, as well as usage data.

Enterprise Agreement and Microsoft Customer Agreement billing administrators use the **Cost Management + Billing** **portal** to review reservation purchases, by selecting **Reservation transactions**.

:::image type="content" source="../media/6-reservation-transactions-small.png" alt-text="A screenshot displaying reservation transactions in Cost Management." border="true" lightbox="../media/6-reservation-transactions.png":::

Enterprise Agreement and Microsoft Customer Agreement customers can also use the **Cost Management** **Power BI** app to get reservation transactions. To do that, complete the following high-level steps:

1. Download and open the **Cost Management** app.

2. Access the **RI Purchases** report to review all purchases and refunds. Exchanges appear as a refund and another purchase.

Enterprise Agreement and Microsoft Customer Agreement customers can get the purchase information from the usage details data, by following these steps:

1. In the Azure portal, go to **Cost management + Billing**.

2. Select the billing account, select **Usage + prices**, and then select **Download** to get the usage details in a CSV file.

3. In the CSV file, filter for **chargeType** = **Purchase**.

4. Select all records where the provider value is **Azure**.

## Monitor and optimize reservation use

After you purchase a reservation, you should monitor its usage to ensure you're fully using it. To do this, you need to know how to find reservations with low utilization and optimize their use. To maximize savings, you want to try to get the reservation to 100 percent utilization wherever possible.

You can review reservation usage in the Azure portal. To maximize savings, try to get the reservation to 100% utilization wherever possible. To review reservation usage, from the Azure portal, complete the following steps:

1. Sign in to the Azure portal.

2. Navigate to **Reservations** and note the Utilization (%) for a reservation.

   :::image type="content" source="../media/6-reservations-small.png" alt-text="A screenshot of the Reservations page in the Azure portal." border="true" lightbox="../media/6-reservations.png":::

3. Select the reservation utilization percentage to review utilization details.

   :::image type="content" source="../media/6-reservation-utilization-small.png" alt-text="A screenshot depicting the utilization percentage for a reservation." border="true" lightbox="../media/6-reservation-utilization.png":::

4. Select a point on the chart to review the usage breakdown by resource in the view.

Billing administrators can review all reservations from **Cost Management + Billing** by selecting **Reservation Transactions**, and then selecting the banner indicating the used percentage.

You can retrieve the same data by using APIs:

- Use the Reservation Summaries API to get reservation utilization percentage data at **Reservations Summaries**.

- Use the Reservation Details API to determine which resources got a reservation discount and for what quantity at **Reservations Details - List**.

If you discover that your organization's reservations are underused, you can either change the reservation scope, or have the reservation refunded:

- **Change the reservation scope.** If your reservation is scoped to a single subscription or resource group, then another subscription or resource group may have matching resources that can benefit from the reservation. Consider one of the following two actions:

  - Change the reservation scope to shared scope.

  - Split the reservation into smaller chunks and assign them individually to scopes that have utilization for matching resources.

- **Refund a reservation** You can have a reservation refund as well.  From the Azure portal, select the reservation that you want to return, and then select **Refund**.

> [!NOTE]
> The total canceled commitment can't exceed (US dollar) \\$50,000 in a 12-month rolling window. Azure won't process any refund that exceeds the \\$50,000 limit in a 12-month window for either a billing profile or EA enrollment.

## Analyze and report after reservation purchase

You can create several reports to help you analyze and perform reporting after buying a reservation. When it comes to cost reporting, it is important to understand two concepts:

- *Actual cost data*
- *Amortized cost data*

**Actual Cost data.** Provides data to reconcile with your monthly bill. This data has reservation purchase costs and reservation application details. With this data, you can know which subscription, resource group, or resource received the reservation discount on a particular day. The EffectivePrice for the usage that receives the reservation discount is zero.

**Amortized Cost.** This dataset is similar to the Actual Cost dataset except that the EffectivePrice for the usage that gets a reservation discount is the prorated cost of the reservation (instead of being zero). This helps you understand the monetary value of reservation consumption by subscription, resource group, or resource. It can also help you charge back for the reservation utilization internally. The dataset also has unused reservation hours, but it doesn't have reservation purchase records.

> [!NOTE]
> Amortized cost data is only available to Enterprise Agreement and Microsoft Customer Agreement customers.

You can review reservation savings in Power BI.

## Chargeback with cost analysis

:::image type="content" source="../media/6-chargeback-with-cost-analysis.png" alt-text="A screenshot displaying selections in cost analysis to view unused reservations." border="true":::

Cost analysis displays charges as they appear on your bill. It displays them as actual costs or amortized over the course of your reservation period. To access cost analysis, perform the following steps:

1. In the Azure portal, navigate to **Cost Management + Billing**.

2. Select **Cost Management**, and then select **Cost analysis**.

3. Change the view from **Actual cost** to **Amortized cost**.

4. Apply the following filters:

   - For **Pricing Model**, select **Reservation**.

   - For **Reservation**, select the desired reservation name.

5. You can select filters and views to display the monetary value of the reservation consumption by subscription, resource group, or resource. Using the data in this window, you can use information to charge back for reservation use.

   :::image type="content" source="../media/6-cost-analysis-1-small.png" alt-text="A screenshot depicting the Amortized cost selection." border="true" lightbox="../media/6-cost-analysis-1.png":::

You can create a chargeback report to charge internal cost centers using amortized data. In amortized data, the cost of a reservation is the consumption value based on the discounted price for the instances covered by reservations. Amortized cost data provides the monetary value of a reservation's utilization for:

- Resources, such as a virtual machine
- Resource group
- Tags
- Subscription

To review amortized data, navigate to **Cost Management + Billing**, select **Exports**, and then select **Amortized Data** in the dimension. You can also obtain amortized data by using APIs.

Enterprise Agreement and Microsoft Customer Agreement customers can review the RI Chargeback report in the Cost Management Power BI App. Review the reservation transactions, subscription names, and resource groups to help identify teams using resources.

In the Cost analysis window, the **unused reservation** view displays the monetary value of underutilized reservations. You can use this report to review reservation waste so you can prioritize fixing it. To review unused or underused reservations:

1. In **Cost analysis**, change the view from **Actual cost** to **Amortized cost**.

2. Set up your cost analysis view with the following selections:

   - Set **Charge type** to **unusedreservation**.

   - Set **Group by** to **Reservation**.

   - Set **Granularity** to **Monthly**.

   - Set the **chart type** to **Table**.

   :::image type="content" source="../media/6-cost-analysis-2-small.png" alt-text="A screenshot displaying cost analysis filters." border="true" lightbox="../media/6-cost-analysis-2.png":::

The same unused reservation information is in the usage details data. To review it, retrieve the amortized data, and then apply a filter on **Charge type** = **unusedreservation**. This will display the reservation waste.

## Renewal options for Azure reservation

You can renew reservations to automatically purchase a replacement when an existing reservation expires. Automatic renewal provides an easy way to continue getting reservation discounts. It also saves you from having to closely monitor a reservation's expiration. With automatic renewal, you prevent savings benefits loss by not having to manually renew. The renewal setting is turned on by default when you make a purchase. You can, however, manually turn off the renewal setting at the time of purchase. After purchase, you can enable or disable the renewal setting at any time, up to the expiration of the existing reservation. If auto-renewal is enabled, you need to manually turn it off to stop automatic renewal.

The renewal price is available 30 days before the expiry of the existing reservation. If you enable renewal more than 30 days before the reservation expiration, you're sent an email 30 days before expiration detailing renewal costs. The reservation price might change between the time that you lock in the renewal price and the renewal time. If so, your renewal will not be processed, and you can purchase a new reservation to continue getting the benefit.

Renewing a reservation creates a new reservation when the existing reservation expires. It doesn't extend the term of the existing reservation.

To set up Azure reservation renewal, from the Azure portal, perform the following steps:

1. Select **Reservations**, and then select the reservation that you want to set up.

2. Select **Renewal**.

3. Select **Automatically purchase a new reservation upon expiry**.

   :::image type="content" source="../media/6-renewal-small.png" alt-text="A screenshot displaying reservation renewal." border="true" lightbox="../media/6-renewal.png":::

## Summary

In this unit, you learned how to manage reservations and review purchased reservations. You also learned how to monitor utilization to help get the most cost savings from your reservations. Finally, you learned how to set up automatic renewals for your reservations to avoid unexpected costs.
