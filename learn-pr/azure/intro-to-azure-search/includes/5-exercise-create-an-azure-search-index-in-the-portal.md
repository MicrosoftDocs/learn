Azure Search is a rich search experience over a variety of content wherever the content is stored. <!-- REVIEW This sentence doesn't have any connection to what's happening in this unit, please use a topic sentence that focuses on the contents of the exercise -->

Your organization has a large number of exercise videos publicly available through its website. Users are struggling to find relevant content or are undertaking exercises beyond their fitness level. The exercise videos need to be indexed using the following properties video title, exercise difficulty, video length, and publication date.  It is hoped that these changes will improve user experience and result in fewer complaints about being unable to find relevant content.

In the unit, you'll load and index data in the Azure Search service we created earlier.

## Create the example video data set

1. Use the Cloud Shell to create a storage account and container.

    ```azurecli
    export AZURE_STORAGE_ACCOUNT="videoblobstorage"$RANDOM
    export CONTAINER="videocontainer"$RANDOM
    az storage account create --name $AZURE_STORAGE_ACCOUNT -g <rgn>[sandbox resource group name]</rgn> --kind StorageV2 --sku Standard_LRS
    export CREDENTIALS=$(az storage account show-connection-string --name $AZURE_STORAGE_ACCOUNT -o tsv)
    az storage container create --connection-string $CREDENTIALS --name $CONTAINER
    ```

1. Download the example video catalog into Cloud Shell storage.

    <!-- TODO replace with path to github repo -->
    ```bash
    curl ... video-catalog.json
    ```

1. Upload the video catalog to the blob storage account.

    ```azurecli
    az storage blob upload --connection-string $CREDENTIALS --container-name $CONTAINER --file video-catalog.json --name VideoCatalog
    ```

1. The `video-catalog.json` contains the following data: <!-- REVIEW Introduce the file further up. In the scenario, where would this have come from? -->

    ```json
    [
        {
            "id": "cc74bc3d-95b4-457f-bf5e-59c577938034",
            "Title": "Squats and Stars",
            "Difficulty": "7",
            "Length": "00:02:40",
            "Publication": "2019-04-29 12:34:56",
            "Size": "346"
        },
        {
            "id": "f94089de-d9f2-42d6-945d-276ae928564d",
            "Title": "Full body workout",
            "Difficulty": "9",
            "Length": "00:15:30",
            "Publication": "2019-04-24 11:14:06",
            "Size": "1897"
        },
        {
            "id": "d3a9f34f-d8a1-421b-bdd3-adbf826dbc84",
            "Title": "Crunches and Curls",
            "Difficulty": "4",
            "Length": "00:4:12",
            "Publication": "2019-04-22 09:56:26",
            "Size": "532"
        } ...
    ```

    A video has a title string, a difficulty rating integer, length in minutes, a publication date, and a file size in megabytes.

## Create an Azure Search index for your data in the Azure portal

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. In the **All Resources** view of the portal, select the Azure Search resource you created to navigate to its overview page. Note the ability to add indexes, import data, and search created indexes.

1. On the **northwindfitness** search Overview page, select **Import data**.

    ![Screenshot of the Azure portal, highlighting the Import data link](../media/5-exercise-screenshot-1.png)

1. On the **Connect to your data** page, select **Azure Blob Storage** as the **Data Source**.
1. Enter **videocatalog** in the **Name** field.
1. Change the **Parsing mode** to **JSON array**.
1. Select **Choose an existing connection**.

    ![Screenshot of the Azure portal, showing the Connect to your data page with the fields completed](../media/5-exercise-screenshot-2.png)

1. Select the video storage account.

    ![Screenshot of the Azure portal, showing the storage accounts](../media/5-exercise-screenshot-3.png)

1. Select the video container, then click **Select**.

    ![Screenshot of the Azure portal, showing the storage container](../media/5-exercise-screenshot-4.png)

1. Select **Next: Add cognitive search (Optional)**.

    ![Screenshot of the Azure portal, showing the dialog shown while an index is being created](../media/5-exercise-screenshot-5.png)

    Azure Search will read the contents of the JSON file and create an index schema automatically.

1. On the **Add cognitive search (Optional)** page, select **Skip to: Customize Target Index**.

    ![Screenshot of the Azure portal, showing the Customize target index page with the fields completed](../media/5-exercise-screenshot-6.png)

1. On the **Customize Target Index** page use the below information to fill out the fields. <!-- REVIEW Why are we doing this? What are we accomplishing here? -->

    | Field | Value |
    | --- | --- |
    | **Key** | Select the **id** field |
    | **Suggester name** |  **northwindfitnesssugg** |
    | **Search mode** | Select **analyzingInfixMatching** option <!-- REVIEW What is this and what does it do? It's never been mentioned --> |

    Change the Type of the fields to match the above <!-- REVIEW Specify in a table; don't force the user to rely on a screenshot to set the correct options -->, and select the checkboxes <!-- REVIEW Why? What are we trying to accomplish? -->, then select **Next: Create an indexer**.

1. On the **Create an indexer** page, select **Submit** to begin building the indexer.

    When the process completes, the portal will return you to the Search service overview.

    ![Screenshot of the Azure portal, showing the overview](../media/5-exercise-screenshot-9.png)

1. Select the **indexers** tab, and then select **myindexer**.
1. At the top of **myindexer** page, select **Run**.

    ![Screenshot of the Azure portal, showing the Customize target index page with the fields completed](../media/5-exercise-screenshot-10.png)

1. The indexer should import the video catalog, and show that 19 documents have been imported into the index.

## Test the index

![Screenshot of the Azure portal, showing the Search service overview page](../media/5-exercise-screenshot-7.png)

1. On the Search service overview, select **Search explorer**.

    ![Screenshot of the Azure portal, showing the Search explorer](../media/5-exercise-screenshot-8.png)

1. In the **Query string** enter `search=*&$count=true`, then select **Search**.

    The search query above returns all the documents in the search index, including a count of all the documents.

1. Leave the Azure portal signed in for the next exercise. <!-- REVIEW Call out that this was just a quick sanity check, and that the reader will get more experience with the explorer in the next units -->