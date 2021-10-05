After speaking to your team you have decided to build in better confidence in your deployments by first deploying to a pre-production environment. In this exercise you will add an additional environment to your pipeline and deploy to the production environment only when the deploy to pre-production looks good. 

During the process, you'll: 

> [!div class="checklist"]
> * Create 2 environments for pre-production and production.
> * Add an approval check for your environments.
> * Update your existing pipeline to add new stages to prepare and deploy to your pre-production environment.
> * Run your pipeline.

## Create Pre-Production and Production environments

First you'll need to create the environments you will use to deploy to. 

1. In your browser, navigate to **Pipelines** > **Environments**.

1. Select **New Environment**. 

1. Fill out *WebsitePreProd* as a name for the environment and select **Create**.

1. Select the **3 dots** button and select **approvals and check** from the drop down menu.

1. Select the **+** button. 

1. Select **Approvals** from the possible options and select **Next**.

1. Fill out your own username as Approver and select **Create**.

1. Select the back arrow to navigate back to the environment detail.

1. Select the back arrow to navigate back to the list of environments.

1. In the same way create a new environment called *WebsiteProd* and add an approval to it. 


## Update your pipeline to make use of the WebsitePreProd environment

Now that you have your two environments created, you need to start using them in your YAML pipeline. 

1. In Visual Studio Code, open the *azure-pipelines.yml* file in the *deploy* folder. You will notice that this pipeline already has a couple of stages in it. These stages are: 

- _Lint_: For Linting the code and checking validity of the Bicep template.
- _Validate_: This stage runs preflight validation checks and makes use of your original service connection.
- _Preview_: This stage will run a what-if deployment. It will give you an overview of which resources will be created, updated or deleted in your Azure subscription.  
- _Deploy_: This is where your actual deployment will happen. You will want to stop right before this stage to first check what-if output before you approve the actual deployment towards an environment. 
- _SmokeTest_: This stage will run a smoke test against the newly deployed resources. It will check whether the website that gets deployed by the Bicep file is reachable. 

1. Append *PreProd* to the name of each of each of the stages, except for the *Lint* stage. 

- _Validate_ will become _ValidatePreProd_
- _Preview_ will become _PreviewPreProd_
- _Deploy_ will become _DeployPreProd_
- _SmokeTest_ will become _SmokeTestPreProd_

1. Remove the job of the *DeployPreProd* stage and replace it with the following deployment job: 

```YAML
  - deployment: DeployWebsite
    displayName: Deploy Website PreProd
    environment: WebsitePreProd
    strategy:
      runOnce:
        deploy:
          steps:
            - checkout: self
            - task: AzureCLI@2
              name: DeployBicepFile
              displayName: Deploy Bicep file
              inputs:
                azureSubscription: $(ServiceConnectionName)
                scriptType: 'bash'
                scriptLocation: 'inlineScript'
                inlineScript: |
                  deploymentOutput=$(az deployment group create \
                    --name $(Build.BuildNumber) \
                    --resource-group $(ResourceGroupName) \
                    --template-file deploy/main.bicep \
                    --parameters environmentType=$(EnvironmentType))
                  appServiceAppHostName=$(echo $deploymentOutput | jq -r '.properties.outputs.appServiceAppHostName.value')
                  echo "##vso[task.setvariable variable=appServiceAppHostName;isOutput=true]$appServiceAppHostName"
```

    Notice that this new deployment job makes use of the WebsitePreProd environment. 

1. Update the *appServiceAppHostName* variable in the *SmokeTestPreProd* stage to make use of the new stage name for *DeployPreProd*.

```YAML
appServiceAppHostName: $[ stageDependencies.DeployPreProd.DeployWebsite.outputs['DeployWebsite.DeployBicepFile.appServiceAppHostName'] ]
```

## Update your pipeline to make use of the WebsiteProd environment

You now have a pipeline that can deploy to your PreProd environment and that will stop deployment and ask for approval right before actually deploying to this environment. You now also want to have the same for your Production environment. 

1. Select the full pipeline starting from the *ValidatePreProd* stage until the end of the file. Make a copy and paste this full block again at the bottom of the file. 

1. Rename the stages in the pasted text: 

- _ValidatePreProd_ will become _ValidateProd_
- _PreviewPreProd_ will become _PreviewProd_
- _DeployPreProd_ will become _DeployProd_
- _SmokeTestPreProd_ will become _SmokeTestProd_

1. In the *ValidateProd*, *PreviewProd* and *DeployProd* stages, change the service connection that is used to *ServiceConnectionProduction*. 

NOTE TO JOHN: For now I didn't add the steps to add this variable ... We need to see where to best add those. 

1. In the *ValidateProd*, *PreviewProd* and *DeployProd* stages, change the resource group that is used to *ResourceGroupNameProd*.

1. In the *_*DeployProd* stage, change the environment to *WebsiteProd*_*

1. Update the *appServiceAppHostName* variable in the *SmokeTestProd* stage to make use of the stage name for *DeployProd*.

```YAML
appServiceAppHostName: $[ stageDependencies.DeployProd.DeployWebsite.outputs['DeployWebsite.DeployBicepFile.appServiceAppHostName'] ]
```

1. Save the file. 

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and validation stages"
   git push
   ```

   Immediately after you push, Azure Pipelines starts a new pipeline run.


## View the pipeline run

1. In your browser, navigate to **Pipelines**.

1. Select the most recent run of your pipeline.

   If the pipeline is still running, wait until it waits for the first approval. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that the pipeline run now shows all the stages you defined in the YAML file. Also notice that execution will stop right before your *DeployPreProd* stage.

1. Approve the deploy to the preproduction environment by selecting the **Review** button.

1. Select the **Approve** button.

1. The pipeline will continue execution until right before the *DeployProd* stage. Once it does, select again the **Review** and the **Approve** buttons to make the pipeline continue. 

1. Once your pipeline has finished execution, select the *Environments*. 

1. Select your *WebsiteProd* environment. 

1. Notice that in the environment details screen, you get an overview of the deployments that have executed against this environment. 

1. Select the 1 deployment that is there. 

1. In the details of the deployment, select the *Changes* tab.

    Notice that the changes tab shows you the commits that happened for the execution of this pipeline. 

You now have a pipeline that deploys to 2 environments. You will have notices however that the pipeline you ended up with is quite extensive and big. In the next section we will make this more concise again, without changing the functionality. 
