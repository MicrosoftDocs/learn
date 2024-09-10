In this unit, you create and run scripts, which use SQL keywords such as LIKE, JOIN, and WHERE to find data with the Cosmos SDK.

## Create the script to find products in the container

1. In Visual Studio Code, on the **File** menu, select **New Text File**.

1. On the **File** menu, select **Save As**. Save the new file with the name **2-contoso-products-find.js**.
1. Copy the following JavaScript and paste it into that file:

    :::code language="json" source="~/../cosmos-db-sql-api-javascript-samples/training/build-node-cosmos-app-vscode/2-contoso-products-find.js" highlight="11,14,17,29,56":::

1. In the Visual Studio Code terminal, execute the JavaScript file to **find all bikes**:

    ```bash
    node 2-contoso-products-find.js find categoryName '%Bikes%'
    ```

    The `bikes` term is wrapped with percent signs, `%`, indicating partial matching. 

    The SQL query in the `executeSqlFind` method for the container uses the **LIKE** keyword and query parameters to find any items with a categoryName that includes `Bikes`.
 
1. Run another query to find all products with the word `Blue` in the name.  

    ```bash
    node 2-contoso-products-find.js find name '%Blue%'
    ```

1. Run another query to find product inventory for bikes in Seattle.

    ```bash
    node 2-contoso-products-find.js find-inventory categoryName '%Bikes%' location Seattle
    ```

1. Run another query to find inventory for all products with the word `Blue` in the name in Dallas.  

    ```bash
    node 2-contoso-products-find.js find-inventory name '%Blue%' location Dallas
    ```

## Create the script to upsert products to a container

1. In Visual Studio Code, on the **File** menu, select **New Text File**.

1. On the **File** menu, select **Save As**. Save the new file with the name **3-contoso-products-upsert.js**.
1. Copy the following JavaScript and paste it into that file:

    :::code language="javascript" source="~/../cosmos-db-sql-api-javascript-samples/training/build-node-cosmos-app-vscode/3-contoso-products-upsert.js" highlight="11,14,17,27,45,48":::

1. Create a new file for the product, **3-contoso-products-upsert-insert.json**, and paste the following JSON object. 

    :::code language="json" source="~/../cosmos-db-sql-api-javascript-samples/training/build-node-cosmos-app-vscode/3-contoso-products-upsert-insert.json":::

    Notice this object with ID `123` doesn't have any inventory. 

1. Create a new file for the product, **3-contoso-products-upsert-update.json**, and paste the following JSON object. 

    :::code language="json" source="~/../cosmos-db-sql-api-javascript-samples/training/build-node-cosmos-app-vscode/3-contoso-products-upsert-update.json":::

    Notice this object does have inventory. 

1. In the Visual Studio Code terminal, execute the JavaScript file to upsert the new product.

    ```bash
    node 3-contoso-products-upsert.js
	```

    Because the product with that ID doesn't exist, the product is inserted. Then the script updates the product with inventory. Both the insert and the update functionality use the same code to upsert.
 