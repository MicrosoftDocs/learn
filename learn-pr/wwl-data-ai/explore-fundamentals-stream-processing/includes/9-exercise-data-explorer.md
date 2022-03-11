In this exercise, you'll use Azure Synapse Data Explorer to analyze time-series data.

To complete this exercise, you will need a Microsoft Azure subscription. If you don't already have one, you can sign up for a free trial at [https://azure.microsoft.com/free](https://azure.microsoft.com/free?azure-portal=true). You cannot use a Microsoft Learn sandbox subscription for this exercise.

## Provision a Synapse Analytics workspace

> [!TIP]
> If you still have the Azure Synapse Workspace from the previous exercise in this module, skip this section and go straight to the **Create a Data Explorer pool** section.

1. Open the Azure portal at [https://portal.azure/com](https://portal.azure.com?azure-portal=true), and sign in using the credentials associated with your Azure subscription.

    Ensure you are working in the directory containing your subscription - indicated at the top right under your user ID. If not, select the user icon and switch directory. Note that if you previously used a Microsoft Learn sandbox subscription, the portal may have defaulted to the *Microsoft Learn Sandbox* directory. If so, you'll need to switch to your own directory.

2. In the Azure portal, on the **Home** page, use the **&#65291; Create a resource** icon to create a new resource.
3. Search for *Azure Synapse Analytics*, and create a new **Azure Synapse Analytics** resource with the following settings:
    - **Subscription**: *Your Azure subscription*
        - **Resource group**: *Create a new resource group with a suitable name, like "synapse-rg"*
        - **Managed resource group**: *Enter an appropriate name, for example "synapse-managed-rg"*.
    - **Workspace name**: *Enter a unique workspace name, for example "synapse-ws-<your_name>*.
    - **Region**: *Select any available region*.
    - **Select Data Lake Storage Gen 2**: From subscription
        - **Account name**: *Create a new account with a unique name, for example "datalake<your_name>"*.
        - **File system name**: *Create a new file system with a unique name, for example "fs<your_name>"*.

    > [!NOTE]
    > A Synapse Analytics workspace requires two resource groups in your Azure subscription; one for resources you explicitly create, and another for managed resources used by the service. It also requires a Data Lake storage account in which to store data, scripts, and other artifacts.

4. When you've entered these details, select **Review + create**, and then select **Create** to create the workspace.
5. Wait for the workspace to be created - this may take five minutes or so.
6. When deployment is complete, go to the resource group that was created and notice that it contains your Synapse Analytics workspace and a Data Lake storage account.
7. Select your Synapse workspace, and in its **Overview** page, in **Open Synapse Studio** card, select **Open** to open Synapse Studio in a new browser tab. Synapse Studio is a web-based interface that you can use to work with your Synapse Analytics workspace.
8. On the left side of Synapse Studio, use the **&rsaquo;&rsaquo;** icon to expand the menu - this reveals the different pages within Synapse Studio that you will use to manage resources and perform data analytics tasks

## Create a Data Explorer pool

1. In Synapse Studio, select the **Manage** page.
2. Select the **Data Explorer pools** tab, and then use the **&#65291; New** icon to create a new pool with the following settings:
    - **Data Explorer pool name**: dxpool
    - **Workload**: Compute optimized
    - **Size**: Extra Small (2 cores)
3. Select **Next: Additional Settings >** and enable the **Streaming ingestion** setting - this enables Data Explorer to ingest new data from a streaming source, such as Azure Event Hubs.
4. Select **Review and create** to create the Data Explorer pool, and then wait for it to be deployed (which may take 15 minutes or longer - the status will change from *Creating* to *Online*).

## Create a database and ingest data

1. In Synapse Studio, select the **Data** page.
2. Ensure that the **Workspace** tab is selected, and if necessary, select the **&#8635;** icon at the top-left of the page to refresh the view so that **Data Explorer databases** is listed.
3. Expand **Data Explorer databases** and verify that **dxpool** is listed.
4. In the **Data** pane, use the **&#65291;** icon to create a new **Data Explorer database** in the **dxpool** pool with the name **iot-data**.
5. While waiting for the database to be created, download **devices.csv** from [https://github.com/MicrosoftLearning/DP-900T00A-Azure-Data-Fundamentals/raw/master/streaming/data/devices.csv](https://github.com/MicrosoftLearning/DP-900T00A-Azure-Data-Fundamentals/raw/master/streaming/data/devices.csv?azure-portal=true), saving it in any folder on your local computer.
6. In Synapse Studio, wait for the database to be created if necessary, and then in the **...** menu for the new **iot-data** database, select **Open in Azure Data Explorer**.
7. In the new browser tab containing Azure Data Explorer, on the **Data** tab, select **Ingest new data**.
8. In the **Destination** page, select the following settings:
    - **Cluster**: *The **dxpool** Data Explorer pool in your Azure Synapse workspace*
    - **Database**: iot-data
    - **Table**: Create a new table named **devices**
9. Select **Next: Source** and on the **Source** page, select the following options:
    - **Source type**: File
    - **Files**: Upload the **devices.csv** file from your local computer.
10. Select **Next: Schema** and on the **Schema** page, ensure the following settings are correct:
    - **Compression type**: Uncompressed
    - **Data format**: CSV
    - **Ignore the first record**:  selected
    - **Mapping**: devices_mapping
11. Ensure the column data types have been correctly identified as *Time (datetime)*, *Device (string)*, and *Value (long)*). Then select **Next: Start Ingestion**.
12. When ingestion is complete, select **Close**.
13. In Azure Data Explorer, on the **Query** tab, ensure that the **iot-data** database is selected and then in the query pane, enter the following query.

    ```kusto
    devices
    ```

14. On the toolbar, use the **&#9655; Run** button to run the query, and review the results, which should look similar to this:

    | Time | Device | Value |
    | --- | --- | --- |
    | 2022-01-01T00:00:00Z | Dev1 | 7 |
    | 2022-01-01T00:00:01Z | Dev2 | 4 |
    | ... | ... | ... |

    If your results match this, you have successfully created the **devices** table from the data in the file.

> [!NOTE]
> In this example, you imported a very small amount of batch data from a file, which is fine for the purposes of this exercise. In reality, you can use Data Explorer to analyze much larger volumes of data; and since you enabled stream ingestion, you could also have configured Data Explorer to ingest data into the table from a streaming source such as Azure Event Hubs.

## Use Kusto query language to query the table in Synapse Studio

1. Close the Azure Data Explorer browser tab and return to the tab containing Synapse Studio.
2. On the **Data** page, expand the **iot-data** database and its **Tables** folder. Then in the **...** menu for the **devices** table, select **New KQL Script** > **Take 1000 rows**.
3. Review the generated query and its results. The query should contain the following code:

    ```kusto
    devices
    | take 1000
    ```

    The results of the query contain the first 1000 rows of data.

4. Modify the query as follows:

    ```kusto
    devices
    | where Device == 'Dev1'
    ```

5. Use the **&#9655; Run** button to run the query. Then review the results, which should contain only the rows for the *Dev1* device.

6. Modify the query as follows:

    ```kusto
    devices
    | where Device == 'Dev1'
    | where Time > datetime(2022-01-07)
    ```

7. Run the query and review the results, which should contain only the rows for the *Dev1* device later than January 7th 2022.

8. Modify the query as follows:

    ```kusto
    devices
    | where Time between (datetime(2022-01-01 00:00:00) .. datetime(2022-07-01 23:59:59))
    | summarize AvgVal = avg(Value) by Device
    | sort by Device asc
    ```

9. Run the query and review the results, which should contain the average device value recorded between January 1st and January 7th 2022 in ascending order of device name.

10. Close the KQL query tab, discarding your changes.

## Delete Azure resources

Now that you've finished exploring Azure Synapse Analytics, you should delete the resources you've created to avoid unnecessary Azure costs.

1. Close the Synapse Studio browser tab, without saving any changes, and return to the Azure portal.
2. On the Azure portal, on the **Home** page, select **Resource groups**.
3. Select the resource group for your Synapse Analytics workspace (not the managed resource group), and verify that it contains the Synapse workspace, storage account, and Data Explorer pool for your workspace (if you completed the previous exercise, it will also contain a Spark pool).
4. At the top of the **Overview** page for your resource group, select **Delete resource group**.
5. Enter the resource group name to confirm you want to delete it, and select **Delete**.

    After a few minutes, your Azure Synapse workspace and the managed workspace associated with it will be deleted.
