The Azure CLI includes a series of commands that you can use to interact with Azure storage. Run CLI commands to upload and download files between the local file system, and transfer data between blobs in Azure Blob storage.

In this unit, you'll learn how to use the Azure CLI to move data to and from Azure Blob storage, and migrate move data between blob storage accounts.

## Create blobs and upload data

Run the `az storage blob` series of commands in the Azure CLI to manage and move blobs in Azure storage.

Before you upload blob data to Azure storage, you must create an Azure storage account and a container for holding your blobs. Run the `az storage account create` command from the Azure CLI to create a storage account. The following example creates a low-latency (hot) storage account named *myAccount*. The storage uses the *Standard* performance tier with read-access geo-redundant storage.

```azurecli
az storage account create \
  --location ukwest \
  --name myAccount \
  --resource-group myGroup \
  --sku Standard_RAGRS \
  --kind BlobStorage \
  --access-tier Hot
```

Blobs are held in containers in Azure storage. Run the `az storage container create` command to add a container to a storage account. Provide the account key and the account name.

```azurecli
az storage container create \
  --name myContainer \
  --account-name myAccount \
  --account-key <storage account key>
```

> [!NOTE]
> You can retrieve the keys for a storage account by running the `az storage keys list` command.
>
> ```azurecli
> az storage account keys list --account-name myAccount --resource-group myGroup --output table
> ```

### Upload data to blob storage

You can upload a single file to blob storage with the `az storage blob upload` command. This command creates a blob for the contents of the file. Specify the details of the account and container, together with the file and the name of the blob to be created.

> [!NOTE]
> The `az storage` commands require an account name and key to authenticate you against the storage account. You can specify these values as the `account-name` and `account-key` parameters to many `az storage` commands, but if you are running a series of operations, a more convenient mechanism is to store this information in the `AZURE_STORAGE_ACCOUNT` and `AZURE_STORAGE_KEY` environment variables. The `az storage` commands looks for these variables if you don't provide the `account-name` and `account-key` parameters.

The following example uploads the data in the file named *blobdata.dat* to a blob called *myBlob* in the *myContainer* container. Depending on the type and size of data, you can also specify the `--type` parameter to indicate whether the blob should be a block blob or a page blob. The default for most types of data is *block*.

```azurecli
az storage blob upload \
  --container-name myContainer \
  --name myBlob\
  --file blobdata.dat
```

If a blob with the given name already exists in the container, it will be overwritten. Use the `--if-match` parameter with an ETag to specify that the blob should only be overwritten with the new data if its ETag matches the value given. The `--if-none-match` parameter overwrites the blob if none of the ETags supplied in the command match that of the blob. Other options are `--if-modified-since` which overwrites the blob only if it has been modified since a specified date, and `--if-unmodified-since`, which makes sure that the blob hasn't changed since the date given. The following example uploads a file to blob storage, and overwrites an existing blob with the same name only if the blob hasn't changed since the date and time specified.

```azurecli
az storage blob upload \
  --container-name myContainer \
  --name myBlob \
  --file blobdata.dat \
  --if-unmodified-since 2019-05-26T10:30Z
```

If you have a collection of files, run the `az storage blob upload-batch` command to upload them. The following example shows how running this command uploads all files with the *.bmp* file extension in the *myFolder* folder to blobs with the same names.

```azurecli
az storage blob upload-batch \
  --destination myContainer \
  --source myFolder \
  --pattern *.bmp
```

Verify that the blobs have been uploaded successfully by running the `az storage blob list` command. The following command lists all the blobs in *myContainer*, and outputs the results in tabular format for ease of viewing.

```azurecli
az storage blob list \
  --container-name myContainer \
  --output table
```

### Move blobs between Azure storage accounts

Run the `az storage blob copy start` command to move a blob from one storage account to another. This time, you must specify the source and destination storage accounts and containers for the operation. The destination account and container must already exist. Specify the source blob using its URL with the `--source-uri` parameter, rather than specifying a source account, source key, source container, and source blob. The blob is transferred directly between storage accounts; it isn't downloaded from the source account, and then uploaded to the destination.

```azurecli
az storage blob copy start \
  --destination-container destContainer \
  --destination-blob myBlob \
  --source-account-name mySourceAccount \
  --source-account-key mySourceAccountKey \
  --source-container myContainer \
  --source-blob myBlob
```

Blobs can be large (several gigabytes in size), and the two storage accounts might be remote from each other. Therefore, this command runs asynchronously. Check the state of the destination blob and verify whether the copy operation has completed by running the `az storage blob show` command.

```azurecli
az storage blob show \
  --container-name destContainer \
  --name myBlob
```

As with uploading a blob, the `az storage blob copy` command can overwrite an existing blob with the same name in the destination container. You can provide ETags with the `--destination-if-match` and `--destination-if-none-match` parameters to only overwrite the destination of the ETag matches (or not). Also, this command has the `--destination-if-modified-since` and `--destination-if-unmodified-since` parameters, which will only overwrite the destination blob if it has or hasn't changed since a specified date and time. There are similar parameters for validating the source blob (`--source-if-match`, `--source-if-none-match`,  `--source-if-modified-since`, and `--source-if-unmodified-since`). Use these parameters to conditionally copy a blob only if it hasn't changed recently. They're useful if you're migrating older blobs to cool storage from hot storage.

If you're moving a collection of blobs, run the `az storage blob copy start-batch` command. This command copies blobs from a source storage account and container to a destination storage account and container, but keeps the names of the blobs the same in both containers. Specify a pattern for matching the names of the source blobs, but the ETag and date condition options aren't available with this command. The following example copies all blobs with names that match the pattern *\*.dat* from one storage account to another. You can also include the `--dryrun` parameter, which causes the command to display the names of the blobs to be copied, but doesn't actually copy them.

```azurecli
az storage blob copy start-batch \
  --destination-container destContainer \
  --source-account-name mySourceAccount \
  --source-account-key mySourceAccountKey \
  --source-container myContainer \
  --pattern *.dat
```

This command runs asynchronously. Run the `az storage blob list` command on the destination container to determine how the operation is progressing. You can cancel a transfer that is in progress by running the `az storage blob copy cancel` command. This command stops the transfer, but leaves a destination blob of zero size in place. Delete this empty blob if you no longer need it.

### Remove blobs from Azure storage

The commands in the previous section copy blobs from a source container to a destination, leaving the source blobs intact. After you've copied a blob to a destination, you can remove it from the source container. Do this by running the `az storage blob delete` command.

```azurecli
az storage blob delete \
  --container sourceContainer \
  --name sourceBlob
```

Specify the `--if-modified-since`, `--if-unmodified-since`, `--if-match`, and `--if-none-match` parameters to perform the delete operation depending on the last modification date of the blob and its ETag.

If you have multiple blobs to remove, run the `az storage blob delete-batch` command. For example, to delete blobs that haven't been modified in the last six months, run the following commands.

```bash
date=`date -d "6 months ago" '+%Y-%m-%dT%H:%MZ'`
az storage blob delete-batch \
  --source sourceContainer \
  --if-unmodified-since $date
```
