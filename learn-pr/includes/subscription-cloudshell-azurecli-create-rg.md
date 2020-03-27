<!-- Standard resource group creation -->
::: zone pivot="personal-subscription"

1. Browse to the [Azure Cloud Shell](https://shell.azure.com?azure-portal=true) and sign into your Azure subscription.

1. Create a new Azure Resource Group named 'learn-resources' to hold your virtual machine. In the Cloud Shell window, run the following Azure CLI command.

    ```azurecli
    az group create --name "learn-resources"
    ```

1. Set the default resource group for the Azure CLI by typing the following command into the Cloud Shell window. This allows you to omit the resource group name from all the commands.

    ```azurecli
    az configure --defaults group=learn-resources
    ```

::: zone-end

::: zone pivot="hosted-subscription"

1. Activate the Cloud Shell window on the right by signing into the Azure Sandbox.

1. Set the default resource group to work with by typing the following command into the Cloud Shell on the right. This allows you to omit the resource group name from all the commands.

    ```azurecli
    az configure --defaults group=<rgn>[Sandbox resource group name]</rgn>
    ```
    
::: zone-end