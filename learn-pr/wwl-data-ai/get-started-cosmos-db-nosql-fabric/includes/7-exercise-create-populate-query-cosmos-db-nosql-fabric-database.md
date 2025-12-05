In this exercise, you create a Cosmos DB NoSQL database in Fabric, and using *Data Explorer* you insert sample JSON data manually and query the data.

## Create a Cosmos DB database and container

Before you begin, make sure you're signed in to Fabric.

1. Open your Fabric workspace.  
   - If a workspace wasn't provided, create a new one. Otherwise, navigate to an existing workspace. We strongly recommend you create a new workspace for this exercise or use a test workspace that isn't in production.

1. In the workspace, select **+ New item** and then select **Cosmos DB (NoSQL)** under the *Store data* section. You can filter the list of items by typing "Cosmos DB" in the search box.

1. Enter a name for the database, and select **Create**.

1. After the database is created, *Data Explorer* will open automatically. You see the database listed and selected in the left pane. You can either create a new container or use some sample data to get familiar with the service.

1. In Data Explorer, select **+ New container**.

1. Enter **Products** for the *Container id* and **/ProductId** for the *Partition key*.

## Insert JSON data using Data Explorer

1. After the container is created, *Data Explorer* now lists the **Products** container in the left pane. Expand the container to see the *Items* and *Setting* listed. Select **Items**.

1. In *Data Explorer*, there are two options to add data: **New item** and **Upload item**. Select **New item**.

1. A new JSON document opens in the right pane. Replace the default JSON with the following sample JSON data. You can add as many items as you want, but for this exercise, we add five items, *one at a time*. In a real-world scenario, you would typically upload a JSON file containing multiple items or use an SDK to insert data programmatically. Let's add the following items one at a time and select **Save** after each item.

   ```json
   {
     "ProductId": "item1",
     "name": "Contoso Widget",
     "category": "Widgets",
     "price": 19.99,
     "inStock": true
   }
   ```

   ```json
   {
     "ProductId": "item2",
     "name": "Fabrikam Gadget",
     "category": "Gadgets",
     "price": 29.99,
     "inStock": false
   }
   ```

   ```json
   {
     "ProductId": "item3",
     "name": "Adventure Works Bicycle",
     "category": "Sporting Goods",
     "price": 199.99,
     "inStock": true
   }
   ```

   ```json
   {
     "ProductId": "item4",
     "name": "Northwind Lamp",
     "category": "Home Decor",
     "price": 49.99,
     "inStock": true
   }
   ```

   ```json
   {
     "ProductId": "item5",
     "name": "Tailspin Drone",
     "category": "Electronics",
     "price": 299.99,
     "inStock": false
   }
   ```

## Query the data in Data Explorer

1. Once data is inserted, hover over the **Products** container name and select the *ellipsis* (...) next to the container name. Select the **New SQL query** option.

1. Replace the default query with the following SQL query to retrieve all items in the container that are in stock:

   ```sql
   SELECT * FROM p WHERE p.inStock = true
   ```

1. Select **Execute Query** option to execute the query. This query should return the three items that are in stock.

1. Notice that you can also review the **Query Stats**. Select the **Query Stats** tab to see the execution time and other statistics related to the query.

1. Let's run another query to retrieve all items in the container and order them by price in descending order. Replace the previous query with the following SQL query and select **Execute Query**:

   ```sql
   SELECT * FROM p ORDER BY p.price DESC
   ```

1. In the results pane, you should see all items in the container ordered by price in descending order.

You can run other queries as well, such as filtering by category or searching for specific items. The SQL-like syntax allows you to perform complex queries on your JSON data.

## Clean up resources

Let's go ahead and delete the database and container you created in this exercise.

1. On your Fabric menu on the left, select **Workspaces**.

1. Select the workspace where you created the Cosmos DB database. The database is listed in the resource pane.

1. To the right of the database name, select the *ellipsis* (...) and select **Delete**.

1. A warning message appears. Select **Delete** to confirm the deletion of the database and all its contents.

1. A message appears confirming that the database is now deleted and the data is no longer listed in the workspace.

> [!NOTE]
> In a production environment, you would be careful when deleting databases and containers, as this action is irreversible. Always ensure you have backups or that you no longer need the data before proceeding with deletion.

## Summary

In this exercise, you created a Cosmos DB NoSQL database and its container in Fabric. You then inserted multiple JSON documents into the container and queried the data using *Data Explorer*.
