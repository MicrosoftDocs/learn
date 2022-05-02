This unit creates these resources using an Azure CLI script.  

This module, as part of the JavaScript on Azure learning path, is a continuation from a previous learn module. If you would like to review the steps to create the Azure resources for a web app, return the to previous module in this path, [Create an Azure App Service resource](/en-us/learn/modules/javascript-deploy-expressjs-app-service/create-app-service-resource). 

## Set up Azure resources

The [Azure CLI script](https://github.com/Azure-Samples/msdocs-javascript-nodejs-server/blob/main/3-Add-cosmosdb-mongodb/setup-in-sandbox.sh), provided as part of the sample repo, creates the following resources for you:

* Azure App Service
* Azure Monitor (Application Insights)

## Azure CLI in the dev container

The Azure CLI is included in the dev container, and defined in the `./devcontainer/devcontainer.json` file with the following **features** array:

```json
"features": {
		"azure-cli": "latest"
	}
```

## Use sandbox subscription

This script uses the Learn sandbox because it sets and uses the `--subscription` parameter. Without this parameter, the Azure CLI would use your default subscription. 