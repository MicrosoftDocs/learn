The Azure Databases extension enables you to create and manage Azure databases, containers, and documents from within Visual Studio Code.

In the sample scenario, you want to work within Visual Studio Code, both as a development environment for building applications and as a tool for managing your Azure databases.

In this exercise, you'll install the Azure Databases extension for Visual Studio Code. Then you'll use the extension to connect to your Azure account and create an Azure account. You'll add a database and container for holding students' course grade information to the Azure Databases extension account. Finally, you'll create some test documents in the container, then view and update them.

This exercise runs on your desktop computer and uses an Azure sandbox for your resources.

> [!NOTE]
> This exercise assumes that you've already installed **Visual Studio Code** on your desktop computer.

## Install the Azure Databases extension for Visual Studio Code

1. Start Visual Studio Code.

1. On the **Extensions** menu at the top, select **Manage Extensions** to open the extensions pane.

1. In the **Search** box, enter **Azure Databases**, and press <kbd>Enter</kbd>.

1. In the list of extensions, select the **Azure Databases** extension published by Microsoft, and then select **Install**.

    :::image type="content" source="../media/3-install-cosmosdb-extension.png" alt-text="Screenshot of Visual Studio Code. The user has selected the Azure Databases extension." loc-scope="vs-code":::

    Wait while the extension is installed.

## Sign in to Azure with sandbox subscription

1. On the **View** menu, select **Command Palette**.

1. In the command palette, enter **Azure**, and then select **Azure: Focus on Resources View**.

    :::image type="content" source="../media/3-command-palette-cosmosdb.png" alt-text="Screenshot of the command palette in Visual Studio Code. The user has selected the Focus on Azure Databases extension View command." loc-scope="vs-code":::

    The Azure Resources pane appears (if not already visible).

    :::image type="content" source="../media/3-cosmosdb-pane.png" alt-text="Screenshot of the Azure Resources pane in Visual Studio Code." loc-scope="vs-code":::

1. On the **View** menu, select **Command Palette**, and then select **Azure: Sign in**.

1. Sign in with the same credentials you used to set up the sandbox, and then close the browser page.

1. In the Azure Resources pane, select **Select subscriptions...**. The Learn sandbox subscription has the following name and tenant ID:

    * Name: Concierge Subscription
    * Tenant ID: 604c1504-c6a3-4080-81aa-b33091104187

1. Select **Concierge Subscription** and then **OK**.

1. In the Azure Resources pane, expand **Concierge Subscription**.

## Create a Cosmos DB account in Visual Studio Code

1. Right-click **Azure CosmosDB** and then select **Create Server**.

    :::image type="content" source="../media/3-add-comsosdb-account.png" alt-text="Screenshot of the Azure Resources pane in Visual Studio Code. The user has selected the **Create Account** command." loc-scope="vs-code":::

    A wizard starts and prompts you for the details of the new account.


1. In the *Select an Azure Database Server* box, select **Core (SQL)**.

1. In the *Account name* box, enter an account name. The name must be globally unique; we suggest using something like **\<*your name or initials*\>-contoso-retail**, and press <kbd>Enter</kbd>.

1. In the *Select a capacity model* box, select **Provisioned Throughput**.

1. In the *Select a resource group for new resources* box, select **<rgn>[sandbox resource group]</rgn>** for the resource group created for you by the Learn sandbox.

1. In the *Select a location for new resources* box, select a location near you.

    Wait while the Azure Databases account is created. This will take a few minutes.

1. When the account has been created, in the Azure Resources pane, expand **Concierge Subscription** and **Azure CosmosDB**. Verify that the new Cosmos DB account appears.

    :::image type="content" source="../media/3-new-comsosdb-account.png" alt-text="Screenshot of the Azure Resources extension pane in Visual Studio Code. The new Azure Databases extension account is listed under the user's Azure account." loc-scope="vs-code":::

## Create a database and container

1. In the Azure Resources pane, right-click the database account you created, and then select **Create Database**.

    :::image type="content" source="../media/3-cosmosdb-create-database.png" alt-text="Screenshot of the Azure Resources pane in Visual Studio Code. The user has selected the Create Database command for the Azure Databases extension account." loc-scope="vs-code":::

1. In the *Database Name* box, enter **ContosoRetail**, and then press <kbd>Enter</kbd>.

1. In the *Enter an id for your Collection* box, enter **Products**, and then press <kbd>Enter</kbd>.

    This container will hold `Products` documents. Tags will be held as an array of subdocuments with each product.

    ```json
    {
        "id": "08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2",
        "categoryId": "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
        "categoryName": "Bikes, Touring Bikes",
        "sku": "BK-T79U-50",
        "name": "Touring-1000 Blue, 50",
        "description": "The product called \"Touring-1000 Blue, 50\"",
        "price": 2384.0700000000002,
        "tags": [
            {
                "_id": "27B7F8D5-1009-45B8-88F5-41008A0F0393",
                "name": "Tag-61"
            }
        ]
    }
    ```

1. In the *Enter the partition key for the collection, or leave blank for fixed size* box, enter **categoryName** and press <kbd>Enter</kbd>.

1. In the *Initial throughput capacity* box, enter **1000**, and then press <kbd>Enter</kbd>.

1. In the Azure Resources pane, verify that the **ContosoRetail** database, containing the **Products** container, appears.

    :::image type="content" source="../media/3-database-and-container.png" alt-text="Screenshot of the Azure Resources pane in Visual Studio Code, showing the SchoolDB database and the StudentCourseGrades container." loc-scope="vs-code":::

## Create and view documents

1. In the Azure Resources pane, expand the **Products** container. Two subfolders should appear, named **Documents** and **Stored Procedures**.

1. Right-click the **Documents** folder, and then select **Create Document**.

    :::image type="content" source="../media/3-create-document.png" alt-text="Screenshot of the Azure Databases pane in Visual Studio Code. The user has selected the Create Document command in the StudentCourseGrades container." loc-scope="vs-code":::

1. In the *Enter a document ID* box, enter `08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2`, and then press <kbd>Enter</kbd>. This will be the ID of a product document.

1. Enter `Bikes, Touring Bikes` as the *Partition key*, and press <kbd>Enter</kbd>.

    The document will be created and appear in Visual Studio Code, in JSON format. The **id** and **_partitionKey** fields will be populated with the values you specified.

    :::image type="content" source="../media/3-new-document.png" alt-text="Screenshot of Visual Studio Code showing the newly created document." loc-scope="vs-code":::

1. In the Azure Resources pane, right-click the **Documents** folder again, and select **Create Document**.

1. In the *Enter a document ID* box, enter `0F124781-C991-48A9-ACF2-249771D44029`, and then press <kbd>Enter</kbd>. This will be the ID of another student.

1. Enter `Bikes, Mountain Bikes` as the *Partition key*, and press <kbd>Enter</kbd>.

    The new document appears.

## Edit documents

1. In the **Documents** list, select the **08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2** document.

1. In the JSON document that appears, move to the end of the **id** line, and press <kbd>Enter</kbd>.

1. Add the following fields to the document.

    ```JSON
    "categoryId": "75BF1ACB-168D-469C-9AA3-1FD26BB4EA4C",
    "sku": "BK-T79U-50",
    "name": "Touring-1000 Blue, 50",
    "description": "The product called \"Touring-1000 Blue, 50\"",
    "price": 2384.0700000000002,
    "tags": [
        {
            "_id": "27B7F8D5-1009-45B8-88F5-41008A0F0393",
            "name": "Tag-61"
        }
    ]
    ```

    The **tags** property is an array field that contains the tags associated with a product. Using an array makes it possible for a product to have several tags.

1. On the **File** menu, select **Save**. 

1. When prompted to update the entity to the cloud, select **Always upload**.

    :::image type="content" source="../media/3-always-upload-message.png" alt-text="Screenshot of Visual Studio Code showing the edited document. The student has selected the Update to Cloud command to save the changes back to Azure." loc-scope="vs-code":::

   The document will be updated in the cloud. The node under the Products container is changed to the **name** property of the document.

1. In the **Documents** list, select the **0F124781-C991-48A9-ACF2-249771D44029** document.

1. Add the following fields to the document after the **id** field.

    ```JSON
    "categoryId": "56400CF3-446D-4C3F-B9B2-68286DA3BB99",
    "sku": "BK-M68B-42",
    "name": "Mountain-200 Black, 42",
    "description": "The product called \"Mountain-200 Black, 42\"",
    "price": 2294.9899999999998,
    "tags": [
        {
            "_id": "4F67013C-3B5E-4A3D-B4B0-8C597A491EB6",
            "name": "Tag-82"
        }
    ]
    ```

1. On the **File** menu, select **Save**.

## Delete documents

In the Azure explorer, right-click each of the product documents and delete them. You will upload the _entire_ products data set in the next section.

## Upload a data set into a container

1. To upload the entire **Products** data set, first copy and save the data from the [GitHub samples repository](https://raw.githubusercontent.com/Azure-Samples/cosmos-db-sql-api-javascript-samples/main/data/products.json).

1. In the Azure explorer, right-click on the **Products** container and select **Import document into a collection**.
1. In the file explorer, select the file you created for the products.json from the GitHub samples repository.

    :::image type="content" source="../media/3-import-documents-into-container.png" alt-text="Screenshot of Visual Studio Code showing the Import Document into a collection choice." loc-scope="vs-code":::


You've now used the Azure Databases extension in Visual Studio Code to create a Cosmos DB database and container. You've added and viewed documents, and you've edited these documents.
