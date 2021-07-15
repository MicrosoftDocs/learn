Now that you've created a basic pipeline, you're ready to configure it to deploy your Bicep templates. In this unit you'll learn how to deploy your Bicep templates from your pipeline, and how you can configure the deployment steps.

## Create a service connection

As you learned previously, a pipeline uses a service connection to store the service principal credentials securely. 

> [!WARNING]
> You might be tempted to store your service principal's credentials in your YAML file and log in using the `az login` command. You should never do this. Credentials in a YAML file will be stored in clear text. Anyone who has access to your repository could take them. Even though you can restrict access to your Azure DevOps organization and project, whenever someone clones your repository the YAML file holding the credentials will be on that person's computer. It's important to use a service credential whenever you work with Azure from a pipeline.

Service connections are created within your Azure DevOps project. A single service connection can be shared by multiple pipelines. However, it's usually a good iea to set up a service connection, and the corresponding service principal, for each pipeline and each environment you deploy to. This helps to increase the security of your pipelines, and reduces the likelihood of you accidentally deploying or configuring resources in a different environment than the one you expect.

You can also configure your service connection so that it's only used by certain pipelines. For example, when you create a service connection that deploys to your website's production environment, it's a good idea to ensure that only your website's pipeline can use this service connection. You can even add more checks and approvals that need to be in place before a service connection can be used in a pipeline. You'll learn more about this in a future module.

## Deploy a Bicep file by using the Azure CLI task

One of the most useful built-in tasks for Azure Pipelines is the Azure CLI task. You use this task to execute one or more Azure CLI commands, including deploying a Bicep file.

> [!NOTE] 
> Azure Pipelines includes a task named _ARM Template Deployment_. This can be used to deploy JSON ARM templates. However, it doesn't currently work with Bicep files.

Here's an example of how you can configure a step to use the Azure CLI task:

```YAML
  - task: AzureCLI@2
    inputs:
      azureSubscription: 'MyServiceConnection'
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: 'az deployment group create --resource-group Example --template-file deploy/main.bicep'
```

Notice that the first line specifies `AzureCLI@2`. This tells Azure Pipelines that the task you want to use for this step is named `AzureCLI`, and you want to use version `2`.

When you use the Azure CLI task, you specify a number of _parameters_ to instruct it what to do:

- `azureSubscription` specifies the name of a service connection. You'll learn how to create these soon.
- `scriptType` specifies the type of script you want to run the Azure CLI commands in. You can choose from multiple script types including Bash and PowerShell.
- `scriptLocation` is used to specify whether you want to run a script file or just to run an _inline script_, where you specify the Azure CLI commands inside the YAML file. In this module, we use `inlineScript`.
- `inlineScript` contains the Azure CLI commands to execute. The commands work just like they do when you run the Azure CLI from your own computer.

When the task starts, it uses the service connection to sign in to Azure, so by the time it runs the commands you specify, it's already authenticated. You don't need to run `az login`.

> [!NOTE]
> You might not have used the Azure CLI before. If you're used to PowerShell, that's OK. We use the Azure CLI task throughout this module because it provides a simple way to deploy a Bicep file.
> 
> In your own pipelines, you could use the _Azure PowerShell_ task instead, or you can even mix and match tasks and use both types of script.

## Variables

Often, your pipelines contain values that you want to keep separate from your YAML file. For example, when you deploy a Bicep file to a resource group, you need to specify the name of the resource group. The resource group name might change when you deploy to different environments. Additionally, you might need to provide parameters to your Bicep files, including secrets like database server passwords. You shouldn't store these in your pipeline YAML file or anywhere else in your Git repository. Instead, you should use _variables_.

### Create a variable

The Azure Pipelines web interface provides an editor for you to use to create variables for your pipeline:

:::image type="content" source="../media/4-new-variable.png" alt-text="Screenshot of the Azure DevOps interface that shows creating a new variable." border="true":::

When you create a variable, you can tell Azure Pipelines that the the variables contain secret values. When you do this, you won't be able to view the values once you've set them. Also, Azure Pipelines will try to prevent the values from showing in your pipeline logs.

> [!WARNING]
> Azure Pipelines will obfuscate the variable values, but this is a best-effort process and you need to follow good practices as well. Your pipeline steps will have access to all of the variables, including secrets, so if your pipeline includes a step that insecurely handles a secure variable then Azure Pipelines might not be able to stop it.

You can also let users override variable values when they run your pipeline manually. The values they provide will only be used for that specific pipeline run. This can be useful when you're testing your pipeline.

### Use a variable in your pipeline

Once you've created a variable, you use a special syntax to refer to it within your pipeline's YAML file, like this:

:::code language="yaml" source="code/4-use-variables.yaml" highlight="14" :::

Notice the Azure CLI command includes a special `$(VariableName)` syntax. You can refer to any variable by using this approach - whether it's secret or not.

### System variables

Azure Pipelines also provides _system variables_. These contain predefined information that you might want to use in your pipeline, such as:

- `Build.BuildNumber`, which is a unique number that identifies your pipeline run. Sometimes, you might use this variable to name your deployment. That way you can track back the deployment to a specific pipeline run.
- `Agent.BuildDirectory`, which is the path on your agent machine's file system where your pipeline run's files are stored. This can be useful when you want to reference files on the build agent. 

### Create variables within your pipeline's YAML file

You can also specify variables in your pipeline's YAML file. You might do this when you have values that aren't secret, that you're happy to store in your repository, and where you want to keep them in one place in the file so you can refer to them throughout the pipeline definition. This approach also allows you to track changes to the variable in your version control system.

When you define variables in your YAML file, you can define them at different _scopes_. For example, you can define a variable at the root scope, which means its value can be used throughout your YAML pipeline. You can also scope a variable to a single job, and it won't be accessible outside of that job. If the same variable is defined in multiple scopes, the value from the most specific scope will be used.

:::code language="yaml" source="code/4-yaml-variables.yaml" highlight="6-8, 12-13" :::

This pipeline contains three variables. `ServiceConnectionName` and `EnvironmentType` are defined at the root level of the pipeline. The `ResourceGroupName` variable is scoped to the job.
