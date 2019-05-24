As the solution architect for EasyHealthCare, you now want to start preparing the foundations for your highly available application deployment.  

In this unit, you'll create an Azure storage account and configure the account for RA-GRS.  By default the storage account will be set to LRS mode when created, so you will change this mode to RA-GRS as you want the application to be highly available.  The storage account will be used as a  disaster recovery feature to ensure the application is always running.

As the first step you will create an Azure storage account.  The storage account will be used to store the application data.

![Exercise scenario storage account visual](../media/3-storage-account-overview.png) 

## Create an Azure storage account

In this step, you'll create a new storage account. This storage account will be used to host the company application.

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Run the following command in the Cloud Shel, to create a storage account for the EasyHealthCare application.

    ```bash
    STORAGEACCT=$(az storage account create \
            --resource-group <rgn>[Sandbox resource group]</rgn> \
            --name easyhealthcareapp$RANDOM \
            --sku Standard_LRS \
            --query "name" | tr -d '"')
    ```

## Change the replication mode on the Azure storage account

In this step you'll specify the replication policy on the storage account as RA-GRS.  This configuration enables the application to fail over to the secondary region in the event of an outage.

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

## Azure storage account failover

In this step you will use the Cloud Shell to view the replication status of your storage account.  

> [!IMPORTANT]
> Manual failover of an Azure storage account is not possible in majority of the Azure regions, this is currently controlled by Microsoft.  
However, a new feature has been made available in WestUS2 and CentralUS regions, where you can manually failover the storage account using the command line `az storage account failover --name "storgeaccountname"`.

1. Run the following command in the Cloud Shell to view the status of the primary and secondary locations.

   ````azurecli
   az storage account show \
     --name $STORAGEACCT \
     --expand geoReplicationStats \
     --query "[primaryEndpoints, secondaryEndpoints, geoReplicationStats]"
   ````

   The output shows useful information relating to the primary endpoint, the secondary endpoint, and the last time data was synchronized across regions

   If the command returns the error *Last sync time is unavailable for account easyhealthcareappnnnn*, then wait for a minute and repeat the command.
