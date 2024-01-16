The GitHub repo that you forked for this project contains the source code for a basic Node.js project. In this part, you create a project in Azure Pipelines that builds and deploys that project to the app created earlier.

In this part, you:

> [!div class="checklist"]
> - Create a CI/CD pipeline triggered by commits to the *main* branch.
> - Review the pipeline tasks.
> - Save the pipeline to trigger a CI/CD workflow.

## Set up an Azure DevOps project

Create an Azure DevOps project.

1. Sign into your account at [dev.azure.com](https://dev.azure.com?azure-portal=true).
1. Select **+ New project**.

   The **Create new project** dialog box opens.

1. Create a new project with the following options.

   | Field                              | Description  |
   |:-----------------------------------|:-------------|
   | **Project name**                   | Enter a name such as *nodejs-hello-world*. |
   | **Visibility**                     | Choose whether to make your project public or private. |
   | **Advanced** > **Version control** | Select **Git**. |

## Create the pipeline

Create a YAML CI/CD pipeline in Azure Pipelines by modifying the starter template. The process generates a pipelines configuration file named *azure-pipelines.yml*, which lives in the root directory of your Git repository.

1. Go to your ***nodejs-hello-world*** project.

1. Go to **Pipelines**, and then select **Create pipeline**.

1. Complete the steps of the wizard by first selecting **GitHub** as the location of your source code.

1. You might be redirected to GitHub to sign in. If so, enter your GitHub credentials.

1. When you see the list of repositories, select your repository.

1. You might be redirected to GitHub to install the Azure Pipelines app. If so, select **Approve & install**.

1. On the **Select** tab, select your ***nodejs-docs-hello-world*** repository.

1. On the **Configure** tab, select **Node.js Express Web App to Linux on Azure**.

    When prompted:

    1. Select the Azure subscription from which you created the resources earlier.
    1. Select **Continue**.
    1. Select the app name you created earlier, for example **helloworld-nodejs-16353**.
    1. Select **Validate and configure**.

1. On the **Review** tab, review the starter code for your pipeline configuration. Don't select **Save and run** yet.

## Review the pipeline tasks

The starter pipeline code provides everything you need to build, test, package, and deploy the Node.js application to Azure. Before you run it, let's walk through the different stages and tasks it uses, to build and deploy the app.

### The CI trigger

The pipeline is configured to run whenever a change is committed to the `main` branch. You can adjust it as needed, such as if you wanted to include or exclude runs based on their branch, path, or tag.

[!code-yml[](code/4-1-azure-pipelines.yml)]

### Pipeline variables

To aid in pipeline maintenance, the default template uses variables for commonly used parameters, such as the name of the service connection string used to connect to Azure. A service connection provides secure access to your Azure subscription from Azure Pipelines.

You can also import variables from pipeline libraries that are managed outside of the pipeline itself. Here's an example. The values you see are specific to your Azure subscription.

[!code-yml[](code/4-2-azure-pipelines.yml)]

### The Build stage

A `stage` is a part of the pipeline that different mechanisms can trigger and can run independently. For example, you might have a stage that builds the application, another stage that deploys it to a preproduction environment, and a final stage that deploys the application to the production.

This pipeline is divided into two stages: `Build` and `Deploy`. The `Build` stage configures and performs the build tasks, which include publishing the build artifact, as a *.zip* file, to artifact storage.

[!code-yml[](code/4-3-azure-pipelines.yml)]

### Node.js Tool Installer task

The `NodeTool@0` task sets up the build environment for Node.js projects. For the purposes of this pipeline, only the `versionSpec` parameter is needed to specify the version of the Node.js tools to install. For more information, see [Node.js Tool Installer task](/azure/devops/pipelines/tasks/tool/node-js?azure-portal=true).

Verify that `versionSpec` is set to `16.x`. If it isn't, update the value.

[!code-yml[](code/4-4-azure-pipelines.yml)]

### Running the build

The build itself is run using `npm` commands in an inline script. This project doesn't include any tests, but if you add them, they run as a part of the `npm run test` command.

[!code-yml[](code/4-5-azure-pipelines.yml)]

### Publishing the build

After the build completes, the `ArchiveFiles@2` task packages the build output as a *.zip* file. The resulting *.zip* file is then published to artifact storage by using the alias `drop` for future review and usage.

[!code-yml[](code/4-6-azure-pipelines.yml)]

You don't need to provide your own storage for build artifacts. Azure Pipelines holds the results of your builds based on the configured retention policy. For more information, see [Build and release retention policies](/azure/devops/pipelines/policies/retention?azure-portal=true&tabs=yaml).

### Deploying the build

The second stage of the pipeline deploys the application to Azure. It depends on the `Build` stage completing successfully. It then uses the pipeline's Azure service connection to deploy the app to the configured target. This project deploys the app to the Azure App Service.

Verify that `runtimeStack` is set to `NODE|16-lts`. If it isn't, update the value.

[!code-yml[](code/4-7-azure-pipelines.yml)]

### Azure Web App task

The `AzureWebApp@1` task deploys web apps to Azure App Service. It's a flexible task that supports apps across various platforms and includes everything needed for this Node.js application:

- `azureSubscription` refers to the name of your Azure service connection pipeline variable.
- `appType` indicates whether the app is being deployed for Linux (`webAppLinux`).
- `appName` specifies the name of the Azure App Service instance in your Azure account.
- `runtimeStack` indicates which image the app should be run on, which is required for Linux deployments.
- `package` specifies the path to the package to be deployed.
- `startUpCommand` specifies the startup command to run after the app has been deployed, which is required for Linux deployments.

You can learn more about the flexibility of this task in the [Azure Web App task](/azure/devops/pipelines/tasks/deploy/azure-rm-web-app?azure-portal=true) documentation.

## Save the pipeline to trigger a build and release

1. Select **Save and run** from the upper right corner of the page. Select **Save and run** again to commit git changes and trigger the pipeline to run.

1. In Azure Pipelines, go to the build. You can trace the build as it runs.
1. After the build succeeds, select the deploy task, and select the URL to view the deployed website.

   :::image type="content" source="../media/5-deploy-url.png" alt-text="Screenshot of the web site URL location in Azure Pipelines.":::

1. You see the site running on App Service.

    :::image type="content" source="../media/5-hello-world.png" alt-text="Screenshot of the Node.js application running in a web browser.":::

You now have a complete CI/CD pipeline that you can extend. You can repeat the steps you performed here to deploy one of your own Node.js projects to Azure.
