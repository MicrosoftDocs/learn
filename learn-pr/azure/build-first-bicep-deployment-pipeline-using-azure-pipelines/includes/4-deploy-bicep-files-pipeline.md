Now that you've created a basic pipeline, you're ready to configure it to deploy your Bicep files. In this unit, you'll learn how to deploy Bicep code from a pipeline, and how you can configure the deployment steps.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## Service connections

When you deploy a Bicep file from your own computer, you use the Azure CLI or Azure PowerShell. Before you can deploy your code, you need to sign in to Azure. Usually the tools ask you to enter your email address and password in a browser. After verifying your credentials, the tools know who you are and can verify that you have permission to deploy your Bicep file.

Because pipelines are run without any human present, they need to authenticate to Azure by using a service principal. A service principal's credentials consist of an _application ID_ and a secret, which is usually a key or a certificate. You use a _service connection_ in Azure Pipelines to securely store these credentials so that your pipeline can use them. A service connection also includes some other information to help your pipeline identify the Azure environment that you want to deploy to.

When you create a service connection, you give it a name. Steps refer to the service connection by using this name. That way, your pipeline YAML code doesn't contain any secret information.

When your pipeline starts, the agent that's running your deployment steps has access to the service connection, including its credentials. A pipeline step uses the credentials to sign in to Azure, just like you do yourself. Then, the actions that step takes uses the service principal's _identity_.

:::image type="content" source="../media/4-service-connection.png" alt-text="Diagram that shows a pipeline that includes an Azure deployment step, which accesses a service connection and then deploys to Azure." border="false":::

You need to ensure that your service principal has the permissions it needs to be able to execute your deployment steps. For example, you might need to assign the service principal the Contributor role for the resource group that it deploys your resources to.

> [!WARNING]
> It might seem like you can just store your service principal's credentials in your YAML file and log in using the `az login` command. You should never do this. Credentials in a YAML file are stored in clear text. Anyone who has access to your repository could take them. Even if you restrict access to your Azure DevOps organization and project, whenever someone clones your repository the YAML file holding the credentials will be on that person's computer. It's important to use a service credential whenever you work with Azure from a pipeline. Service connections also provide additional security and access control features.

Service connections are created within your Azure DevOps project. A single service connection can be shared by multiple pipelines. However, it's usually a good idea to set up a service connection, and the corresponding service principal, for each pipeline and each environment you deploy to. This helps to increase the security of your pipelines, and reduces the likelihood of accidentally deploying or configuring resources in a different environment than the one you expect.

You can also configure your service connection so that it's only allowed to be used in certain pipelines. For example, when you create a service connection that deploys to your website's production environment, it's a good idea to ensure that only your website's pipeline can use this service connection. This stops someone else accidentally using the same service connection for a different project, and potentially causing your production website to go down.

> [!TIP]
> You can even add more checks and approvals that need to be in place before a service connection can be used in a pipeline. You'll learn more about these capabilities in a future module.

## Deploy a Bicep file by using the Azure CLI task

One of the most useful built-in tasks for Azure Pipelines is the Azure CLI task. You use this task to execute one or more Azure CLI commands, including deploying a Bicep file.

> [!NOTE] 
> Azure Pipelines includes a task named _Azure Resource Group Deployment_. This can be used to deploy JSON ARM templates. However, it doesn't currently work with Bicep files.

Here's an example of how you can configure a step to use the Azure CLI task:

```yaml
- task: AzureCLI@2
  inputs:
    azureSubscription: 'MyServiceConnection'
    scriptType: 'bash'
    scriptLocation: 'inlineScript'
    inlineScript: |
      az deployment group create \
        --resource-group Example \
        --template-file deploy/main.bicep
```

Notice that the first line specifies `AzureCLI@2`. This tells Azure Pipelines that the task you want to use for this step is named `AzureCLI`, and you want to use version `2` of the task.

When you use the Azure CLI task, you specify a number of _inputs_ to instruct it what to do:

- `azureSubscription` specifies the name of the service connection to use.
- `scriptType` specifies the type of script you want to run the Azure CLI commands in. You can choose from multiple script types including Bash and PowerShell.
- `scriptLocation` is used to specify whether you want to run a script file stored in your repository, or an _inline script_ where you specify the Azure CLI commands inside the YAML file. In this module, we use inline scripts.
- `inlineScript` contains the Azure CLI commands to execute. The commands work just like they do when you run the Azure CLI from your own computer.

When the task starts, it uses the service connection to sign in to Azure, so by the time it runs the commands you specify, it's already authenticated. You don't need to run `az login`.

> [!NOTE]
> You might not have used the Azure CLI before. If you're used to PowerShell, that's OK. We use the Azure CLI task throughout this module because it provides a simple way to deploy a Bicep file.
> 
> In your own pipelines, you can use the _Azure PowerShell_ task instead, or you can even mix and match tasks and use both types of script.

## Variables

Often, your pipelines contain values that you want to keep separate from your YAML file. For example, when you deploy a Bicep file to a resource group, you need to specify the name of the resource group. The resource group name is probably different when you deploy to different environments. Additionally, you might need to provide parameters to your Bicep files, including secrets like database server passwords. You shouldn't store these in your pipeline YAML file or anywhere else in your Git repository. Instead, you should use _variables_.

### Create a variable

The Azure Pipelines web interface provides an editor for you to use to create variables for your pipeline:

:::image type="content" source="../media/4-new-variable.png" alt-text="Screenshot of the Azure DevOps interface that shows creating a new variable." border="true":::

You can tell Azure Pipelines that a variable's value is secret. When you do this, you can't view the value once you've set it. Also, Azure Pipelines will try to prevent the secret value from showing in your pipeline logs.

> [!WARNING]
> Azure Pipelines will obfuscate secret variable values in pipeline logs, but this is a best-effort process and you need to follow good practices as well. Your pipeline steps have access to all of the variable values, including secrets, so if your pipeline includes a step that insecurely handles a secure variable then Azure Pipelines might not be able to stop it.

You can also let users override variable values when they run your pipeline manually. The values they provide will only be used for that specific pipeline run. This can be useful when you're testing your pipeline.

### Use a variable in your pipeline

Once you've created a variable, you use a special syntax to refer to it within your pipeline's YAML file, like this:

:::code language="yaml" source="code/4-variables.yml" range="14-23" highlight="3, 8, 10" :::

Notice the Azure CLI command includes a special `$(VariableName)` syntax. You can refer to any variable by using this approach - whether it's secret or not.

> [!TIP]
> Notice that the template filename isn't stored in a variable. Just like Bicep parameters, you don't need to create variables for everything. It's a good idea to create variables for anything that might change between environments, and anything secret. Since the pipeline will always use the same template file, we don't need to create a variable for the path.

### System variables

Azure Pipelines also provides _system variables_. These contain predefined information that you might want to use in your pipeline, such as:

- `Build.BuildNumber`, which is the unique identifier for your pipeline run. Despite its name, it's often not a number - it's a string. You might use this variable to name your Azure deployment so that you can track the deployment back to the specific pipeline run that triggered it.
- `Agent.BuildDirectory`, which is the path on your agent machine's file system where your pipeline run's files are stored. This can be useful when you want to reference files on the build agent. 

### Create variables within your pipeline's YAML file

You can also set variable values in your pipeline's YAML file. You might do this when you have values that aren't secret, that you're happy to store in your repository, and where you want to keep them in one place in the file so you can refer to them throughout the pipeline definition. This approach also allows you to track changes to the variable in your version control system.

To set a variable in your YAML file, add a `variables` section:

:::code language="yaml" source="code/4-variables.yml" highlight="6-9" :::

The pipeline above defines three variables: `ServiceConnectionName`, `EnvironmentType`, and `ResourceGroupName`.

However, in this module, we create variables using the Azure Pipelines web interface.
