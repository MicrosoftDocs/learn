In this exercise, you use a variable for your storage account name expression. 

## Add a variable

Here, you add a variable to store your storage account name expression in one place in the template.

1. In the *azuredeploy.json* file in Visual Studio Code, place your curser between the curly braces in the variables block. ```"variables":{},``` Press <kbd>Enter</kbd>.
1. Type **var**** in the square brackets. You see a list of related snippets. Choose arm-variable.

  :::image type="content" source="../media/5-arm-variable.png" alt-text="Visual Studio Code showing the snippets for Azure Resource Manager template variables." border="true":::

1. Your variables section will look like this.

    ```json
    "variables": {"variable1": "value"},
    ```

1. Change the name of the variable to **uniqueResourceName**, and change the value to **"[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"** Your variables section will look like this:

    ```json
    "variables": {
        "uniqueStorageName": "[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"
      },
    ```

1. Use the variable in the resources section. Change the values of the ```name:``` and ```displayName``` attributes to **"[variables('uniqueStorageName')]"**

1. Change value of the ```maxLength:``` attribute for the *storagePrefix* variable  to 11. The maximum length for a storage account name is 24, and you want to be sure the added hash from the function you created doesn't cause the name to be more than 24 characters.

1. The entire file will look look this:

    [!code-json[](code/variable.json)]

## Optionally, deploy the template

The updated template doesn't have any changes to the resource you deployed, so deploying this template won't make any changes to your Azure environment. However, if you would like to deploy this template to see it succeed, use the Azure CLI commands below. Be sure to use the same *storagePrefix* parameter value you used in the last deployment.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addVariable-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters storagePrefix={your-Prefix}
```
