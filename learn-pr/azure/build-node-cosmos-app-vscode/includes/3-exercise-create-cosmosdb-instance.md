In this unit, you'll work in Visual Studio Code with the Databases extension:

* Install the Azure Databases extension for Visual Studio Code. 
* Use the extension to connect to your Azure sandbox account.
* Create a Cosmos DB account. 
* Add a database and container.
* Create some test documents in the container, then view and delete them.

In the sample scenario, you want to work within Visual Studio Code, both as a development environment for building applications and as a tool for managing your Azure databases. This exercise runs on your desktop computer and uses a free Azure sandbox subscription.

> [!NOTE]
> This exercise assumes that you've already installed **Visual Studio Code** on your desktop computer.

## Install the Azure Databases extension for Visual Studio Code

1. Start Visual Studio Code.

1. On the **View** menu at the top, select **Extensions** to open the extensions pane or use the keyboard shortcut, <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd>.

1. In the **Search** box, enter **Azure Databases**, and press <kbd>Enter</kbd>.

1. In the list of extensions, select the **Azure Databases** extension published by Microsoft, and then select **Install**.

    :::image type="content" source="../media/3-install-cosmosdb-extension.png" alt-text="Screenshot of Visual Studio Code. The user has selected the Azure Databases extension." loc-scope="vs-code":::

    Wait while the extension is installed.

## Sign in to Azure with sandbox subscription

1. On the **View** menu, select **Command Palette**.

1. In the command palette, enter **Azure**, and then select **Azure: Focus on Resources View**, or use the keyboard shortcut, <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.

    :::image type="content" source="../media/3-command-palette-cosmosdb.png" alt-text="Screenshot of the command palette in Visual Studio Code. The user has selected the Focus on Azure Databases extension View command." loc-scope="vs-code":::

    The Azure explorer appears (if not already visible).

    :::image type="content" source="../media/3-cosmosdb-pane.png" alt-text="Screenshot of the Azure explorer in Visual Studio Code." loc-scope="vs-code":::

1. On the **View** menu, select **Command Palette**, and then select **Azure: Sign in**.

1. Sign in with the same credentials you used to set up the sandbox, and then close the browser page.

1. In the Azure explorer, select **Select subscriptions...**. The Learn sandbox subscription has the following name and tenant ID:

    **Troubleshooting**: If you aren't able to find the Concierge Subscription, you may have to change tenants and sign in again. Use the following tenant ID to complete that:

    * Tenant ID: 604c1504-c6a3-4080-81aa-b33091104187
    * Name: Concierge Subscription

1. Select **Concierge Subscription** and then **OK**.

1. In the Azure explorer, expand **Concierge Subscription**. 

## Create a Cosmos DB account in Visual Studio Code

1. Right-click **Azure CosmosDB** and then select **Create Server**.

    :::image type="content" source="../media/3-add-comsosdb-account.png" alt-text="Screenshot of the Azure explorer in Visual Studio Code. The user has selected the **Create Account** command." loc-scope="vs-code":::

    A wizard starts and prompts you for the details of the new account. Use the following table to complete the prompts:

    |Prompt|Answer|
    |--|--|
    |Select an Azure Database Server|**Core (SQL)**|
    |Account name|Enter a globally unique account name; we suggest using something like **\<*your name or initials*\>-contoso-retail**.|
    |Select a capacity model|**Provisioned Throughput** - Setting provisioned throughput on a container is the most frequently used option. You can elastically scale throughput for a container by provisioning any amount of throughput by using Request Units (RUs).|
    |Select a resource group for new resources|Select **<rgn>[sandbox resource group]</rgn>** for the resource group created for you by the Learn sandbox.|
    |Select a location for new resources|Select a location near you.|

1. When the account has been created, in the Azure explorer, expand **Concierge Subscription** and **Azure CosmosDB**. Verify that the new Cosmos DB account appears.

    :::image type="content" source="../media/3-new-comsosdb-account.png" alt-text="Screenshot of the Azure Resources extension pane in Visual Studio Code. The new Azure Databases extension account is listed under the user's Azure account." loc-scope="vs-code":::

## Create a database and container

1. In the Azure explorer, <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>, right-click the database account you created, then select **Create Database**.

    :::image type="content" source="../media/3-cosmosdb-create-database.png" alt-text="Screenshot of the Azure explorer in Visual Studio Code. The user has selected the Create Database command for the Azure Databases extension account." loc-scope="vs-code":::

1. A wizard starts and prompts you for the details. Use the following table to complete the prompts:

    |Prompt|Answer|
    |--|--|
    |Database Name|**ContosoRetail**|
    |Enter an ID for your Collection|**Products**|
    |Enter the partition key for the collection, or leave blank for fixed size|**categoryName**|
    |Initial throughput capacity|**1000**|

    This container will hold `Products` documents. Tags and inventory are arrays of subdocuments with each product. The following document is an example of a product.

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
        ],
        "inventory": [
            { "location": "Dallas", "inventory": 42 },
            { "location": "Seattle", "inventory": 3 },
            { "location": "Boston", "inventory": 15 },
            { "location": "Miami", "inventory": 89 },
            { "location": "San Diego", "inventory": 19 }
        ]
    }
    ```

1. In the Azure explorer, verify that the **ContosoRetail** database, containing the **Products** container, appears.

    :::image type="content" source="../media/3-database-and-container.png" alt-text="Screenshot of the Azure explorer in Visual Studio Code, showing the SchoolDB database and the StudentCourseGrades container." loc-scope="vs-code":::

## Create and view documents

1. In the Azure explorer, expand the **Products** container. Two subfolders should appear, named **Documents** and **Stored Procedures**.

1. Right-click the **Documents** folder, and then select **Create Document**.

    :::image type="content" source="../media/3-create-document.png" alt-text="Screenshot of the Azure Databases pane in Visual Studio Code. The user has selected the Create Document command in the StudentCourseGrades container." loc-scope="vs-code":::

1. A wizard starts and prompts you for the details. Use the following table to complete the prompts:

    |Prompt|Answer|
    |--|--|
    |Enter a document ID|**08225A9E-F2B3-4FA3-AB08-8C70ADD6C3C2**|
    |Partition key|**Bikes, Touring Bikes**|

1. The document will be created and appear in Visual Studio Code, in JSON format. The **id** and **categoryName** fields will be populated with the values you specified.

    :::image type="content" source="../media/3-new-document.png" alt-text="Screenshot of Visual Studio Code showing the newly created document." loc-scope="vs-code":::

1. Add a second document. In the Azure explorer, right-click the **Documents** folder again, and select **Create Document**.

1. A wizard starts and prompts you for the details. Use the following table to complete the prompts:

    |Prompt|Answer|
    |--|--|
    |Enter a document ID|**0F124781-C991-48A9-ACF2-249771D44029**|
    |Partition key|**Bikes, Mountain Bikes**|

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
    ],
    "inventory": []
    ```

    The **tags** property is an array field that contains the tags associated with a product. Using an array makes it possible for a product to have several tags.

1. On the **File** menu, select **Save**. 

1. When prompted to update the entity to the cloud, select **Always upload**.

    :::image type="content" source="../media/3-always-upload-message.png" alt-text="Screenshot of Visual Studio Code showing the edited document. The student has selected the Update to Cloud command to save the changes back to Azure." loc-scope="vs-code":::

   The document will be updated in the cloud. The node under the Products container is changed to the **name** property of the document.

1. In the **Documents** list, select the other document, named **0F124781-C991-48A9-ACF2-249771D44029**.

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

    You have added and edited Cosmos DB documents. 

1. The Documents list now shows readable names, using the `name` field of each object. When you work locally with documents, it's helpful to find documents if they use the `name` property. 

## Check your work

* In Visual Studio Code, in the Azure Databases extension you see your Cosmos DB account, database and container.
* When you expand the container node, you see two documents.
