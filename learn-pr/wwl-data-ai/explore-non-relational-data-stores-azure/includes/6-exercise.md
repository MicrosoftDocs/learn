In the sample scenario, suppose that you've created the following data stores: 

- A Cosmos DB database for holding information about the products that Contoso manufactures.
- A blob container in Azure Storage for holding the images of products.

In this exercise, you'll run a script to upload data to these data stores. You'll perform queries against the data in the Cosmos DB database. Then, you'll download and view the images held in Azure Storage.

You'll perform this exercise using the Azure portal and the Azure Cloud Shell.

## Setup

1. In the Cloud Shell window on the right, run the following command:

    ```bash
    git clone https://github.com/MicrosoftLearning/DP-900T00A-Azure-Data-Fundamentals dp-900
    ```

    This command copies the scripts and data required to set up the sample Cosmos DB database and Azure Storage account used by this exercise.

2. Move to the **dp-900/nosql** folder.

    ```bash
    cd dp-900/nosql
    ```

3. Run the following command.

    ```bash
    bash setup.sh
    ```

    This command creates the Cosmos DB database and Azure Storage account and populates them with sample data. It takes as long as 10 minutes to run. When the script has finished, make a note of the values for the Cosmos DB account, database, container, and Storage account names.

## Query product data in Cosmos DB

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

2. On the Azure Home page, select the drop-down menu at the top of the left-hand pane, and then select **All resources**.

    > [!div class="mx-imgBorder"]
    > ![Image of Home page in the Azure portal. The user has selected **All resources** from the main menu](../media/6-main-menu.png)

3. On the **All resources** page, select the Cosmos DB account that was created by the setup script. The account name will be *cosmos* followed by a random number:

    > [!div class="mx-imgBorder"]
    > ![Image of All resources page in the Azure portal. The user has selected the Cosmos DB account](../media/6-all-resources.png)

4. On the Cosmos DB account page, select **Data Explorer**. On the **Data Explorer** page, expand the **ProductData** database, expand the **ProductCatalog** container, and then select **Items**. Verify that the **Items** pane contains a list of products.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Items** page for the Cosmos DB container](../media/6-cosmosdb-items.png)

5. Select the item with ID 316. A JSON document containing the details for product 316 should appear in the right-hand pane.

    > [!div class="mx-imgBorder"]
    > ![Image of the data for product 316](../media/6-document-316.png)

6. In the toolbar, select **New SQL Query**.

    > [!div class="mx-imgBorder"]
    > ![Image of the toolbar. The user has selected **New SQL Query**](../media/6-new-query.png)

7. In the **Query 1** pane, enter the following query, and then select **Execute Query**. This query returns the name, color, listprice, description, and file name of the image for each model of mountain bike that Contoso make. The query should return 32 documents.

    ```SQL
    SELECT p.productname, p.color, p.listprice, p.description, p.images.thumbnail
    FROM products p
    WHERE p.productcategory.subcategory = "Mountain Bikes"
    ```

    > [!div class="mx-imgBorder"]
    > ![Image showing the list of mountain bikes returned by the query](../media/6-mountain-bike-query.png)

8. Modify the query to return information about Road Bikes, and then click **Execute Query**.

    ```SQL
    SELECT p.productname, p.color, p.listprice, p.description, p.images.thumbnail
    FROM products p
    WHERE p.productcategory.subcategory = "Road Bikes"
    ```

    The query should return 43 documents.

9. Replace the query with the following text. This query counts the number of Touring Bikes.

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

10. Modify the query, and add the **VALUE** keyword as shown below.  

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

11. Run the following query:

    ```SQL
    SELECT VALUE SUM(p.quantityinstock)
    FROM products p
    WHERE p.productcategory.subcategory = "Touring Bikes"
    ```

    This query returns the total number of touring bikes currently in stock. It should return the value 3477.

12. If you have time, experiment with some queries of your own.

## View uploaded images in Azure Blob storage

1. In the Azure portal, in the left-hand navigation menu, select **Home**

    > [!div class="mx-imgBorder"]
    > ![Image showing navigation menu in the Azure portal. The user has selected **Home**](../media/6-navigation-menu.png)

2. On the **Home** page, select **All resources**, and then select the storage account created by the setup script.

    > [!div class="mx-imgBorder"]
    > ![Image showing the page for the Storage Account in the Azure portal. The user has selected **Shared access signature**](../media/6-storage-account.png)

3. On the storage account page, select **Storage Explorer**.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **storage account** page. The user has selected **Storage Explorer**](../media/6-storage-account-page.png)

4. In the Storage Explorer pane, expand **BLOB CONTAINERS** and then click **images**. The Images blob contains the image files uploaded by the setup script.

    > [!div class="mx-imgBorder"]
    > ![The **images** blob in the **BLOB CONTAINERS** folder in **Storage Explorer**](../media/6-images.png)

5. Select any image , and then select **Open** in the toolbar.

    > [!div class="mx-imgBorder"]
    > ![Image showing the **images** container. The user has selected a blob and is about to download and open it](../media/6-open-image.png)

6. In the **File download** window, select **Click here to begin download**.

    > [!div class="mx-imgBorder"]
    > ![The **File download** dialog box. The user has selected **Click here to begin download**.](../media/6-download-file.png)

7. The file should be downloaded by the browser. Select the file and open it to display the contents.

    > [!div class="mx-imgBorder"]
    > ![Image of the browser showing the downloaded file](../media/6-file-downloaded.png)

8. The image should be displayed. By default, Windows will use the Photo Viewer app, but if you have a different configuration then an alternative application might be used. 

    > [!div class="mx-imgBorder"]
    > ![Image of the bike lock](../media/6-bike-lock.png)

9. If time allows, try downloading and displaying other images.

## Summary

In this exercise, you investigated using Cosmos DB and Azure Storage to store and retrieve data. You ran a script that created a Cosmos DB database and a storage account, and uploaded sample data. You used Data Explorer in Cosmos DB to run simple queries against the data. You used Storage Explorer for the storage account to browse blob storage and download files.