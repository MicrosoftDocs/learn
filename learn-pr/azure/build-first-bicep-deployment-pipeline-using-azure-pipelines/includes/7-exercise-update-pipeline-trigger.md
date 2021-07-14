You have a pipeline that can execute a Bicep deployment to your Azure environment. We will now make this pipeline run automatically. In this exercise you will: 

- Update your pipeline so it triggers automaticaly based on changes to the main branch and the deploy folder. 
- See your pipeline trigger automatically

## Update the trigger to be branch-based

1. In Visual Studio Code, open your YAML pipeline file and change the manual trigger to a branch trigger: 

```YAML
trigger:
  branches:
    include:
    - main
```

1. Save the file. The full code should look like this: 

```YAML
trigger:
  branches:
    include:
    - main

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

1. Commit the changes and push them to the git repository.

```cmd
git add -A
git commit -m 'Added trigger'
git push
```

1. Open your project in Azure DevOps and navigate to your `Pipelines`. On the pipelines overview page, you should already see that your pipeline has been triggered and is running. If it is not, try refreshing the page. 

<TODO: Insert image>

## Add a Bicep module and make it intentionally invalid

1. Go back to Visual Studio Code and open your Bicep template. Add the bottom of the file, add an ApplicationInsights resource: 

```bicep
resource applicationInsights 'Microsoft.Insights/components@2018-05-01-preview' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
```

1. Save the file and commit the changes: 

```cmd
git add -A
git commit -m 'New bicep'
git push
```

1. Go back to Azure DevOps and notice that this change as well triggered a pipeline run. This run however will fail, since we used a unsupported version of the Application Insights resource provider. 

<TODO: Insert image>

## Fix the Bicep module and see the pipeline triggered again

1. Go back to Visual Studio Code and open your Bicep template. Add the bottom of the file, remove the ApplicationInsights resource again. Your bicep file should agin look like this: 

```bicep
@description('The location into which your Azure resources should be deployed.')
param location string = resourceGroup().location

@description('Select the type of environment you want to provision. Allowed values are Production and Test.')
@allowed([
  'Production'
  'Test'
])
param environmentType string

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

// Define the names for resources.
var appServiceAppName = 'toy-website-${resourceNameSuffix}'
var appServicePlanName = 'toy-website'

// Define the SKUs for each component based on the environment type.
var environmentConfigurationMap = {
  Production: {
    appServicePlan: {
      sku: {
        name: 'S1'
        capacity: 2
      }
    }
  }
  Test: {
    appServicePlan: {
      sku: {
        name: 'F1'
        capacity: 1
      }
    }
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: environmentConfigurationMap[environmentType].appServicePlan.sku
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
      ]
    }
  }
}
```

1. Save the file and commit all changes: 

```cmd
git add -A
git commit -m 'New bicep'
git push
```

1. This will trigger another pipeline run, which is ok. 

<TODO: Insert image>


