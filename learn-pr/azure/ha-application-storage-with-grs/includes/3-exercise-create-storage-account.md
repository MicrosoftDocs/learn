As the solution architect for the health care system, you want to start preparing the foundations for your highly available healthcare application deployment.

In this exercise, you'll create an Azure storage account and configure the account for RA-GRS. By default the storage account is set to LRS when you create it. You'll change this mode to RA-GRS as you want the application to be highly available. The storage account will be used as a disaster recovery feature to ensure the application is always running.

As the first step you will create an Azure storage account. The storage account will be used to store the application data.

![Exercise scenario storage account visual](../media/3-storage-account-overview.png) 

## Create an Azure storage account

In this step, you'll create a new storage account. This storage account hosts the health care application.

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Run the following command in the Cloud Shell.

    ```bash
    STORAGEACCT=$(az storage account create \
            --resource-group <rgn>[Sandbox resource group]</rgn> \
            --name healthcareapp$RANDOM \
            --sku Standard_LRS \
            --output tsv \
            --query "name")
    ```

## Change the replication mode on the Azure storage account

The previous step set the storage account to support LRS. You'll need to change the replication policy to RA-GRS to enable the application to fail over to the secondary region in the event of an outage.

1. Run the following command in the Cloud Shell to amend the replication setting from **Standard_LRS** to **Standard_RAGRS**.

    ```azurecli
    az storage account update \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --name $STORAGEACCT \
      --sku Standard_RAGRS
    ```

    You can check the replication status by running the following command:

   ```azurecli
   az storage account show \
     --name $STORAGEACCT \
     --query "[statusOfPrimary, statusOfSecondary]"
   ```

## Retrieve the connection string for the storage account

1. Switch to the Cloud Shell window in the browser, and run the following command to obtain the connection string for the storage account you created in the previous exercise:

    ```azurecli
    az storage account show-connection-string \
        --name $STORAGEACCT \
        --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

1. Copy the output connection string and save it for reference later on in this module.

## Azure storage account failover

In this step you will use the Cloud Shell to view the replication status of your storage account. 

1. Run the following command in the Cloud Shell to view the status of the primary and secondary locations.

   ````azurecli
   az storage account show \
     --name $STORAGEACCT \
     --expand geoReplicationStats \
     --query "[primaryEndpoints, secondaryEndpoints, geoReplicationStats]"
   ````

   The output shows useful information relating to the primary endpoint, the secondary endpoint, and the last time data was synchronized across regions

   If the command returns the error *Last sync time is unavailable for account healthcareappnnnn*, then wait for a few minutes and repeat the command.
