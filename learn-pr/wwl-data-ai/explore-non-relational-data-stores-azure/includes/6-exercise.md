In the sample scenario, suppose that you've created the following data stores:

- A Cosmos DB for holding information about the products that Contoso manufactures.
- A blob container in Azure Storage for holding the images of products.
- A file share, in the same Azure Storage account, for holding product documentation. 

In this exercise, you'll upload data to these data stores. You'll run queries against the data in the Cosmos DB database. Finally, you'll download and view the images and documents held in Azure Storage.

You'll perform this exercise using the Azure portal and the command line.

## Setup

1. In the Cloud Shell window on the right, run the following command:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-explore-non-relational-data-stores-azure.git lab
    ```

    This command copies the scripts and data required to set up the sample Cosmos DB database and Azure Storage account used by this exercise.

2. Move to the **lab** folder.

    ```bash
    cd lab
    ```

3. Run the following command. 

    ```bash
    bash setup.sh
    ```

    This command creates the Cosmos DB database and Azure Storage account. It takes as long as 10 minutes to run. When the script has finished, make a note of the values for the Cosmos DB account, database, container, and Storage account names.

4. Download the Data Migration tool for Azure Cosmos DB  from the following link: [Data Migration tool](https://aka.ms/csdmtool). Download and open the zip file, and extract the contents of the **drop** folder to a convenient folder on your computer.

5. Download [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/) and run the installer. Use the default options to install the utility.

6. Download [git for Windows](https://gitforwindows.org/). Run the installer, and accept the default options.

## Upload product data to Cosmos DB

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

2. On the home page, select **Azure Cosmos DB**.

    > [!div class="mx-imgBorder"]
    > ![Image of home page in the Azure portal. The user has selected **Cosmos DB**](../media/6-home-page.png)

3. On the **Azure Cosmos DB** page, select the Cosmos DB account that was created by the setup script.

4. On the Cosmos DB account page, under **Settings**, select **Keys**. Copy the **PRIMARY CONNECTION STRING** to the clipboard.

    > [!div class="mx-imgBorder"]
    > ![Image of **Keys** page for the Cosmos DB account. The user has selected the primary connection string](../media/6-cosmos-key.png)

5. Switch to your desktop computer.

6. Open a command prompt window, move to a convenient folder, and run the following command to create another copy of the code and data required for the exercise.

    > [!NOTE]
    > You need a copy of the data on your computer because you'll run the tools to upload this data from your desktop.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-explore-non-relational-data-stores-azure.git lab
    ```

7. Using File Explorer, move to the folder where you installed the Data Migration tool.

8. Double-click the file **dtui.exe**. This application is the Data Migration Tool.

    > [!div class="mx-imgBorder"]
    > ![Image of **File Explorer** on the user's desktop. The user is in the folder for the Data Migration Tool, and is about to start the **dtui.exe** application.](../media/6-tools-folder.png)

9. On the **Welcome** page of the Data Migration Tool, select **Next**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Welcome** page in the Data Migration Tool](../media/6-welcome.png)

9. On the **Source Information** page, in the **Import from** drop-down list box, select **JSON file(s)**. and then select **Add Files**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Source Information** page in the Data Migration Tool](../media/6-source.png)

10. In the **Open** dialog box, browse to the folder on the desktop where you cloned the repository containing the sample data for the exercise, move to the **lab** folder, move to the **products** folder, and select the **productinfo.json** file. Select **Open**.

    > [!NOTE]
    > The **productinfo.json** file contains the product information in JSON format. If you have time, you can examine the contents of this file using Notepad.

11. Back on the **Source Information** page, select **Next**

12. On the **Target Information** page, enter the following settings, and then select **Next**.

    | Field | Value |
    |-|-|
    | Export to | Azure Cosmos DB - Sequential record import (partitioned collection) | 
    | Connection String | Paste the primary connection string from the clipboard, and append the text *database=ProductData* to the end of the string, after the semi-colon ( ; ) character. |
    | Collection | ProductCatalog |
    | Partition Key | /productcategory/subcategory |
    | Collection Throughput | 1000 |
    | ID | *leave empty* |

    > [!div class="mx-imgBorder"]
    > ![Image of the **Target Information** page in the Data Migration Tool](../media/6-target.png)

13. On the **Advanced** page, leave all settings at their default values, and then select **Next**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Advanced** page in the Data Migration Tool](../media/6-advanced.png)

14. On the **Summary** page, select **Import**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Summary** page in the Data Migration Tool](../media/6-summary.png)

15. Wait while the import proceeds. It should complete without any errors or warnings, and report that it has transferred 504 records.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Results** page in the Data Migration Tool](../media/6-results.png)

16. Close the Data Migration Tool.

## Query product data in Cosmos DB

1. Return to the Azure portal, and go to your Cosmos DB account.

2. On the **Overview** page for the account, select **Data Explorer**. On the **Data Explorer** page, expand the **ProductData** database, expand the **ProductCatalog** container, and then select **Items**. Verify that the **Items** pane contains a list of products.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Items** page for the Cosmos DB container](../media/6-items.png)

3. Select the item with ID 316. A JSON document containing the details for product 316 should appear in the right-hand pane.

    > [!div class="mx-imgBorder"]
    > ![Image of the data for product 316](../media/6-document-316.png)

4. In the toolbar, select **New SQL Query**.

    > [!div class="mx-imgBorder"]
    > ![Image of the toolbar. The user has selected **New SQL Query**](../media/6-new-query.png)

5. In the **Query 1** pane, enter the following query, and then select **Execute Query**. This query returns the name, color, listprice, description, and file name of the image for each model of mountain bike that Contoso make. The query should return 32 documents.

    ```SQL
    SELECT p.productname, p.color, p.listprice, p.description, p.images.thumbnail
    FROM products p
    WHERE p.productcategory.subcategory = "Mountain Bikes"
    ```
    > [!div class="mx-imgBorder"]
    > ![Image showing the list of mountain bikes returned by the query](../media/6-mountain-bike-query.png)

6. Modify the query to return information about Road Bikes. 

    ```SQL
    SELECT p.productname, p.color, p.listprice, p.description, p.images.thumbnail
    FROM products p
    WHERE p.productcategory.subcategory = "Road Bikes"
    ```

    The query should return 43 documents.

7. Replace the query with the following text. This query counts the number of Touring Bikes.

    ```SQL
    SELECT COUNT(p.productname)
    FROM products p
    WHERE p.productcategory.subcategory = "Touring Bikes"
    ```

    The data is returned as a document with a field named "$1" that has the value 22.

    ```text
    [
        {
            "$1": 22
        }
    ]
    ```

8. Modify the query, and add the **VALUE** keyword as shown below.  

    ```SQL
    SELECT VALUE COUNT(p.productname)
    FROM products p
    WHERE p.productcategory.subcategory = "Touring Bikes"
    ```

    This time the query just returns the value 22, and doesn't generate a field name.

    ```text
    [
        22
    ]
    ```

9. Run the following query:

    ```SQL
    SELECT VALUE SUM(p.quantityinstock)
    FROM products p
    WHERE p.productcategory.subcategory = "Touring Bikes"
    ```

    This query returns the total number of touring bikes currently in stock. It should return the value 3477.

10. If you have time, experiment with some queries of your own.

## Upload images to Azure Blob storage

1. In the Azure portal, in the left-hand navigation menu, select **Home**

    > [!div class="mx-imgBorder"]
    > ![Image showing navigation menu in the Azure portal. The user has selected **Home**](../media/6-navigation-menu.png)

2. On the **Home** page, select **Storage accounts**, and then select the storage account created by the setup script.

3. On the **Storage Account** page, under **Settings**, select **Shared access signature**.

    > [!div class="mx-imgBorder"]
    > ![Image showing the page for the Storage Account in the Azure portal. The user has selected **Shared access signature**](../media/6-storage.png)

4. On the **Shared access signature** page, under **Allowed services**, select **Blob** and **File**. Deselect **Queue** and **Table**.

    Under **Allowed resource types**, select **Service**, **Container**, and **Object**. 
    
    Accept the default permissions, and start and expiry date/time values. 
    
    In the **Allowed IP addresses** box, enter the public IP address of your desktop computer. 

    > [!NOTE]
    > You can find the IP address of your desktop computer by visiting https://whatismyipaddress.com/.

    Leave **Allowed protocols** set to **HTTPS only**, and then click **Generate SAS and connection string**.

    Make a note of the values in the **SAS token**, **Blob service SAS URL**, and **File service SAS URL** fields.

    > [!TIP]
    > Copy these values to the clipboard, and paste them into a text file, using Notepad.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **Shared access signature** page for the storage account](../media/6-shared-access-signature-page.png)

5. Return to your desktop computer, and start Azure Storage Explorer.

6. In Azure Storage Explorer, expand **Local & Attached**, right-click **Storage Accounts**, and then select **Connect to Azure Storage**

    > [!div class="mx-imgBorder"]
    > ![Image showing the **Azure Storage Explorer**. The user has selected **Storage Accounts**](../media/6-local-attached.png)

7. In the **Connect to Azure Storage** dialog box, select **Use a shared access signature (SAS) URI**, and then select **Next**.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **Connect to Azure Storage** dialog box. The user has selected **Use a shared access signature (SAS) URI**](../media/6-select-shared-access-signature.png)

8. On the **Attach with SAS URI** page, in the **Display name** field, enter **Image Data**. In the **URI** field, provide the  Blob service SAS URL that you generated earlier in the Azure portal, and then select **Next**. The **Blob endpoint** and **File endpoint** fields on this page are populated automatically.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **Attach with SAS URI** dialog box. The user has provided the Blob service SAS URL from the Azure portal](../media/6-attach-shared-access-signature.png)

9. On the **Connection Summary** page, select **Connect**

    > [!div class="mx-imgBorder"]
    > ![Image showing the **Connection Summary** dialog box.](../media/6-shared-access-signature-connect.png)

10. In Azure Storage Explorer, under **Storage Accounts**, expand **Image Data**. Verify that folders appear for **Blob Containers** and **File Shares**.

    > [!div class="mx-imgBorder"]
    > ![Image showing **Azure Storage Explorer**. The **Image Data** account has been attached](../media/6-image-data-account.png)

11. Right-click **Blob Containers**, and then select **Create Blob Container**. Add a container named **images**.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **images** container added to the list of blob containers](../media/6-new-blob-container.png)

12. Return to the Cloud Shell window, and move to the **lab** folder.

13. Run the following command. Replace **\<storage account name\>** with the name of your Azure Storage account:

    ```azurecli
    az storage blob upload-batch \
        --account-name <storage account name> \
        --source 'images' \
        --pattern '*.gif' \
        --destination 'images'
    ```

    This command uploads all the files in the **images** folder to the **images** blob container in your storage account.

    > [!NOTE]
    > You may see a message that starts with *No connection string, account key or sas token found*. You can ignore this message.

## View images in Azure Blob storage

1. Switch back to Azure Storage Explorer on your desktop computer.

2. Close the **images** pane, and then select the **images** container to open it again. The container should now contain the image blobs for your products.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **images** container, with the image blobs](../media/6-image-blobs.png)

3. Select any blob, and then select **Open** in the toolbar.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **images** container. The user has selected a blob and is about to download and open it](../media/6-open-image.png)

    The blob should be downloaded, and the contents displayed.

    > [!div class="mx-imgBorder"]
    > ![Image of a red bicycle](../media/6-red-bicycle.png)

4. If time allows, try downloading other images. You can also select multiple images and use the **Download** command in the toolbar to retrieve the image files from blob storage and save them locally. 

## Upload documents to Azure File storage

1. In Azure Storage Explorer, in the left-hand pane, under **Image Data (SAS)**, right-click **File Shares**, and then select **Create File Share**. Add a file share named **documents**.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **documents** file share added to the list of file shares](../media/6-file-share.png)

2. Return to the Cloud Shell window, and make sure you are in the **labs** folder.

3. Run the following command:

    ```bash
    bash findip.sh
    ```

    This command returns the public IP address of your Cloud Shell. Make a note of this address.

4. Switch to the Azure portal and go to the page for your storage account.

5. Under **Settings**, select **Shared access signature**, and create another SAS token, this time for your Cloud Shell. Specify the following settings, and then click **Generate SAS and connection string**:

    | Setting | Value |
    |-|-|
    | Allowed services | File | 
    | Allowed reource types | Container, and Object | 
    | Permissions | Accept the default permissions |
    | Start and expiry date/time | Accept the default values |
    | Allowed IP addresses| Enter the IP address of your Cloud Shell | 
    | Allowed protocols | HTTPS only |

    Make a note of the SAS token that is generated.
    
6. Return to the Cloud Shell and run the following command. Replace **\<storage-account-name\>** with the name of your storage account, and replace **\<SAS-token\>** with the SAS token for your storage account that you generated in the previous step:

    ```azurecli
    azcopy copy 'docs' 'https://<storage-account-name>.file.core.windows.net/documents/productdocs<SAS-token>' --recursive
    ```

    This command uploads all the files in the *docs* folder to a folder named *productdocs* in the *documents* file share. It should upload seven items; one folder and six files.

## Download documents from Azure File storage

1. Return to Azure Storage Explorer on your desktop computer.

2. Close the **documents** pane, and the select the **documents** file share to open it again. The **productdocs** folder should be listed in the right-hand pane.

3. Double-click the **productdocs** folder, and then double-click the **docs** sub-folder. This sub-folder contains six documents:

    > [!div class="mx-imgBorder"]
    > ![Image showing the files in the **productdocs** folder](../media/6-productdocs.png)

4. Select any of the files, and then select **Open**. The file will be downloaded and opened using an editor. If you have Microsoft Word installed on your desktop, it will start and display the file, otherwise WordPad will be used (in this case, you should see the text, but the graphics images in the file won't display correctly). 

    The example below shows the *Front Reflector Bracket and Reflector Assembly 3.doc* file.

    > [!div class="mx-imgBorder"]
    > ![Image showing the *Front Reflector Bracket and Reflector Assembly 3.doc* file](../media/6-word-document.png)

5. If you have time, download and view the other documents.
