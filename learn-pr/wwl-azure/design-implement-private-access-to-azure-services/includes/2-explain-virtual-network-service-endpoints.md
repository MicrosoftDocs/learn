Use virtual network Service Endpoints to extend your private address space in Azure by providing a direct connection to your Azure services. Service Endpoints let you secure your Azure resources to only your virtual network. Service traffic will remain on the Azure backbone and doesn't go out to the internet.

:::image type="content" source="../media/service-endpoint-e15a99ae.png" alt-text="image showing web server, database server, and service endpoint within a v-net. A link is shown to from the service endpoint to Azure storage outside the v-net.":::


By default, Azure services are all designed for direct internet access. All Azure resources have public IP addresses, including PaaS services, such as Azure SQL Database and Azure Storage. Because these services are exposed to the internet, anyone can potentially access your Azure services.

Service Endpoints can connect certain PaaS services directly to your private address space in Azure, so they act like they’re on the same virtual network. Use your private address space to access the PaaS services directly. Adding Service Endpoints doesn't remove the public endpoint. It simply provides a redirection of traffic.

Azure Service Endpoints are available for many services, such as:

 -  Azure Storage
 -  Azure SQL Database
 -  Azure Cosmos DB
 -  Azure Key Vault
 -  Azure Service Bus
 -  Azure Data Lake

For a service like SQL Database, which can't be accessed until you add IP addresses to its firewall, Service Endpoints should still be considered. Using a Service Endpoint for SQL Database restricts access to specific virtual networks, providing greater isolation and reducing the attack surface.

## What is a Service Endpoint?

In your company, you may need connect Azure to external systems or services. This is done with a bundle of secure Azure DevOps properties known as Service Endpoints.

Service Endpoints include (but are not limited to) the following properties:

 -  Service name
 -  Description
 -  Server URL
 -  Certificates or tokens
 -  Usernames and passwords

Once configured, extensions use the Service Endpoint to manage stored details and necessary operations on that service.

How is Azure Private endpoint different from a service endpoint?

Private Endpoints grant network access to specific resources behind a given service providing granular segmentation. Traffic can reach the service resource from on premises without using public endpoints.

A service endpoint remains a publicly routable IP address. A private endpoint is a private IP in the address space of the virtual network where the private endpoint is configured.

## Preparing to Implement Service Endpoints

To enable a Service Endpoint, you must do the following two things:

 -  Turn off public access to the service.
 -  Add the Service Endpoint to a virtual network.

When you enable a Service Endpoint, you restrict the flow of traffic, and enable your Azure VMs to access the service directly from your private address space. Devices cannot access the service from a public network. On a deployed VM vNIC, if you look at Effective routes, you'll notice the Service Endpoint as the Next Hop Type.

This is an example route table, before enabling a Service Endpoint:

| **SOURCE** | **STATE** | **ADDRESS PREFIXES** | **NEXT HOP TYPE** |
|:----------:|:---------:|:--------------------:|:-----------------:|
|  Default   |  Active   |     10.1.1.0/24      |       VNet        |
|  Default   |  Active   |      0.0.0.0./0      |     Internet      |
|  Default   |  Active   |      10.0.0.0/8      |       None        |
|  Default   |  Active   |     100.64.0.0./     |       None        |
|  Default   |  Active   |    192.168.0.0/16    |       None        |

And here's an example route table after you've added two Service Endpoints to the virtual network:

| **SOURCE** | **STATE** |  **ADDRESS PREFIXES**   |       **NEXT HOP TYPE**       |
|:----------:|:---------:|:-----------------------:|:-----------------------------:|
|  Default   |  Active   |       10.1.1.0/24       |             VNet              |
|  Default   |  Active   |       0.0.0.0./0        |           Internet            |
|  Default   |  Active   |       10.0.0.0/8        |             None              |
|  Default   |  Active   |      100.64.0.0./       |             None              |
|  Default   |  Active   |     192.168.0.0/16      |             None              |
|  Default   |  Active   | 20.38.106.0/23, 10 more | VirtualNetworkServiceEndpoint |
|  Default   |  Active   |  20.150.2.0/23, 9 more  | VirtualNetworkServiceEndpoint |

All traffic for the service now is routed to the Virtual Network Service Endpoint and remains internal to Azure.

## Create Service Endpoints

As the network engineer, you're planning to move sensitive engineering diagram files into Azure Storage. The files must only be accessible from computers inside the corporate network. You want to create a virtual network Service Endpoint for Azure Storage to secure the connectivity to your storage accounts.

You'll create a Service Endpoint and use network rules to restrict access to Azure Storage. You'll create a virtual network Service Endpoint for Azure Storage on the Databases subnet. You'll then verify that your DataServer VM can access Azure Storage. Lastly, you'll check that the AppServer VM, which is on a different subnet, can't access storage.

:::image type="content" source="../media/exercise-task-723aea52.png" alt-text="Diagram showing data server accessing Azure storage with service endpoint" lightbox="../media/exercise-task-723aea52.png":::

**Add rules to the network security group**

Ensure that communications with Azure Storage pass through the Service Endpoint. Add outbound rules to allow access to the Storage service but deny all other internet traffic.

 -  To create an outbound rule to allow access to Storage, in the Cloud Shell, run the following command using Azure CLI.
    
    ```AzureCLI
    az network nsg rule create \
    
     --resource-group $rg \
    
     --nsg-name ERP-SERVERS-NSG \
    
     --name Allow_Storage \
    
     --priority 190 \
    
     --direction Outbound \
    
     --source-address-prefixes "VirtualNetwork" \
    
     --source-port-ranges '*' \
    
     --destination-address-prefixes "Storage" \
    
     --destination-port-ranges '*' \
    
     --access Allow \
    
     --protocol '*' \
    
     --description "Allow access to Azure Storage"
    
    ```
 -  To create an outbound rule to deny all internet access, in the Cloud Shell, run the following command using Azure CLI.
    
    ```AzureCLI
     az network nsg rule create \
    
     --resource-group $rg \
    
     --nsg-name ERP-SERVERS-NSG \
    
     --name Deny_Internet \
    
     --priority 200 \
    
     --direction Outbound \
    
     --source-address-prefixes "VirtualNetwork" \
    
     --source-port-ranges '*' \
    
     --destination-address-prefixes "Internet" \
    
     --destination-port-ranges '*' \
    
     --access Deny \
    
     --protocol '*' \
    
     --description "Deny access to Internet."
    
    ```

You should now have the following rules in ERP-SERVERS-NSG:

| **Rule name**  | **Direction** | **Priority** |               **Purpose**               |
|:--------------:|:-------------:|:------------:|:---------------------------------------:|
|  AllowSSHRule  |    Inbound    |     100      |            Allow inbound SSH            |
|    httpRule    |    Inbound    |     150      | Deny from DataServer to AppServer on 80 |
| Allow\_Storage |   Outbound    |     190      |      Allow access to Azure Storage      |
| Deny\_Internet |   Outbound    |     200      |    Deny access to Internet from VNet    |

At this point, both AppServer and DataServer have access to the Azure Storage service.

**Configure storage account and file share**

In this step, you'll create a new storage account, and then add an Azure file share to this account. This share is where you'll store your engineering diagrams.

 -  To create a storage account for engineering documents, in the Cloud Shell, run the following command.
    
    ```AzureCLI
     STORAGEACCT=$(az storage account create \
    
     --resource-group $rg \
    
     --name engineeringdocs$RANDOM \
    
     --sku Standard_LRS \
    
     --query "name" | tr -d '"')
    
    ```
 -  To store the primary key for your storage in a variable, in the Cloud Shell, run the following command.
    
    ```AzureCLI
     STORAGEKEY=$(az storage account keys list \
    
     --resource-group $rg \
    
     --account-name $STORAGEACCT \
    
     --query "[0].value" | tr -d '"')
    
    ```
 -  To create an Azure file share called erp-data-share, in the Cloud Shell, run the following command.
    
    ```AzureCLI
       az storage share create \
    
     --account-name $STORAGEACCT \
    
     --account-key $STORAGEKEY \
    
     --name "erp-data-share"
    
    ```

**Enable the Service Endpoint**

You now need to configure the storage account to be accessible only from database servers, by assigning the storage endpoint to the Databases subnet. You then add a security rule to the storage account.

 -  To assign the Microsoft.Storage endpoint to the subnet, in the Cloud Shell, run the following command.
    
    ```AzureCLI
      az network vnet subnet update \
    
     --vnet-name ERP-servers \
    
     --resource-group $rg \
    
     --name Databases \
    
     --service-endpoints Microsoft.Storage
    
    ```
 -  To deny all access to change the default action to Deny, in the Cloud Shell, run the following command. After network access is denied, the storage account is not accessible from any network.
    
    ```AzureCLI
       az storage account update \
      
      --name $storageAcctName \
  
      --resource-group myResourceGroup \
  
      --default-action Deny
    
    ```
 -  To restrict access to the storage account, in the Cloud Shell, run the following command. By default, storage accounts are open to accept all traffic. You want only traffic from the **Databases** subnet to be able to access the storage.
    
    ```AzureCLI
       az storage account network-rule add \
    
     --resource-group $rg \
    
     --account-name $STORAGEACCT \
    
     --vnet-name ERP-servers \
    
     --subnet Databases
    
    ```

**Test access to storage resources**

In this step, you'll connect to both of your servers, and verify that only DataServer has access to the Azure file share on the storage account.

 -  To save the public IP addresses of **AppServer** and **DataServer** to variables, in the Cloud Shell, run the following command.
    
    ```AzureCLI
       APPSERVERIP="$(az vm list-ip-addresses \
    
     --resource-group $rg \
    
     --name AppServer \
    
     --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    
     --output tsv)"
    
    DATASERVERIP="$(az vm list-ip-addresses \
    
     --resource-group $rg \
    
     --name DataServer \
    
     --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
    
     --output tsv)"
    
    ```
 -  To connect to your **AppServer** VM, and attempt to mount the Azure file share, in the Cloud Shell, run the following command.
    
    ```AzureCLI
      ssh -t Azureuser@$APPSERVERIP \
    
     "mkdir Azureshare; \
    
     sudo mount -t cifs //$STORAGEACCT.file.core.windows.net/erp-data-share Azureshare \
    
     -o vers=3.0,username=$STORAGEACCT,password=$STORAGEKEY,dir_mode=0777,file_mode=0777,sec=ntlmssp; findmnt \
    
     -t cifs; exit; bash"
    
    ```
 -  Enter the password you used when you created the VM.
 -  The response should include a mount error message. This connection isn't allowed, because there is no Service Endpoint for the storage account on the **Applications** subnet.
 -  To connect to your DataServer VM, and attempt to mount the Azure file share, in the Cloud Shell, run the following command.
    
    ```AzureCLI
      ssh -t Azureuser@$DATASERVERIP \
    
     "mkdir Azureshare; \
    
     sudo mount -t cifs //$STORAGEACCT.file.core.windows.net/erp-data-share Azureshare \
    
     -o vers=3.0,username=$STORAGEACCT,password=$STORAGEKEY,dir_mode=0777,file_mode=0777,sec=ntlmssp;findmnt \
    
     -t cifs; exit; bash"
    
    ```
 -  Enter the password you used when you created the VM.
 -  The mount should be successful, and the response should include details of the mount point. This is allowed because you created the Service Endpoint for the storage account on the **Databases** subnet.

By using the storage Service Endpoint on the **Databases** subnet, you've now verified that **DataServer** can access storage. You've also verified that **AppServer** can't access storage. This is because this server is on a different subnet and doesn't have access to the virtual network Service Endpoint.

## Configure service tags

A service tag represents a group of IP address prefixes from a given Azure service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change, minimizing the complexity of frequent updates to network security rules.

You can use service tags to define network access controls on network security groups or Azure Firewall. Use service tags in place of specific IP addresses when you create security rules. By specifying the service tag name, such as API Management, in the appropriate source or destination field of a rule, you can allow or deny the traffic for the corresponding service.

As of March 2021, you can also use Service Tags in place of explicit IP ranges in user defined routes. This feature is currently in Public Preview.

You can use service tags to achieve network isolation and protect your Azure resources from the general Internet while accessing Azure services that have public endpoints. Create inbound/outbound network security group rules to deny traffic to/from Internet and allow traffic to/from AzureCloud or other available service tags of specific Azure services.

:::image type="content" source="../media/service-tags-efcdf95b.png" alt-text="example NSG with service tags" lightbox="../media/service-tags-efcdf95b.png":::


## Available service tags

The following table includes all the service tags available for use in network security group rules.

The columns indicate whether the tag:

 -  Is suitable for rules that cover inbound or outbound traffic.
 -  Supports regional scope.
 -  Is usable in Azure Firewall rules.

By default, service tags reflect the ranges for the entire cloud. Some service tags also allow more granular control by restricting the corresponding IP ranges to a specified region. For example, the service tag Storage represents Azure Storage for the entire cloud, but Storage. WestUS narrows the range to only the storage IP address ranges from the WestUS region. The [following table](/azure/virtual-network/service-tags-overview#available-service-tags) indicates whether each service tag supports such regional scope.


In the classic deployment model (before Azure Resource Manager), a subset of the tags listed in the previous table are supported. These tags are spelled differently:

| **Classic Spelling** | **Equivalent Resource Manager Tag** |
|:--------------------:|:-----------------------------------:|
| Azure\_LOADBALANCER  |          AzureLoadBalancer          |
|       INTERNET       |              Internet               |
|   VIRTUAL\_NETWORK   |           VirtualNetwork            |

Service tags of Azure services denote the address prefixes from the specific cloud being used. For example, the underlying IP ranges that correspond to the SQL tag value on the Azure Public cloud will be different from the underlying ranges on the Azure China cloud.

If you implement a virtual network Service Endpoint for a service, such as Azure Storage or Azure SQL Database, Azure adds a route to a virtual network subnet for the service. The address prefixes in the route are the same address prefixes, or CIDR ranges, as those of the corresponding service tag.
