When you're bulk loading data, it has to come from somewhere. In Azure, it's common to store or dump data into an Azure Blob storage because it is optimized for storing massive amounts of unstructured data at a relatively low cost.

In this scenario, AdventureWorks is receiving store return data based on store identification number (for example, 1, 2, etc.). This return data is being stored in .dat files, which are then pushed into Azure Blob storage. Once the data is in blob storage, Azure SQL needs a way to access it. You can do that by creating an external data source that has access to the Azure Storage account. You can control access to that storage account through Azure Active Directory, Shared Key authorization, or with a Shared access signature (SAS).

In this exercise, you'll explore one scenario for bulk loading data from Azure Blob storage using T-SQL and Shared Access Signatures (SAS) into Azure SQL Database.

There are two options for completing this exercise:

- `sqlcmd` in the Azure Cloud Shell (follow along this page)
- SQL Notebooks in Azure Data Studio

Both exercises contain the same commands and content, so you can choose the option you prefer.

### Option 1: `sqlcmd` in the Azure Cloud Shell

`sqlcmd` is a command-line utility, which allows you to interact with SQL Server and Azure SQL using the command-line. In this exercise, you'll use `sqlcmd` in the PowerShell instance of the Azure Cloud Shell. `sqlcmd` is installed by default, so it is easy to use from the Azure Cloud Shell.

1. Due to the way the Azure Cloud Shell for bash is configured, you first need to change the terminal mode by running the following command in the integrated terminal (right-hand side of this browser).

    ```powershell
    TERM=dumb
    ```

1. Run the following command in the integrated terminal after modifying your server name and password.

    ```powershell
    sqlcmd -S <server name>.database.windows.net -P <password> -U cloudadmin -d AdventureWorks
    ```

1. First, you need to create a table and schema for our data to be loaded into. This is pretty straightforward, good old-fashioned T-SQL. Run the following script in the terminal, now that you're connected to your database.

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
    > You'll see a number entry after the T-SQL statements representing each line of the T-SQL entry. For example, the above command will end with `26`. Be sure to select `ENTER` after this. You'll know the command has completed when you see the `1>` again (indicating `sqlcmd` is ready for the first line of your next T-SQL entry).

1. Next, you must create a `MASTER KEY`.

    ```sql
    CREATE MASTER KEY 
    ENCRYPTION BY PASSWORD='MyComplexPassword00!';
    GO
    ```

1. A `MASTER KEY` is required to create a `DATABASE SCOPED CREDENTIAL` since the blob storage is not configured to allow public (anonymous) access. The credential refers to the Azure blob storage account and the data portion specifies the container where the store return data is located.

    We use a SHARED ACCESS SIGNATURE as the identity which SQL knows how to interpret, and the secret provided is the SAS token that you can generate from the Azure blob storage account. In this example, the SAS token for a storage account you do not have access to is provided so you can access only the store return data.

    ```sql
    CREATE DATABASE SCOPED CREDENTIAL [https://azuresqlworkshopsa.blob.core.windows.net/data/]
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sv=2019-02-02&ss=bfqt&srt=sco&sp=rcp&se=2025-01-23T00:09:52Z&st=2020-01-22T16:09:52Z&spr=https&sig=Ro98PLwsmMqBsH9T1UUAzqxM3KJJLKFLshRlnfLYnBI%3D';
    GO
    ```

1. Next, you can create an external data source to the container

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

1. You're finally ready to bulk insert one of the store return files. Run the following script, and while it completes, review the comments.

    ```sql
    SET NOCOUNT ON -- Reduce network traffic by stopping the message that shows the number of rows affected
    BULK INSERT DataLoad.store_returns -- Table you created in Step 3
    FROM 'dataset/store_returns/store_returns_1.dat' -- Within the container, the location of the file
    WITH (
    DATA_SOURCE = 'dataset' -- Using the External data source from Step 6
    ,DATAFILETYPE = 'char'
    ,FIELDTERMINATOR = '\|'
    ,ROWTERMINATOR = '\|\n'
    ,BATCHSIZE=100000 -- Reduce network traffic by inserting in batches
    , TABLOCK -- Minimize number of log records for the insert operation
    );
    GO
    ```

1. Finally, you can check how many rows were inserted into the table.

    ```sql
    SELECT COUNT(*) FROM DataLoad.store_returns;
    GO
    ```

    If everything ran correctly, you should see `2807797` returned.

You've now seen a simple example of how to insert data from blob storage into Azure SQL Database. If you want to run through the exercise again, run the following code to reset what you've done.

```sql
DROP EXTERNAL DATA SOURCE dataset;
DROP DATABASE SCOPED CREDENTIAL [https://azuresqlworkshopsa.blob.core.windows.net/data/];
DROP TABLE DataLoad.store_returns;
DROP MASTER KEY;
GO
```

### Option 2: SQL Notebooks in Azure Data Studio

For this activity, you'll use the notebook called **LoadData.ipynb** which located in `\mslearn-azure-sql-fundamentals\02-DeployAndConfigure\loaddata` on your device. Open this file in Azure Data Studio to complete this exercise, and then return here.  

If you are unable to complete the exercise for any reason, you can review the results in the [corresponding notebook file on GitHub](https://github.com/MicrosoftDocs/mslearn-azure-sql-fundamentals/blob/master/02-DeployAndConfigure/loaddata/LoadData.ipynb?azure-portal=true).
