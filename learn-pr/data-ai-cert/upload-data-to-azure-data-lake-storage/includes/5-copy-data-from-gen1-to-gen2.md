Azure Data Factory is a cloud-based data integration service that creates workflows in the cloud. These workflows orchestrate batch data movement and transformations. Use Data Factory to create and schedule workflows (called _pipelines_) to ingest data from various data stores. The data can then be processed and transformed with services like these:

- Azure HDInsight
- Spark
- Azure Data Lake
- Azure Machine Learning

Data Factory can orchestrate many data tasks. In this exercise, you'll use it to copy data from Azure Data Lake Storage Gen1 to Data Lake Storage Gen2. 

> [!NOTE]
> If you don't have an Azure account, or prefer not to do this exercise in your account, just read through the exercise to understand how to use Data Factory to copy data into a data lake.

## Create a data factory

The first step is to provision a data factory in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) using the same subscription as you used in the previous exercise.

1. On the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Integration**, and under *Popular services*, select **Data Factory**. The **Create Data Factory** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting      | Value  |
    | ------------ |  ------- |
    | **Project details** |
    | Subscription | Subscription in which the Azure Data Factory instance is created. |
    | Resource group|  Resource group where the Azure Data Factory instance will reside. |
    | **Instance details**|
    | Region | Datacenter location in which the Azure Data Factory instance is stored. |
    | Name | Name of the Azure Data Factory instance. |
    | Version | Select *V2* for the latest features. |

1. Select **Next : Git configuration**, and check the **Configure Git later** check box.

1. Select **Review + create**.

1. After validation passes, select **Create.**

1. After deployment completes, select **Go to resource**.

    Your **Data factory (V2)** pane appears.

![Screenshot of the new data factory.](../media/6-generated-data-factory.png)

> [!IMPORTANT]
> You will need a Data Lake Storage Gen1 account that contains data. If you don't have this, follow the steps in the next sections.

## Create a Data Lake Storage Gen1 account

1. Go to the Azure portal **Home** page, and under **Azure services**, select **Create a new resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Storage**, and under *Popular services*, select **Data Lake Storage Gen1**. The **New Data Lake Storage Gen1** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting      | Value  |
    | ------------ |  ------- |
    | **Project details** |
    | Subscription | Select your subscription. |
    | Resource group|  From the dropdown list, select *mslearn-datalake-test* |
    | Location | From the dropdown list, select a location. Typically, you'll want to select a region near where the data will be consumed. For this example, select a location near you. |
    | **Instance details**|
    | Name | Enter *dlsgen1XXX*, and replace *XXX* with numbers that you choose. A green check mark indicates that the name is unique. |

1. Select **Review + create**.

1. After validation passes, select **Create**.

1. After deployment completes, select **Go to resource**. Your Data Lake Storage Gen1 service appears.

## Create a sample text file

You'll need some sample data to work with, so create a text file on your local computer. Name the file **salesUK.txt**. Then paste the following text into the file:

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

You'll upload this data file in various ways. Keep in mind that this is a _simple_ example. Typically, you'll populate your data lake with much larger data samples from a variety of sources.

## Upload a file into a Data Lake Storage Gen1 account

1. On the Data Lake Storage Gen1 **Overview** pane, in the top menu bar, select **Data explorer**. The **Data explorer** pane appears.

1. In the top menu bar, select **Upload**. The **Upload files** pane appears.

1. In the **Select files to upload to** text box, select the browse icon, go to the folder, and select **salesUK.txt**.

1. Select **Add selected files**. You'll know the file is uploaded when the **Status** column displays **Completed**.

1. Close the **Upload files** pane.

## Set permissions for the Data Lake Storage Gen1 account

Set permissions to allow the data factory to access the data in your Data Lake Store Gen1 account.

1. In the Azure portal, search for your Data Lake Storage Gen1 service named **dlsgen1XXX**.

1. In the left menu pane, select **Access control (IAM)**. The **Access control (IAM)** pane appears for your Data Lake Storage Gen1 service.

1. In the top menu bar, select **Add** > **Add role assignment**. The **Add role assignment** pane appears.

1. In the **Add** text box, for the **Role**, select **Owner**.

1. Under **Select**, enter your data factory name.

1. Select **Save**.

1. Close the **Access control (IAM)** pane.

## Load data into the Data Lake Storage Gen2 account

1. In the Azure portal, go to your data factory. You'll see the **Data factory (V2)** home page.

1. Under **Getting started**, in the **Open Azure Data Factory Studio** box, select the **Open** link. This enables you to author and monitor your data pipelines and data flows.

    ![Screenshot showing the Data factory home page, where Open Azure Data Factory Studio is selected.](../media/6-generated-data-factory.png)

    The **Data factory** app appears for your data factory.

1. Select **Ingest** to open the Copy Data tool.

    ![Screenshot showing how to open the Ingest feature.](../media/6-copy-data.png)

    The **Copy Data tool** pane appears.

1. In the **Properties** section, under **Task type**, select **Built-in copy task**.

1. Under **Task cadence or task schedule**, select **Run once now**, and select **Next**.

    ![Screenshot showing the Properties pane of the Copy Data tool.](../media/6-copy-data-property.png)

    The **Source data store** pane appears.

1. Select **New connection**.

    ![Screenshot showing the Source data store pane, where New connection is selected.](../media/6-create-new-connection.png)

    The **New connection** pane appears.

1. In the connector gallery, select **Azure Data Lake Storage Gen1** > **Continue**.

    ![Screenshot showing selections in the connector gallery.](../media/6-create-gen1.png)

    The **New connection (Azure Data Lake Storage Gen1)** pane appears.

1. Enter the following values for each setting.

    | Setting      | Value  |
    | ------------ |  ------- |
    | **Data Lake Store selection method** |
    | From Azure subscription | *enabled* |
    | Azure subscription |  From the dropdown list, select your subscription. |
    | Data Lake Store account name | From the dropdown list, select your Data Lake account. |
    | Tenant | Specify or validate the tenant. |

1. To validate the settings, select **Test connection** > **Finish**.

    ![Screenshot showing how to create a linked service.](../media/6-create-new-linked-service.png)

1. When the test connection succeeds, select **Finish**. The **Source data store** pane appears.

1. Select **Next**.

1. On the **Choose the input file or folder** pane, go to the folder and file that you want to copy over. Select the folder or file, and then select **Choose**.

    ![Screenshot showing how to select the input file or folder.](../media/6-choose-file-or-folder.png)

1. Specify the copy behavior by selecting **Copy files recursively** and **Binary Copy**, and then select **Next**.

    ![Screenshot showing the two copy options on the Choose the input file or folder pane.](../media/6-two-copy-options.png)

    The **Target data store** pane appears.

1. Select **New connection**.

    The **New connection** pane appears.

1. In the connector gallery, select **Azure Data Lake Storage Gen2 (Preview)* > **Continue**.

    ![Screenshot showing how to select the destination.](../media/6-select-destination.png)

    The **New connection (Azure Data Lake Storage Gen2 (Preview))** pane appears.

1. Enter the following values for each setting.

    | Setting      | Value  |
    | ------------ |  ------- |
    | **Data Lake Store selection method** |
    | From Azure subscription | *enabled* |
    | Azure subscription |  From the dropdown list, select your subscription. |
    | Storage account name | From the dropdown list, select your Data Lake Storage Gen2 account. This will automatically populate the access key. |
    | Tenant | Specify or validate the tenant. |

1. To create the connection, select **Finish** > **Next**.

    The **Choose the output file or folder** pane appears.

1. Next to **Folder path**, enter *copyfromadlsgen1*, and then select **Next**.

    ![Screenshot showing where to enter the output folder path.](../media/6-choose-output-folder-path.png)

    The **Settings** pane appears.

1. Select **Next** to use the default settings.

    The **Summary** pane appears.

1. Review the settings, and select **Next**.

    ![Screenshot of the Summary pane.](../media/6-summary-page.png)

1. To monitor the pipeline, on the deployment pane, select **Monitor**.

    ![Screenshot of the deployment pane.](../media/6-deployment-page.png)

    You can monitor details like how much data is copied from the source to the sink, data throughput, execution steps and their duration, and configurations.

    ![Screenshot of the Details pane.](../media/6-details-page.png)

After the transfer is complete, you can use Azure Storage Explorer to verify that the data has been copied into your Data Lake Storage Gen2 account.
