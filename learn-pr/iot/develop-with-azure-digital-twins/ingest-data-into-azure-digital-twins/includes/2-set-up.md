In this unit, you'll follow steps to set up Azure Digital Twins and get ready to work with it.

## Download files

First, clone a GitHub repo that contains some files you'll need:

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
    $username = Read-Host "Enter username. ex: jdoe@contoso.com"
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

1. Create the manifest.json file for later use:

    ```azurecli
    touch manifest.json
    cat > manifest.json
    ```

    Now you're editing manifest.json.

1. Paste the following JSON code into PowerShell and then use Ctrl+C to close the file.

    ```json
    [{
        "resourceAppId": "0b07f429-9f4b-4714-9392-cc5e8e80c8b0",
        "resourceAccess": [
         {
           "id": "4589bd03-58cb-4e6c-b17f-b580e39652f8",
           "type": "Scope"
         }
        ]
    }]
    
    ```

1. Create an Azure Active Directory (Azure AD) application with permissions to connect to Azure Digital Twins. You'll use this application in later units.

    ```azurecli
    az ad app create --display-name $aaddtapp --native-app --required-resource-accesses ./manifest.json --reply-url http://localhost -o json 
    ```

1. The following command will output the application ID. Save this ID for later use.

    ```azurecli
    $appid = $(az ad app list --display-name $aaddtapp --query '[0].appId' -o json)
    ```

1. Create a service principal for the application by using the application ID from the preceding step:

    ```azurecli
    az ad sp create --id $appid
    ```

1. The next command gives the application you just created permissions to the Azure Digital Twins instance. Add the application ID from the preceding steps to the command before you run it:

    ```azurecli
    az dt role-assignment create --dt-name $dtname --assignee $appid --role "Azure Digital Twins Data Owner"
    ```

1. Create a password for the application:

    > [!NOTE]
    > Make sure to copy the password from the output because you can't retrieve it later. If you lose your password, you'll have to create a new one.
    >

    ```azurecli
    az ad app credential reset --id $appid --append
    ```

## Collect important values

You'll need several important values from the resources set as you continue working with your Azure Digital Twins instance.

> [!NOTE]
> Save these values for later use.
>

### Collect instance values

Get the host name of the Azure Digital Twins instance. Copy the output to Notepad for later use.

```azurecli
az dt show -n $dtname --query 'hostName'
```

### Collect app-registration values

Get the Azure AD tenant ID:

```azurecli
az account show --query 'tenantId'
```
