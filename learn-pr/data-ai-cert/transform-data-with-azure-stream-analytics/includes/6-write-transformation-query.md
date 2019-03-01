An Azure Stream Analytics query transforms an input data stream and produces an output. Queries are written in a SQL-like language which is a subset of the Transact-SQL (T-SQL) language. We'll use a simple transformation of the input data to demonstrate the transformation query capabilities exposed by Stream Analytics. 

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in setting up an input file and changing the transformation query in an Azure Streaming Analytics job.

Let's assume we have some census data for specific cites and we need to pull specific elements out of the data - in this case, the coordinates of each city we got data for. We'll use a simple JSON file as our input, run a transformation query to pull coordinates out of the data, and then write the results out to a new file in our Blob storage.

## Create the sample input file

Let's start by creating a simple input file. Create a file named **input.json** with the following contents on your local computer.

```json
{
    "City" : "Reykjavik",
    "Coordinates" :
    {
        "Latitude": 64,
        "Longitude": 21
    },
    "Census" :
    {
        "Population" : 125000,
        "Municipality" : "Reykjavík",
        "Region" : "Höfuðborgarsvæðið"
    }
}
```

## Upload the input file to blob store container

Next, let's upload that file to Azure Blob Storage.

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Navigate to your source Blob storage account (**streamsrc**).

    > [!TIP]
    > You can use the Search field at the top of the Azure portal window to locate created resources by name, or use your Resource Group to find related resources.

1. Select the **streamsource** blob storage account you created earlier.
1. Select **Blobs** under **Blob service**.

    ![Screenshot of Configuring Input Blob Container](../media/6-input-blob.png)

1. Select the **learn-container** container you created. It should be empty.
1. Select **Upload**, click the folder icon next to the Files input and select the JSON file with the file dialog.
1. Expand the **Advanced** options if it's not expanded already.
1. Use **input/[YYYY-MM-DD]** for **Upload to folder** field where _YYYY-MM-DD_ is the current date.
1. Leave defaults for all other options.
1. Select **Upload** to upload the file.

    ![Screenshot of Uploading JSON File](../media/6-upload-json.png)

1. Once it's uploaded, you should see the "input" folder in the container. If you click on it, you can explore the blob hierarchy and see the data.

## Configure the output blob store container

Next, let's configure the destination for the transformed data.

1. Navigate to your destination Blob storage account (**streamsink**).
1. Select **Storage Explorer (preview)** from the set of choices on the Overview page.

    ![Screenshot of Storage Explorer in Azure portal](../media/6-storage-explorer.png)

1. In the right pane, navigate to **BLOB CONTAINERS**.
1. Select the container previously created.
1. Select **New Folder** from the menu above the container details. If it's not visible, click the **More...** drop-down to find it.
1. Type **output** for the folder name and select **Create**. This will create a placeholder, but Azure won't show it until a file is put into the folder.

## Write the transformation query

Now we are ready to write our transformation query. We need to pull the coordinates out of the input data and write it to the output. We'll do that using a `SELECT` statement. The full query options are documented online and there's a link in the summary of this module.

1. Locate your Stream Analytics job in the Azure portal using the search field - recall it's name is **SimpleTransfomer**.
1. Under **Job topology**, select **Query**.
1. In the Query pane, add the following query.

    ```sql
    SELECT City,
        Coordinates.Latitude,
        Coordinates.Longitude
    INTO streamoutput
    FROM streaminput
    ```

    ![Screenshot of Writing Query](../media/6-write-query.png)

1. Select **Save** to save your changes.

## Testing your query

A useful step before you run a job is to test the query to ensure it does what you want. Navigate to your Stream Analytics job in the Azure portal, select **Query** under **Job topology**, and then select **Test**. You can then upload sample data to use with the query in order to perform the test.
