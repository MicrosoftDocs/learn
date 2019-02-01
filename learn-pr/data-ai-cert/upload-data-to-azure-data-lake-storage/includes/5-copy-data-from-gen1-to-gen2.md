Azure Data Factory is the platform that solves such data scenarios. It is a cloud-based data integration service that allows you to create data-driven workflows in the cloud for orchestrating and automating data movement and data transformation. Using Azure Data Factory, you can create and schedule data-driven workflows (called pipelines) that can ingest data from disparate data stores. It can process and transform the data by using compute services such as Azure HDInsight Hadoop, Spark, Azure Data Lake Analytics, and Azure Machine Learning.

> [!IMPORTANT]
> Before you begin this exercise, you will need an Azure Data Lake Storage Gen1 account with data in it.

## Create a data factory

1. On the left menu, select **New** > **Data + Analytics** > **Data Factory**:

![Screenshot of Selecting Data Factory](../media/6-select-data-factory.png)

In the **New data factory** page, provide values for the fields that are shown in the following image:

![Screenshot of Creating Data Factory](../media/6-create-data-factory.png)

**Name**: Enter a globally unique name for your Azure data factory. If you receive the error "Data factory name, "LoadADLSDemo" is not available," enter a different name for the data factory. For example, you could use the name **yournameADFTutorialDataFactory**. Try creating the data factory again. For the naming rules for Data Factory artifacts, see Data Factory naming rules. Here is a summary of the following options:

1. **Subscription**: Select your Azure subscription in which to create the data factory.
2. **Resource Group**: Select an existing resource group from the drop-down list or select the **Create new** option and enter the name of a resource group. To learn about resource groups, see Using resource groups to manage your Azure resources.
3. **Version**: Select **V2**.
4. **Location**: Select the location for the data factory. Only supported locations are displayed in the drop-down list. The data stores that are used by the data factory can be in other locations and regions.
5. Select **Create**.
6. After creation is complete, go to your data factory. You see the **Data Factory** home page as shown in the following image:

![Screenshot of Generated Data Factory](../media/6-generated-data-factory.png)

Select the **Author & Monitor** tile to launch the Data Integration Application in a separate tab.

## Load data into Azure Data Lake Storage Gen2

In the **Get started** page, select the **Copy Data** tile to launch the Copy Data tool:

![Screenshot of Copying Data in Data Factory](../media/6-copy-data.png)

In the **Properties** page, specify **CopyFromADLSGen1ToGen2** for the **Task name** field, and select **Next**:

![Screenshot of Properties of Copying Data in Data Factory](../media/6-copy-data-property.png)

In the **Source data store** page, click **+ Create new connection**:

![Screenshot of Creating New Connection](../media/6-create-new-connection.png)

Select **Azure Data Lake Storage Gen1** from the connector gallery, and select **Continue**:

![Screenshot of Selecting Gen1](../media/6-create-gen1.png)

In the **Specify Azure Data Lake Storage Gen1 connection** page, do the following steps:

- Select your Data Lake Storage Gen1 for the name and specify or validate the Tenant.
- Click **Test connection** to validate the settings, then select **Finish**.
- You will see a new connection gets created. Select **Next**.

![Screenshot of Creating New Linked Service](../media/6-create-new-linked-service.png)

In the **Choose the input file or folder** page, browse to the folder and file that you want to copy over. Select the folder/file, select **Choose**:

![Screenshot of Choosing input file or folder](../media/6-choose-file-or-folder.png)

Specify the copy behavior by checking the **Copy files recursively** and **Binary copy** options. Select **Next**:

![Screenshot of Two Copy Options](../media/6-two-copy-options.png)

In the **Destination data** store page, click **+ Create new connection**, and then select **Azure Data Lake Storage Gen2 (Preview)**, and select **Continue**:

![Screenshot of Selecting Destination](../media/6-select-destination.png)

In the **Specify Azure Data Lake Storage Gen2 connection** page, do the following steps:

- Select your Data Lake Storage Gen2 capable account from the "Storage account name" drop-down list.
- Select **Finish** to create the connection. Then select **Next**.

In the **Choose the output file or folder** page, enter **copyfromadlsgen1** as the output folder name, and select **Next**:

![Screenshot of Choosing Output folder Path](../media/6-choose-output-folder-path.png)

1. In the **Settings** page, select **Next** to use the default settings.
2. In the **Summary** page, review the settings, and select **Next**:

![Screenshot of Summary Page](../media/6-summary-page.png)

In the **Deployment page**, select **Monitor** to monitor the pipeline:

![Screenshot of Deployment Page](../media/6-deployment-page.png)

You can monitor details like the volume of data copied from the source to the sink, data throughput, execution steps with the corresponding duration, and used configurations:

![Screenshot of Details Page](../media/6-details-page.png)

Verify that the data has been copied into your Data Lake Storage Gen2 account.