The Tailspin team has been using a build pipeline to automate their build processes. They've decided they're ready to implement a simple CI/CD pipeline as a POC. They'll extend the build pipeline to include a deployment stage that deploys to Azure App Service.

Andy and Mara have taken on the job of creating the pipeline. Let's follow them and see how they achieve their first automated deployment.

> [!IMPORTANT]
> You need your own Azure subscription to complete the exercises in this module.

Here you create a multistage pipeline that includes a stage named _Build_ and a stage named _Deploy_. To create the pipeline, you:

> [!div class="checklist"]
> * Create an App Service instance to host the website.
> * Use multistage pipelines to define a build stage and a deployment stage.
> * Run the pipeline and see the website deployed to App Service.

## Create the App Service instance

Here you create the App Service instance that hosts the website.

You can bring up App Service in several ways. In this case, you'll use the Azure portal because it's a great way to explore and visualize available services. In later modules, you'll use more automated ways to bring up and manage App Service.

We won't go into many of the details about how App Service works or the configuration options you can select. You'll find more information about App Service at the end of this module.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/create-release-pipeline/8-clean-up-environment?azure-portal=true) page in this module explains how to tear down your App Service instance after you're done with it. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Be sure to follow the cleanup steps even if you don't complete this module.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. From the home page, under **Azure services**, select **App Services**.

1. Select **Create**. The **Create Web App** pane appears.

1. On the **Basics** tab, enter the following values.

    | Setting | Value |
    |---------|-------|
    | **Project Details** |
    | Subscription | *your subscription* |
    | Resource Group | Select **Create new**, and then enter *tailspin-space-game-rg*, and select **OK**. |
    | **Instance Details** |
    | Name | Provide a unique name, such as *tailspin-space-game-1234*. This name must be unique across Azure. It becomes part of the domain name. In practice, choose a name that describes your service. Note the name for later. |
    | Publish  | Code |
    | Runtime stack | .NET 5 |
    | Operating System | Linux |
    | Region | Select a region, preferably one close to you.|
    | **App Service Plan** |
    | Linux Plan | Accept the default.                                                                       |
    | Sku and size | Select **Change size**. In the **Spec Picker** pane, select **Dev/Test**, **B1** pricing tier, and then select **Apply**. |

1. Select **Review + create**, and then select **Create**.

    The deployment takes a few moments to finish.

1. When deployment is complete, select **Go to resource**.

    The **App Service** Essentials displays details related to your deployment.

    :::image type="content" source="../media/5-app-service-details.png" alt-text="Screenshot showing deployment details, including the deployment URL." lightbox="../media/5-app-service-details.png":::

1. Select the URL.

    Your web app displays in a new browser tab.

    :::image type="content" source="../media/5-default-home-page.png" alt-text="A screenshot of a web browser showing the default App Service home page.":::

    In the next exercise, you'll define a pipeline that deploys the _Space Game_ website to this App Service instance, so keep this browser tab open.

> [!NOTE]
> For learning purposes, use the default network settings to make your site accessible from the internet. In practice, you could configure an Azure virtual network so that your website is in a network that only you and your team can access. Later, when you're ready, you can reconfigure your network to make the website available to your users.

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Release** project.

1. From the bottom of the page, select **Project settings**.

1. Under **Pipelines**, select **Service connections**.

1. Select **New service connection**, then choose **Azure Resource Manager**, then select **Next**.

1. Near the top of the page, **Service principal (automatic)**. Then select **Next**.

1. Enter the following values for each setting.

    | Field | Value |
    | ----- | ----- |
    | Scope level | **Subscription** |
    | Subscription | Your Azure subscription |
    | Resource Group | **tailspin-space-game-rg** |
    | Service connection name | *Resource Manager - Tailspin - Space Game* |

    During the process, you might be prompted to sign in to your Microsoft account.

1. Ensure that **Grant access permission to all pipelines** is selected.

1. Select **Save**.

    Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps can't connect, you may be prompted to sign in.

## Add the Build stage to the pipeline

Here, you convert your existing build pipeline to use the multistage feature of Azure Pipelines. You update your build configuration to define one stage that performs the build. Then you watch the pipeline run.

Recall that your build pipeline defines the agent pool, variables, and tasks that are required to build your app. As a refresher, here are the first few lines from your current build configuration:

```yml
trigger:
- '*'

pool:
  vmImage: 'ubuntu-20.04'
  demands:
  - npm

variables:
  buildConfiguration: 'Release'
  wwwrootDir: 'Tailspin.SpaceGame.Web/wwwroot'
  dotnetSdkVersion: '5.x'

steps:
- task: UseDotNet@2
  displayName: 'Use .NET SDK $(dotnetSdkVersion)'
  inputs:
    version: '$(dotnetSdkVersion)'

...
```

A _multistage pipeline_ enables you to define distinct phases that your change passes through as it's promoted through the pipeline. Each stage defines the agent, variables, and steps required to carry out that phase of the pipeline. In this module, you define one stage to perform the build. You define a second stage to deploy the web application to App Service.

To convert your existing build configuration to a multistage pipeline, you add a `stages` section to your configuration. You then add one or more `stage` sections to define each phase of your pipeline. Stages break down into jobs, which are a series of steps that run sequentially as a unit.

Before we add the _Deploy_ stage to the pipeline, let's convert the existing build configuration to a multistage pipeline.

1. From your project in Visual Studio Code, open *azure-pipelines.yml* and replace its contents with this code:

    [!code-yml[](code/5-azure-pipelines-1.yml?highlight=7-11)]

    > [!IMPORTANT]
    > In YAML, white space is important. This change affects all of the white space in your file, so replace the entire contents of the file. The highlighted section illustrates the use of stages and jobs.

1. From the integrated terminal, add *azure-pipelines.yml* to the index. Then commit the change and push it up to GitHub.

    > [!TIP]
    > Save *azure-pipelines.yml* before you run these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add a build stage to the pipeline"
    git push origin release-pipeline
    ```

1. In Azure Pipelines, go to the build and trace the build as it runs.

1. After the build finishes, select the back button to return to the summary page.

    :::image type="content" source="../media/5-pipeline-build-stage-summary.png" alt-text="A screenshot of Azure Pipelines showing the job summary.":::

    You see that the build finished successfully. Your build pipeline accomplishes the same task as before. It builds the web app and publishes the artifact to the pipeline. But with this new change, you can now add more stages to the pipeline.

## Create the dev environment

Recall that in Azure Pipelines, an _environment_ is an abstract representation of your deployment environment. You can also define an environment through Azure Pipelines that includes specific criteria for your release. This criteria can include the pipelines that are authorized to deploy to the environment. You can also specify the human approvals that are needed to promote the release from one stage to the next.

For your POC, you'll deploy to the **dev** environment. For now, your environment will define no specific release criteria. In future modules, you'll specify criteria such as human approvals which are required to sign off on changes before those changes move to the next stage.

Create the **dev** environment.

1. From Azure Pipelines, select **Environments**.

    :::image type="content" source="../../shared/media/pipelines-environments.png" alt-text="A screenshot of Azure Pipelines showing the location of the Environments menu option.":::

1. Select **Create environment**.

1. Under **Name**, enter *dev*.

1. Leave the remaining fields at their default values.

1. Select **Create**.

## Store your web app name in a pipeline variable

Here, you add a variable to your pipeline to store the name of your web app in App Service.

When you set up App Service earlier, you assigned it a name, such as *tailspin-space-game-web-1234*. The _Deploy_ stage you'll define uses this name to identify which App Service instance to deploy to.

Although you could hard-code this name in your pipeline configuration, defining it as a variable makes your configuration more reusable.

A pipeline variable enables you to define a value in Azure Pipelines and read that value from your pipeline configuration. If the name of your App Service instance changes, you can update the variable and trigger your pipeline without modifying your configuration.

To add the variable:

1. In Azure DevOps, under **Pipelines**, select **Library**.

    :::image type="content" source="../media/5-pipelines-library.png" alt-text="Screenshot of Azure Pipelines showing the location of the Library menu.":::

1. Select **Variable group**.

1. Under **Properties**, enter *Release* for the variable group name.

1. Under **Variables**, select **Add**.

1. For the name of your variable, enter *WebAppName*. For its value, enter your App Service instance's name, such as *tailspin-space-game-web-1234*.

1. Near the top of the page, select **Save** to save your variable to the pipeline.

## Add the deployment stage to the pipeline

Here you extend your pipeline by adding a deployment stage that uses App Service to deploy the _Space Game_ web application. To accomplish this objective, you define a second stage and use the `download` and `AzureWebApp@1` tasks to download the build artifact from the pipeline and perform the deployment.

1. From Visual Studio Code, replace the contents of *azure-pipelines.yml* with this code:

    [!code-yml[](code/5-azure-pipelines-2.yml?highlight=68-89)]

    Notice the use of the `download` and `AzureWebApp@1` tasks. `$(WebAppName)` reads the web app name from your pipeline variable.

    Also notice the `environment` field. This specifies that the deployment is associated with the **dev** environment.

1. From the integrated terminal, add *azure-pipelines.yml* to the index. Then commit the change and push it up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add a deployment stage to the pipeline"
    git push origin release-pipeline
    ```

1. In Azure Pipelines, trace the build and deployment through each of the stages.

1. After the pipeline finishes, select the back button to return to the summary page.

    :::image type="content" source="../media/5-pipeline-deployment-summary.png" alt-text="A screenshot of Azure Pipelines showing the completed Build and Deploy stages.":::

    You see that both the build stages and the deployment stages finished successfully.

## See the deployed website on App Service

When you created your App Service instance, you saw the default website that was created for you. Here you revisit your website to see the results of your deployment.

1. From a web browser, navigate to the URL that's associated with your App Service instance.

    If you still have the browser tab open, simply refresh the page. If the browser tab isn't open, you can find the URL on the App Service details page in the Azure portal.

    :::image type="content" source="../media/5-app-service-details.png" alt-text="Screenshot showing deployment details.":::

1. See that the _Space Game_ website has been successfully deployed to App Service and is running.

    :::image type="content" source="../media/5-deployed-website.png" alt-text="Screenshot of web browser showing the Space Game website.":::

Congratulations! You've successfully deployed the _Space Game_ website to App Service by using Azure Pipelines.
