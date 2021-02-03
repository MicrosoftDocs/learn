## Download files

First we'll need to clone a GitHub repo that contains some files we'll need

```azurecli
git clone https://github.com/Azure-Samples/digital-twins-samples
```

> [!TIP]
> Take note of the directory these files are downloaded to

## Set up variables

We'll create and store some variables, which will make running the commands needed in the subsequent units easier and avoid mistakes from typos.

1. Open a PowerShell Console locally or a Cloud Shell with PowerShell
1. Ensure you're logged into the right account and set to the correct default Azure subscription by running the command below

    ```azurecli
    az account show
    ```

1. You can change the subscription using the command below

    ```azurecli
    az account set -s <subscriptionId>
    ```

1. Set up the variables that will be used by the commands in the rest of this module. Copy and paste the following into the CLI.

    > [!TIP]
    > dtname and functionname must be globally unique and **LOWERCASE**
    >
    > **Save these values for use later**

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

## Use the CLI to deploy Azure digital twins

1. Create a Resource Group

    ```azurecli
    az group create -n $rgname -l $location
    ```

1. Create Azure Digital Twins

    ```azurecli
   az dt create --dt-name $dtname -g $rgname -l $location
    ```

1. In order to modify the Azure Digital Twins service, you'll need to assign the *Azure Digital Twins Owner* permission

    ```azurecli
    az dt role-assignment create -n $dtname -g $rgname --role "Azure Digital Twins Data Owner" --assignee $username -o json
    ```

1. Create manifest.json for use later

    ```azurecli
    touch manifest.json
    cat > manifest.json
    ```

1. Now you're editing manifest.json
1. Paste the JSON code below into the PowerShell and use ctrl+C to close the file

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

1. Create an Azure AD application with permissions to connect to Digital Twins.  This will be used in later units.

    ```azurecli
    az ad app create --display-name $aaddtapp --native-app --required-resource-accesses ./manifest.json --reply-url http://localhost -o json 
    ```

1. The command below will output the Application ID. Save this for use later.

    ```azurecli
    $appid = $(az ad app list --display-name $aaddtapp --query '[0].appId' -o json)
    ```

1. Create a Service Principal for the application using the appID from the command above

    ```azurecli
    az ad sp create --id $appid
    ```

1. The command below assign permissions to the application created above to the Azure digital twin instance. Add the App ID from above to the command below before running.

    ```azurecli
    az dt role-assignment create --dt-name $dtname --assignee $appid --role "Azure Digital Twins Data Owner"
    ```

1. Create a password for the application.

    > [!NOTE]
    > Make sure you copy the password from the output. This can't be retrieved later.  If you lose your secret/password you'll have to create a new one
    >
    ```azurecli
    az ad app credential reset --id $appid --append
    ```

## Collect important values

There are several important values from the resources set that you will need as you continue working with your Azure Digital Twins instance.

> [!NOTE]
> Save these values for use later
>

### Collect instance values

Get the hostname of the Digital Twins instance. Copy the output to notepad for use later.

```azurecli
az dt show -n $dtname --query 'hostName'
```

### Collect app registration values

Get the Azure Active Directory (AAD) Tenant ID

```azurecli
az account show --query 'tenantId'
```
