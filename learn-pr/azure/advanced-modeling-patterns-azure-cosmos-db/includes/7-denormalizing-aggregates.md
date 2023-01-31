Before your new model is complete, one last operation to look at is to query your top 10 customers by the number of sales orders. In your current model, you first do a *group by* on each customer and sum for sales orders in your customer container. You then sort in descending order and take the top 10 results. Even though customers and sales orders sit in the same container, this type of query isn't something you can currently do.

The solution here's to denormalize and create a new property, `salesOrderCount`, in the customer document. You can get the data you want by using this property in a query such as the one shown in the following diagram:

:::image type="content" source="../media/7-sales-order-count.png" alt-text="Diagram showing a new sales order count property, customer container, and query for getting top 10 customers." border="false":::

Now, every time a customer creates a new sales order and a new sales order is inserted into your customer container, you need a way to update the customer document and increment the `salesOrderCount` property by one. To do this update, you need a transaction. Azure Cosmos DB supports transactions when the data sits within the same logical partition.

Because customers and sales orders reside in the same logical partition, you can insert the new sales order and update the customer document within a transaction. There are two ways to implement transactions in Azure Cosmos DB: by using stored procedures or by using a feature called *transactional batch*, which is available in both .NET and Java SDKs.

:::image type="content" source="../media/7-sales-order-customer-transaction.png" alt-text="Diagram of a customer container showing that when a new sales order is created, the customer document is updated with the new sales order total." border="false":::
