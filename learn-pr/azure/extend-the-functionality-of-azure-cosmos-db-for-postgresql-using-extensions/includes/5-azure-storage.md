Woodgrove Bank has decided to use Azure Blob Storage to store its historical data files in the cloud securely. They requested the ability to bulk load their historical data from CSV files stored in a private container in their storage account.

Microsoft developed the `pg_azure_storage` extension to allow working with data stored in files hosted in [Azure Blob Storage](https://azure.microsoft.com/services/storage/blobs/#overview). Using the extension, you can operate on files in a blob storage account directly from an Azure Cosmos DB for PostgreSQL database. The extension allows you to:

- Securely connect to an Azure Blob Storage account directly from your database.
- Fetch data from publicly shared Blob Storage resources.
- List files in Blob Storage container.
- Retrieve data from files.
- Import CSV file data directly into a table using the COPY PostgreSQL command.

## Migrate files to a storage account

Files need to be added or [migrated to an Azure Storage account](/azure/storage/common/storage-use-azcopy-migrate-on-premises-data) before you can take advantage of this extension's features. Moving files into Azure Blob Storage allows you to use a cloud-native, secure storage service.

## Load the pg_azure_storage extension

To get started, you need to load the extension using either `CREATE EXTENSION` or the `create_extension()` function:

```sql
-- Install the extension in the database
SELECT create_extension('azure_storage');
```

The `pg_` is dropped from the extension's name when creating and working with the extension in your database, abbreviating it to simply `azure_storage`.

## Grant access to a blob storage account

An Azure Cloud engineer at Woodgrove Bank created a storage account named `stlearnpostgresql` for you to use and added a few sample files into a private container named `historical-data`. The `pg_azure_storage` extension includes the `account_add()` method to enable connecting a storage account to your database. Adding an account allows access to the files within secure or private containers. To connect to a private container, you must provide the storage account name and access key, the syntax of which follows:

```sql
SELECT azure_storage.account_add('{STORAGE_ACCOUNT_NAME}', '{STORAGE_ACCOUNT_ACCESS_KEY}');
```

To provide access to Woodgrove Bank's storage account from the database, you need to retrieve its name and access key. You can get this information from the **Access keys** page associated with the storage account in the Azure portal.

:::image type="content" source="../media/storage-account-access-keys.png" alt-text="Screenshot of the access keys option highlighted in the left-hand menu of the Storage account page.":::

Provide the storage account name when running the following query and the access key will grant the `pg_azure_storage` extension access to the account:

```sql
SELECT azure_storage.account_add('stlearnpostgresql', '4zzZGx4sUk8TBVnHnoPYt0G7A3w9/DJJBCfdxeeb+VDrR8P3bSwWA3lYsTvO1HwYzrt4XQ37iIEL+AStWuQ/uA==');
```

Providing an access key is only required when working with data in containers with a "Private (no anonymous access)" access level. Suppose you wish to pull data from a container whose access level is set to "Container (anonymous read access for containers and blobs)." In that case, you can ingest files from Azure Blob Storage using their public URLs and enumerate container contents without configuring the account key in the `pg_azure_storage` extension.

## List files in blob storage

Now that you're connected to the storage account, you can perform multiple actions against the storage account, including listing the blobs in a named container. To get a better idea of what sample files were uploaded to the `historical-data` container, you can run the following query:

```sql
SELECT path, content_type, pg_size_pretty(bytes)
FROM azure_storage.blob_list('stlearnpostgresql', 'historical-data');
```

The `blob_list()` function takes the storage account and container names as input, and it outputs a list of blobs in the container:

```output
    path    | content_type | pg_size_pretty 
------------+--------------+----------------
 events.csv | text/csv     | 17 MB
 users.csv  | text/csv     | 29 MB
```

In addition to each file's path, content type, and size (in bytes), you can also view the last modified date, content encoding, and content hash using the `blob_list()` function.

## Bulk load data from blobs

Woodgrove has expressed the desire to have the historical data stored in CSV files in their Azure Blob Storage account. The data then should be loaded directly into distributed tables in the Azure Cosmos DB for PostgreSQL database. To bulk load data from files in blob storage, `pg_azure_storage` extends the native PostgreSQL `COPY` command to make it capable of handling Azure Blob Storage resource URLs. This feature is enabled by default, and you can manage it using the `pg_azure_storage.enable_copy_command` setting.

By using the `COPY` command, you can run the following to ingest user data into the `payment_users` table:

```sql
-- Bulk load data from the user.csv file in Blob Storage into the payment_users table
COPY payment_users FROM 'https://stlearnpostgresql.blob.core.windows.net/historical-data/users.csv';
```

A crucial difference to note when running the `COPY` command with `pg_azure_storage` is that you can't have a `\` before `COPY`, and you must end the line with a semicolon. This requirement is because the `COPY` command runs on the coordinator node when using the `pg_azure_storage` extension. The `\COPY` version is used when running the command in the `psql` client.

The output from the `COPY` command will specify the number of rows copied into the table, such as `COPY 264197`.
