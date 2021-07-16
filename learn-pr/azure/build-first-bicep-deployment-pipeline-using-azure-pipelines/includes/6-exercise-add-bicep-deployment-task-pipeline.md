Now that you have a basic pipeline, you want to use it to deploy your website's Bicep file to Azure.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a Bicep file to your repository.
> * Add a pipeline step to deploy your Bicep file.
> * Run your pipeline again and verify that it successfully deployed your website.

## Add your website's Bicep file to the Git repository

1. In Visual Studio Code, in the _deploy_ folder, create a new file named _main.bicep_.

1. Copy the following into the _main.bicep_ file:

   :::code language="bicep" source="code/6-main.bicep" :::

1. Save the file.

1. In the Visual Studio Code **Terminal**, stage the changes, commit the changes and push the changes to your repository by using the following commands:

   ```bash
   git add -A
   git commit -m 'Add Bicep file'
   git push
   ```

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

