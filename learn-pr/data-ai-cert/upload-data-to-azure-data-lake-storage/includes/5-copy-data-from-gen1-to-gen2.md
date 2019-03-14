Azure Data Factory is a cloud-based data integration service that creates workflows in the cloud for orchestrating batch data movement and transformations. Using Azure Data Factory, you can create and schedule workflows (called _pipelines_) to ingest data from disparate data stores. The data can then be processed and transformed with services such as:

- Azure HDInsight Hadoop
- Spark
- Azure Data Lake
- Azure Machine Learning

There are many data orchestration tasks that can be conducted using Azure Data Factory. In this exercise, we'll copy data from Azure Data Lake Storage Gen1 to Azure Data Lake Storage Gen2. 

> [!NOTE]
> If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the following instructions to understand the steps involved using Azure Data Factory to copy data into an Azure Data Lake.

## Create an Azure Data Factory instance

The first step is to provision an instance of Azure Data Factory in the Azure portal.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true). 

1. On the left menu, select **New** > **Data + Analytics** > **Data Factory**:

    ![Screenshot of Selecting Data Factory](../media/6-select-data-factory.png)

1. In the **New data factory** page, provide values for each of the required fields.
    - Enter a globally unique name for your Azure data factory. Try using your initials with a suffix such as **ADFTutorialDataFactory**.
    - In the Subscription drop-down list, click on your subscription
    - In the resource group drop-down list, select **mslearn-datalake-test**
    - Select **V2** for the version.
    - Select the location for the data factory. Only supported locations are displayed in the drop-down list. The data stores that are used by the data factory can be in other locations and regions.

    ![Screenshot of Creating Data Factory](../media/6-create-data-factory.png)

5. Select **Create**.

After creation is complete, navigate to the new data factory. You should see the **Data Factory** home page.

![Screenshot of Generated Data Factory](../media/6-generated-data-factory.png)

> [!IMPORTANT]
> You will need an Azure Data Lake Storage Gen1 account with data in it. If you do not have this perform the following steps.

## Create a Data Lake Storage Gen 1 Account

1. In the left sidebar, click on **+ Create a new resource**.
In the **New** blade, click **Storage** and then click **Data Lake Storage Gen1**.
1. In the Name text box, type **dlsgen1XXX** replace "XXX" with numbers of your choice. A green tick should appear confirming that the name is unique.
1. In the Subscription drop-down list, click on your subscription.
1. In the resource group drop-down list, select **mslearn-datalake-test**.
1. Select a location - you typically want to select a region near where the data consumption will occur. In this example, select a location near you.
1. Click **Create**.

## Create a second sample text file

To provide some sample data to work with, create a local text file on your computer named **salesUK.txt** and paste the following text into the file.

```text
#salaries Details
#Company Information
#Fields : Date company employee Salaries
01-02-2019  d1   f1 8000
01-02-2019  d2   f2 9000
01-02-2019  d1   f3 2000
01-02-2019  d2   f4 3000
01-02-2019  d1   f5 4000
01-02-2019  d3   f6 5000
```

We'll upload this data file in various ways. Keep in mind that this is a _simple_ example - you would typically be populating your data lake with much larger data samples from a variety of sources.

## Upload a file into data lake storage Gen 1 account

1. In the Azure portal, search for the Data Lake Storage Gen1 service you created (**dlsgen1XXX**).
1. In the overview blade, click **Data Explorer**
1. In the Data Explorer blade, click on the **Upload** icon.
1. In the Upload file blade, click on the browse icon, browse to the folder, and select your **salesUK.txt** file, click on the button **Add selected files**. Conformation that the upload has completed is when the states column states **completed**.
1. Close the Upload files blade.

## Setting permissions on the data lake storage Gen 1 account

Next, you need to set permissions to enable the Azure Data Factory instance to access the data in your Data Lake Store Gen 1.

1. In the Azure portal, search for the Data Lake Storage Gen1 named **dlsgen1XXX** that you created.
1. In the overview blade, click **Access control (IAM)**
1. In the Access Control (IAM) blade, click on the **Add** button in the **Add Role Assignment** box.
1. In the Add Role Assignment blade, select **Owner** for the **Role**.
1. Select the text box under **Select** and type in the Azure Data Factory instance name you created.
1. Click **Save**.
1. Close the **Access control (IAM)** blade.

## Load data into Azure Data Lake Storage Gen2

1. In the Azure portal, go to your data factory. You see the **Data Factory** home page.

1. Select the **Author & Monitor** tile to launch the Data Integration Application in a separate tab.


    ![Screenshot of Generated Data Factory](../media/6-generated-data-factory.png)

1. In the **Get started** page, select the **Copy Data** tile to launch the Copy Data tool.

    ![Screenshot of Copying Data in Data Factory](../media/6-copy-data.png)

1. In the **Properties** page, specify **CopyFromADLSGen1ToGen2** for the **Task name** field, set the cadence to "once", and select **Next**:

    ![Screenshot of Properties of Copying Data in Data Factory](../media/6-copy-data-property.png)

1. In the **Source data store** page, click **+ Create new connection**.

    ![Screenshot of Creating New Connection](../media/6-create-new-connection.png)

1. Select **Azure Data Lake Storage Gen1** from the connector gallery, and select **Continue**.

    ![Screenshot of Selecting Gen1](../media/6-create-gen1.png)

1. In the **Specify Azure Data Lake Storage Gen1 connection** page, do the following steps:
    - Select your Data Lake Storage Gen1 for the name and specify or validate the Tenant.
    - Click **Test connection** to validate the settings, then select **Finish**.
    - You'll see a new connection gets created. Select **Next**.

    ![Screenshot of Creating New Linked Service](../media/6-create-new-linked-service.png)

1. In the **Choose the input file or folder** page, browse to the folder and file that you want to copy over. Select the folder/file, select **Choose**.

    ![Screenshot of Choosing input file or folder](../media/6-choose-file-or-folder.png)

1. Specify the copy behavior by checking the **Copy files recursively** and **Binary copy** options. Select **Next**:

    ![Screenshot of Two Copy Options](../media/6-two-copy-options.png)

1. In the **Destination data** store page, click **+ Create new connection**, select **Azure Data Lake Storage Gen2 (Preview)**, and click **Continue**.

    ![Screenshot of Selecting Destination](../media/6-select-destination.png)

1. In the **Specify Azure Data Lake Storage Gen2 connection** page, do the following steps:
    - Select your Data Lake Storage Gen2 capable account from the "Storage account name" drop-down list.
    - Select **Finish** to create the connection. Then select **Next**.

1. In the **Choose the output file or folder** page, enter **copyfromadlsgen1** as the output folder name, and select **Next**.

    ![Screenshot of Choosing Output folder Path](../media/6-choose-output-folder-path.png)

1. In the **Settings** page, select **Next** to use the default settings.
1. Review the settings, and select **Next**.

    ![Screenshot of Summary Page](../media/6-summary-page.png)

1. In the **Deployment page**, select **Monitor** to monitor the pipeline.

    ![Screenshot of Deployment Page](../media/6-deployment-page.png)

    You can monitor details like the volume of data copied from the source to the sink, data throughput, execution steps with the corresponding duration, and used configurations.

    ![Screenshot of Details Page](../media/6-details-page.png)

Once the transfer is complete, you can verify the data has been copied into your Data Lake Storage Gen2 account with the Azure Storage Explorer.