When you're bulk loading data, it has to come from somewhere. In Azure, it's common to store or dump data into Azure Blob storage because it's optimized for storing massive amounts of unstructured data at a relatively low cost.

In this scenario, Adventure Works Cycles is receiving store return data based on store identification number. This data is stored in .dat files, which are then pushed into Azure Blob storage. After the data is in Blob storage, Azure SQL needs a way to access it. You can do that by creating an external data source that has access to the storage account. You can control access to that storage account through Azure Active Directory, shared key authorization, or a shared access signature (SAS).

In this exercise, you'll explore one scenario for bulk loading data from Azure Blob storage by using T-SQL and shared access signatures into Azure SQL Database.

There are two options for completing this exercise:

- `sqlcmd` in Azure Cloud Shell
- SQL notebooks in Azure Data Studio

Both exercises contain the same commands and content, so you can choose the option that you prefer.

## Option 1: `sqlcmd` in Azure Cloud Shell

`sqlcmd` is a command-line tool that allows you to interact with SQL Server and Azure SQL by using the command line. In this exercise, you'll use `sqlcmd` in the PowerShell instance of Azure Cloud Shell. `sqlcmd` is installed by default, so it's easy to use from Azure Cloud Shell.

1. Because of the way Azure Cloud Shell for Bash is configured, you first need to change the terminal mode by running the following command in [Azure Cloud Shell](https://shell.azure.com).

    ```bash
    TERM=dumb
    ```

1. Run the following command in the integrated terminal after modifying your server name and password.

    ```bash
    sqlcmd -S <server name>.database.windows.net -P <password> -U cloudadmin -d AdventureWorks
    ```

1. You need to create a table and schema for data to be loaded into. This process is straightforward T-SQL. Run the following script in the terminal, now that you're connected to your database:

    ```sql
    IF SCHEMA_ID('DataLoad') IS NULL
    EXEC ('CREATE SCHEMA DataLoad')
    CREATE TABLE DataLoad.store_returns
    (
        sr_returned_date_sk             bigint,
        sr_return_time_sk               bigint,
        sr_item_sk                      bigint           ,
        sr_customer_sk                  bigint,
        sr_cdemo_sk                     bigint,
        sr_hdemo_sk                     bigint,
        sr_addr_sk                      bigint,
        sr_store_sk                     bigint,
        sr_reason_sk                    bigint,
        sr_ticket_number                bigint           ,
        sr_return_quantity              integer,
        sr_return_amt                   float,
        sr_return_tax                   float,
        sr_return_amt_inc_tax           float,
        sr_fee                          float,
        sr_return_ship_cost             float,
        sr_refunded_cash                float,
        sr_reversed_charge              float,
        sr_store_credit                 float,
        sr_net_loss                     float
    );
    GO
    ```

    > [!TIP]
    > You'll see a number entry after the T-SQL statements, representing each line of the T-SQL entry. For example, the preceding command will end with `26`. Be sure to select `ENTER` after this. You'll know the command has finished when you see `1>` again, which indicates that `sqlcmd` is ready for the first line of your next T-SQL entry.

1. Next, create a master key:

    ```sql
    CREATE MASTER KEY 
    ENCRYPTION BY PASSWORD='MyComplexPassword00!';
    GO
    ```

1. A master key is required to create a `DATABASE SCOPED CREDENTIAL` value because Blob storage isn't configured to allow public (anonymous) access. The credential refers to the Blob storage account, and the data portion specifies the container for the store return data.

    We use a shared access signature as the identity that Azure SQL knows how to interpret. The secret is the SAS token that you can generate from the Blob storage account. In this example, the SAS token for a storage account that you don't have access to is provided so you can access only the store return data.

    ```sql
    CREATE DATABASE SCOPED CREDENTIAL [https://azuresqlworkshopsa.blob.core.windows.net/data/]
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'st=2020-09-28T22%3A05%3A27Z&se=2030-09-29T22%3A05%3A00Z&sp=rl&sv=2018-03-28&sr=c&sig=52WbuSIJCWyjS6IW6W0ILfIpqh4wLMXmOlifPyOetZI%3D';
    GO
    ```

1. Create an external data source to the container:

    ```sql
    CREATE EXTERNAL DATA SOURCE dataset
    WITH
    (
        TYPE = BLOB_STORAGE,
        LOCATION = 'https://azuresqlworkshopsa.blob.core.windows.net/data',
        CREDENTIAL = [https://azuresqlworkshopsa.blob.core.windows.net/data/]
    );
    GO
    ```

1. You're finally ready to bulk insert one of the store return files. Run the following script, and while it finishes, review the comments:

    ```sql
    SET NOCOUNT ON -- Reduce network traffic by stopping the message that shows the number of rows affected
    BULK INSERT DataLoad.store_returns -- Table you created in step 3
    FROM 'dataset/store_returns/store_returns_1.dat' -- Within the container, the location of the file
    WITH (
    DATA_SOURCE = 'dataset' -- Using the external data source from step 6
    ,DATAFILETYPE = 'char'
    ,FIELDTERMINATOR = '\|'
    ,ROWTERMINATOR = '\|\n'
    ,BATCHSIZE=100000 -- Reduce network traffic by inserting in batches
    , TABLOCK -- Minimize number of log records for the insert operation
    );
    GO
    ```

1. Check how many rows were inserted into the table:

    ```sql
    SELECT COUNT(*) FROM DataLoad.store_returns;
    GO
    ```

    If everything ran correctly, you should see `2807797` returned.

You've now seen a simple example of how to insert data from Blob storage into Azure SQL Database. If you want to run through the exercise again, run the following code to reset what you've done:

```sql
DROP EXTERNAL DATA SOURCE dataset;
DROP DATABASE SCOPED CREDENTIAL [https://azuresqlworkshopsa.blob.core.windows.net/data/];
DROP TABLE DataLoad.store_returns;
DROP MASTER KEY;
GO
```

## Option 2: SQL notebooks in Azure Data Studio

For this activity, you'll use the notebook called LoadData.ipynb. You can find it in `\mslearn-azure-sql-fundamentals\02-DeployAndConfigure\loaddata` on your device. Open this file in Azure Data Studio to complete this exercise, then return here.  

If you can't complete the exercise for any reason, you can review the results in the [corresponding notebook file on GitHub](https://github.com/MicrosoftDocs/mslearn-azure-sql-fundamentals/blob/master/02-DeployAndConfigure/loaddata/LoadData.ipynb?azure-portal=true).
