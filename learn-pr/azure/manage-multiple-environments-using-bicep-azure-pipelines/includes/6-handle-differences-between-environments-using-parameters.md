_Pipeline templates_ help you to handle repetition in pipelines. However, with repetition might also come small variations. Parameters will help you in handling these differences between environments, both in your pipeline templates, but also in your Bicep templates. 

## Handle differences between environments by using parameters in your Bicep template

The first part where differences in deployments between environments might pop up is when deploying resources from your Bicep template to your Azure environment. It might be that in a test environment you want to deploy a smaller, less expensive version of a resources, whereas in production you want to deploy a bigger version with better performance. Or it might be that you need to comply to a certain naming convention, where the name of a resource contains the environment it is deployed to. 

An example might be that in your test environment you want to deploy a F1 sku of app services, and name the website ToyWebsite-tst. Where in production you want to use the S1 sku of app services, and name the website ToyWebsite-prd.

To make these differences across environments possible in your Bicep template, you can make use of parameters. Parameters let the users of your template input alternative values. You define a parameter in your Bicep template like this: 

```YAML
@description('The environment you want to deploy to. This parameter should have a value of dev, tst or prd.')
@allowed([
  'dev'
  'tst'
  'prd'
])
param environmentName string = 'dev'
```

The above parameter definition has the following parts: 

- _description_ this is a human readable description of your parameter.
- _allowed_ indicates the possible values this parameter is allowed to have. In this case 'dev', 'tst' and 'prd' are the only values allowed.
- _param_ indicates to Bicep that you are declaring a parameter.
- _environmentName_ the name of this parameter.
- _string_ the type of this parameter. Other possible types are _int_, _bool_, _object_ and _array_.
- _= 'dev'_ the default value of this parameter in case no value is provided. 

When executing a Bicep deployment with 'az deployment group create' you can indicate an alternative value for each parameter in the Bicep file: 

```CLI
az deployment group create --resource-group the-resource-group --template-file deploy/main.bicep --parameters environmentType=tst
```

You can also provide a parameters file with the values you want to use for the parameters. A parameter file is a file in JSON format that indicates the parameter values you want to use for each environment. In our example you could have a parameter file parameters.tst.json: 

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environmentName": {
      "value": "tst"
    }
  }
}
```

And a parameters.prd.json file: 

```JSON
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "environmentName": {
      "value": "prd"
    }
  }
}
```

When deploying your Bicep template you use one of these parameter files: 

```CLI
az deployment group create --resource-group the-resource-group --template-file deploy/main.bicep --parameters parameters.prd.json
```

> [!WARNING]
> Beware when you need to pass secure values to parameters in a Bicep file. It is not safe to use a parameters file for these, since there is no way to obfuscate the secure value in the parameters file. You can however use other means to pass in the value for such a parameter, which we will handle in the next sections. 

## Handle differences between environments by using parameters in your pipeline templates

Once you use pipeline templates to abstract the similarities between environments, here as well you would like to indicate certain differences across environments. Pipeline templates also know the concept of parameters, which allow you to add variation. You indicate the parameters for a pipeline template at the top of your template file: 

```YAML
parameters: 
- name: environment
  type: string
  default: 'dev'
- name: serviceConnection
  type: string
  default: 'ServiceConnectionName'
- name: resourceGroupName
  type: string
  default: 'ToyWebsite'
```

When defining a parameter you need to indicate the _name_ of the parameter, it's _type_ and a _default_ value. You can define as many of these parameters at the top of your pipeline template as you need. The different possible types for pipeline template parameters are: 

- _string_ a string value
- _number_ a numeric value
- _boolean_ a _true_ or _false_ value
- _object_ any YAML structure 
- _step_ a single pipeline step
- _stepList_ a sequence of steps
- _job_ a single job
- _jobList_ a sequence of jobs
- _deployment_ a single deployment job
- _deploymentList_ a sequence of deployment jobs
- _stage_ a single stage
- _stageList_ a sequence of stages

As you can see from the above list, it is also possible to use steps, jobs, deployments and stages as parameter in a pipeline template. This makes for some quite complex structures you can set up. 

Using a parameter can be done by using the _${{parameters.parametername}}_ syntax, like in this example: 

```YAML
stages:
- stage: Deploy${{parameters.environment}}
  jobs: 
  - job: Deploy${{parameters.environment}}
    steps:
      - task: AzureCLI@2
        name: Deploy
        inputs:
          azureSubscription: ${{parameters.serviceConnection}}
          scriptType: 'bash'
          scriptLocation: 'inlineScript'
          inlineScript: |
            az deployment group what-if \
              --resource-group ${{parameters.resourceGroupName}} \
              --template-file deploy/main.bicep \
              --parameters environmentType=${{parameters.environment}}
```

The _${{parameters.environment}}_ parameter is used 3 times in this sample. Once to use it as part of the stage name, once to use it as part of the job name and once to pass it in for the Bicep template deployment. Using a parameter in this way to name your stages and jobs, makes that you can use stage and job names in your pipeline template file. The template can now be included multiple times in your pipeline. 

Passing parameters to a pipeline template can be done like this: 

```YAML
- template: deploy-environment.yml
  parameters:
    environment: tst
    serviceConnection: ServiceConnectionNameTst
    resourceGroupName: ToyWebsiteTst
- template: deploy-environment.yml
  parameters: 
    environment: prd
    serviceConnection: ServiceConnectionNamePrd
    resourceGroupName: ToyWebsitePrd
```

## The approaches you can use to specify parameters, with their pros and cons

The above way of passing parameters to a pipeline template is easy to do, however it will not be suitable in all cases. Suppose you want to pass secure values to the pipeline template, the above way of passing that value will be in clear text, which is not suitable for secure values. Or suppose you want to have certain values that need to be passed at multiple places, but you want to define the value only once, so you can easily update it in case you need to. There are a couple of ways in which you can pass parameter values to pipeline templates or in which you can use values in your pipelines. 

### Parameter files

We already mentioned parameter files as one way to pass parameters to a Bicep template. This is a good way of passing parameter values that are not secure values. You indicate all values in the parameter file and you can even vary which parameter file to use when calling a pipeline template: 

```YAML
# deploy-environment.yml file
parameters: 
- name: parameterfile
  type: string
- name: serviceConnection
  type: string
  default: 'ServiceConnectionName'
- name: resourceGroupName
  type: string
  default: 'ToyWebsite'

stages:
- stage: 
  jobs: 
  - job: 
    steps:
      - task: AzureCLI@2
        name: Deploy
        inputs:
          azureSubscription: ${{parameters.serviceConnection}}
          scriptType: 'bash'
          scriptLocation: 'inlineScript'
          inlineScript: |
            az deployment group what-if \
              --resource-group ${{parameters.resourceGroupName}} \
              --template-file deploy/main.bicep \
              --parameters ${{parameters.parameterfile}}
```

```YAML
- template: deploy-environment-.yml
  parameters:
    parameterfile: parameters.tst.json
    serviceConnection: ServiceConnectionNameTst
    resourceGroupName: ToyWebsiteTst
- template: deploy-environment-.yml
  parameters:
    parameterfile: parameters.prd.json
    serviceConnection: ServiceConnectionNamePrd
    resourceGroupName: ToyWebsitePrd
```

The advantage of using this approach is that neither your pipeline template, neither your main pipeline YAML file are polluted with a whole list of parameters that need to be passed one by one. All parameters are nicely grouped in your parameter JSON file. The parameter files are also part of your coding repository, so they can get versioned in the same way as all your other code. 

A disadvantage of this approach is that it can't be used for secure values. 

### Pipeline variables 

If you need to pass secure values, like a database password in your pipeline templates and to your Bicep template, a first approach you can use is by utilizing pipeline variables and by marking the variable as secure. This will obfuscate the variable value in your pipeline logs. You add a secure pipeline variable in the Azure DevOps UI. You could for instance have the following pipeline variables: 

- _ServiceConnectionTst_, not secure, value: ToyWebsiteSC
- _resourceGroupNameTst_, not secure, value: ToyWebsiteTst
- _parameterfileTst_, not secure, value: parameters.tst.json
- _databasePasswordTst_, secure, value: abc1234!
- _ServiceConnectionPrd_, not secure, value: ToyWebsitePrdSC
- _resourceGroupNamePrd_, not secure, value: ToyWebsitePrd
- _parameterfilePrd_, not secure, value: parameters.prd.json
- _databasePasswordPrd_, secure, value: abc1234!_more_secure

You can now use these variables when you use your pipeline templates: 

```YAML
- template: deploy-environment-.yml
  parameters:
    parameterfile: $(parameterfileTst)
    serviceConnection: $(ServiceConnectionTst)
    resourceGroupName: $(resourceGroupNameTst)
    databasePassword: $(databasePasswordTst)
- template: deploy-environment-.yml
  parameters:
    parameterfile: $(parameterfilePrd)
    serviceConnection: $(ServiceConnectionPrd)
    resourceGroupName: $(resourceGroupNamePrd)
    databasePassword: $(databasePasswordPrd)
```

Usage of these parameters in the pipeline template itself is similar to how they were used before:

```YAML
# deploy-environment.yml file
parameters: 
- name: parameterfile
  type: string
- name: serviceConnection
  type: string
  default: 'ServiceConnectionName'
- name: resourceGroupName
  type: string
  default: 'ToyWebsite'
- name: databasePassword
  type: string

stages:
- stage: 
  jobs: 
  - job: 
    steps:
      - task: AzureCLI@2
        name: Deploy
        inputs:
          azureSubscription: ${{parameters.serviceConnection}}
          scriptType: 'bash'
          scriptLocation: 'inlineScript'
          inlineScript: |
            az deployment group what-if \
              --resource-group ${{parameters.resourceGroupName}} \
              --template-file deploy/main.bicep \
              --parameters ${{parameters.parameterfile}} \
              --parameters dbPass=${{parameters.databasePassword}}
```

Advantage of this approach is that it can be used for secure values you may want to pass. As you can see in the above sample, this can be combined with a parameter file. 

However, beware that with this approach, it won't keep anyone from writing out a secure value in a script step in your pipeline to a file. You will need to trust whoever is providing you with the pipeline templates to make proper usage of secure values.

### Variable groups

A special type of variable you can use in a pipeline or in a pipeline template, is a _variable group_. A variable group gets defined in the Azure DevOps UI, in the Library menu and, as the name implies, it groups a couple of variables. The big advantage of variable groups is that they can be reused across multiple pipelines. They can also be used to store secure values. 

Suppose you have defined a variable group and named it _ToyWebsiteTst_ and you add variables to it named _EnvironmentType_, _ServiceConnectionName_ and _ResourcegroupName_. You can now refer to this variable group at the top of your pipeline.

```YAML
variables: 
- group: ToyWebsiteTst
- name: additionalVariable
  value: somevalue
```

In the above sample we also define an extra variable _additionalVariable_ with a value of _somevalue_ to show that you can combine variable groups and regular variables in a pipeline. 

Further down your pipeline you can now use the _EnvironmentType_, _ServiceConnectionName_ and _ResourcegroupName_ variables: 

```YAML
stages: 
- stage: Validate
  displayName: Validate
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
```

In case you have different variables for your Test and Production environment, you could create 2 variable groups, named _ToyWebsiteTst_ and _ToyWebsitePrd_. In each of these variable groups you add the same keys, but with different values for each environment. When you use pipeline templates, you can now use a parameter in the template to choose a specific variable group. In this case the variable group needs to be added in each stage in the pipeline template: 

```YAML
#deploy-environment.yml
parameters: 
- name: environment
  default: 'Tst'

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
              --parameters environmentType=$(environmentType)
```
As you can see in the above sample the variable group is chosen based on the environment parameter. The pipeline calling this template can now look like this: 

```YAML
trigger:
  branches:
    include:
    - main

pool:
  vmImage: ubuntu-latest

stages:
- template: deploy-environment.yml
  parameters:
    environment: Tst
- template: deploy-environment.yml
  parameters:
    environment: Prd
```

### Key Vault variable groups

An additional feature of variable groups, is that you can link them to an Azure Key Vault. All keys that exist in the Key Vault that you link will become available as variables in the variable group and can as such be used in your pipelines. 

This way of linking a variable group to an Azure Key Vault will make the management of your secret values more secure. It can also be managed by a separate security team. 

### Try and make variables obsolete

And although there are multiple ways to add variables to your pipeline, you should always try and use as few variables as possible in your pipeline. Since every variable or parameter that you add is a potential additional point of exposure of information. 

In a lot of cases these values are needed when certain resources need to connect to other resources. Let us take the example of an Azure web app that needs to connect to its backend Azure SQL database. For this connectivity you need a connection string, which contains the username and password for the database. However, when setting up this type of connectivity, other options are possible: 

> Note to John: would be great if we could get pictures for these 3 situations and add them for clarity. 

- You could add the connection string that the web app needs to an Azure Key Vault. Next you give the web app list and read access to that Key Vault. When you set it up like this, your pipeline has no need anymore for the connection string, the web app itself can fetch it directly from the Key Vault, without any developers seeing any secret values. 
- When connecting a web app to a backend Azure SQL database, you can also make use of a managed identity. This is an identity that is managed by Azure Active Directory and that you assign to your web app. This identity you then give access to your database. Once this is done, you can simplify your connection string and remove any username and password values. These values then also don't need to be part of your pipeline code. A managed identity is the safest option for this type of connectivity. 

## Conditions and how you can switch on/off tasks for an environment based on a variable or parameter

An additional feature you can use in your pipelines and pipeline templates is the ability to add conditions in your pipeline. Suppose in your test environment you want to run the same deployment stages as for your production environment, but you want to skip a certain stage. For instance you only want to run the what-if stage for your production environment. In the below example we add a condition that checks for the value of the environment parameter and only when it has a value of 'Prod' will we run the Preview stage: 

```YAML
parameters: 
- name: environment
  default: 'PreProd'

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
# rest of the pipeline omitted for brevity
```

Do note the extra indentation on the Preview stage. 

When you run the above pipeline, you will notice the following stages in the pipeline run: ValidateTst, DeployTst, SmokeTestTst, ValidatePrd, PreviewPrd, DeployPrd, SmokeTestPrd. So there will be no PreviewTst. 

> [!NOTE]
> Even though conditionals can be a powerful construct, beware to not use too many of them. They will also complicate your pipeline. When you see a lot of them being used in your pipeline template, it might be a code smell that a template might not be the best solution for the workflow you plan to run. 

