Azure Data Factory is a cloud-based data integration service that allows you to create workflows in the cloud for orchestrating batch data movement and transformations. Using Azure Data Factory, you can create and schedule workflows (called pipelines) that can ingest data from disparate data stores. It can process and transform the data by using compute services such as Azure HDInsight Hadoop, Spark, Azure Data Lake, and Azure Machine Learning.

There are many data orchestration tasks that can be conducted using Azure Data Factory. In this example, you will see an example of orchestrating a data copy from Azure Data Lake Storage Gen1 to Azure Data Lake Storage Gen2. The first step is to provision an instance of Azure Data Factory as shown in the following steps: 

## Create an Azure Data Factory instance

1. On the left menu, select **New** > **Data + Analytics** > **Data Factory**:

![Screenshot of Selecting Data Factory](../media/6-select-data-factory.png)

2. In the **New data factory** page, provide values for the fields that are shown in the following image:

![Screenshot of Creating Data Factory](../media/6-create-data-factory.png)

**Name**: Enter a globally unique name for your Azure data factory. If you receive the error "Data factory name, "LoadADLSDemo" is not available," enter a different name for the data factory. For example, you could use the name **yournameADFTutorialDataFactory**. Try creating the data factory again. For the naming rules for Data Factory artifacts, see Data Factory naming rules. Here is a summary of the following options:

1. **Subscription**: Select your Azure subscription in which to create the data factory.
2. **Resource Group**: Select an existing resource group from the drop-down list or select the **Create new** option and enter the name of a resource group. To learn about resource groups, see Using resource groups to manage your Azure resources.
3. **Version**: Select **V2**.
4. **Location**: Select the location for the data factory. Only supported locations are displayed in the drop-down list. The data stores that are used by the data factory can be in other locations and regions.
5. Select **Create**.
6. After creation is complete, go to your data factory. You see the **Data Factory** home page as shown in the following image:

![Screenshot of Generated Data Factory](../media/6-generated-data-factory.png)

> [!IMPORTANT]
> You will need an Azure Data Lake Storage Gen1 account with data in it. If you do not have this perform the following steps.

## Create a Data Lake Storage Gen 1 Account

1. Log into the Azure Portal with you account.
1. On the left, click on **+ Create a new resource**.
In the **New** blade, click **Storage** and then click **Data Lake Storage Gen1**
1. In the Name text box type **dlsgen1XXX** where XXX should be replaced with numbers of your choice. A green tick should appear confirming that the name is unoque
1. In the Subscription drop down list, click on your subscription
1. In the resource group drop down list select **mslearn-datalake-test**
1. Select a location - you typically want to select a region near where the data consumption will occur. Since this is an example, just select a location near you.
1. Click **Create**

## Create a second sample text file

To provide some sample data to work with, create a local text file on your computer named "SalesUK.txt" and paste the following into the file.

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

We'll upload this data file in various ways. Keep in mind that this is a _very simple_ example - you would typically be populating your data lake with much larger data samples from a variety of sources.

## Upload a file into data lake storage Gen 1 account
1. In the Azure portal search for the Data Lake Storage Gen1 named dlsgen1XXX that you have just created.
1. In the overview blade, click **Data Explorer**
1. In the Data Explorer blade, click on the **Upload** icon.
1. In the Upload file blade, click on the browse icon, browese to the folder and select your **SalesUK.txt** file, click on the button **Add selected files**. Conformation that the upload has completed is when the states column states **completed**.
1. Close down the Upload files blade.

You will also have to set permissions to enable the the Azure Data Factory instance to access the data in your Data Lake Store Gen 1. This can be achieved by performing the following steps

## Setting permissions on the data lake storage Gen 1 account
1. In the Azure portal search for the Data Lake Storage Gen1 named dlsgen1XXX that you have just created.
1. In the overview blade, click **Access control (IAM)**
1. In the Access Control (IAM) blade, click on the **+ Add Role Assignment** button.
1. In the Add Role Assignment blade, click on the  drop down list in **Role** and click **Owner**, click on the text box under **Select** and type in the Azure Data Factory instance name of **yournameADFTutorialDataFactory** and then click **Save**.
1. Close down the **Access control (IAM)** blade.

## Load data into Azure Data Lake Storage Gen2

1. In the Azure Portal, go to your data factory. You see the **Data Factory** home page as shown in the following image:

![Screenshot of Generated Data Factory](../media/6-generated-data-factory.png)

2. Select the **Author & Monitor** tile to launch the Data Integration Application in a separate tab.

3. In the **Get started** page, select the **Copy Data** tile to launch the Copy Data tool:

![Screenshot of Copying Data in Data Factory](../media/6-copy-data.png)

4. In the **Properties** page, specify **CopyFromADLSGen1ToGen2** for the **Task name** field, and select **Next**:

![Screenshot of Properties of Copying Data in Data Factory](../media/6-copy-data-property.png)

5. In the **Source data store** page, click **+ Create new connection**:

![Screenshot of Creating New Connection](../media/6-create-new-connection.png)

6. Select **Azure Data Lake Storage Gen1** from the connector gallery, and select **Continue**:

![Screenshot of Selecting Gen1](../media/6-create-gen1.png)

7. In the **Specify Azure Data Lake Storage Gen1 connection** page, do the following steps:
    - Select your Data Lake Storage Gen1 for the name and specify or validate the Tenant.
    - Click **Test connection** to validate the settings, then select **Finish**.
    - You will see a new connection gets created. Select **Next**.

![Screenshot of Creating New Linked Service](../media/6-create-new-linked-service.png)

8. In the **Choose the input file or folder** page, browse to the folder and file that you want to copy over. Select the folder/file, select **Choose**:

![Screenshot of Choosing input file or folder](../media/6-choose-file-or-folder.png)

9. Specify the copy behavior by checking the **Copy files recursively** and **Binary copy** options. Select **Next**:

![Screenshot of Two Copy Options](../media/6-two-copy-options.png)

10. In the **Destination data** store page, click **+ Create new connection**, and then select **Azure Data Lake Storage Gen2 (Preview)**, and select **Continue**:

![Screenshot of Selecting Destination](../media/6-select-destination.png)

11. In the **Specify Azure Data Lake Storage Gen2 connection** page, do the following steps:
    - Select your Data Lake Storage Gen2 capable account from the "Storage account name" drop-down list.
    - Select **Finish** to create the connection. Then select **Next**.

12. In the **Choose the output file or folder** page, enter **copyfromadlsgen1** as the output folder name, and select **Next**:

![Screenshot of Choosing Output folder Path](../media/6-choose-output-folder-path.png)
  - In the **Settings** page, select **Next** to use the default settings.
- In the **Summary** page, review the settings, and select **Next**:

![Screenshot of Summary Page](../media/6-summary-page.png)

13. In the **Deployment page**, select **Monitor** to monitor the pipeline:

![Screenshot of Deployment Page](../media/6-deployment-page.png)

14. You can monitor details like the volume of data copied from the source to the sink, data throughput, execution steps with the corresponding duration, and used configurations:

![Screenshot of Details Page](../media/6-details-page.png)

15. Verify that the data has been copied into your Data Lake Storage Gen2 account.