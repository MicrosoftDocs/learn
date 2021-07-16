Now that you have a basic basic pipeline, you want to use it to deploy your Bicep file to Azure.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a Bicep file to your repository.
> * Create a resource group for your website.
> * Create a service principal and grant it access to the resource group.
> * Create a service connection and configure it with the service principal's credentials.
> * Add a pipeline step to deploy your Bicep file.
> * Execute your pipeline.
> * Verify that the pipeline runs successfully.

In this exercise will use the [Azure Pipelines extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines). Be sure to install this extension in Visual Studio Code.


## Add your bicep template to the repository

1. Once the project has opened, you will see your azure-pipelines.yml file and the README.md file in the file tree. Add a new folder in the root of the file tree and call it `deploy`. In the deploy folder create a new `main.bicep` file.

<TODO: Insert image>

1. Copy paste the following bicep code in the main.bicep file:

(https://review.docs.microsoft.com/en-us/learn/modules/authenticate-azure-deployment-pipeline-service-principals/6-exercise-authorize-service-principal-deployments?branch=pr-en-us-18385&pivots=cli)

```bicep
@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the App Service app.')
param appServiceAppName string = 'toywebsite${uniqueString(resourceGroup().id)}'

@description('The name of the App Service plan SKU.')
param appServicePlanSkuName string = 'F1'

var appServicePlanName = 'toy-website-plan'
var applicationInsightsInstanceName = 'toy-website-insights'

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource applicationInsightsInstance 'Microsoft.Insights/components@2018-05-01-preview' = {
  name: applicationInsightsInstanceName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsightsInstance.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsightsInstance.properties.ConnectionString
        }
      ]
    }
  }
}
```

1.  Save the file. 
1.  In the Visual Studio Code `Terminal` window, add the changes, commit the changes and push the changes to your repository. 

```cmd
git add -A
git commit -m 'Added bicep file'
git push
```

1.  Switch back to Azure DevOps `Repos`. The _main.bicep_ file in the _deploy_ directory should be present. If not, try refreshing the page. 


##  Create a resource group in Azure

TODO, reuse content from https://review.docs.microsoft.com/en-us/learn/modules/authenticate-azure-deployment-pipeline-service-principals/?branch=pr-en-us-18385 ? 


##  Create a service principal and grant it access to the resource group

TODO, reuse content from https://review.docs.microsoft.com/en-us/learn/modules/authenticate-azure-deployment-pipeline-service-principals/?branch=pr-en-us-18385 ? 

##  Create a service connection and refer to it in the task

With the resource group and service principal created, you will now use the details of the service principal to create a service connection. 

1. Open your project in `dev.azure.com`. 

<TODO: Insert image>

1. Navigate to `Project settings` in the bottom left.

<TODO: Insert image>

1. Select `Service connections`

<TODO: Insert image>

1. Click on the `New service connection` button.

<TODO: Insert image>

1. Choose `Azure Resource Manager` from the list and click `Next`.

<TODO: Insert image>

1. Choose `Service principal (manual)` from the list and click `Next`.

<TODO: Insert image>

> [!Note]
> We advise you to follow the manual and not the automatic service principal authentication process. The reason for this is that in the automatic process Azure DevOps creates the Service Principal for you and gives the Service Principal Owner permission at subscription level. This is a wide set of permissions. Hence we recommend to create the service principal beforehand and give it only the permissions needed for the job it needs to execute. We advise to utilize the principle of least privilege. 

1. Fill out your `Subscription Id`, `Subscription Name` in the designated textboxes. You can find these values on the overview screen of your resource group in the Azure portal. 

<TODO: Insert image>

1. For `Service Principal Id` you use the `Application Id` of the service principal you created. 

<TODO: Insert image>

1. For Credential type, you can leave it to the default value of `Service principal key`. Use the service principal `Password` as a value. 

<TODO: Insert image>

1. Fill out the `Tenant ID` as well.

<TODO: Insert image>

1. You can now click the `Verify` button, this should indicate the values you filled out are correct.

<TODO: Insert image>

1. Name your service connection `Toywebsite`.

<TODO: Insert image>

1. Leave the `Grant access permission to all pipelines as is`.

<TODO: Insert image>

1. Click `Verify and save`.


##  Replace the existing tasks in the pipeline by a task that will deploy your Bicep template

You will now update your YAML pipeline to include tasks to deploy the bicep template to Azure using your service connection. 

1. Open your Visual Studio Code and open the azure-pipelines.yml file. 

<TODO: Insert image>

1. Remove all script steps that are already present. 
1. Add a task step. Type: -task: 
1. If a context menu does not appear, type Ctrl + space, this shows a context menu of available tasks.

<TODO: Insert image>

> [!Note]
> While working in Visual Studio Code the Ctrl + Space key combination is a handy one to bring up a context menu of suggestions at all times at the place where your cursor is. 

> [!Note]
> Keep an eye on indentation. If your indentation is off, your YAML file will not be correct. Visual Studio Code will also indicate faulty indication by means of squigly lines. 

1. Start typing `AzureCLI@2`, the context menu will filter down the entries based on the text you type. You can use the arrow keys to choose this task from the context menu and insert it by pressing `Enter`. 

<TODO: Insert image>

1. Add the following statements underneath the task. Be sure to have input at the same indentation level as task. You will notive that the task is already making use of variables. We will define these variables at a later step in the pipeline UI. 

```YAML
inputs:
  azureSubscription: $(serviceConnection)
  scriptType: 'bash'
  scriptLocation: 'inlineScript'
  inlineScript: 'az deployment group create --resource-group $(resourcegroup) --template-file deploy/main.bicep -n $(Build.BuildId) -p environmentType=$(environment)'
```

> [!Note]
> Notice that in the task we also add the extra system variable Build.BuildId for the name of the deployment. 

TODO mention the az bicep upgrade thing

1. Your resulting YAML file should look like this: 

```YAML
trigger: none

pool:
  vmImage: ubuntu-latest

jobs:
- job: 
  steps:
  - task: AzureCLI@2
    inputs:
      azureSubscription: $(serviceConnection)
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: 'az deployment group create --resource-group $(resourcegroup) --template-file deploy/main.bicep -n $(Build.BuildId) -p environmentType=$(environment)'
```

1. Save your YAML pipeline file.
1. Add your changes, commit and push them to your repository. 

```cmd
git add -A
git commit -m 'Added Azure CLI task'
git push
```

1. Go back to your project in Azure DevOps in the browser and navigate to `Pipelines`. 

<TODO: Insert image>

1. Select your pipeline.

<TODO: Insert image>

1. Click the `Edit` button. 

<TODO: Insert image>

1. On the top right, click the `Variables` button. 

<TODO: Insert image>

1. Click the `+` button. 

<TODO: Insert image>

1. Fill out `serviceConnection` for the `Name` and `Toywebsite` for the `Value`. 

<TODO: Insert image>

1. Click the `Ok` button.

<TODO: Insert image>

1. In the same way create the `resourcegroup` variable with a value of `ToyWebsite`.

<TODO: Insert image>

1. Also create an `environment` variable with a value of `Test`. For this variable check the checkbox to `Let users override this value when running this pipeline`.

<TODO: Insert image>

1. When you created all 3 variables, click the `Save` button.

<TODO: Insert image>


## Run your pipeline

1. Now that you created your variables and while you are still on the pipeline edit screen in Azure Devops, on the top right, click the `Run pipeline` button.

<TODO: Insert image>

1. In the Run pipeline flyout, expand the variables.

<TODO: Insert image>

1. Select the `environment` variable.

<TODO: Insert image>

1. Give it a new value of `Production`. 

<TODO: Insert image>

1. Click the `Update` button.

<TODO: Insert image>

1. Click the `<-` back arrow.

<TODO: Insert image>

1. Click the `Run` button to start a new pipeline run.

<TODO: Insert image>

1. Click on the `Job` to see its details. 

<TODO: Insert image>

1. On the `Job`, click open the `fx 3 queue time variables used`. This should show the 2 values for resourcegroup and serviceConnection as your set them up in the overall variable definitions. For environment it will show Production as you indicated this value for this specific run. 

<TODO: Insert image>

1. Also inspect the rest of your pipeline output. This should succeed. 

<TODO: Insert image>

1. Navigate to the resource group you created in the Azure portal and verify that your resources got deployed.

<TODO: Insert image>

1. Select the App Service Plan in the resource group.

<TODO: Insert image>

1.  Since you deployed the Production environmentType of the Bicep template, this will be a Standard 1 plan running 2 instances. 

<TODO: Insert image>

1. Navigate back to your resource group in the Azure portal. 

<TODO: Insert image>

1. Select the `Deployments` menu. You will notice that a new deployment was added, with as name your build ID.

<TODO: Insert image>

