As a DBA within AdventureWorks, you need to back up a database to a URL in Azure and restore it after a human error has
occurred.

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Configure Backup to URL

1.	Open a Cloud Shell prompt by selecting the icon shown below in the upper right corner.

    :::image type="content" source="../media/cloud-shell.png" alt-text="Cloud Shell":::

1.	At the bottom half of the portal, you may see a message welcoming you to Azure Cloud Shell, if you have not yet used Cloud Shell. Select **Bash**.

    :::image type="content" source="../media/welcome-to-cloud-shell.png" alt-text="Welcome to Azure Cloud Shell":::

1.	If you have not previously used Cloud Shell, you must give it storage. Click **Create Storage** in the dialog below:

    :::image type="content" source="../media/create-storage.png" alt-text="Create storage":::

1.	If you have already used Cloud Shell, just make sure the upper level corner of the Cloud shell screen show **Bash**. You can use the drop down arrow to select either PowerShell or Bash. 

    Once complete, you will see a prompt similar to the one below.

    :::image type="content" source="../media/cloud-shell-prompt.png" alt-text="Cloud Shell prompt":::

1.	Create a storage account from the CLI using by executing the following command in cloud shell. Your storage account name must be unique and all lower case with no special characters. You should change dp300storage in the example to a unique name such as **dp300storagemsl123**. The value **DP-300-HADR** is the name of a Resource Group.:

    ```bash
    az storage account create -n dp300storage -g DP-300-HADR --kind StorageV2 -l eastus2
    ```

    Next you will get the account keys for your account, which you will use in subsequent steps. Execute the following code in cloud shell using the unique name of your storage account:

    ```bash
    az storage account keys list -g DP-300-HADR -n dp300storage
    ```

    Your account key will be in the results of the above command. Make sure you use the same name (after the **-n**) and resource group (after the **-g**) that you used in the previous command. Copy the returned value for **key1** (without the double quotes) as shown here:

    :::image type="content" source="../media/storage-account-keys.png" alt-text="Key1":::

1.	Backing up a database in SQL Server to a URL uses a storage account and a container within it. You will create a container specifically for backup storage in this step. To do this, execute:

    ```bash
    az storage container create --name "backups" --account-name "dp300storage" --account-key "storage_key" --fail-on-exist
    ```

    where **dp300storage** is the storage account name used when creating the storage account and **storage_key** is the key generated above. The output should return **true**.

1.	To further verify the container backups has been created, execute:

    ```bash
    az storage container list --account-name “dp300storage" --account-key "storage_key"
    ```

    where **dp300storage** is the storage account name used you created and storage_key is the key you generated above. The output should return something similar to below:

    :::image type="content" source="../media/storage-list.png" alt-text="Container list":::

1.	A shared access signature (SAS) at the container level is required for security. This can be done via Cloud Shell or PowerShell. Execute the following:

    ```bash
    az storage container generate-sas -n "backups" --account-name "dp300storage" --account-key "storage_key" --permissions "rwdl" --expiry "date_in_the_future" -o tsv
    ```

    where **dp300storage** is the storage account name you created above, **storage_key** is the key generated above, and **date_in_the_future** is a time later than now. **date_in_the_future** must be in UTC. An example is **2020-12-31T00:00Z** which translates to expiring at Dec 31, 2020 at midnight.

    The output should return something similar to below. Copy the shared access signature and paste it in **Notepad**, because it will be used in the next task:

    :::image type="content" source="../media/storage-key.png" alt-text="Shared access signature":::

## Task 2: Back Up WideWorldImporters

Now that the functionality is configured, you can generate a backup file as a blob in Azure.
1. Start **SQL Server Management Studio (SSMS).**
1. You will be prompted to connect to  SQL Server. Ensure that **Windows Authentication** is selected, and click **Connect**.
1.	Click **New Query**.
1.	Create the credential that will be used to access storage in the cloud with the following Transact-SQL. Fill in the appropriate values:

    ```tsql
    IF NOT EXISTS  
    (SELECT * FROM sys.credentials   
    WHERE name = 'https://dp300storage.blob.core.windows.net/backups')  
    BEGIN
    CREATE CREDENTIAL [https://dp300storage.blob.core.windows.net/backups]
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sas_token'
    END;
    GO  
    ```

    where both instances of **dp300storage** are the storage account name created in **Task 1** and **sas_token** is the value generated at the end of the previous task.
1.	Click **Execute**. This should be successful.
1.	Back up the database WideWorldImporters to Azure with the following command in Transact-SQL:

    ```tsql
    BACKUP DATABASE WideWorldImporters   
    TO URL = 'https://dp300storage.blob.core.windows.net/backups/WideWorldImporters.bak';
    GO 
    ```

    where **dp300storage** is the storage account name used in **Task 1**.

    If something is configured incorrectly, you will see an error message similar to the following:

    :::image type="content" source="../media/backup-error.png" alt-text="Backup error":::

    If an error occurs, check that you did not mistype anything and that everything was created successfully.
1.	To see that the file is actually in Azure, you can use Storage Explorer or Azure Cloud Shell. The Azure Cloud Shell syntax in Bash is:

    ```bash
    az storage blob list -c "backups" --account-name "dp300storage" --account-key "storage_key"
    ```

    where **dp300storage** is the storage account name used in **Task 1** and **storage_key** is the key used there as well.

## Task 3: Restore WideWorldImporters
This task will show you how to restore a database.

1.	In a query window, execute the following query:

    ```tsql
    USE WideWorldImporters;
    GO
    ```

1.	Now execute the statement below to return the very first row of the Customers table which has a CustomerID of 1. Note the name of the customer:

    ```tsql
    SELECT TOP 1 * FROM Sales.Customers;
    GO
    ```

1.	Run this command to change the name of that customer.

    ```tsql
    UPDATE Sales.Customers
    SET CustomerName = 'This is a human error'
    WHERE CustomerID = 1;
    GO
    ```

1.	Re-run **Step 2** to verify that the name has been changed. Now imagine if someone had changed thousands or millions of rows without a WHERE clause – or the wrong WHERE clause.
1.	To restore the database to get it back to where it was before the change you made in **Step 3**, execute the following. (First, make sure there are no connections to the WideWorldImporters database.)

    ```tsql
    USE master;
    GO
    
    RESTORE DATABASE WideWorldImporters 
    FROM URL = 'https://dp300storage.blob.core.windows.net/backups/WideWorldImporters.bak';
    GO
    ```

    where **sp300storage** is the storage account name used in **Task 1**.

    The output should be similar to this:

    :::image type="content" source="../media/restore-database.png" alt-text="Restore database":::
1.	Re-run **Step 2** to verify that the data has been restored.

You have now seen that you can back up a database to a URL in Azure and, if necessary, restore it.
