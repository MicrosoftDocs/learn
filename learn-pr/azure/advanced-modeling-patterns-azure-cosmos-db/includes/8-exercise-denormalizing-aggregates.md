In this unit, you'll see how to denormalize an aggregate to write the top 10 customers query for your e-commerce site. You'll use the transactional batch feature in the Azure Cosmos DB .NET SDK that simultaneously inserts a new sales order and updates the customer's `salesOrderCount` property, both of which are in the same logical partition.

For this exercise, you'll complete the following steps:

- Start Azure Cloud Shell and open the code editor.
- View the code to create a new sales order.
- Complete the C# code to increment *salesOrderCount* for the customer.
- Complete the C# code to implement the transaction to insert the new sales order and update the customer record by using *transactional batch*.
- Run a query for a specific customer to see the customer's record and all of the customer's orders.
- Create a new sales order for that customer and update their `salesOrderCount` property.
- Run your top 10 customers query to see what the results currently are.
- Show how you can use transactional batch when a customer cancels an order.

## Start Azure Cloud Shell and open the code editor

Go to the code that you'll use in this unit.

1. In Cloud Shell, if necessary, change the current directory to the location of the project.

    ```bash
    cd mslearn-model-partition-data-azure-cosmos-db/modeling
    ```

1. Open the *Program.cs* file in the code editor.

    ```bash
    code Program.cs
    ```

1. You should now see the following code in Cloud Shell.

    :::image type="content" source="../media/5-cloud-shell-vs-code.png" lightbox="../media/5-cloud-shell-vs-code.png" alt-text="Screenshot of Cloud Shell with the code editor open, displaying a list of 'using' statements, the app namespace, and the start of the Program class.":::

## Complete the code to update total sales orders

1. Select Ctrl+G, and then type **488** to go to the function that creates a new sales order.

1. You should now see the following code:

    :::image type="content" source="../media/8-create-order-function.png" lightbox="../media/8-create-order-function.png" alt-text="Screenshot of Cloud Shell that shows the create new order and update customer order total function.":::

    This function creates a new sales order and updates the customer record by using transactional batch.

    First, the customer record is retrieved by calling `ReadItemAsync()` and passing in the `customerId` as both the partition key and ID.

1. At line 486, below the `//To-Do:` comment, increment the value of `salesOrderCount` by pasting the following code snippet:

    ```csharp
    //Increment the salesOrderTotal property
    customer.salesOrderCount++;
    ```

    Your screen should now look like this:

    :::image type="content" source="../media/8-create-order-sales-order-count.png" lightbox="../media/8-create-order-sales-order-count.png" alt-text="Screenshot of the create new order and update customer total function with the line of code to increment sales order count by one.":::

## Complete the code to implement transactional batch

1. Scroll down a few lines to see the data for the new sales order you'll create for your customer.

    Your new sales order object has a header and detail structure typical of sales orders in an e-commerce application.

    The sales order header has `orderId`, `customerId`, `orderDate`, and `shipDate`, which you'll leave blank.

    Because your customer container contains both customer and sales order entities, your sales order object also contains your discriminator property, `type`, with the value of `salesOrder`. This value helps you distinguish a sales order from a customer object in your customer container.

    Farther down, you can also see the two products for the order that make up the details section in your sales order.

1. Scroll a little farther to another `//To-Do:` comment. Here, you need to add code that inserts a new sales order and updates the customer record by using transactional batch.

1. Copy the following code snippet, and then paste it on the line below the `//To-Do:` comment.

    ```csharp
    TransactionalBatchResponse txBatchResponse = await container.CreateTransactionalBatch(
        new PartitionKey(salesOrder.customerId))
        .CreateItem<SalesOrder>(salesOrder)
        .ReplaceItem<CustomerV4>(customer.id, customer)
        .ExecuteAsync();
    
    if (txBatchResponse.IsSuccessStatusCode)
        Console.WriteLine("Order created successfully");
    ```

    This code calls `CreateTransactionalBatch()` on your container object. It takes the partition key value as a required parameter, because all transactions are scoped to a single logical partition. You'll also pass in your new sales order calling `CreateItem()` and your updated customer object calling `ReplaceItem()`. Then, call `ExecuteAsync()` to execute the transaction.

    Finally, check to see whether the transaction was successful by looking at the response object.

    Your screen should now look like the following screenshot:

    :::image type="content" source="../media/8-create-order-transactional-batch.png" lightbox="../media/8-create-order-transactional-batch.png" alt-text="Screenshot of Cloud Shell, showing that the transactional batch code is now implemented in your function.":::

1. Select Ctrl+S to save your changes.
1. Select CTRL+Q to close the editor.
1. To compile and execute the project, run the following command:

    ```bash
    dotnet build
    dotnet run
    ```

1. Your screen should now display the main menu for the application, as shown here:

    :::image type="content" source="../media/5-main-menu.png" lightbox="../media/5-main-menu.png" alt-text="Screenshot that shows the main menu for the application with multiple options for working with the data.":::

## Query for the customer and their sales orders

Because you designed your database to store both the customer and all their sales orders in the same container by using `customerId` as your partition key, you can query the customer container and return the customer's record and all of the customer's sales orders in a single operation.

1. On the main menu, select **c** to run the menu item for **Query for customer and all orders**. This query returns the customer record, followed by all the customer's sales orders. You should see all the customer's sales orders output on the screen.

   Note that the last order was for a **Road-650 Red, 58** for $782.99.

1. Scroll up to **Print out customer record and all their orders**.

   Note that the `salesOrderCount` property shows two sales orders.

   Your screen should look like the following screenshot:

    :::image type="content" source="../media/8-query-customer-and-orders-initial.png" lightbox="../media/8-query-customer-and-orders-initial.png" alt-text="Screenshot of Cloud Shell, showing the output of the query customer and orders query with a customer record and two sales orders.":::

## Create a new sales order and update total sales orders in a transaction

Create a new sales order for the same customer, and update the total sales orders saved in their customer record.

1. Press any key in the window to return to the main menu.
1. Select **d** to run the menu item for **Create new order and update order total**.
1. Press any key to return to the main menu.
1. Select **c** to run the same query again.

   Note that the new sales order shows **HL Mountain Frame - Black, 38** and **Racing Socks, M**.

1. Scroll back up to **Print out customer record and all their orders**.

   Note that the `salesOrderCount` property shows three sales orders.

1. Your screen should look like the following screenshot:

    :::image type="content" source="../media/8-query-customer-and-orders-next.png" lightbox="../media/8-query-customer-and-orders-next.png" alt-text="Screenshot of Cloud Shell, with an updated customer record showing a value of 3 for the sales order count and three sales orders below it.":::

## Delete an order by using transactional batch

As with any e-commerce application, customers also cancel orders. You can do the same here as well.

1. Press any key to return to the main menu.

1. Select **f** to run the menu item for **Delete order and update order total**.

1. Press any key to return to the main menu.
1. Select **c** to run the same query again to confirm that the customer record is updated.

   The new order is no longer returned. If you scroll up, you can see that `salesOrderCount` value has returned to `2`.

## View the code that deletes a sales order

You delete a sales order in exactly the same way that you create one. Both operations are wrapped in a transaction and executed in the same logical partition. Let's look at the code that does that.

1. Type **x** to exit the application.
1. In Cloud Shell, open the *Program.cs* file.

    ```bash
    code Program.cs
    ```

1. Select Ctrl+G, and then enter **549**.

    This function deletes the new sales order and updates the customer record.

    Here you can see that the code first retrieves the customer record and then decrements `salesOrderCount` by 1.

    Next is the call to `CreateTransactionalBatch()`. Again, the logical partition key value is passed in, but this time, `DeleteItem()` is called with the order ID and `ReplaceItem()` is called with the updated customer record.

## View the code for your top 10 customers query

Let's look at the query for your top 10 customers.

1. Select Ctrl+G, and then enter **580**.

    Near the top is the definition for your query.

    ```sql
    SELECT TOP 10 c.firstName, c.lastName, c.salesOrderCount
        FROM c WHERE c.type = 'customer'
        ORDER BY c.salesOrderCount DESC
    ```

    This query is fairly simple, with a `TOP` statement to limit the number of records returned and an `ORDER BY` on your `salesOrderCount` property in descending order.

    Also notice the discriminator property of `type` with a value of `customer`, so you return only back customers because your customer container has both customers and sales orders within it.

1. Select CTRL+Q to close the code editor.
1. To start the application again, run the following command:

    ```bash
    dotnet run
    ```

1. Finally, type **e** to run the query.

    :::image type="content" source="../media/8-top-10-customers.png" lightbox="../media/8-top-10-customers.png" alt-text="Screenshot of Cloud Shell, showing the output for your top 10 customers query.":::

    Something you might not realize is that the top 10 customers query is a cross-partition query that fans out across all the partitions in your container.

    The companion lab to this one pointed out that you should strive to avoid cross-partition queries. However, in reality, such queries can be OK in situations where the container is still small or the query is run infrequently. If the query is run frequently or the container is exceptionally large, it would be worth exploring the cost of materializing this data into another container and using it to serve this query.
