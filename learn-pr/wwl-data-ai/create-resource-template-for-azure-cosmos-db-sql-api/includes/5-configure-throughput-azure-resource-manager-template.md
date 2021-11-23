Now that the templates have been defined, use the Azure CLI to deploy either JSON or Bicep Azure Resource Manager templates. To make things easier, the ``az deployment group create`` command is identical between the two types of templates that can be deployed.

## Deploy Azure Resource Manager template to a resource group

Use the ``az deployment group create`` with the following arguments to deploy an Azure Resource Manager template to a resource group:

| **Argument** | **Description** |
| --- | --- |
| **--resource-group** | The name of the resource group that is the target of the deployment |
| **--template-file** | The name of the file with the resources defined to deploy |

```azurecli
az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.json'
```

There are also other optional arguments that you can use to customize the deployment.

For example, you can name a deployment to make it easier to find in logs or the Azure portal using the **--name** argument.

```azurecli
az deployment group create \
    --resource-group '<resource-group>' \
    --name '<deployment-name>' \
    --template-file '.\template.json'
```

You can also define parameters inline with the command using the **--parameters** argument.

```azurecli
az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.json' \
    --parameters name='<value>'
```

If you prefer to use a parameter JSON file, that is also possible with the **--parameters** argument.

```azurecli
az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.json' \
    --parameters '@.\template.json'
```

## Deploy Bicep template to a resource group

Fortunately, deploying a Bicep template is identical in practice to deploying a JSON template. In this example, a Bicep template is deployed with the only difference being a change in the name of the file's extension.

```azurecli
az deployment group create \
    --resource-group '<resource-group>' \
    --template-file '.\template.bicep'
```
