Now that you've created a first starter pipeline, you are ready to add a task to it to deploy your Bicep templates. In this unit you'll learn how to deploy your Bicep templates from your pipeline, and how you can configure the deployment steps.

## Using a script task for Bicep commands

When using Azure DevOps Microsoft hosted agents, you will find that all the bicep tooling is already installed on the agent machine. This means you can run a script task using the bicep command: 

```YAML
  - script: |
      bicep --version
```

The above example will print out for you the bicep version that is being used by the agent nachine. 

However, since the Bicep language and tooling still tends to change quite often, it might be that the agent machine you are using is running an outdated version of the Bicep tooling. In case you want to make sure you are always using the latest available bicep tooling on your agent machine, it makes sense to start your pipeline with a first step that upgrades the Bicep tooling to the latest version: 

```YAML
  - script: |
      bicep --version
      az bicep upgrade
      bicep --version
```

The above example will upgrade the bicep tooling on the agent machine to the latest version. When you run this task the output will show you the version that's installed, it will perform the upgrade and then show you the potentially new version. 

Even though the script task can also be used to run Azure CLI statements that deploy a Bicep template to Azure, it is not the best choice for doing this. There is a better task that is specifically made for running Azure CLI commands against your Azure environment and that's the Azure CLI task which we'll look at next. 


## Deploying Bicep templates with an Azure CLI task

The task type you can use to deploy a Bicep template is the Azure CLI task. This task makes use of a `service connection` you can configure in Azure DevOps. The service connection wraps your service principal, and will be used to create the connection from your Azure DevOps agent to your Azure environment. On top of this the Azure CLI task handles the login process to Azure for you, so you can focus on just the deployment statements you want to execute. 

```YAML
  - task: AzureCLI@2
    inputs:
      azureSubscription: 'ServiceConnectionName'
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: 'az deployment group create --resource-group exampleRG --template-file deploy/main.bicep'
```

This task uses the following parameters: 

- `azureSubscription`: This is the name of the Service Connection you created in Azure DevOps. Later in this module you will learn how to create a service connection.
- `scriptType`: This can be bash, batch, ps or pscore. When running on a Linux agent machine you can use bash and pscore. When you run on a Windows machine you can use batch, ps and pscore. 
- `scriptLocation`: Indicates where your script can be found. In this case we indicate the script can be found inline. In that case you use the next inlineScript parameter and provide your script statements. The other option is scriptPath. In that case you provide a path to a file containing the script you want to execute.
- `inlineScript`: The script you want to execute. 


> [!Note] 
> There also exists a [ARM template deployment](https://github.com/microsoft/azure-pipelines-tasks/blob/master/Tasks/AzureResourceManagerTemplateDeploymentV3/README.md) task you can use to deploy ARM json templates. However, at the time of this writing this task does not allow for usage of ARM Bicep files yet. 

> [!Note]
> There also exists an [Azure PowerShell](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-powershell?view=azure-devops) task that acts similar to the Azure CLI task. For this module we opted for simplicity and only included the Azure CLI task. However in a pipeline you can mix and match tasks, so feel free to use the Azure PowerShell task if you prefer that. 

## Create a service connection

The above described task already makes use of a service connection, by referring to the name of the service connection. 

A service connection can be used for securely connecting to external resources and remote services your pipeline might need. You Azure subscription is one of these external resources. A service connection will provide a secure way to store the credentials for these external resources. When you create a pipeline, you reference the service connection by its name. The service connection will make it possible for your pipeline to connect to the external resource on your behalf, without you needing to add any credentials to the YAML pipeline file. 

> [!Important]
> If you don't use a service connection, you will need to somehow add your credentials to your YAML file. This is a bad practice, since they will be there in clear text for anyone to see and grab. And even though you can lock down your Azure DevOps organization and project from a security perspective, once someone clones your repository, the YAML file holding the credentials will be on that persons' computer. Which makes it easy for them to copy and share. 
> Using a service connection is a secure option for connecting to external resources, where credentials are stored and no longer accessible. 

For connecting to Azure as an external resource, the service connection will make use of a service principal, which we already covered in a previous module. Other types of service connections might use other ways of connecting. 

A service connection can be shared by multiple pipelines, however, it is a common practice to set up a service connection and a corresponding service principal on a per pipeline and per environment basis. This is a way of separating different concerns and increasing the security of your pipelines and environments. You want to scope the service connection and service principal specifically to the environment you are deploying to. 

> [!Note]
> You can lock down your service connection to be used only by specific pipelines. For instance for deployments to production you want to limit the use of your service connection. Additionaly you can add extra checks and approvals to your service connection before it gets used in a pipeline. We will further cover these possibilities in a later module.  


## Variables

When working with YAML pipelines there are also certain values you may want to keep separate from your pipeline's YAML file. For example, you might have information that changes in different environments, like the name of the resource group or the Azure subscription ID to deploy to, or you might have secure parameter values that shouldn't be stored in your Git repository. For these situations, you can make use of _variables_. Variables are reusable values.

### Types of variables

In YAML pipelines, you can set variables at the root, and job level. This will indicate the scope of the variable. A variable defined at the root of your pipeline can be used throughout your YAML pipeline. A variable defined at job level will only be available within that specific job. 

You can also specify variables outside of a YAML pipeline in the UI. These variables are also available in the entire pipeline. 

Variables that you define and set yourself are called `user-defined variables`. Azure DevOps also has `system variables`. These are pre-defined variables that you can use in your pipeline. A couple of examples of these system variables: 

- `Build.BuildNumber`: A unique number that identifies your pipeline run. This variable is often used as a tag. For a Bicep deployment for instance you could use this variable to name your deployment in Azure. That way you can track back the deployment to a specific pipeline run. 
- `Agent.BuildDirectory`: The local path on your agent machine where all folders for your pipeline get created. This can be handy when you want to reference certain files on the build agent. 

There are more predefined variables than the ones listed above. We pointed out a couple that might be handy for your Bicep deployments. 

### Defining and using variables in YAML pipelines

In the most common case you will set and use your variables in a YAML file. This allows you to track changes to the variable in your version control system.

Here is an example of setting and using variables in a YAML pipeline: 

```YAML
variables:
  serviceConnection: 'ToywebsiteSC'
  resourcegroup: 'ToyWebsite' 

trigger: none

pool:
  vmImage: ubuntu-latest

jobs:
- job: 
  variables:
    environment: 'Test'
  steps:
  - task: AzureCLI@2
    inputs:
      azureSubscription: $(serviceConnection)
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: 'az deployment group create --resource-group $(resourcegroup) --template-file deploy/main.bicep -p environmentType=$(environment)'
```

This pipeline contains 3 variables, one for the name of the service connection, and one for the resource group, defined at the root level of the pipeline. These 2 variables are available in the full pipeline. The third variable is scoped at the job level and is called 'environment'. You are free in how you name your variables. All 3 variables are used in the task. You reference them by $() syntax, which is the macro syntax.

By using variables, you can avoid hardcoding values in our pipeline and it is a good practice to use them. You get a single place where you can change the value if need be.

### Defining variables in the UI

When you create your variables through the Azure DevOps UI, you get a couple of extra possibilities. These variables will also be available for your entire pipeline and are used in exactly the same way as variables you define in your YAML file. 

You can also make these variables defined in the UI secret. This will obfuscate the value of this variable in your pipeline runs. However, beware, you could still output the value of the secret value with a script and echo statement, so it is not completely secure. This is also the reason why it is better to use a service connection in a pipeline than to put your service principal password in a secret variable and perform the Azure login process yourself. 

Variables you define through the DevOps UI can also be overwritten for a specific run. This might be handy if you want to run your pipeline with different values. In our example, you might for instance want to deploy to a different resource group with a different service connection.

The variables that you create through the UI can be used in your pipeline in exactly the same way as variables you created in YAML. If you define the variables of the previous example through the UI, the YAML file would look like this: 

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
      inlineScript: 'az deployment group create --resource-group $(resourcegroup) --template-file deploy/main.bicep -p environmentType=$(environment)'
```

You now only use the variables in the task. Since they are defined in the Azure DevOps UI they are no longer part of the YAML file. 
