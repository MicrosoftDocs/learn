<!-- markdownlint-disable MD041 -->

In interactive mode, Azure CLI allows you to enter and run commands immediately.

If you only need to create a few Azure resources, manually executing Azure CLI commands is a reasonable choice.

## Create a storage account with Azure CLI

Let's perform a common task: creating a storage account. Here are the four steps you need to follow:

1. Connect to Azure using `az login`.

1. Work with Azure subscriptions using `az account`.

1. Create a resource group using `az group create`.

1. Create a storage account using `az storage account create`.

### 1. Connect

Because you're working with a local Azure CLI installation, you need to authenticate before you can execute Azure commands. Sign into Azure by using the Azure CLI **az login** command.

```azurecli
az login

```

Azure CLI typically launches your default browser to open the Azure sign in page.

If it doesn't work, follow the command-line instructions, and enter an authorization code in the [Enter Code](https://aka.ms/devicelogin) dialog box.

After a successful sign in, you'll be connected to your Azure subscription.

> [!IMPORTANT]
> Starting in 2025, Microsoft will enforce mandatory multifactor authentication for Azure CLI and other command-line tools. The new MFA requirements impact Microsoft Entra ID user identities. It does affect workload identities, such as service principals and managed identities.

### 2. Verify your subscription

If you have permissions to multiple Azure subscriptions, verify your default subscription.

```azurecli
az account show --output table
```

```output
EnvironmentName    HomeTenantId                          IsDefault    Name                               State    TenantId
-----------------  ------------------------------------  -----------  ---------------------------------  -------  ------------------------------------
AzureCloud         aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e  True         The name of my subscription        Enabled  aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e
```

If you want, change your default subscription.

```azurecli
az account set --subscription "the name of a different subscription or subscription ID"
```

### 3. Create a resource group

An Azure resource group is a container for Azure resources. Resource groups keep your Azure resources organized and help you manage security and costs. Resource group names must be unique within a subscription and be assigned a geographical location.

1. Find which Azure locations are available to your default subscription

   ```azurecli
   az account list-locations --output table
   ```

   ```output
   DisplayName               Name                 RegionalDisplayName
   ------------------------  -------------------  -------------------------------------
   East US                   eastus               (US) East US
   South Central US          southcentralus       (US) South Central US
   West US 2                 westus2              (US) West US 2
   West US 3                 westus3              (US) West US 3
   Australia East            australiaeast        (Asia Pacific) Australia East
   ... <more regions here>
   ```

1. Create a resource group using variables

   Because this module is advanced, let's begin using random identifiers and Bash variables. The use of random IDs allows you to test a script repeatedly without having to wait for the resource group of the previous test to be deleted.

   ```azurecli
   # Variable block
   let "randomIdentifier=$RANDOM*$RANDOM"
   location="westus2"
   resourceGroup="msdocs-rg-$randomIdentifier"

   # Create the resource group
   az group create --name $resourceGroup --location $location --output json
   ```

### 4. Create a storage account

Using the resource group you created, create a storage account. Replace `<msdocs-rg-0000000>` with the name of the resource group you created in the previous step. Storage account names can only contain lowercase letters and numbers.

```azurecli
# Variable block
let "randomIdentifier=$RANDOM*$RANDOM"
location="westus2"
resourceGroup="<msdocs-rg-0000000>"
storageAccount="msdocssa$randomIdentifier"

# Create the storage account.
echo "Creating storage account $storageAccount in resource group $resourceGroup"
az storage account create --name $storageAccount \
                          --resource-group $resourceGroup \
                          --location $location \
                          --sku Standard_RAGRS \
                          --kind StorageV2 \
                          --output json
```

### 5. Verify resource creation

For most Azure command groups, Azure CLI provides **list** and **show** commands to get resource details.

1. Verify your new storage account was created.

   ```azurecli
   az storage account list
   ```

   To get more concise information, you can format the output as a simple table:

   ```azurecli
   az storage account list --output table
   ```

1. If you have several storage accounts, filter the return values by using the `--query` parameter.

   ```azurecli
   # get a list of all storage account created in the last 30 days
   saDate=$(date +%F -d "-30days")
   az storage account list --resource-group <msdocs-rg-00000000> \
       --query "[?creationTime >='$saDate'].{saName:name, saID: id, sku: sku.name}"
   ```

> [!NOTE]
> Format the `--query` parameter string using **JMESPath**, which is a standard query language for JSON requests.

## Clean up resources

Using random IDs and running these module steps creates test resource groups that can be removed. The easiest way to clean up Azure resources is to delete the resource group. However, when you delete a resource group, you delete every object inside the group, so it's important delete the right resource group name!

```azurecli
# Get a list of resource groups in the active subscription
az group list --output table

# Delete a resource group and do not wait for the operation to finish
az group delete --name <msdocs-rg-0000000> --no-wait
```

Complex or repetitive tasks can be time-consuming and error-prone when performed manually. Many organizations prefer to automate these tasks to reduce costs and avoid mistakes. Using an Azure CLI script to automate the creation of Azure resources creation is much more efficient and reliable
than manually creating them one at a time.
