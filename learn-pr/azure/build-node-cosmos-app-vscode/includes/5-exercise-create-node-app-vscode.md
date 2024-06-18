In this unit, use Visual Studio Code to build and run a Node.js application against the Azure sandbox containing your resources.

* **Install npm packages** that enable you to programmatically work with your Cosmos DB Core (SQL) database. 
* **Write JavaScript code** that uploads the Contoso products dataset to a container. 

> [!NOTE]
> This exercise assumes that you've already installed **Node.js** and **npm** on your desktop computer and started your Learn sandbox and connected to it in Visual Studio Code.

## Create Node.js project 

1. Use a terminal at a folder location where you want your Node.js application. Enter the following command to open Visual Studio Code at the location.

    ```bash
    code .
    ```

1. On the **Terminal** menu, select **New Terminal**, or use keyboard shortcut, <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>.

1. In the **Terminal** window, run the following command to create a new folder named **contoso-retail** for the Node application and change into that folder.
  
    ```bash
    mkdir contoso-retail && cd contoso-retail
    ```

1. Enter the following commands to move to initialize a new Node application.

    ```bash
    npm init -y
    ```

    The **npm init** command creates a **package.json** file and displays its contents. This file contains the initial metadata for the application, containing a default name, description, and entry point.

1. On the **File** menu in Visual Studio Code, select **Open folder**, and then open the **contoso-retail** folder.

1. In the **Explorer** window, select the **package.json** file.

1. In the editor pane, change the following for the **package.json** file: 

    |Property|Value|
    |--|--|
    |**type**|`module` - the module's JavaScript code uses ES6 syntax|

    The file should look like this. The sample code uses ES6 syntax so you need to set the type of the application to **module**. 

    ```text
    {
        "name": "contoso-retail",
        "version": "1.0.0",
        "description": "Student and course grades maintenance",
        "main": "index.js",
        "type": "module",
        "scripts": {
            "test": "echo \"Error: no test specified\" && exit 1"
        },
        "keywords": [],
        "author": "",
        "license": "MIT"
    }
    ```

1. On the **File** menu, select **Save**.

## Configure Visual Studio Code to autosave file changes

1. Turn autosave on using **File > Preferences > Settings**, <kbd>Ctrl</kbd> + <kbd>,</kbd>.
1. Search for **files auto save**. 
1. Select *afterDelay* of *1000*.

## Create .gitignore file

The **.gitignore** file prevents you from checking in files to source control that shouldn't be added.

Create a file, <kbd>Ctrl</kbd> + <kbd>N</kbd>, named `.gitignore` and add the following to it.

```text
node_modules
.env
```

## Create secrets environment file

1. In Visual Studio Code, on the **File** menu, select **New Text File**.

1. On the **File** menu, select **Save As**. Save the new file with the name `.env`.
1. Add the following variables to the file:

    ```text
    COSMOS_CONNECTION_STRING=
    COSMOS_DATABASE_NAME=ContosoRetail
    COSMOS_CONTAINER_NAME=Products
    COSMOS_CONTAINER_PARTITION_KEY=categoryName
    ```

1. From the Azure explorer, <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>, select your subscription, then the **Azure Cosmos DB** node to see the resources. 
1. Right-click on your Cosmos DB account and select **Copy connection string**.

    :::image type="content" source="../media/3-copy-connection-string.png" alt-text="Screenshot of the Visual Studio Code with Cosmos DB account name selected and the submenu to Copy Connection String highlighted." loc-scope="vs-code":::

1. Paste the connection string into the `.env` file for the **COSMOS_CONNECTION_STRING** variable.

## Install the Cosmos DB package 

1. At the integrated terminal, add the Cosmos DB SDK. 

    ```bash
    npm install @azure/cosmos
    ```

1. At the integrated terminal, add the npm package to use the `.env` file for environment variables. This package reads the `.env` file and adds those values into the `process.env` runtime object.

    ```bash
    npm install dotenv
    ```

## Product shape

Understanding the JSON in the document helps you understand the input for the operations and the responses.

The products in this dataset have the following shape:

```json
{
      "id": "FEEFEE3B-6CB9-4A75-B896-5182531F661B",
      "categoryId": "AE48F0AA-4F65-4734-A4CF-D48B8F82267F",
      "categoryName": "Bikes, Road Bikes",
      "sku": "BK-R19B-52",
      "name": "Road-750 Black, 52",
      "description": "The product called \"Road-750 Black, 52\"",
      "price": 539.99,
      "tags": [
        { "id": "461ADE06-0903-4BAF-97AB-CC713E5B1DD4", "name": "Tag-174" },
        ...
      ],
      "inventory": [
        { "location": "Dallas", "inventory": 91 },
        ...
      ]
    }
```

|Property|Description|
|--|--|
|id|Cosmos DB uses the custom identifier, **id**, to uniquely identify each item. The ID can be any data type such as number, string, etc. If you don't provide the ID, Cosmos DB creates one for you.|
|categoryName|This property is selected specifically for this dataset as the partition key. The product category name provides an even distribution of the data, which is ideal for the partition key. Also, the categoryName doesn't change often, which is important for a partition key.|
|tags and inventory|These represent subproperties that can be used to find and reshape the results of queries using the `JOIN` keyword.|

## Create the script to add products to a container

1. In Visual Studio Code, on the **File** menu, select **New Text File**.

1. On the **File** menu, select **Save As**. Save the new file with the name **1-contoso-products-upload-data.js**.
1. Copy the following JavaScript and paste it into the file. 

    :::code language="javascript" source="~/../cosmos-db-sql-api-javascript-samples/training/build-node-cosmos-app-vscode/1-contoso-products-upload-data.js" highlight="11,14,17,29,34,47-51":::

1. Create a new file, named **products.json**, and copy the contents of the sample data file, [products.json](https://raw.githubusercontent.com/Azure-Samples/cosmos-db-sql-api-javascript-samples/main/training/build-node-cosmos-app-vscode/products.json) into it.

    The file contains an array of JSON objects.

1. In the Visual Studio Code terminal, execute the JavaScript file to upload the data into the Cosmos DB container:

    ```bash
    node 1-contoso-products-upload-data.js
    ```

    The terminal displays the item count, activityId, statusCode, and the item name. 

## The operation's result object

The result object returned from an operation is documented in the Cosmos DB SQL reference documentation. While the result can have information specific to the operation, each result has some properties that are always returned and are helpful to determine what happened. 

|Result property|Description|
|--|--|
|activityId|The unique event ID associated with the specific operation. This ID, along with your resource name and subscription, can help identify the issue if your operation fails and you need to contact support.|
|statusCode|The HTTP status code indicating the success or failure of the operation.|
|resource|This is a JSON object of the final object, such as a JSON doc in a container.|

## View Cosmos DB documents in Visual Studio Code

1. In Visual Studio Code, open the Azure explorer, or use the keyboard shortcut, <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. Find and expand the Concierge Subscription node, then your **Azure Cosmos DB** resources node. 
1. Find and expand your **ContosoRetail** database and its **Products** container. 
1. Expand the **Documents** node to see the products the Node.js script added. The node name for each document is the **name** property. 
1. Select the first product to see the entire JSON. 

    :::image type="content" source="../media/5-view-product-document.png" alt-text="Screenshot of the Visual Studio Code showing a newly added Cosmos DB Core document." loc-scope="vs-code":::

## Check your work

* In Visual Studio Code, in the Azure Databases extension you see your Cosmos DB account, database, and container.
* When you expand your container, you see many items under the **Documents** node. 