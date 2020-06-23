In this exercise, you use a variable for your storage account name function. 

## Add a variable

Here, you add a variable to store your storage account name function in one place in the template.

1.  
     image 5-arm-variable

looks like this

    ```json
    "variables": {"variable1": "value"},
    ```

change to look like

```json
"variables": {
    "uniqueStorageName": "[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"
  },
```

use in resources section 

```json
"name": "[variables('uniqueStorageName')]",
```

same with displayName

change maxLength to 11



The parameter "storageName" was changed to "storagePrefix" and its "maxLength" value was changed to 11 from 24. This is to ensure the prefix + the generated unique string would not exceed the maximum storage account name length limit of 24
The code now includes a variable named uniqueStorageName. This variable uses five functions to construct a string value.
toLower()
concat()
parameters()
uniqueString()
resourceGroup()
The resource name was changed from "name": "[parameters('storageName')]", to "name": "[variables(uniqueStorageName)]", to leverage the newly created variable.

## deploy (optionally) - won't change anything

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addVariable-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters storagePrefix={your-Prefix}
```