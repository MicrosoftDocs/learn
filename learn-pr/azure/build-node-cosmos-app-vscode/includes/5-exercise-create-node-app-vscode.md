In this exercise, use Visual Studio Code's customizable IDE to build, test, and run this Node.js application against the Azure sandbox containing your resources.

* **Install npm packages** that enable you to configure Node.js for use in Visual Studio Code. 
* **Write JavaScript code** that creates and queries for data with an Azure SDK package. 
* **Run code** to manage that data.

> [!NOTE]
> This exercise assumes that you've already installed **Node.js** and **npm** on your desktop computer.

## Create Node.js project 

1. Start Visual Studio Code if it isn't already running.

2. On the **Terminal** menu, select **New Terminal**, <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>.

3. In the **Terminal** window, run the following command to create a new folder named **contoso-retail** for the Node application.
  
    ```bash
    mkdir contoso-retail && cd contoso-retail
    ```

4. Enter the following commands to move to initialize a new Node application.

    ```bash
    npm init -y
    ```

    The **npm init** command creates a **package.json** file and displays its contents. This file contains the initial metadata for the application, containing a default name, description, and entry point.

5. On the **File** menu in Visual Studio Code, select **Open Folder**, and then open the **contoso-retail** folder.

6. In the **Explorer** window, select the **package.json** file.

7. In the editor pane, change the following: 

    |Property|Value|
    |--|--|
    |**description**|`Contoso retail product maintenance`|
    |**type**|`module` - the JavaScript code uses ES6 syntax|


    The file should look like this.

    ```text
    {
        "name": "contoso-retail",
        "version": "1.0.0",
        "description": "Student and course grades maintenance",
        "main": "index.js",
        "type": module,
        "scripts": {
            "test": "echo \"Error: no test specified\" && exit 1"
        },
        "keywords": [],
        "author": "",
        "license": "MIT"
    }
    ```

8. On the **File** menu, select **Save**. 

## Configure Visual Studio Code to autosave file changes

1. Turn autosave on using **File > Preferences > Settings**, <kbd>Ctrl</kbd> + <kbd>,</kbd>.
1. Search for **files auto save**. 
1. Select *afterDelay* of *1000*.

## Create .gitignore file

The **.gitignore** file prevents you from checking in files to source control that shouldn't be added.

Create a file, <kbd>Ctrl</kbd> + <kbd>N</kbd>, named `.gitignore` and add the following to it.

```
node_modules
.env
```


## Create secrets environment file

1. In Visual Studio Code, on the **File** menu, select **New Text File**.

1. On the **File** menu, select **Save As**. Save the new file with the name **.env**.
1. Add the following variables to the file:

    ```text
    COSMOS_CONNECTION_STRING=
    COSMOS_DATABASE_NAME=ContosoRetail
    COSMOS_CONTAINER_NAME=Products
    COSMOS_CONTAINER_PARTITION_KEY=categoryName
    ```

1. From the Azure explorer, <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>, select your subscription, then the **Azure Cosmos DB** node to see the resources. 
1. Right-click on your resource and select **Copy connection string**.
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

The products in this dataset have the following shape:

```
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
        { "id": "AC4CC3CC-4E6B-461D-9B0E-4218EDDF3142", "name": "Tag-122" },
        { "id": "D56040DB-E5DF-40BE-9F2F-7E10F4340BCA", "name": "Tag-31" },
        { "id": "D77B44A9-7951-4CC8-BB27-8B5D78CFDDF8", "name": "Tag-124" },
        { "id": "E468DF53-4836-4546-9D05-C855AAC4B0AF", "name": "Tag-2" }
      ],
      "inventory": [
        { "location": "Dallas", "inventory": 91 },
        { "location": "Seattle", "inventory": 54 },
        { "location": "Boston", "inventory": 7 },
        { "location": "Miami", "inventory": 86 },
        { "location": "San Diego", "inventory": 81 }
      ]
    }
```

|Property|Description|
|--|--|
|id|Cosmos DB uses the custom identifier, **id**, to uniquely identify each item. The ID can be any data type such as number, string, etc. If you don't provide the ID, Cosmos DB creates one for you.|
|categoryName|This property has been specifically selected for this dataset as the partition key. The product category name provides a somewhat even distribution of the data, which is ideal for the partition key. The categoryName also won't change very often, which is also important for a partition key.|
|tags and inventory|These represent subproperties that can be used to find and reshape the results of queries using the [JOIN]() keyword.|
 

## Create the script to add products to a container

1. In Visual Studio Code, on the **File** menu, select **New Text File**.

1. On the **File** menu, select **Save As**. Save the new file with the name **1-contoso-products-upload-data.js**.
1. Copy the following JavaScript and paste it into that file:

    :::code language="javascript" source="~/../cosmos-db-sql-api-javascript-samples/training/build-node-cosmos-app-vscode/1-contoso-products-upload-data.js" highlight="11,14,17,29,34,47-51":::

1. Create a new file, named **products.json**, and copy the contents of the sample data file, [products.json](https://github.com/Azure-Samples/cosmos-db-sql-api-javascript-samples/blob/main/training/build-node-cosmos-app-vscode/products.json) into it. 

    This is an array of JSON objects. 

1. In the Visual Studio Code terminal, <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>, execute the JavaScript file to upload the data into the Cosmos DB container:

    ```bash
    node 1-contoso-products-upload-data.js
    ```

1. Copy the container name displayed at the end of the execution in the terminal. In order for the remaining JavaScript files to run successfully, you need to set this name in the `.env` file. 
1. Past the value into the `.env` file for the **COSMOS_CONTAINER_NAME** property. The container name has a timestamp postpended, such as `Products-1664304175357`. 

## View products in Azure explorer

1. In Visual Studio Code, open the Azure explorer, <kbd>Shift<kbd> + <kbd>Alt<kbd> + <kbd>A<kbd>.
1. Find and expand your subscription node, then your **Azure Cosmos DB** resources node. 
1. Find and expand your Cosmos DB database and its products container. 
1. Expand the **Documents** node to see the products the Node.js script added. The node name for each document is the **name** property. 

You've now seen how to use Visual Studio Code to create, edit, and run a Node.js application.