Now that you've created a basic workflow, you're ready to set up the workflow to deploy your Bicep files. In this unit, you'll learn how to deploy Bicep code from a workflow and how to set up the deployment steps.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## Check out your code

Your Bicep files are stored in your Git repository. In GitHub Actions, you need to explicitly tell the workflow to check out the files from your Git repository. Otherwise, your workflow won't have access to the files. This step is usually the first thing your job does.

To check out your code, you can use the `actions/checkout@v2` action:

:::code language="yaml" source="code/4-workflow.yml" range="1-2, 9-15" highlight="7-9":::

Notice that the workflow includes the `uses` keyword. This indicates you want to use a pre-defined action named `actions/checkout`.

Like Bicep resources, actions are always versioned. In this case the workflow uses version 2, so `@v2` is appended to the action name.

After the workflow includes this action, your repository's code will be checked out onto the runner's file system. You specify the path the files should be stored in by using the `path` parameter.

## GitHub secrets

When you deploy a Bicep file from your own computer, you use the Azure CLI or Azure PowerShell. Before you can deploy your code, you sign in to Azure. Usually, the tools ask you to enter your email address and password in a browser. After your credentials are verified, your permissions to deploy resources are confirmed and you can use the tools to deploy your Bicep file.

Deployment by workflow requires authentication, too. Because workflows run without human intervention, workflows authenticate to Azure by using a service principal. A service principal's credentials consist of an *application ID* and a secret, which usually is a key or a certificate. In GitHub Actions, you use a *secret* to securely store these credentials so that your workflow can use them.

> [!TIP]
> In this module, you'll create a service principal for your workflow to use. The module [Authenticate your Azure deployment pipeline by using service principals](xref:learn.azure.authenticate-azure-deployment-pipeline-service-principals) provides a more detailed explanation of service principals including how they work, as well as how you create them, assign them roles, and manage them.

When you create a secret, you give it a name. Steps refer to the secret by using this name, so your workflow YAML code doesn't need to contain secret information. GitHub encrypts the secret values before storing them.

When your workflow starts, the runner that's running your deployment steps has access to the secret value. A workflow step uses the credentials to sign in to Azure, just like you sign in yourself. Then, the steps that are defined in the workflow use the service principal's *identity*.

:::image type="content" source="../media/4-secret.png" alt-text="Diagram that shows a workflow that includes an Azure deployment step, which accesses a secret and then deploys to Azure." border="false":::

You must ensure that your service principal has the permissions it needs to execute your deployment steps. For example, you might need to assign the service principal the Contributor role for the resource group it deploys your resources to.

> [!WARNING]
> It might seem easier to store your service principal's credentials in your YAML file, and then sign in by using the `az login` command. You should never use this approach to authenticate your service principal. Credentials in a YAML file are stored in clear text. Anyone who has access to your repository can see and use the credentials. Even if you restrict access to your GitHub reposistory, whenever someone clones your repository, the YAML file that holds the credentials will be on that person's computer. It's important to use a secret whenever you work with Azure from a GitHub Actions workflow. Secrets also provide other security and access control features.

Secrets are created in your GitHub repository settings. A secret is available to all of the workflows in the repository. In a later module, you'll learn about _environments_, which enable you to restrict the use of secrets to deployments to a specific environment. 

### Use a secret in your workflow

To refer to a secret value in your workflow, use the following syntax:

```yaml
${{ secrets.NAME_OF_THE_SECRET }}
```

When your workflow starts, the runner that's running your deployment steps has access to the decrypted GitHub secret value. GitHub Actions is designed to not reveal secret values in your workflow logs.

[!include[Best-effort protection for secrets](../../includes/github-actions-secret-best-effort.md)]

You can also use GitHub secrets to store other kinds of secret values your workflows might need. For instance a database password can be created as a GitHub secret, and then provided to your Bicep file by using a secure parameter. 

## Sign in to Azure

Before your workflow can execute commands against your Azure environment, it first needs to sign in. There is an action named `azure/login` that handles the sign-in process. The action uses a GitHub secret to get the credentials for your service principal:

:::code language="yaml" source="code/4-workflow.yml" range="1-2, 9-18" highlight="10-12":::

The `azure/login` action has a `creds` parameter to specify the Azure credentials to use when signing in. In this example, the workflow uses the `AZURE_CREDENTIALS` secret value as the credentials.

After this action has executed, your runner will be authenticated and able to run statements against your Azure environment. 

## Deploy your Bicep file

After you've signed in to Azure, you can use the service principal's identity to run the Bicep deployment. In GitHub Actions, you use the `azure/arm-deploy` action to initiate a Bicep deployment.

> [!NOTE] 
> There are other ways you can deploy Bicep files from GitHub Actions. For example, you can use the `azure/CLI` action and then provide Azure CLI commands to run your deployments. However, since the `azure/arm-deploy` task is specifically designed for deployments, you'll use that in this module.

Here's an example of how you can configure a step to use the `azure/arm-deploy` action:

:::code language="yaml" source="code/4-workflow.yml" range="1-2, 9-23" highlight="13-17":::

The `azure/arm-deploy` action accepts several parameters, including:

- `resourceGroupName`. This indicates the name of the resource group that you want to deploy the Bicep file to.
- `template`. This is the path to the Bicep file in your repository. The path is relative to the repository's root.
- `parameters`. This indicates any parameter values you provide at deployment time. In this example, we provide a value for the _environmentType_ parameter.

Because the previous `azure/login` action already signed your workflow in to Azure, the `azure/arm-deploy` step executes on an authenticated runner.

## Variables

Often, your workflows contain values that you want to reuse in multiple places in your workflow file. You might also want to store these values at the top of the workflow file for easy reference, and to be able to change the values easily. In your workflow the variables you define will be surfaced as environment variables. To define reusable values, use *variables*.

### Create a variable

You can create variables at different levels in your workflow file. However, if you want them to be available for your whole workflow file, you define them near the top of the file, just below your `on` statement. To define your variables you use the `env` parameter:

```yaml
env:
    AZURE_RESOURCEGROUP_NAME: gh-actions
    AZURE_WEBAPP_NAME: webapp-gh-actions
    SQLADMIN_LOGIN: ${{ secrets.SQLADMIN_LOGIN  }}
    SQLADMIN_PASS: ${{ secrets.SQLADMIN_PASS  }}
```

In the above example, we specify four environment variables. Two of them are set to the values of decrypted GitHub secrets. 

### Use a variable in your workflow

After you've created a variable, you use a special syntax to refer to it within your workflow's YAML file, like this:

```yaml
${{ env.AZURE_RESOURCEGROUP_NAME }}
```

Notice that it's similar to referring to a secret value, but instead of `secret.` you use `env.`

> [!TIP]
> Just like Bicep parameters, you don't need to create variables for everything. It's a good idea to create variables for anything that might change between environments, and GitHub secrets for anything that is secret. Because the workflow will always use the same template file, you don't need to create a variable for the path.

### Default environment variables

GitHub Actions also uses *default environment variables*. Default environment variables contain predefined information you might want to use in your workflow. Here are some of the default environment variables you can use in your workflow:

- `github.sha`: The identifier of the Git commit that triggered the workflow to execute.
- `github.run_number`: A unique number for each run of a particular workflow in a repository. This number begins at 1 for the workflow's first run, and increments with each new run. You might use this variable to name your Azure deployment, so you can track the deployment back to the specific workflow run that triggered it.
   > [!NOTE]
   > In GitHub Actions, you can re-execute a workflow run. When you do this, the run number doesn't change. So, you shouldn't use the `github.run_number` variable to count how many times your workflow has executed.
