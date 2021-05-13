The GitHub repo that you forked for this project contains the source code for a basic Node.js project. In this part, you create a project in Azure Pipelines that builds and deploys that project to the Azure app service created earlier.

In this part, you:

> [!div class="checklist"]
> * Install the Azure Pipelines extension for your GitHub repo.
> * Set up an Azure DevOps project for this module.
> * Create a CI/CD pipeline triggered by commits to the *master* branch.
> * Review the pipeline tasks.
> * Save the pipeline to trigger a CI/CD workflow.

## Install the Azure Pipelines extension

Here you install the Azure Pipelines extension for your GitHub repository. This extension enables Azure Pipelines to access your GitHub account so that it can pull the latest source code from your repository.

1. Go to the [GitHub Marketplace](https://github.com/marketplace?azure-portal=true).
1. Search for **Azure Pipelines** and select the **Azure Pipelines** result.
1. Locate the **Free** option and select **Install it for free**.
1. Select **Complete order and begin installation**.
1. Select **Only select repositories** and choose the **nodejs-docs-hello-world** repository that you forked earlier.
1. Select **Install**.

## Set up an Azure DevOps project

The previous task links your GitHub repository to your Azure DevOps organization. To complete the process, you now create an Azure DevOps project.

1. Sign into your account at [dev.azure.com](https://dev.azure.com?azure-portal=true).
1. Select **+ New project**.

    The **Create new project** dialog box opens.
1. In the **Project name** field, enter a name such as *nodejs-hello-world*.
1. Under **Visibility**, you choose whether to make your project public or private. For now, you can choose private.

    Creators of open source projects will often choose public visibility so that others can view active issues and build status.
1. Select **Advanced**.
1. Under **Version control**, make sure that **Git** is selected.
1. Select **Create**.

## Create the pipeline

Here you create a CI/CD pipeline in Azure Pipelines by using one of the built-in templates. The process generates a pipelines configuration file named *azure-pipelines.yml*, which lives in the root directory of your Git repository.

1. In Azure DevOps, go to your **nodejs-hello-world** project.
1. Select **Pipelines**, either from the project page or from the left pane.
1. Select **Create Pipeline**.
1. On the **Connect** tab, select **GitHub**.

    If prompted, enter your GitHub credentials.
1. On the **Select** tab, select your **nodejs-docs-hello-world** repository.
1. On the **Configure** tab, select **Node.js Express Web App to Linux on Azure**.

    When prompted:

    1. Select the Azure subscription from which you created resources earlier.
    1. Select **Continue**.
    1. Select the Web App name you created earlier, for example **nodejs-cicd-17396**.
    1. Select **Validate and configure**.
1. On the **Review** tab, review the starter code for your pipeline configuration. Don't select **Save and run** just yet.

## Review the pipeline tasks

The starter pipeline code provides everything you need to build, test, package, and deploy the Node.js application to Azure. Before you run it, let's walk through the stages and tasks it uses to build and deploy the app.

### The CI trigger

The pipeline is configured to run whenever a change is committed to the `master` branch. You can adjust this as needed, such as if you wanted to include (or exclude) runs based on their branch, path, or tag.

[!code-yml[](code/4-1-azure-pipelines.yml)]

### Pipeline variables

To aid in pipeline maintenance, the default template uses variables for commonly-used parameters, such as the name of the service connection string used to connect to Azure. A service connection provides secure access to your Azure subscription from Azure Pipelines.

You can also import variables from pipeline libraries that are managed outside of the pipeline itself. Here's an example. The values you see will be specific to your Azure subscription.

[!code-yml[](code/4-2-azure-pipelines.yml)]

### The Build stage

A _stage_ is a part of the pipeline that can run independently and be triggered by different mechanisms. For example, you might have one stage that builds the application, a second stage that deploys to a pre-production environment, and a final stage that deploys to production.

This pipeline is divided into two stages: *Build* and *Deploy*. The *Build* stage configures and performs the build tasks, which includes publishing the build artifact (a *.zip* file) to artifact storage.

[!code-yml[](code/4-3-azure-pipelines.yml)]

### Node.js Tool Installer task

The `NodeTool@0` task sets up the build environment for Node.js projects. For the purposes of this pipeline, only the `versionSpec` parameter is needed to specify the version of the Node.js tools to install. You can learn more about this task in the [Node.js Tool Installer task](/azure/devops/pipelines/tasks/tool/node-js?azure-portal=true) documentation.

[!code-yml[](code/4-4-azure-pipelines.yml)]

### Running the build

The build itself is run using `npm` commands in an inline script. This project doesn't include any tests, but if you add them, they would be run as part of the `npm run test` command.

[!code-yml[](code/4-5-azure-pipelines.yml)]

### Publishing the build

After the build completes, the `ArchiveFiles@2` task packages the build output as a *.zip* file. The resulting *.zip* file is then published to artifact storage by using the alias *drop* for future usage and review.

[!code-yml[](code/4-6-azure-pipelines.yml)]

You don't need to provide your own storage for build artifacts. Azure Pipelines holds the results of your builds based on the configured retention policy. To learn more, see [Build and release retention policies](https://docs.microsoft.com/azure/devops/pipelines/policies/retention?tabs=yaml&azure-portal=true).

### Deploying the build

The second stage of the pipeline deploys the application to Azure. It depends on the *Build* stage completing successfully, after which it uses the pipeline's Azure service connection to deploy the app to the configured target. This projects deploys the app to Azure App Service.

[!code-yml[](code/4-7-azure-pipelines.yml)]

### Azure Web App task

The `AzureWebApp@1` task deploys web apps to Azure App Service. It's a very flexible task that supports apps across a variety of platforms and includes everything needed for this Node.js application:

* `azureSubscription` refers to the name of your Azure service connection pipeline variable.
* `appType` indicates whether the app is being deployed for Linux (`webAppLinux`).
* `appName` specifies the name of the Azure App Service instance in your Azure account.
* `runtimeStack` indicates which image the app should be run on, which is required for Linux deployments.
* `package` specifies the path to the package to be deployed.
* `startUpCommand` specifies the startup command to run after the app has been deployed, which is required for Linux deployments.

You can learn more about the flexibility of this task in the [Azure Web App task](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app?azure-portal=true) documentation.

## Save the pipeline to trigger a build and release

1. Select **Save and run** from the top right corner of the page. Select **Save and run** again to trigger the pipeline to run.
1. In Azure Pipelines, go to the build. Trace the build as it runs.
1. After the build has succeeded, select the web site's deploy task and click the URL to view the deployed site.

    ![Locating the web site URL in Azure Pipelines](../media/4-deploy-url.png)

1. You see the site running on App Service.

    ![The Node.js application running in a web browser](../media/4-hello-world.png)

Although this application is very basic, you now have a complete CI/CD pipeline that you can extend. You can repeat the steps you performed here to deploy one of your own Node.js projects to Azure.
