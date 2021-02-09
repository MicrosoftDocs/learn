In this unit, you'll follow steps to set up Azure Digital Twins and get ready to work with it.

## Download files

First, you'll download the the Digital Twins samples repo which contain the Digital Twins models (in DTDL format), a IoT device simulator, and the C# code for the Azure Function that will be created.  

Clone a GitHub repo that contains some files you'll need:

```azurecli
git clone https://github.com/Azure-Samples/digital-twins-samples
```

> [!TIP]
> Take note of the directory where these files are downloaded.

## Set up variables

Now, create and store some variables. These variables will make it easier to run the commands in the later units and to avoid typing mistakes.

1. Open a PowerShell console locally or Azure Cloud Shell with PowerShell.
1. To make sure you're logged in to the right account and set to the correct default Azure subscription, run this command:

    ```azurecli
    az account show
    ```

1. If you need to change the subscription, use this command:

    ```azurecli
    az account set -s <subscriptionId>
    ```

1. Set up the variables that will be used by the commands in the rest of this module. Copy and paste the following into the CLI:

    > [!IMPORTANT]
    >
    > - Values for *$dtname* and *$functionname* must be globally unique and lowercase.
    > - Save these values for later use.

    ```azurecli
    $rgname = "adtholrg"+ $(get-random -maximum 10000)
    $random = "adthol" + $(get-random -maximum 10000)
    $dtname = $random + "-digitaltwin"
    $location = "eastus"
    $functionstorage = $random + "storage"
    $telemetryfunctionname = $random + "-telemetryfunction"
    $aaddtapp = $random + "dtapp"
    $username = (az ad signed-in-user show --query "userPrincipalName" -o tsv)
    ```

## Use the CLI to deploy Azure Digital Twins

1. Create a resource group:

    ```azurecli
    az group create -n $rgname -l $location
    ```

1. Create an Azure Digital Twins instance:

    ```azurecli
   az dt create --dt-name $dtname -g $rgname -l $location
    ```

1. To be able to modify the Azure Digital Twins service, you'll need to assign the *Azure Digital Twins Data Owner* role:

    ```azurecli
    az dt role-assignment create -n $dtname -g $rgname --role "Azure Digital Twins Data Owner" --assignee $username -o json
    ```
