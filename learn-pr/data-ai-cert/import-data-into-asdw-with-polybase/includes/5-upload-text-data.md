PolyBase can read data from several file formats and data sources. Before uploading your data into Azure SQL Data Warehouse, you must prepare the source data into an acceptable format for Polybase. These include:

- Comma-delimited text files (UTF-8 and UTF-16).
- Hadoop file formats including RC files, Optimized Row Columnar (ORC) files, and Parquet files.
- Gzip and Snappy compressed files.

If the data is coming from a relational database such as Microsoft SQL Server, you'll need to pull the data and then load it into an acceptable data store such as an Azure Blob storage account. Tools such as SQL Server Integration Services can ease this transfer process.

Let's take some sample data and upload it to our Blob storage container.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in uploading a text file to Azure Blob storage.

## Obtain the source data

Our data processing department has exported the data we need into a comma-delimited file. Let's import that data into the Blob container we created earlier.

Start by downloading the [sample data file](https://raw.githubusercontent.com/MicrosoftDocs/mslearn-implement-azure-sql-data-warehouse/master/import-data-into-asdw-with-polybase/DimDate2.txt) file onto your local computer. The file contains time and data information with details about each entry.

The text file is named `DimDate2.txt` and has 1188 rows/lines of data. Each line of data is separated into 12-column values using commas. Here's a sample of the data file:

```text
2011-01-01 00:00:00.000,20110102,1,Jan,Q1,2011,2011-Q1,2011-Jan,2011-01,1,Sun,2
2011-01-02 00:00:00.000,20110103,1,Jan,Q1,2011,2011-Q1,2011-Jan,2011-01,2,Mon,3
2011-01-03 00:00:00.000,20110104,1,Jan,Q1,2011,2011-Q1,2011-Jan,2011-01,3,Tue,4
2011-01-04 00:00:00.000,20110105,1,Jan,Q1,2011,2011-Q1,2011-Jan,2011-01,4,Wed,5
...
```

## Import data into Blob storage

Let's upload it into the blob container.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true) with the Azure account you created the storage account in.

1. Click **All resources** and in the _Search_ box type **demodwstorage**. Select your storage account from the results.

1. Select **Blobs** from the **Blob service** section in the storage account.

    ![Screenshot showing blob container in the Azure portal](../media/5-select-blob-container.png)

1. Click on the container named **data-files** to open it.

1. Click the **Upload** icon. In the Upload blob blade on the right, browse and select the **DimDate2.txt** file you downloaded.

    ![Screenshot of Uploading Data File](../media/5-upload-data-file.png)

1. Once it's uploaded, you can close the upload blade and you should see the file in your blob container.

> [!TIP]
> While this example uses a single text file to upload data, it's a best practice to split up the data between data files of equal size that match the number of compute nodes in your Data Warehouse. That way you gain full parallelism of all the text files against each available compute node. For example, if you use a **Gen1 - DWU6000** or **Gen2 - DW30000c** configuration, you can import 60 text files in parallel as there are 60 nodes.