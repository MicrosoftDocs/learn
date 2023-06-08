Billing administrators can view payments that were made using APIs, usage data, and in Cost Management.

## Reservation transactions in Cost Management

Enterprise Agreement and Microsoft Customer Agreement billing administrators can view reservation purchases in **Cost Management + Billing**.

1. Sign in to the [Azure portal](https://portal.azure.com/).

1. Navigate to **Cost Management + Billing**. The **Cost Management + Billing** pane appears.

1. Select **Reservation transactions**.

    :::image type="content" source="../media/5-reservation-transactions.png" alt-text="Screenshot showing reservation transactions in Cost Management." lightbox="../media/5-reservation-transactions.png" :::

You can also get reservation transactions by using the [Transactions API](/rest/api/consumption/reservationtransactions/list).

## Reservation transactions using Power BI

Enterprise Agreement and Microsoft Customer Agreement customers can use the Power BI Cost Management App to get reservation transactions.

1. Get the [Cost Management App](https://appsource.microsoft.com/product/power-bi/costmanagement.azurecostmanagementapp).

1. Go to **RI Purchases** report to see all purchases and refunds. Exchanges appear as a refund and another purchase.

## Reservation transactions in usage data

Enterprise Agreement and Microsoft Customer Agreement customers can get the purchase information from the usage details data.

1. In the Azure portal, go to **Cost management + Billing**.

1. Select the billing account, select **Usage + prices**, and then select **Download** to get the usage details in a CSV file.

1. In the CSV file, filter for **chargeType** = **Purchase**.

1. Select all records where **provider** = **Azure**.

You can also get usage details data [by using APIs](/azure/cost-management-billing/reservations/understand-reserved-instance-usage-ea#get-azure-consumption-and-reservation-usage-data-using-api).
