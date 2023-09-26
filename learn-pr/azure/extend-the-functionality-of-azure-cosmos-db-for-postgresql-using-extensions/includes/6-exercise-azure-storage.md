In this exercise, you'll use the `pg_azure_storage` extension to ingest data from files securely stored in a private container in Azure Blob Storage.

> [!IMPORTANT]
> This exercise relies on the Azure Cosmos DB for PostgreSQL database and distributed tables you created in Unit 3.

## Create an Azure Blob Storage account

To complete this exercise, you must create an Azure Storage account, retrieve its access key, create a container, and copy Woodgrove Bank's historical data files into the container. In this task, you make the storage account.

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/).

2. Select **Create a resource**, **Storage**, and **Storage account**. You can also use the **Search** functionality to find the resource.

    :::image type="content" source="../media/create-resource-storage-account.png" alt-text="Screenshot of the Azure portal's create a resource screen, Storage and Storage account are highlighted.":::

3. On the **Basics** tab, enter the following information:

    | Parameter            | Value |
    | -------------------- | ----- |
    | **Project details**  |       |
    | Subscription         | Choose your Azure subscription.  |
    | Resource group       | Select the `learn-cosmosdb-postgresql` resource group you created in the previous exercise. |
    | **Instance details** |       |
    | Storage account name | _Enter a globally unique name_, such as `stlearnpostgresql`. |
    | Region               | Select the same region you chose for your Azure Cosmos DB for PostgreSQL database cluster. |
    | Performance          | Select **Standard**. |
    | Redundancy           | Select **Locally-redundant storage (LRS)**. |

    :::image type="content" source="../media/create-storage-account-basics-tab.png" alt-text="Screenshot of the Basics tab of the Create a storage account dialog. The fields are populated with the values specified in the exercise.":::

4. You'll use the default settings for the remaining tabs of the storage account configuration, so select the **Review** button.

5. Select the **Create** button on the **Review** tab to create the storage account.

## Create a blob storage container and upload data files

Woodgrove Bank has provided you with their historical data files in CSV format. Create a container named `historical-data` in the new storage account and then upload those files into it using the [Azure CLI](/cli/azure/).

1. Navigate to your new storage account in the [Azure portal](https://portal.azure.com/).

2. In the left-hand navigation menu, select **Containers** under **Data storage**, and then select **+ Container** on the toolbar.

    :::image type="content" source="../media/storage-account-add-container.png" alt-text="Screenshot of the Storage account page where Containers is selected and highlighted under Data storage in the left-hand navigation menu, and + Container is highlighted on the Containers page.":::

3. In the **New container** dialog, enter `historical-data` in the **Name** field, leave **Private (no anonymous access)** selected for the **Public access level** setting, and select **Create**.

    :::image type="content" source="../media/storage-account-new-container.png" alt-text="Screenshot of the New container dialog, with the name set to historical-data and the public access level set to private (no anonymous access).":::

    By setting the container's access level to **Private (no anonymous access)**, you're preventing public access to the container and its contents. Below, you'll provide the `pg_azure_storage` extension with the account name and access key, allowing it to access the files securely.

4. You'll need the name and key associated with your storage account to upload the data files using the Azure CLI. In the left-hand navigation menu, select **Access keys** under **Security + networking**.

    :::image type="content" source="../media/storage-account-access-keys.png" alt-text="Screenshot of Access Keys, which is selected and highlighted in the left-hand menu of the Storage account page.":::

5. With the **Access keys** page open, select the **Cloud Shell** icon in the Azure portal toolbar to open a new Cloud Shell pane at the bottom of your browser window.

    :::image type="content" source="../media/portal-cloud-shell.png" alt-text="Screenshot of the Cloud Shell icon in the Azure portal toolbar and a Cloud Shell window is open at the bottom of the browser window.":::

6. At the Azure Cloud Shell prompt, execute the following `curl` commands to download the files provided by Woodgrove Bank.

    ```bash
    curl -O https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/users.csv
    curl -O https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/events.csv
    ```

    The files will be added to the Cloud Shell storage account.

7. Next, you'll use the [Azure CLI](/cli/azure/) to upload the files into the `historical-data` container you created in your storage account. Start by creating variables to hold your storage account name and key values to make things easier.

    Copy your storage account name by selecting the **Copy to clipboard** button next to the storage account name on the Access keys page above your Cloud Shell:

    :::image type="content" source="../media/storage-account-name.png" alt-text="Screenshot of the Copy to clipboard button and the ACCOUNT_NAME variable declaration line in the Cloud Shell.":::

    Now, execute the following command to create a variable for your storage account name, replacing the `{your_storage_account_name}` token with your storage account name:

    ```bash
    ACCOUNT_NAME={your_storage_account_name}
    ```

    Next, select the **Show** button next to the **Key** for **key1** and then select the **Copy to clipboard** button next to the key's value.

    :::image type="content" source="../media/storage-account-key.png" alt-text="Screenshot of the Copy to clipboard button next to the key1 Key value, and the ACCOUNT_KEY variable declaration line is highlighted in the Cloud Shell.":::

    Then, run the following command, replacing the `{your_storage_account_key}` token with the key value you copied:

    ```bash
    ACCOUNT_KEY={your_storage_account_key}
    ```

8. To upload the files, you'll use the [`az storage blob upload`](/cli/azure/storage/blob#az-storage-blob-upload) command from the Azure CLI. Run the following commands to upload the files to your storage account's `historical-data` container:

    ```bash
    az storage blob upload --account-name $ACCOUNT_NAME --account-key $ACCOUNT_KEY --container-name historical-data --file users.csv --name users.csv --overwrite

    az storage blob upload --account-name $ACCOUNT_NAME --account-key $ACCOUNT_KEY --container-name historical-data --file events.csv --name events.csv --overwrite
    ```

    In this exercise, you're working with a few files. You'll most likely work with many more files in real-world scenarios. In those circumstances, you can review different methods for [migrating files to an Azure Storage account](/azure/storage/common/storage-use-azcopy-migrate-on-premises-data) and select the technique that will work best for your situation.

9. To verify the files uploaded successfully, you can navigate to the **Containers** page of your storage account by selecting **Containers** from the left-hand navigation menu. Select the `historical-data` container from the list of containers and observe the container now contains files named `events.csv` and `users.csv`.

    :::image type="content" source="../media/storage-account-container-blobs.png" alt-text="Screenshot of the events.csv and users.csv blobs highlighted in the list of files in the historical-data container.":::

## Connect to the database using psql in the Azure Cloud Shell

With the files now securely stored in blob storage, it's time to set up the `pg_azure_storage` extension in your database. You'll use the `psql` command line utility from the Azure Cloud Shell to accomplish this task.

1. Using the same browser tab where the Cloud Shell is open, navigate to your Azure Cosmos DB for PostgreSQL resource in the [Azure portal](https://portal.azure.com/).

2. From the database's left-hand navigation menu, select **Connection strings** under **Settings** and copy the connection string labeled **psql**.

    :::image type="content" source="../media/cosmos-db-postgresql-connection-strings-psql.png" alt-text="Screenshot of the Connection strings page of the Azure Cosmos DB Cluster resource. On the Connection strings page, the copy to clipboard button to the right of the psql connection string is highlighted.":::

3. Paste the connection string into a text editor such as Notepad and replace the `{your_password}` token with the password you assigned to the `citus` user when creating your cluster. Copy the updated connection string for use below.

4. In your open Cloud Shell pane, ensure **Bash** is selected for the environment, then use the psql command-line utility to connect to your database. Paste your updated connection string (the one containing your correct password) at the prompt in the Cloud Shell, and then run the command, which should look similar to the following command:

    ```bash
    psql "host=c.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus user=citus password=P@ssword.123! sslmode=require"
    ```

## Install the pg_azure_storage extension

Now that you're connected to your database, you can install the `pg_azure_storage` extension.

1. From the Cloud Shell Citus prompt, run the following SQL command to load the extension into your database:

    ```sql
    SELECT create_extension('azure_storage');
    ```

    The extension's name is abbreviated to `azure_storage` when creating and working with the extension in your database.

## Grant access to a blob storage account

The next step is to grant access to your storage account after installing the `pg_azure_storage` extension. Recall that the `historical-data` container was created with an access level of **Private (no anonymous access)**, so you must provide the name and key associated with your storage account to grant the extension to access files in the container.

1. Using the same browser tab where the Cloud Shell is open, navigate to your storage account resource in the [Azure portal](https://portal.azure.com/).

2. In the left-hand navigation menu, select **Access keys** under **Security + networking**.

    :::image type="content" source="../media/storage-account-access-keys.png" alt-text="Screenshot of Access keys, which is selected and highlighted in the left-hand menu of the Storage account page.":::

3. Execute the query below to give the `pg_azure_storage` extension access to your storage account, replacing the `{storage_account_name}` and `{storage_account_key}` tokens with your values, which you can copy from the **Access keys** page of your storage account.

    ```sql
    SELECT azure_storage.account_add('{storage_account_name}', '{storage_account_key}');
    ```

4. If you wish to view the list of accounts that have been added to your database, you can use the `account_list()` function as follows:

    ```sql
    SELECT azure_storage.account_list();
    ```

    This query will provide the following output:

    ```output
          account_list      
    ------------------------
    (stlearnpostgresql,{})
    ```

    Note that you can remove accounts from the database using the `account_remove('ACCOUNT_NAME')` function; but don't do there here, because you need the account connected for the remainder of the exercise.

## List files in a blob storage container

Now that you're securely connected to the storage account, you can use the `blob_list()` function to produce a list of the blobs within a named container.

1. To view the files in the `historical-data` container, run the following query:

    ```sql
    SELECT path, content_type, pg_size_pretty(bytes)
    FROM azure_storage.blob_list('stlearnpostgresql', 'historical-data');
    ```

2. The `blob_list()` function outputs all of the blobs within the container you specified:

    ```output
        path    | content_type | pg_size_pretty 
    ------------+--------------+----------------
    events.csv | text/csv     | 17 MB
    users.csv  | text/csv     | 29 MB
    ```

## Inspect the users.csv file

Before attempting to ingest data from any file, you must understand the structure of data within the file. The simplest way to understand the structure is to preview the file in the Azure portal, but this feature is limited to files smaller than 2.1 MB. The output from the `blob_list()` function reveals that both of the files Woodgrove Bank provided you with are larger than the limit. To review the files, you'll need to download and open them locally.

1. In the [Azure portal](https://portal.azure.com/), navigate to your Storage account resource, select **Storage browser** from the left-hand navigation menu, and then select **Blob containers** on the Storage browser page.

    :::image type="content" source="../media/storage-browser-blob-containers.png" alt-text="Screnshot of the Storage browser menu item highlighted on the Storage account page. On the Storage browser window, Blob containers are highlighted in the navigation tree.":::

2. From the list of containers, select **historical-data**.

3. Select the ellipsis (...) button to the right of the `users.csv` file and select **Download** from the context menu.

    :::image type="content" source="../media/storage-browser-users-download.png" alt-text="Screenshot of the users.csv file in the historical-data container, and the ellipsis button is highlighted. In the context menu for the file, Download is highlighted.":::

4. After the download completes, open the file using Microsoft Excel (or another text editor that can open CSV files) and observe the structure of the data contained within the file, which resembles the following example of the first 10 rows of the `users.csv` file.

    | `user_id` | `url` | `login` | `avatar_url` |
    | --- | --- | --- | --- |
    | `21` | `https://api.woodgrove.com/users/technoweenie` | `technoweenie` | `https://avatars.woodgroveusercontent.com/u/21?` |
    | `22` | `https://api.woodgrove.com/users/macournoyer` | `macournoyer` | `https://avatars.woodgroveusercontent.com/u/22?` |
    | `38` | `https://api.woodgrove.com/users/atmos` | `atmos` | `https://avatars.woodgroveusercontent.com/u/38?` |
    | `45` | `https://api.woodgrove.com/users/mojodna` | `mojodna` | `https://avatars.woodgroveusercontent.com/u/45?` |
    | `69` | `https://api.woodgrove.com/users/rsanheim` | `rsanheim` | `https://avatars.woodgroveusercontent.com/u/69?` |
    | `78` | `https://api.woodgrove.com/users/indirect` | `indirect` | `https://avatars.woodgroveusercontent.com/u/78?` |
    | `81` | `https://api.woodgrove.com/users/engineyard` | `engineyard` | `https://avatars.woodgroveusercontent.com/u/81?` |
    | `82` | `https://api.woodgrove.com/users/jsierles` | `jsierles` | `https://avatars.woodgroveusercontent.com/u/82?` |
    | `85` | `https://api.woodgrove.com/users/brixen` | `brixen` | `https://avatars.woodgroveusercontent.com/u/85?` |
    | `87` | `https://api.woodgrove.com/users/tmornini` | `tmornini` | `https://avatars.woodgroveusercontent.com/u/87?` |

    Notice the file contains four columns. The first column contains integer values, and the remaining columns contain text. It's also crucial to note that the file doesn't include a header row. This information will change how you set up the `COPY` command to ingest the file's data into your database.

    You created the `payment_users` table in Unit 3. As a reminder, the structure of that table is as follows:

    ```sql
    /*
    -- Table structure and distribution details provided for reference
    CREATE TABLE payment_users
    (
        user_id bigint PRIMARY KEY,
        url text,
        login text,
        avatar_url text
    );

    SELECT created_distributed_table('payment_users', 'user_id');
    */
    ```

    Based on the observed structure of the `users.csv` file, the data appears to align with what's expected, and you should be able to load the `payment_users` table without issue.

## Extract data from files in blob storage

Now that you understand the data contained in the file, you can fulfill Woodgrove Bank's request to bulk load their historical data from files in an Azure Blob Storage account. The `pg_azure_storage` extension provides bulk load capabilities by extending the native PostgreSQL `COPY` command to make it capable of handling Azure Blob Storage resource URLs. This feature is enabled by default, and you can manage it using the `azure_storage.enable_copy_command` setting.

1. Using the extended `COPY` command, run the following command to ingest data from the `users.csv` into the `payment_users` table, making sure to replace the `{STORAGE_ACCOUNT_NAME}` token with the unique name of the storage account you created above.

    ```sql
    -- Bulk load data from the user.csv file in Blob Storage into the payment_users table
    copy payment_users FROM 'https://{STORAGE_ACCOUNT_NAME}.blob.core.windows.net/historical-data/users.csv';
    ```

    The output from the `COPY` command will specify the number of rows copied into the table. You should see the result for the `users.csv` file: `COPY 264197`.

    Suppose the `users.csv` file contained a header row. To handle that using the `COPY` command and the `pg_azure_storage` extension, you need to specify the `WITH (header)` option following the resource URL. For example, `copy payment_users FROM 'https://{STORAGE_ACCOUNT_NAME}.blob.core.windows.net/historical-data/users.csv' WITH (header);`.

2. Next, run a `COUNT` query on the `payment_users` table to verify the number of records copied into the table:

    ```sql
    SELECT COUNT(*) FROM payment_users;
    ```

    You should see the following results, which match the result from the `COPY` command:

    ```output
     count  
    --------
    264197
    ```

    Congratulations! You've successfully extended your Azure Cosmos DB for PostgreSQL database and used the `pg_azure_storage` extension to ingest file data from a secure container in Azure Blob Storage into a distributed table.

3. In the Cloud Shell, run the following command to disconnect from your database:

    ```sql
    \q
    ```

## Clean up

It's crucial that you clean up any unused resources. You're charged for the configured capacity, not how much the database is used. Use the following procedure to delete your resource group along with the resources you created for this module.

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/).

1. In the left-hand navigation menu, select **Resource Groups**, and then select the resource group you created as part of the exercise in Unit 4.

1. In the **Overview** pane, select **Delete resource group**.

1. Enter the name of the resource group you created to confirm and then select **Delete**.

1. Select **Delete** again to confirm deletion.
