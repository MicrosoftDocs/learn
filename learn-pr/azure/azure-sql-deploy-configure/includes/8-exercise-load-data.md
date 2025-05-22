When you're bulk loading data, it has to come from somewhere. In Azure, it's common to store or dump data into Azure Blob Storage. Blob Storage is optimized for storing massive amounts of unstructured data at a relatively low cost.

In this scenario, Adventure Works Cycles is receiving store return data based on store identification number. This data is stored in *.dat* files, which are then pushed into Azure Blob storage. After the data is in Blob storage, Azure SQL needs a way to access it. You can do that by creating an external data source that has access to the storage account. You can control access to that storage account through Microsoft Entra ID, shared key authorization, or a shared access signature (SAS).

In this exercise, we explore one scenario for bulk loading data from Azure Blob storage into Azure SQL Database by using T-SQL in sqlcmd. 

## Load data into Azure SQL Database using `sqlcmd`

`sqlcmd` is a command-line tool that allows you to interact with SQL Server and Azure SQL by using the command line. In this exercise, you use `sqlcmd` in the PowerShell instance of Azure Cloud Shell. `sqlcmd` is installed by default, so it's easy to use from Azure Cloud Shell.

1. Because of the way Azure Cloud Shell for Bash is configured, you first need to change the terminal mode by running the following command in [Azure Cloud Shell](https://shell.azure.com).

    ```bash
    TERM=dumb
    ```

1. Run the following command in the integrated terminal after modifying your server name and password.

    ```bash
    sqlcmd -S <server name>.database.windows.net -P <password> -U cloudadmin -d AdventureWorks
    ```

1. Create a table and schema for data to be loaded into. This process is straightforward T-SQL. Run the following script in the terminal, now that you're connected to your database:

    ```sql
    DROP TABLE IF EXISTS holiday
    CREATE TABLE [dbo].[holiday](
          [countryOrRegion] [varchar](255) NULL,
          [holidayName] [varchar](255) NULL,
          [normalizeHolidayName] [varchar](255) NULL,
          [isPaidTimeOff] [varchar](255) NULL,
          [countryRegionCode] [varchar](255) NULL,
          [date] varchar(255) NULL
    ) ON [PRIMARY];
    ```

    > [!TIP]
    > You see a number entry after the T-SQL statements. It represents each line of the T-SQL entry. For example, the preceding command ends with `26`. Be sure to select **ENTER** after these lines.
    >
    > You know that the command has finished when you see `1>` again, which indicates that `sqlcmd` is ready for the first line of your next T-SQL entry.

1. Create an external data source to the container:

    ```sql
    DROP EXTERNAL DATA SOURCE holiday_dataset;
    
    CREATE EXTERNAL DATA SOURCE holiday_dataset
    WITH
    (   TYPE = BLOB_STORAGE,
        LOCATION = 'https://fabrictutorialdata.blob.core.windows.net/sampledata/Fabric/Holiday'
    );    
    ```

1. Bulk insert one of the store return files. Run the following script, and while it finishes, review the comments:

    ```sql
    SET NOCOUNT ON -- Reduce network traffic by stopping the message that shows the number of rows affected
    BULK INSERT holiday -- Table you created previously
    FROM 'Holiday.csv' -- Within the container, the location of the file
    WITH (DATA_SOURCE = 'holiday_dataset' -- Using the external data source from step 6
          , FORMAT = 'CSV'
          , FIRSTROW = 2
          , FIELDTERMINATOR = ','
          , ROWTERMINATOR = '0x0a'
          , CODEPAGE = '65001'
        ,BATCHSIZE=100000 -- Reduce network traffic by inserting in batches
        , TABLOCK -- Minimize number of log records for the insert operation
    );
    ```

1. Check how many rows were inserted into the table:

    ```sql
    SELECT COUNT(*) FROM holiday;
    GO
    ```

    If everything ran correctly, you should see `274` returned.

This code is a simple example of how to insert data from Blob storage into Azure SQL Database. If you want to run through the exercise again, run the following code to reset what you've done:

```sql
DROP EXTERNAL DATA SOURCE holiday_dataset
DROP TABLE holiday
GO
```

