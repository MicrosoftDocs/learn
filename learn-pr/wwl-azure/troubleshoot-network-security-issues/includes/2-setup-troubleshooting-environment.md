You’ll troubleshoot a site-to-site connection problem in a later exercise. Use the following instructions and the Azure Cloud Shell on the right of the screen to create the environment for this exercise.

> **NOTE**:
> The resource group **sandbox-rg** has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.


## Create the exercise environment

 Use the cloud shell on the right run these commands to create the example topology.

1. Enter this Azure CLI command:

    ```azurecli
    az deployment group create \
    --resource-group sandbox-rg \
    --template-uri "https://raw.githubusercontent.com/MicrosoftDocs/mslearn-troubleshoot-network-security-issues/main/arm-lab.json"
    ```
1. You can continue to the next unit as this command runs in the background.
