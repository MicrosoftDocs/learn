# Denormalizing aggregates

In this exercise, we will show how we can use denormalization of an aggregate that will allow us to write our top 10 customers query for our e-commerce site. To accomplish this we will use the transactional batch feature in the Azure Cosmos DB .NET SDK that will simultaneously insert a new sales order and update the customer's **salesOrderCount** property, both of which are in the same logical partition.

For this exercise we will complete the following steps:

- Start Azure Cloud Shell and open VS Code to show our code to create a new sales order.
- Complete the C# code to increment **salesOrderCount** for the customer.
- Complete the C# code to implement the transaction to insert the new sales order and update the customer record using transactional batch.
- Run a query for a specific customer to see the customer record and all of their orders.
- Create a new sales order for that customer and update their **salesOrderCount** property.
- Run our top 10 customers query to see what the results currently are.
- Show how transactional batch can be used when a customer cancels an order.

## Start Azure Cloud Shell and open VS Code

Follow these steps to navigate to our code that we will view and update for Change Feed.

1. Open Azure Cloud Shell from the Azure portal.
1. Navigate to the directory where our project is by changing the current directory to the one where our project is located.

    ```bash
    cd mslearn-model-partition-data-azure-cosmos-db/modeling
    ```

1. Open VS Code to our Program.cs file

    ```bash
    code Program.cs
    ```

1. You should now see this code below in Azure Cloud Shell.

    :::image type="content" source="../media/5-cloud-shell-vs-code.png" lightbox="../media/5-cloud-shell-vs-code.png" alt-text="Cloud Shell with VS Code":::

## Complete the code to update total sales orders

1. Navigate to the function that creates a new sales order.
1. Type **CTRL + G**, then type in **487** to go to that line in the file.
1. You should now see this code below in Azure Cloud Shell.

    :::image type="content" source="../media/8-create-order-function.png" lightbox="../media/8-create-order-function.png" alt-text="create new order":::

1. This function creates a new sales order and updates the customer record using transactional batch.
1. First, the customer record is retrieved by calling `ReadItemAsync()` by passing in the `customerId` as both the partition key and id.
1. Notice on line **485** there is a `//To-Do:` comment.
1. Here we need to write code that will increment the value of the **salesOrderCount**
1. Copy this code snippet below and paste it below the line that starts with `//To-Do:`

    ```csharp
    //Increment the salesOrderTotal property
    customer.salesOrderCount++;
    ```

1. Your screen should now look like this.

    :::image type="content" source="../media/8-create-order-sales-order-count.png" lightbox="../media/8-create-order-sales-order-count.png" alt-text="increment sales order count":::

## Complete the code to implement transactional batch

1. Next scroll down a few lines to see the data for the new sales order we will create for our customer.
1. Here you can see the new dummy sales order object that we be inserted. It has a header and detail structure typical of sales orders in an ecommerce application.
1. For the sales order header we an order id, customer id, and order date. It also something specific to our design with a `type` property that allows us to distinguish a sales order from a customer object in our customer container.
1. The order also includes two products that are part of the details in our sales order.
1. Scroll a little further until you see another `//To-Do:` comment.
1. Here we need to write code that will insert a new sales order and update the customer record using transactional batch.
1. Copy this code snippet below and paste it below the line that starts with `//To-Do:`

    ```csharp
    TransactionalBatchResponse txBatchResponse = await container.CreateTransactionalBatch(
        new PartitionKey(salesOrder.customerId))
        .CreateItem<SalesOrder>(salesOrder)
        .ReplaceItem<CustomerV4>(customer.id, customer)
        .ExecuteAsync();
    
    if (txBatchResponse.IsSuccessStatusCode)
        Console.WriteLine("Order created successfully");
    ```

1. This code calls `CreateTransactionalBatch()` on our container object. It takes the partition key value as a required parameter because all transactions are scoped to a single logical partition. We will also pass in our new sales order in `CreateItem()` and our updated customer object in `ReplaceItem()`. Then finally call `ExecuteAsync()` to execute the transaction.
1. Finally we will check whether the transaction was successful by looking at the response object.
1. Your screen should now look like this below.

    :::image type="content" source="../media/8-create-order-transactional-batch.png" lightbox="../media/8-create-order-transactional-batch.png" alt-text="transactional batch":::

1. Next type **CRTL + S** to save our changes and **CTRL + Q** to quit the editor.
1. Next type **dotnet build** to compile our project and **dotnet run** to execute it.
1. Your screen should now look like this with the main menu for the application.

    :::image type="content" source="../media/5-main-menu.png" lightbox="../media/5-main-menu.png" alt-text="main menu":::

## Query for the customer and their sales orders

1. Because we designed our database to store both customers and all of their sales orders in the same container using `customerId` as our partition key, we can query the customer container and return the customer record and all of their sales orders in a single operation.
1. Type **c** to run the menu item for *Query for customer and all orders*. This query returns the customer record, followed by all of the customer's sales orders.
1. You should see all of the customer's sales orders output on the screen.
1. Note the last order was for a *Road-650 Red, 58* for $782.99.
1. Scroll up until you see, *Print out customer record and all their orders*
1. Note the `salesOrderCount` property shows two sales orders.
1. Your screen should look like this.

    :::image type="content" source="../media/8-query-customer-and-orders-initial.png" lightbox="../media/8-query-customer-and-orders-initial.png" alt-text="query customer and orders initial":::

## Create new sales order and update total sales orders in a transaction

1. Press any key in the window to return to the main menu.
1. Next we will create a new sales order for the same customer and update the total sales orders saved in their customer record.
1. Type **d** to run the menu item for *Create new order and update order total*.
1. Then press any key to return to the main menu.
1. Next, type **c** to run the same query again.
1. Note the new sales order with an *HL Mountain Frame - Black, 38* and *Racing Socks, M*.
1. Scroll back to the top until you see, *Print out customer record and all their orders*
1. Note the `salesOrderCount` property shows three sales orders.
1. Your screen should look like this.

    :::image type="content" source="../media/8-query-customer-and-orders-next.png" lightbox="../media/8-query-customer-and-orders-next.png" alt-text="updated customer record":::

## Delete an order using transactional batch

1. Press any key to return to the main menu.
1. Like any e-commerce application, customers also cancel orders. We can do the same here as well.
1. Type **f** to run the menu item for *Delete order and update order total*
1. Then press any key to return to the main menu.
1. We can then confirm the customer record is updated by running our query again.
1. Type **c** to run the same query again.
1. Note the new order is no longer returned and if you scroll up you can see `salesOrderCount` has returned back to 2.

## View the code that deletes a sales order

The way we delete an order works exactly the same as the way we create an order where both operations are wrapped in a transaction and executed in the same logical partition. Let's look at the code that does that.

1. Type **x** to exit the application.
1. In Azure Cloud Shell, type `code Program.cs`
1. Next type **CTRL + G** then enter **553**.
1. This function deletes the new sales order and updates the customer record.
1. Here you can see the code first retrieve the customer record, then decrement `salesOrderCount` by 1.
1. Next is the call to `CreateTransactionalBatch()`. Again the logical partition key value is passed in but this time `DeleteItem()` is called with the order id and `ReplaceItem()` is called with the updated customer record.

## View the code for our top 10 customers query

1. Let's look at the query for our top 10 customers.
1. Type **CTRL + G** then enter **584**
1. Near the top is the definition for our query.

    ```sql
    SELECT TOP 10 c.firstName, c.lastName, c.salesOrderCount
        FROM c WHERE c.type = 'customer'
        ORDER BY c.salesOrderCount DESC
    ```

1. This query is fairly simple with a TOP statement to limit the number of records returned and an ORDER BY on our `salesOrderCount` property in descending order.
1. Also note the discriminator property of `type` with a value of *customer* so we only return back customers because our customer container has both customers and sales orders within it.
1. Finally, let's run our top 10 customers query and see the customers and their order totals.
1. Type **CTRL + Q** to exit VS Code.
1. Next type **dotnet run** to launch our application again.
1. Then finally, type **e** to run the query.

    :::image type="content" source="../media/8-top-10-customers-initial.png" lightbox="../media/8-top-10-customers-initial.png" alt-text="top 10 customers initial results":::

1. Something you may not realize is the top 10 customers query is a cross-partition query that fans-out across all the partitions in our container.
1. In the companion lab to this one, it was pointed out that you should strive to avoid cross-partition queries. However, in reality they can be ok in situations where the container is still small or if the query is not run often. If this query frequently executed or the container was exceptionally large, it would be worth exploring the cost of materializing this data into another container and using it to serve this query.

## Summary

In this exercise you learned how can use denormalizing of an aggregate to allow us to write our top 10 customers query for our e-commerce site. You also learned how, when data exists in the same logical partition, the aggregate can be updated in an transaction through the use of the transactional batch feature in the Cosmos DB .NET SDK.
