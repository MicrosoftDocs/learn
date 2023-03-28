Whether you use the Azure OpenAI Studio interface or REST API to start, you first need to deploy a model to make API calls to receive completions to prompts. When you create a new deployment, you need to indicate which base model to deploy. There are several ways you can deploy your base model. 

## Deploy using Azure OpenAI Studio 
In Azure OpenAI Studio, you can navigate from the home page to deployments in the **Manage your deployments and models** section and by selecting **Go to deployments**.  

![Screenshot of the options in Azure OpenAI Studio for managing models with deployments selected.](../media/studio-navigate-deployments.png)

From the deployments page, you are able to create a new deployment by selecting a model from the menu. The available base models are based on the list in the models page.  

![Screenshot of the Azure OpenAI Studio portal's model deployment wizard.](../media/studio-deployment.png)


## Deploy using the Command Line 

You can deploy a model using the console. Using the example below, you want to replace the following variables with your own: 
- myResourceGroupName: *replace with your resource group name* 
- myResourceName: *replace with your resource name*
- MyModel: *replace with a unique name for your model*
- text-curie-001: *replace with the base model you wish to deploy*

```dotnetcli
az cognitiveservices account deployment create \
   -g myResourceGroupName \
   -n myResourceName \
   --deployment-name MyModel \
   --model-name text-curie-001 \
   --model-version "1"  \
   --model-format OpenAI \
   --scale-settings-scale-type "Standard"
```

## Deploy using the REST API 

You can deploy a model using the REST API. In the request body, you will identify the base model you wish to deploy. See an example in the [documentation](https://learn.microsoft.com/rest/api/cognitiveservices/azureopenaistable/deployments/create?portal=true). 
 

