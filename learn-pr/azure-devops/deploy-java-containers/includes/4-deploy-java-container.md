The GitHub repo for this module contains the source code for a basic Java web project that connects to a MySQL database. In this unit, you create an Azure Pipelines continuous integration and continuous deployment (CI/CD) pipeline that builds and deploys the Java project to Azure App Service.

In this unit, you:

> [!div class="checklist"]
> * Set up an Azure DevOps project for the CI/CD pipeline.
> * Create required service connections for Azure Pipelines to connect to GitHub and Azure.
> * Create pipeline variables in Azure Pipelines.
> * Create and trigger a CI/CD pipeline that builds and publishes the Java container app to App Service.

## Set up Azure DevOps

In this section, you make sure your Azure DevOps account has the necessary permissions and capabilities to:

- Create a project.
- Run pipelines in your project.
- Sign in to Azure.
- Connect to GitHub.

### Project creation permissions

To create an Azure DevOps project, you need access to an Azure DevOps organization with [Project Collection Administrators](/azure/devops/organizations/security/change-organization-collection-level-permissions) group membership or collection-level **Create new projects** permission. Organization owners are automatically members of the **Project Collection Administration** group.

### Parallel jobs availability

To run the pipeline in this module, your Azure DevOps project must be able to run parallel jobs on Microsoft-hosted machines. Most Azure DevOps private projects allow one Microsoft-hosted parallel job with a certain number of free minutes available.

To check availability, select **Organization settings** at the bottom of the Azure DevOps left navigation, and then select **Parallel jobs** under **Pipelines**. For more information, see [Check for available parallel jobs](/azure/devops/pipelines/troubleshooting/troubleshooting#check-for-available-parallel-jobs).

### Azure sign-in account

You don't need an Azure subscription to use Azure DevOps, but this module uses Azure DevOps to deploy resources that exist in your Azure subscription. To simplify this process, you use the same Microsoft account to sign in to your Azure subscription and your Azure DevOps organization.

If you use different Microsoft sign-in accounts for Azure and Azure DevOps, add a user to your Azure DevOps organization for your Azure sign-in account. To add the user, you must be the Azure DevOps organization owner or a member of the **Project Collection Administrators** group.

When you add the user, choose the **Basic** access level. Then sign out of Azure DevOps and sign back in with your Azure sign-in account. For more information, see [Add users to your organization or project](/azure/devops/organizations/accounts/add-organization-users?azure-portal=true).
  
### Azure Pipelines authorization for GitHub

Azure Pipelines needs access to your GitHub account so it can pull the latest source code from your repository. To install and authorize the Azure Pipelines extension for GitHub:

1. Go to the [GitHub Marketplace](https://github.com/marketplace?azure-portal=true), and search for and select **Azure Pipelines**.
1. At the bottom of the **Azure Pipelines** page, select **Install it for free**.
1. Fill out the form and select **Save**.
1. Select **Only select repositories** and choose the **mslearn-java-containers** repository that you forked earlier.
1. Select **Install**.

>[!NOTE]
>Optionally, you can install and authorize the Azure Pipelines extension for your GitHub repository later when you create your service connections or pipeline. 

## Create your Azure DevOps project

Create an Azure DevOps project to contain your CI/CD pipeline. Make sure you're the Azure DevOps organization owner, are a **Project Collection Administrators** group member, or have **Create new projects** permission.

1. Go to your Azure DevOps organization at [dev.azure.com](https://dev.azure.com?azure-portal=true). If you're already signed in to Azure, you're automatically signed in to Azure DevOps. Otherwise, sign in.
1. Select **Get started**. 
1. Select **Create a new project to get started** and then choose **Create project**, or if you're already in your Azure DevOps organization, choose **New project**.
1. On the **Create new project** page, in the **Project name** field, enter *mslearn-java-containers*.
1. Under **Visibility**, choose whether to make your project public or private. Open-source project creators often choose public visibility so others can view project status and issues. For this project, choose **Private**.
1. Select **Advanced**, and make sure **Git** appears under **Version control**.
1. Select **Create**.

## Create Azure service connections

Create the necessary Azure service connections to allow Azure Pipelines to access your Azure resources. Azure Pipelines uses the Azure resource service connection to deploy the Java application to App Service, and uses the Docker Registry connection to publish the application's Docker container to Container Registry.

> [!IMPORTANT]
> Make sure that you're signed in to Azure DevOps with an Azure sign-in account that has the **Owner** role in Azure.

### Azure resource service connection

1. In your DevOps project, select **Project settings** at the bottom of the left navigation.
1. Under **Pipelines**, select **Service connections**, and then select **Create service connection**.
1. On the **New service connection** screen, select **Azure Resource Manager**, and then select **Next**.
1. Select **Service principal (automatic)**, and then select **Next**.
1. On the next screen, complete the following fields:

   | Field           | Value                                        |
   |-----------------|----------------------------------------------|
   | **Scope level**     | Select **Subscription**.                             |
   | **Subscription**    | Select your Azure subscription.                      |
   | **Resource group**  | Select **java-containers-cicd-rg**                   |
   | **Service connection name** | Enter *Azure Connection*.                           |

1. Select **Grant access permission to all pipelines**.
1. Select **Save**. Azure DevOps tests the connection to verify that it can connect to your Azure subscription. If Azure DevOps can't connect, you get the chance to sign in a second time.

### Container Registry service connection

1. Back on the **Service connections** page, select **New service connection**.
1. On the **New service connection** screen, select **Docker Registry**, and then select **Next**.
1. On the **New Docker Registry service connection** page, under **Registry type**, select **Azure Container Registry**.
1. Under **Authentication Type**, select **Service Principal**.
1. Complete the following fields:

   | Field           | Value                                        |
   |-----------------|----------------------------------------------|
   | **Subscription**| Select your Azure subscription.|
   | **Azure container registry**|Select the container registry you created for this module.|
   | **Service connection name**| Enter *Container Registry Connection*.|

1. Select **Grant access permission to all pipelines**.
1. Select **Save**.

>[!NOTE]
>If you didn't yet authorize Azure Pipelines to access GitHub, you can use a service connection to grant authorization. Follow the preceding instructions to set up a service connection, and choose **GitHub** on the **New service connection** screen. Select **AzurePipelines** on the **New GitHub service connection** screen, and then select **Authorize**.

## Create Azure Pipelines variables

Your CI/CD pipeline uses the Azure resource names you created in previous steps. You could hardcode these names in your pipeline configuration, but your configuration is more reusable and less error-prone if you define them as pipeline variables. If your instance names change, you can update the variables and trigger your pipeline without modifying your configuration.

To define the pipeline variables:

1. In the left navigation for your DevOps project, select **Pipelines** > **Library**.

   :::image type="content" source="../media/4-pipelines-library.png" alt-text="Screenshot of the Library menu option under Pipelines in Azure DevOps.":::

1. On the **Library** page, select **Variable group**.
1. On the new variable group page, under **Properties**, enter *Release* for **Variable group name**.
1. Under **Variables**, select **Add**.
1. Enter the following variable names and values, and select **Add** after adding each name-value pair:

   |Variable name|Value|
   |-------------|-----|
   |**WebAppName**|Name of the App Service instance you created, such as `java-container-cicd-18116`. Be sure to use the instance name, not the host name that contains `azurewebsites.net`.|
   |**RegistryName**|Your Container Registry login server name, such as `javacontainercicd18116.azurecr.io`.|
   |**MySqlServer**|Your MySQL server host name, such as `java-container-cicd-18116`, which if you followed the preceding instructions is the same as your web app name. Don't use the fully qualified domain, just the host.|
   |**MySqlUserName**|The MySQL administrator login name you used to create the server, such as `sysadmin`.|
   |**MySqlPassword**|The MySQL password you used to create the server, such as `P@ssw0rd`. After you enter the password, select the padlock icon to change variable type to secret so it doesn't show as plain text after it's saved.|

   > [!IMPORTANT]
   > In a real-world scenario, you might opt to use an alternative storage mechanism for credentials, such as Azure Key Vault. To learn more about Key Vault, see [Configure and manage secrets in Azure Key Vault](/training/modules/configure-and-manage-azure-key-vault/?azure-portal=true).

   Make sure your variable group resembles the following image:

   :::image type="content" source="../media/4-library-variable-group.png" alt-text="Screenshot of Azure Pipeline showing the variable group with five variables.":::

1. Select **Save** near the top of the page to save your variable group to Azure Pipelines.

## Create the CI/CD pipeline

Now use Azure Pipelines to create your CI/CD build and deployment pipeline. You base the pipeline on a starter pipeline configuration template named *azure-pipelines.yml* that's in the root directory of your Git repository.

1. In your Azure DevOps project, select **Pipelines** from the left navigation.
1. Select **Create Pipeline**.
1. On the **Where is your code** page, select **GitHub**.
1. On the **Select a repository** page, select your **mslearn-java-containers** repository.

   - If prompted, select your GitHub account, select **Authorize**, select **Authorize Azure Pipelines**, and sign in to GitHub.
   - If you haven't yet installed and authorized the Azure Pipelines extension, select **Approve and install Azure Pipelines**.

1. On the **Configure your pipeline** screen, select **Starter pipeline**. You could choose other templates that provide starter pipeline code, but for this learning path you define each build step.
1. On the **Review your pipeline YAML** screen, view the starter pipeline configuration code.

### Pipeline trigger

To make the pipeline run whenever there's a code change in the `main` branch of your GitHub repository, replace the contents of *azure-pipelines.yml* with the following code:

[!code-yml[](code/4-1-azure-pipelines.yml)]

### Pipeline variables

To aid in maintenance, the pipeline sets variables for commonly used parameters, such as the container repository to publish the app image to. You can also import variables from pipeline libraries.

To set the pipeline variables, add the following code to the end of the file:

[!code-yml[](code/4-2-azure-pipelines.yml)]

> [!IMPORTANT]
> YAML is very particular about indentation. The Azure Pipelines YAML editor underlines bad indentation with squiggly lines. After each step where you add YAML, be sure to review the the Azure Pipelines YAML editor and address any indentation issues.

### Build stage

This pipeline has two stages, `Build` and `Deploy`. The `Build` stage configures and runs the build, and publishes the package to artifact storage.

Add the following code to define the `Build` stage:

[!code-yml[](code/4-3-azure-pipelines.yml)]

#### Maven task

The `Maven@3` task builds Java projects into Apache Maven packages. This pipeline uses only the `options` and `publishJUnitResults` parameters, which specify the path to the settings file and skip publishing test results. For more information about this task, see [Maven task](/azure/devops/pipelines/tasks/build/maven?azure-portal=true).

Add the following code to the end of the pipeline:

[!code-yml[](code/4-4-azure-pipelines.yml)]

#### Copy output files task

The build produces a WAR file that the Docker build must be able to access. To make the file available, use the `CopyFiles@2` task to copy it to the artifact staging directory.

Add the following code to the end of the pipeline:

[!code-yml[](code/4-5-azure-pipelines.yml)]

#### Docker task

The `Docker@2` task builds and deploys Docker containers. This task is ideal for this scenario, because it does the build and deployment in a single task.

- `command` indicates the feature to run, in this case `buildAndPush`.
- `buildContext` specifies the path to the build context.
- `repository` specifies the name of the repository.
- `dockerfile` specifies the path to the Dockerfile.
- `containerRegistry` specifies the name of the container registry connection to use.
- `tags` indicates which tags to apply to the container image.

For more information about this task, see [Docker task](/azure/devops/pipelines/tasks/build/docker?azure-portal=true).

Add the following code to the end of the pipeline:

[!code-yml[](code/4-6-azure-pipelines.yml)]

#### Azure Database for MySql deployment task

The `AzureMysqlDeployment@1` task enables running scripts against an Azure Database for MySQL database. For this scenario, the task runs the initialization script that creates the database and configures sample data. This code can safely run every time the pipeline runs, because it makes changes only when necessary.

This task uses the pipeline variable group values and other configurations you set up earlier.

- `azureSubscription` specifies the name of the Azure service connection to use.
- `ServerName` specifies the fully qualified host name of the server.
- `DatabaseName` specifies the name of the database, which is `alm` in this app.
- `SqlUsername` specifies the username in the format `username@server`.
- `SqlPassword` specifies the password you configured earlier.
- `SqlFile` specifies the script to run, which is in the root of the project's source code.

For more information about this task, see [Azure Database for Mysql Deployment task](/azure/devops/pipelines/tasks/deploy/azure-mysql-deployment?azure-portal=true).

Add the following code to the end of the pipeline:

[!code-yml[](code/4-7-azure-pipelines.yml)]

### Deploy stage

The second, `Deploy` stage of the pipeline deploys the solution to Azure. This stage is dependent on the `Build` stage completing successfully, and imports the variables from the Release variable group you created earlier.

Add the following code to the end of the pipeline:

[!code-yml[](code/4-8-azure-pipelines.yml)]

#### Azure Web App for Container task

The `AzureWebAppContainer@1` task deploys Docker containers to App Service in a single task.

- `appName` specifies the name of the App Service instance.
- `azureSubscription` specifies the name of the Azure connection.
- `imageName` specifies the full name of the Docker container image.

For more information about this task, see [Azure Web App for Container task](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app-containers?azure-portal=true).

Add the following code to the end of the pipeline:

[!code-yml[](code/4-9-azure-pipelines.yml)]

#### App Service Settings task

The `AzureAppServiceSettings@1` task enables pipelines to update the settings of an Azure app service. In this case, after each successful deployment, the pipeline adds or updates the connection string the container app uses. The task uses the following parameters:

- `azureSubscription` specifies the name of the Azure connection.
- `appName` specifies the name of the App Service instance.
- `resourceGroupName` specifies the resource group the app service belongs to.
- `connectionStrings` provides the JSON-formatted list of connection string settings to apply.

For more information about this task, see [Azure App Service Settings task](/azure/devops/pipelines/tasks/deploy/azure-app-service-settings?azure-portal=true).

Add the following code to the end of the pipeline:

[!code-yml[](code/4-10-azure-pipelines.yml)]

## Trigger the pipeline

1. Take a moment to review your *azure-pipelines.yml* file, and ensure that the indentation looks like the following example:

   [!code-yml[](code/complete-azure-pipelines.yml)]

1. Select **Save and run** at upper right, and then select **Save and run** again to trigger the pipeline run.
1. Select **Pipelines**, and then select the name of the run and the **Build** stage to see the steps as they run.
1. After the pipeline completes successfully, expand the **DeploymentJob** at left, select **Update the web app with the new container**, and copy the **App Service Application URL** from the right pane.

   :::image type="content" source="../media/4-deploy-url.png" alt-text="Screenshot of Azure Pipelines showing the location of the website URL.":::

1. The site is hosted under the `/myshuttledev/` path on the server. Open a new browser tab and paste in the application URL you copied, appended with `/myshuttledev/`. For example, `http://java-container-cicd-18116.azurewebsites.net/myshuttledev/`.
1. Go to the site to view the deployed application. If prompted for permission to access the insecure site, grant permission.

   It might take a few minutes before you can see the site running on App Service. When the site appears, you can log in by using the user name `fred` and password `fredpassword` and explore the site.

   :::image type="content" source="../media/4-myshuttle.png" alt-text="Screenshot of the running website.":::
   
When you're finished with the resources you created for this module, proceed to the next unit to remove them.
