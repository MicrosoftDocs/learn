Now that you've created a basic workflow, you're ready to configure it to deploy your Bicep files. In this unit you'll learn how to deploy Bicep code from a workflow, and how you can configure the deployment steps.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## GitHub secrets

When you deploy a Bicep file from your own computer, you use the Azure CLI or Azure PowerShell. Before you can deploy your code, you need to sign in to Azure. Usually the tools ask you to enter your email address and password in a browser. After verifying your credentials, the tools know who you are and can verify that you have permission to deploy your Bicep file.

Because workflows are run without any human present, they need to authenticate to Azure by using a service principal. It's a good practice to create a service principal before you create your workflow. A service principal's credentials consist of an _application ID_ and a secret, which is usually a key or a certificate. You use a _GitHub secret_ in GitHub Actions to securely store these credentials so that your workflow can use them.

GitHub encrypts the secret values before storing them. Also, GitHub tries to prevent the secret values from showing in your workflow logs.

> [!WARNING]
> GitHub will obfuscate the variable values, but this is a best-effort process and you need to follow good practices as well. Your workflow steps have access to the decrypted secret values, so if your workflow includes a step that insecurely handles a secure variable then GitHub might not be able to stop it.

When you create a GitHub secret, you give it a name. Steps refer to the secret by using this name. That way, your workflow YAML code doesn't contain any secret information.

To refer to a secret value in your workflow, use the following syntax:

```YAML
${{ secrets.NAME_OF_THE_SECRET }}
```

When your workflow starts, the runner that's running your deployment steps has access to the decrypted GitHub secret. 

Since your workflow needs to sign in to Azure to deploy your Bicep template, you need to create a GitHub secret that contains your service principal information. You need to ensure that your service principal has the permissions it needs to be able to execute your deployment steps. For example, you might need to assign the service principal the Contributor role for the resource group that it deploys your resources to.

> [!WARNING]
> Even though a GitHub secret is an encrypted environment value, and even though it will be obfuscated in all GitHub Actions output logs, the workflow itself has access to the decrypted value of the secret. This means that in case someone maliciously would add an echo command to your workflow to write the secret in the output log of the workflow run, they could do so. This is why you should always review the source code of any workflow file when someone updates the file. 

GitHub secrets are created within your GitHub repository settings. A GitHub secret will be shared by all the workflows in your repository. 

> [!NOTE]
> Repository secrets can be used by all workflows in your repository. 
> In a later module you will also learn about environments to limit secrets to a certain environment. 

You can also use GitHub secrets to store other kinds of secret values your workflows might need. For instance a database password can be created as a GitHub secret, and then provided to your Bicep file by using a secure parameter. 


## Check out your code by using the actions/checkout action

Your Bicep files are stored in the Git repository. In GitHub Actions, you need to explicitly tell the workflow to check out the files from your Git repository. Otherwise, your workflow won't have access to the files.

To check out your code, you can use the `actions/checkout@v2` action:

```yaml
- uses: actions/checkout@v2
  with:
    path: repo
```

Now that the workflow includes this action, your repository's code will be checked out onto the runner and available in the file system. You specify the path the files should be stored in by using the `path` parameter.

This step is usually the first step in your job before you do anything else. 


## Sign in to Azure by using the azure/login action

Before your workflow can execute commands against your Azure environment, it also first needs to sign in. There is an action named `azure/login` that handles the login process. It uses a GitHub secret to get the credentials for your service principal:

```YAML
- uses: azure/login@v1
  with:
    creds: ${{ secrets.AZURE_CREDENTIALS }}
```

Notice that the workflow includes the `uses` keyword. This indicates you want to use a pre-defined action. named `azure/login`. Actions are always versioned. In this case you use version 1, so `@v1` is appended to the action name.

The `azure/login` action has a `creds` parameter to specify the Azure credentials to use when signing in. In this example, the workflow uses the `AZURE_CREDENTIALS` secret value as the credentials.

After this action has executed your runner will be authenticated and able to run statements against your Azure environment. 


## Deploy a Bicep file by using the azure/arm-deploy action

Only logging in to your Azure environment is of course not enough to deploy any Bicep template, you will also need an additional action to run the Bicep template deployment. For this you can use the `azure/arm-deploy` action. You use this action to execute an ARM deployment.

> [!NOTE] 
> GitHub Actions marketplace includes an actions named _azure/CLI_. This can also be used to deploy Bicep templates. With this action you can execute plain Azure CLI statements. The _azure/arm-deploy_ task however is targetted specifically at deploying ARM templates, so we will use that one in this module. 

Here's an example of how you can configure a step to use the azure/arm-deploy action:

```YAML
- uses: azure/arm-deploy@v1
  with:
    resourceGroupName: github-action-arm-rg
    template: ./deploy/main.bicep
    parameters: environmentType=Test
```

Here as well you indicate which action you want to use with the `uses` parameter. This task makes use of the following parameters: 

- `resourceGroupName` indicates in which resource group you want to deploy your bicep template
- `template` is the path to your bicep file
- `parameters` indicates any parameters you want to provide a value for in the deployment. In this case we are providing a value for the _environmentType_ parameter

Since the previous `azure/login` action already logged you into the Azure environment, this `azure/arm-deploy` step will be running on an authenticated runner. 


## Variables

Often, your workflows contain values that you want to reuse in multiple places in your workflow file. Or you might want to store them at the top of the workflow file for easy reference and to be able to change these values easily. For example, when you deploy a Bicep file to a resource group, you need to specify the name of the resource group. The resource group name might change when you deploy to different environments. Additionally, you might need to provide parameters to your Bicep files. For these use cases you can use _variables_.

In your workflow the variables you define will be surfaced as environment variables. 

### Create a variable

You can create variables at different levels in your workflow file. However, if you want them to be available for your entire workflow file, you define them near the top of the file, just below your `on` statement. To define your variables you use the `env` parameter:

```yaml
env: 
    AZURE_RESOURCEGROUP_NAME: gh-actions
    AZURE_WEBAPP_NAME: webapp-gh-actions
    SQLADMIN_LOGIN: ${{ secrets.SQLADMIN_LOGIN  }}
    SQLADMIN_PASS: ${{ secrets.SQLADMIN_PASS  }}
```

In the above example, four environment variables get created. Two of them are set to the decrypted values from GitHub secrets. 

### Use a variable in your workflow

Once you've created a variable, you use a special syntax to refer to it within your workflow's YAML file, like this:

```yaml
${{ env.AZURE_RESOURCEGROUP_NAME }}
```

Notice that it's similar to referring to a secret value, but instead of `secret.` you use `env.`

> [!TIP]
> Notice that the template filename isn't stored in a variable. Just like Bicep parameters, you don't need to create variables for everything. It's a good idea to create variables for anything that might change between environments, and anything secret.

### System variables

GitHub Actions workflows also provides _default environment variables_. These contain predefined information that you might want to use in your workflow, such as:

- `GITHUB_SHA`, The identifier of the Git commit that triggered the workflow to execute. You might use this variable to name your Azure deployment so that you can track the deployment back to the specific Git commit that triggered it.
- `GITHUB_RUN_NUMBER`, A unique number for each run of a particular workflow in a repository. This number begins at 1 for the workflow's first run, and increments with each new run.
   > [!NOTE]
   > In GitHub Actions, you can re-execute a workflow run. When you do this, the `GITHUB_RUN_NUMBER` doesn't change. So, you shouldn't use the `GITHUB_RUN_NUMBER` variable to count how many times your workflow has executed.
