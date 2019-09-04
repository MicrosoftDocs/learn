As the solution architect for the health care system, you want to start preparing the foundations for your highly available healthcare application deployment.

In this exercise, you'll create an Azure storage account and configure the account for RA-GRS. By default the storage account is set to LRS when you create it. You'll change this mode to RA-GRS as you want the application to be highly available. The storage account will be used as a disaster recovery feature to ensure the application is always running.

As the first step you'll create an Azure storage account. The storage account will be used to store the application data.

![A diagram that shows the exercise scenario storage account configuration](../media/3-storage-account-overview.png)

## Create an Azure storage account

In this step, you'll create a new storage account. This storage account hosts the health care application.

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Run the following commands in the Cloud Shell.

    ```bash
    STORAGEACCT=$(az storage account create \
            --resource-group <rgn>[Sandbox resource group]</rgn> \
            --name healthcareapp$RANDOM \
            --sku Standard_RAGRS \
            --output tsv \
            --query "name")
  
    echo $STORAGEACCT
    ```

    Make a note of the value of the **\$STORAGEACCT** variable, in case you need to recreate it in a later exercise.

    This step sets the replication policy of the storage account to RA-GRS to enable the application to fail over to the secondary region if there's an outage.

1. Verify the replication status by running the following command:

    ```bash
        az storage account show \
            --name $STORAGEACCT \
            --query "[statusOfPrimary, statusOfSecondary]"
    ```

   The status of the primary and secondary sites should both be listed as *available*.

## Retrieve the connection string for the storage account

1. Switch to the Cloud Shell window in the browser, and run the following command to obtain the connection string for the storage account you created in the previous exercise:

    ```bash
        az storage account show-connection-string \
            --name $STORAGEACCT \
            --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

1. Copy the output connection string and save it for reference later on in this module.

## Azure storage account failover

In this step, you'll use the Cloud Shell to view the replication status of your storage account.

1. Run the following command in the Cloud Shell to view the status of the primary and secondary locations.

    ```bash
        az storage account show \
            --name $STORAGEACCT \
            --expand geoReplicationStats \
            --query "[primaryEndpoints, secondaryEndpoints, geoReplicationStats]"
    ```

   The output shows useful information relating to the primary endpoint, the secondary endpoint, and the last time data was synchronized across regions

   If the command returns the error *Last sync time is unavailable for account healthcareappnnnn*, then wait for a few minutes and repeat the command.
