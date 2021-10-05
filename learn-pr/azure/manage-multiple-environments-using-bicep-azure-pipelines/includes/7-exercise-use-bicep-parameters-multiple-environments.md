Your team is very happy with the new pipeline that is able to deploy to the 2 environments they have. However, they are worried that the current pipeline definition might be brittle once additional steps need to be added. They would like the same process to be used in the pre-production and the production environment. In case anything needs to be changed to this process they want to be able to do this in one place to avoid errors. 

During the process you'll:

> [!div class="checklist"]
> *	Create a YAML template for the similar deployment steps
> *	Update the pipeline to deploy to multiple environments and use template files

## Create a YAML template for the similar deployment steps

First you'll create a template that contains the stages that are similar for both environments you deploy to.

1. In Visual Studio Code, create a new *deploy-environment.yml* file in the *deploy* folder. 

1. As the first line in this file add: 

```YAML
stages:
```

1. Open the *azure-pipelines.yml* file and select the full code of the stages _ValidatePreProd_, _PreviewPreProd_, _DeployPreProd_ and _SmokeTestPreProd_. Copy these stages and paste them in the *deploy-environment.yml* file under the stages line.

1. The file should now look like this: 

```YAML
stages: 
- stage: Validate
  jobs:
  - job: ValidateBicepCode
    displayName: Validate Bicep code
    steps:
      - task: AzureCLI@2
        name: RunPreflightValidation
        displayName: Run preflight validation
        inputs:
          azureSubscription: $(ServiceConnectionName)
          scriptType: 'bash'
          scriptLocation: 'inlineScript'
          inlineScript: |
            az deployment group validate \
              --resource-group $(ResourceGroupName) \
              --template-file deploy/main.bicep \
              --parameters environmentType=$(EnvironmentType)

- stage: Preview
  jobs: 
  - job: PreviewAzureChanges
    displayName: Preview Azure changes
    steps:
      - task: AzureCLI@2
        name: RunWhatIf
        displayName: Run what-if
        inputs:
          azureSubscription: $(ServiceConnectionName)
          scriptType: 'bash'
          scriptLocation: 'inlineScript'
          inlineScript: |
            az deployment group what-if \
              --resource-group $(ResourceGroupName) \
              --template-file deploy/main.bicep \
              --parameters environmentType=$(EnvironmentType)

- stage: Deploy
  jobs:
  - deployment: DeployWebsite
    displayName: Deploy Website
    environment: WebsiteProd
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

- stage: SmokeTest
  jobs:
  - job: SmokeTest
    displayName: Smoke test
    variables:
      appServiceAppHostName: $[ stageDependencies.Deploy${{parameters.environment}}.DeployWebsite.outputs['DeployWebsite.DeployBicepFile.appServiceAppHostName'] ]
    steps:
      - task: PowerShell@2
        name: RunSmokeTests
        displayName: Run smoke tests
        inputs:
          targetType: inline
          script: |
            $container = New-PesterContainer `
              -Path 'deploy/Website.Tests.ps1' `
              -Data @{ HostName = '$(appServiceAppHostName)' }
            Invoke-Pester `
              -Container $container `
              -CI

      - task: PublishTestResults@2
        name: PublishTestResults
        displayName: Publish test results
        condition: always()
        inputs:
          testResultsFormat: NUnit
          testResultsFiles: 'testResults.xml'
```

1. Save this file. 

## Update pipeline to deploy to multiple environments and use template files

Now that the similar part exists in the *deploy-environment.yml* file, you can call this file to deploy to both environments.

1. In the *azure-pipelines.yaml* file, select everything from line 21 all the way to the last line in the file. Delete all these lines, you should only have the _Lint_ stage left now in the file. 

1. Add a new line under the _Lint_ stage: 

```YAML
- template: deploy-environment.yml
```

1. The file should now look like this: 

```YAML
trigger:
  branches:
    include:
    - main

pool:
  vmImage: ubuntu-latest

stages:

- stage: Lint
  jobs: 
  - job: LintCode
    displayName: Lint code
    steps:
      - script: |
          az bicep build --file deploy/main.bicep
        name: LintBicepCode
        displayName: Run Bicep linter

- template: deploy-environment.yml
```

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Added template"
   git push
   ```

   Immediately after you push, Azure Pipelines starts a new pipeline run. However, you will notice that it will again only deploy to 1 environment. We could add the following line twice: 

```YAML
- template: deploy-environment.yml
```

    However, this will lead to a couple of problems: 

    - Stage and job names are present twice in the pipeline, Azure DevOps does not allow this. Your pipeline will not start running because of invalid syntax.
    - As a fix you might be tempted to remove the stage and job names altogether. This will indeed result again in a valid pipeline. However, the SmokeTest stage needs to be able to reference the Deploy stage, because it needs the output variable from this stage. If you remove the names of the stages, stages will no longer be able to reference each other. 
    - The values for the resource group name and the service connection are currently based on variables that are defined in the pipeline UI, but these variables only exist for 1 environment, not for 2. 

In the next part of this exercise, we will start using variable groups and parameters to fix these problems.





You just created a first version of a pipeline template, which contains the similarities of the 2 environments you want to deploy to. However, your template is not capable of handling differences between environments yet. In this exercise we will allow for these differences. 

During the process you'll:

> [!div class="checklist"]
> * Create 2 variable groups for each environment you want to deploy to
> *	Update the pipeline template so it picks the correct variable group for each environment
> * Add a condition to the pipeline template to skip the what-if step for the test environment.
> * Update the pipeline to send the right parameter value when calling your template
> * watch output for the different environments

## Create 2 variable groups for each environment you want to deploy to

First we will make sure that the variable groups we need with the variables for the service connection, resourcegroup name and environmenttype are ready.

1. In your browser navigate to **Pipelines** - **Library**.

1. Select **+ Variable Group**

1. Fill out _ToyWebsiteTest_ as name for the variable group.

1. Select **+ Add** 

1. As a name for the new variable fill out _ServiceConnectionName_ and as a value fill out _ToyWebsiteSC_

1. In the same manner create 2 new variables: 

- name: ResourceGroupName, value: ToyWebsiteTest
- name: EnvironmentType, value: Test

1. Select **Save** to save your changes.

1. Select **+ Variable Group**

1. Fill out _ToyWebsiteProd_ as name for the variable group.

> Note to John: we will need to double check the names we use here.
> Also, I was thinking of linking this second variable group to key vault, but not sure, since we are not really using secret values here. 

1. Select **+ Add** 

1. As a name for the new variable fill out _ServiceConnectionName_ and as a value fill out _ToyWebsiteSC_

1. In the same manner create 2 new variables: 

- name: ResourceGroupName, value: ToyWebsiteTest
- name: EnvironmentType, value: Production

1. Select **Save** to save your changes.

##	Update the pipeline template so it picks the correct variable group for each environment

Now that you have created 2 variable groups, you can use these in the pipeline template for each environment you want to deploy to.

1. In Visual Studio Code, open the **deploy-environment.yml** template file.

1. At the top of this file, add a parameter for the environment.

```YAML
parameters: 
- name: environment
  default: 'Test'
```

1. For each stage in the template, use this parameter to give all the stages a unique name. For instance the Validate stage: 

```YAML
- stage: Validate
```

    Will now be: 

```YAML
- stage: Validate${{parameters.environment}}
```

    Do this for all stages in the template. 

1. You may also want to update the displayName value of each stage in a similar way.

1. Update the appserviceAppHostName variable in the SmokeTest job to use the new name of the Deploy stage: 

```YAML
variables:
    appServiceAppHostName: $[ stageDependencies.Deploy${{parameters.environment}}.DeployWebsite.outputs['DeployWebsite.DeployBicepFile.appServiceAppHostName'] ]
```

1. Add a variables section beneath each stage, where you choose the correct variable group. For instance for the Validate stage this will be: 

```YAML
- stage: Validate${{parameters.environment}}
  variables: 
  - group: ToyWebsite${{parameters.environment}}
```

    Do this for all the stages in the file.

## Add a condition to the pipeline template to skip the what-if step for the pre-production environment.

We want to only run the Preview stage when deploying to the production environment.

1. Right above the Preview stage, add an if condition: 

```YAML
- ${{ if eq(parameters.env, 'Prod') }}:
```

1. Indent the full Preview stage block with 1 step. 

1. Your resulting template file should now look like this: 

```YAML
parameters: 
- name: environment
  default: 'Test'

stages: 
- stage: Validate${{parameters.environment}}
  variables: 
  - group: ToyWebsite${{parameters.environment}}
  displayName: Validate${{parameters.environment}}
  jobs:
  - job: ValidateBicepCode
    displayName: Validate Bicep code
    steps:
      - task: AzureCLI@2
        name: RunPreflightValidation
        displayName: Run preflight validation
        inputs:
          azureSubscription: $(ServiceConnectionName)
          scriptType: 'bash'
          scriptLocation: 'inlineScript'
          inlineScript: |
            az deployment group validate \
              --resource-group $(ResourcegroupName) \
              --template-file deploy/main.bicep \
              --parameters environmentType=$(EnvironmentType)

- ${{ if eq(parameters.env, 'Prod') }}:
  - stage: Preview${{parameters.environment}}
    variables: 
    - group: ToyWebsite${{parameters.environment}}
    displayName: Preview${{parameters.environment}}
    jobs: 
    - job: PreviewAzureChanges
      displayName: Preview Azure changes
      steps:
        - task: AzureCLI@2
          name: RunWhatIf
          displayName: Run what-if
          inputs:
            azureSubscription: $(ServiceConnectionName)
            scriptType: 'bash'
            scriptLocation: 'inlineScript'
            inlineScript: |
              az deployment group what-if \
                --resource-group $(ResourcegroupName) \
                --template-file deploy/main.bicep \
                --parameters environmentType=$(EnvironmentType)

- stage: Deploy${{parameters.environment}}
  variables: 
  - group: ToyWebsite${{parameters.environment}}
  displayName: Deploy${{parameters.environment}}
  jobs:
  - deployment: DeployWebsite
    displayName: Deploy Website
    environment: ${{parameters.environment}}
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
                    --resource-group $(ResourcegroupName) \
                    --template-file deploy/main.bicep \
                    --parameters environmentType=$(EnvironmentType))
                  appServiceAppHostName=$(echo $deploymentOutput | jq -r '.properties.outputs.appServiceAppHostName.value')
                  echo "##vso[task.setvariable variable=appServiceAppHostName;isOutput=true]$appServiceAppHostName"

- stage: SmokeTest${{parameters.environment}}
  variables: 
  - group: ToyWebsite${{parameters.environment}}
  displayName: SmokeTest${{parameters.environment}}
  jobs:
  - job: SmokeTest
    displayName: Smoke test
    variables:
      appServiceAppHostName: $[ stageDependencies.Deploy${{parameters.environment}}.DeployWebsite.outputs['DeployWebsite.DeployBicepFile.appServiceAppHostName'] ]
    steps:
      - task: PowerShell@2
        name: RunSmokeTests
        displayName: Run smoke tests
        inputs:
          targetType: inline
          script: |
            $container = New-PesterContainer `
              -Path 'deploy/Website.Tests.ps1' `
              -Data @{ HostName = '$(appServiceAppHostName)' }
            Invoke-Pester `
              -Container $container `
              -CI

      - task: PublishTestResults@2
        name: PublishTestResults
        displayName: Publish test results
        condition: always()
        inputs:
          testResultsFormat: NUnit
          testResultsFiles: 'testResults.xml'
```

> Note to John, best to double check the above with whatever pipeline we start from. 

## Update the pipeline to send the right parameter value when calling your template

Your template is now ready to handle variations in environments. You will now call this template twice in your pipeline with the right parameter values.

1. In visual Studio Code open the **azure-pipelines.yml** file.

1. Update the 1 template line with the below: 

```YAML
- template: deploy-environment.yml
  parameters:
    environment: Test
- template: deploy-environment.yml
  parameters:
    environment: Prod
```

> Note to John: The environment name now is 'Prod', probably want to change that in the template so it takes Website${{parameters.environment}}.

1. Commit and push your changes to your Git repository by using the following commands: 

   ```bash
   git add .
   git commit -m "Added pipeline template"
   git push
   ```

## Watch output for the different environments

1. In your browser, navigate to your pipeline runs.

1. You will notice that your pipeline is now running multiple stages one after the other for each environment: ValidateTest, DeployTest, SmokeTestTest, ValidateProd, PreviewProd, DeployProd, SmokeTestProd. Notice that there is no PreviewTest stage.

1. Navigate to the Test results of your run. You will notice that there are now 4 tests run. Since the Smoke test runs 2 tests and these now run for each environment, you get 4 test results. 

1. Navigate to your **Environments**.

1. Notice that each environment has a status message with the latest build ID of your pipeline. 

1. Select the WebsiteProd environment. It will show the job that deployed to this environment and the commit that is linked to this pipeline run. 

1. In your browser navigate to the Azure portal. 

1. Navigate the the **WebsiteProd** resource group. In the resource group open the App Service Plan.

1. Notice that the production app service plan is of type S1: Standard. This is a different type from the app service plan in your test environment which is a F1: Free plan.
