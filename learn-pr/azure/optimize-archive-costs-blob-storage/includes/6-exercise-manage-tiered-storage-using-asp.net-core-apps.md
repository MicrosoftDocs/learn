You're now going to test out some sample .NET code to retrieve and modify tier levels for some example Azure Storage blobs. You'll create a new BlobStorage account and set the account to Cool. Then, you'll upload some data and use the app to modify the storage tiers.

## Download the code and sample data

In this first step, you'll download source code and sample data to your Cloud Shell storage.

1. Run the following commands in the Cloud Shell to download source code and sample data to the `storageapp` folder in your Cloud Shell storage:

   ```azurecli
   git clone https://github.com/MicrosoftDocs/mslearn-optimize-blob-storage-costs storageapp
   cd storageapp
   ```

## Use the CLI to create a new blob storage account

You'll now create a new BlobStorage account and retrieve the account storage key.

1. Run the following commands in the Cloud Shell to create a new BlobStorage account set to Cool. Replace `<random string>` in the following code with a string of letters or numbers:

   ```azurecli
   export RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
   
   export AZURE_STORAGE_ACCOUNT=<random string>storageaccount
   
   az storage account create \
       --resource-group $RESOURCE_GROUP \
       --name $AZURE_STORAGE_ACCOUNT \
       --kind BlobStorage \
       --access-tier Cool
   ```

1. Run the following command in the Cloud Shell to retrieve the storage key for the account and store it in a variable:

   ```bash
   export AZURE_STORAGE_KEY=`az storage account keys list -g $RESOURCE_GROUP -n $AZURE_STORAGE_ACCOUNT --query [0].value --output tsv`
   ```

## Create container and upload data

In this step, you'll create a blob container and three blobs, each containing some sample data.

1. Run the following command in the Cloud Shell to create a new container:

   ```azurecli
   az storage container create \
       --name blobcontainer \
       --account-name $AZURE_STORAGE_ACCOUNT \
       --account-key $AZURE_STORAGE_KEY
   ```

1. Run the following commands in the Cloud Shell to blobs with sample data:

   ```azurecli
   cd ManageStorageTiers
   az storage blob upload --file testdata.txt --container-name blobcontainer --name blob1
   az storage blob upload --file testdata.txt --container-name blobcontainer --name blob2
   az storage blob upload --file testdata.txt --container-name blobcontainer --name blob3
   ```

## Set the tier for each blob

In this step, you'll set the access tier for each blob.

1. Run the following command in the Cloud Shell to set blob1 as Archive:

   ```azurecli
   az storage blob set-tier \
       --container-name blobcontainer \
       --name blob1 \
       --tier Archive
   ```

1. Run the following command in the Cloud Shell to set blob2 as Cool:

   ```azurecli
   az storage blob set-tier \
       --container-name blobcontainer \
       --name blob2 \
       --tier Cool
   ```

1. Run the following command in the Cloud Shell to set blob3 as Hot:

   ```azurecli
   az storage blob set-tier \
       --container-name blobcontainer \
       --name blob3 \
       --tier Hot
   ```

## Manage storage tiers in code

You're now ready to deploy and test out some code. First, you'll set the environment variables the sample app requires. You'll then build and run the sample app (ignore the warnings about the Microsoft.Azure.KeyVault.Core package).

1. Run the following commands in the Cloud Shell to store the environment variables the app uses:

   ```bash
   export STORAGE_CONNECTION_STRING=`az storage account show-connection-string -g $RESOURCE_GROUP -n $AZURE_STORAGE_ACCOUNT --output tsv`
   export CONTAINER_NAME=blobcontainer
   ```

1. Run the following command in the Cloud Shell to build and run the **ManageStorageTiers** app:

   ```azurecli
   cd ManageStorageTiers
   dotnet build
   dotnet run
   ```

1. The ManageStorageTiers app now connects to your blob storage and queries the three blobs named blob1, blob2, and blob3. It then changes the storage tier of all three blobs, and queries each blob's storage tier again to verify the change. The Archive tier won't have changed, due to rehydration latency.

## Review the app code

In this final step, you'll take a look at the code used by the ManageStorageTiers app to manage and change access tiers.

1. In the Cloud Shell, enter `code .`, then use the editor to open ManageStorageTiers\Program.cs.

1. This code displays the storage tiers for all of the blobs in a container:

   ```csharp
   private static async Task DisplayBlobTiers(BlobContainerClient blobContainerClient)
   {
       AsyncPageable<BlobItem> blobItems = blobContainerClient.GetBlobsAsync();

       await foreach (var blobItem in blobItems)
       {
           Console.WriteLine($"  Blob name {blobItem.Name}:   Tier {blobItem.Properties.AccessTier}");
       }
   }
   ```

1. The following methods work together to update the storage tier for a set of blobs in a container:

   ```csharp
   private static async Task UpdateBlobTiers(BlobContainerClient blobContainerClient)
   {
       AsyncPageable<BlobItem> blobItems = blobContainerClient.GetBlobsAsync();

       await foreach (var blobItem in blobItems)
       {
           string blobName = blobItem.Name;
           AccessTier? currentAccessTier = blobItem.Properties.AccessTier;
           AccessTier newAccessTier = GetNewAccessTier(currentAccessTier);

           Console.WriteLine($"  Blob name: {blobItem.Name}   Current tier: {currentAccessTier}   New tier: {newAccessTier}");

           BlobClient blobClient = blobContainerClient.GetBlobClient(blobItem.Name);
           blobClient.SetAccessTier(newAccessTier);
       }
   }

   private static AccessTier GetNewAccessTier(AccessTier? accessTier)
   {
       if (accessTier == AccessTier.Hot)
           return AccessTier.Cool;
       else if (accessTier == AccessTier.Cool)
           return AccessTier.Archive;
       else
           return AccessTier.Hot;
   }
   ```
