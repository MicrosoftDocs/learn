In this exercise, you'll see how to use denormalization of an aggregate to write the top 10 customers query for our e-commerce site. You'll use the transactional batch feature in the Azure Cosmos DB .NET SDK that will simultaneously insert a new sales order and update the customer's **salesOrderCount** property, both of which are in the same logical partition.

For this exercise, you will complete the following steps:

- Start Azure Cloud Shell and open Visual Studio Code.
- View the code to create a new sales order.
- Complete the C# code to increment **salesOrderCount** for the customer.
- Complete the C# code to implement the transaction to insert the new sales order and update the customer record using transactional batch.
- Run a query for a specific customer to see the customer record and all of their orders.
- Create a new sales order for that customer and update their **salesOrderCount** property.
- Run our top 10 customers query to see what the results currently are.
- Show how transactional batch can be used when a customer cancels an order.

## Start Azure Cloud Shell and open VS Code

Follow these steps to get to the code that you'll use in this unit.

1. In Cloud Shell, if needed, change the current directory to the location of the project.

    ```bash
    cd mslearn-model-partition-data-azure-cosmos-db/modeling
    ```

1. Open VS Code to the Program.cs file

    ```bash
    code Program.cs
    ```

1. You should now see the following code in Cloud Shell.

    :::image type="content" source="../media/5-cloud-shell-vs-code.png" lightbox="../media/5-cloud-shell-vs-code.png" alt-text="Screenshot that shows the top of program.cs with using statements, the start of the namespace and start of the program class.":::

## Complete the code to update total sales orders

1. Go to the function that creates a new sales order.
1. Type **CTRL + G**, then type in **488** to go to that line in the file.
1. You should now see the following code.

    :::image type="content" source="../media/8-create-order-function.png" lightbox="../media/8-create-order-function.png" alt-text="Screenshot of Cloud Shell that shows the create new order and update customer order total function.":::

    This function creates a new sales order and updates the customer record using transactional batch.

    First, the customer record is retrieved by calling `ReadItemAsync()` by passing in the `customerId` as both the partition key and ID.
1. Notice on line **488** there is a `//To-Do:` comment. Here we need to write code that will increment the value of the **salesOrderCount**
1. Copy the following code snippet and paste it below the line that starts with `//To-Do:`.

    ```csharp
    //Increment the salesOrderTotal property
    customer.salesOrderCount++;
    ```

1. Your screen should now look like this.

    :::image type="content" source="../media/8-create-order-sales-order-count.png" lightbox="../media/8-create-order-sales-order-count.png" alt-text="Screenshot of the create new order and update customer total function with the line of code to increment sales order count by one.":::

## Complete the code to implement transactional batch

1. Next scroll down a few lines to see the data for the new sales order you will create for our customer.

    Our new sales order object has a header and detail structure typical of sales orders in an e-commerce application.

    The sales order header has an `orderId`, `customerId`, `orderDate`, and `shipDate` which we will leave blank.

    Because our customer container contains both customer and sales order entities, our sales order object also contains our discriminator property, `type` with the value of "salesOrder" so we can distinguish a sales order from a customer object in our customer container.

    Further down we can also see the two products for the order that make up the details section in our sales order.
1. Scroll a little further until you see another `//To-Do:` comment. Here we need to write code that will insert a new sales order and update the customer record using transactional batch.
1. Copy the following code snippet and paste it below the line that starts with `//To-Do:`.

    ```csharp
    TransactionalBatchResponse txBatchResponse = await container.CreateTransactionalBatch(
        new PartitionKey(salesOrder.customerId))
        .CreateItem<SalesOrder>(salesOrder)
        .ReplaceItem<CustomerV4>(customer.id, customer)
        .ExecuteAsync();
    
    if (txBatchResponse.IsSuccessStatusCode)
        Console.WriteLine("Order created successfully");
    ```

    This code calls `CreateTransactionalBatch()` on our container object. It takes the partition key value as a required parameter because all transactions are scoped to a single logical partition. We will also pass in our new sales order calling `CreateItem()` and our updated customer object calling `ReplaceItem()`. Then finally call `ExecuteAsync()` to execute the transaction.

    Finally we will check whether the transaction was successful by looking at the response object.
1. Your screen should now look like the following.

    :::image type="content" source="../media/8-create-order-transactional-batch.png" lightbox="../media/8-create-order-transactional-batch.png" alt-text="Screenshot of the Cloud Shell that shows the transactional batch code now implemented in our function.":::

1. Next type **CRTL + S** to save your changes.
1. Type **CTRL + Q** to close the editor.
1. Run the following command to compile  and execute the project.

    ```bash
    dotnet build
    dotnet run
    ```

1. Your screen should now look like this with the main menu for the application.

    :::image type="content" source="../media/5-main-menu.png" lightbox="../media/5-main-menu.png" alt-text="Screenshot of the Cloud Shell that shows the main menu for the application.":::

## Query for the customer and their sales orders

Because we designed our database to store both customers and all of their sales orders in the same container using `customerId` as our partition key, we can query the customer container and return the customer record and all of their sales orders in a single operation.

1. Type **c** to run the menu item for *Query for customer and all orders*. This query returns the customer record, followed by all of the customer's sales orders. You should see all of the customer's sales orders output on the screen.
1. Notice that the last order was for a *Road-650 Red, 58* for $782.99.
1. Scroll up until you see, *Print out customer record and all their orders*
1. Notice that the `salesOrderCount` property shows two sales orders.
1. Your screen should look like the following image.

    :::image type="content" source="../media/8-query-customer-and-orders-initial.png" lightbox="../media/8-query-customer-and-orders-initial.png" alt-text="Screenshot of the Cloud Shell that shows the output of the query customer and orders query with a customer record and two sales orders.":::

## Create new sales order and update total sales orders in a transaction

Next we will create a new sales order for the same customer and update the total sales orders saved in their customer record.

1. Press any key in the window to return to the main menu.
1. Type **d** to run the menu item for *Create new order and update order total*.
1. Then press any key to return to the main menu.
1. Next, type **c** to run the same query again.
1. Notice that the new sales order with an *HL Mountain Frame - Black, 38* and *Racing Socks, M*.
1. Scroll back to the top until you see, *Print out customer record and all their orders*
1. Note the `salesOrderCount` property shows three sales orders.
1. Your screen should look like the following image.

    :::image type="content" source="../media/8-query-customer-and-orders-next.png" lightbox="../media/8-query-customer-and-orders-next.png" alt-text="Screenshot of the Cloud Shell that shows the output for our query with the updated customer record showing three for the sales order total property and three sales orders below it.":::

## Delete an order using transactional batch

Like any e-commerce application, customers also cancel orders. We can do the same here as well.

1. Press any key to return to the main menu.
1. Type **f** to run the menu item for *Delete order and update order total*
1. Then press any key to return to the main menu.
1. Type **c** to run the same query again to confirm the customer record is updated.
1. Notice that the new order is no longer returned. If you scroll up, you can see `salesOrderCount` has returned back to 2.

## View the code that deletes a sales order

The way we delete an order works exactly the same as the way we create an order. Both operations are wrapped in a transaction and executed in the same logical partition. Let's look at the code that does that.

1. Type **x** to exit the application.
1. In Cloud Shell, open the Program.cs file.

    ```bash
    code Program.cs
    ```

1. Next type **CTRL + G** then enter **549**.

    This function deletes the new sales order and updates the customer record.

    Here you can see the code first retrieve the customer record, then decrement `salesOrderCount` by 1.

    Next is the call to `CreateTransactionalBatch()`. Again the logical partition key value is passed in but this time `DeleteItem()` is called with the order ID and `ReplaceItem()` is called with the updated customer record.

## View the code for our top 10 customers query

Let's look at the query for our top 10 customers.

1. Type **CTRL + G** then enter **580**

    Near the top is the definition for our query.

    ```sql
    SELECT TOP 10 c.firstName, c.lastName, c.salesOrderCount
        FROM c WHERE c.type = 'customer'
        ORDER BY c.salesOrderCount DESC
    ```

    This query is fairly simple with a TOP statement to limit the number of records returned and an ORDER BY on our `salesOrderCount` property in descending order.

    Also notice the discriminator property of `type` with a value of *customer* so we only return back customers because our customer container has both customers and sales orders within it.

1. Type **CTRL + Q** to close VS Code.
1. Run the following command to launch the application again.

    ```bash
    dotnet run
    ```

1. Then finally, type **e** to run the query.

    :::image type="content" source="../media/8-top-10-customers.png" lightbox="../media/8-top-10-customers.png" alt-text="Screenshot of the Cloud Shell that shows the output for our top 10 customers query.":::

    Something you may not realize is the top 10 customers query is a cross-partition query that fans-out across all the partitions in our container.

    The companion lab to this one pointed out that you should strive to avoid cross-partition queries. However, in reality they can be ok in situations where the container is still small or if the query is not run often. If this query frequently executed or the container was exceptionally large, it would be worth exploring the cost of materializing this data into another container and using it to serve this query.
