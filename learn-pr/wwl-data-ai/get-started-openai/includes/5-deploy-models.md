Whether you use the Azure OpenAI Studio interface or REST API to start, you first need to deploy a model to make API calls to receive completions to prompts. 

## Deploy using Azure OpenAI Studio 
In Azure OpenAI Studio, you can navigate from the home page to deployments in the **Manage your deployments and models** section and by selecting **Go to deployments**.  

![Screenshot of the options in Azure OpenAI Studio for managing models with deployments selected.](../media/studio-navigation-deployments.png)

From the deployments page, you are able to create a new deployment by selecting a model from the menu. The available base models are based on the list in the models page.  

![Screenshot of the Azure OpenAI Studio portal's model deployment wizard.](../media/studio-deployment.png)

## Deploy using the Command Line 

```dotnetcli
az cognitiveservices account deployment create \
   -g $myResourceGroupName \
   -n $myResourceName \
   --deployment-name MyModel \
   --model-name text-curie-001 \
   --model-version "1"  \
   --model-format OpenAI \
   --scale-settings-scale-type "Standard"
```

## Deploy using the REST API 

```http
POST {endpoint}/openai/deployments?api-version=2022-12-01
```

```http
POST https://aoairesource.openai.azure.com/openai/deployments?api-version=2022-12-01


{
  "scale_settings": {
    "capacity": 2,
    "scale_type": "manual"
  },
  "model": "curie"
}
```

```json
{
  "scale_settings": {
    "capacity": 2,
    "scale_type": "manual"
  },
  "model": "curie",
  "owner": "organization-owner",
  "id": "deployment-afa0669ca01e4693ae3a93baf40f26d6",
  "status": "notRunning",
  "created_at": 1646126127,
  "updated_at": 1646127311,
  "object": "deployment"
}
```
You can review the [documentation](https://learn.microsoft.com/en-us/rest/api/cognitiveservices/azureopenaistable/deployments/create?tabs=HTTP?portal=true) 
 

Once the model is deployed, you can test it in the playground. 
