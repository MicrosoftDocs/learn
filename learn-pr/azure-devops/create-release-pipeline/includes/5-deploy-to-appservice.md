The Tailspin team has been using a build pipeline to automate their build processes. They've decided to extend the pipeline to include a deployment stage. This stage deploys to App Service as a proof of concept that Andy and Mara will share with the team.

Let's follow Andy and Mara as they create their first automated deployment.

> [!IMPORTANT]
> Remember that you need your own Azure subscription to complete the exercises in this module.

Here, you create multi-stage pipeline that includes a build stage and a deployment stage. To do this, you:

> [!div class="checklist"]
> * Create an App Service instance to host the website.
> * Use multi-stage pipelines to define a build stage and a release stage.
> * Run the pipeline and see the website deployed to App Service.

## Create web app on App Service

Here, you create the App Service instance that hosts the website.

There are several ways to bring up App Service. Here you use the Azure portal because it's a great way to explore and visualize what services are available. In later modules, you'll use more automated ways to bring up and manage App Service.

We won't go into many of the details about how App Service works or the configuration options you can select from. We point you to more information about App Service at the end of this module.

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/learn/modules/create-release-pipeline/8-clean-up-environment?azure-portal=true) page in this module explains how to tear down your App Service instance after you're done with it. Cleaning up when you're done ensures you don't build up additional costs.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. On the left side, select **App Services**.
1. Select **+ Add**.
1. On the **Web App** page, fill in these fields:

    | Field                | Value                                                                                         |
    |----------------------|-----------------------------------------------------------------------------------------------|
    | **Subscription**     | Your Azure subscription                                                                       |
    | **Resource Group**   | Select **Create new** and then enter **TailspinAppServiceRG** as the resource group name.     |
    | **Name**             | Provide a unique name, such as **TailspinSpaceGame1234**                                      |
    | **Publish**          | **Code**                                                                                      |
    | **Runtime stack**    | **.NET Core 2.1**                                                                             |
    | **Operating System** | **Linux**                                                                                     |
    | **Region**           | Select any region, preferably one close to you.                                               |
    | **Linux Plan**       | Keep the default value.                                                                       |
    | **Sku and size**     | Select **Change size**. Then select the **Dev / Test** tab, and then select **B1**. Select **Apply**. |

    Your App Service instance requires a unique name because that name becomes part of the domain name. In practice, you would choose a name that describes your service.

    Note the name you choose for later.

1. Select **Review and Create** and then select **Create**.

    The deployment takes a few moments to complete.

1. After the deployment completes, select **Go to resource**.

    You see details related to your deployment.

    ![](../media/5-app-service-details.png)

1. Select the URL shown in the details section.

    From a new browser tab, you see the default home page for your app.

    ![](../media/5-default-home-page.png)

    Shortly, you define a pipeline stage that deploys the _Space Game_ website to this App Service instance.

    Keep this browser tab open for later.

> [!NOTE]
> For learning purposes, here you use the default network settings, which makes your site accessible from the internet. In practice, you could configure an Azure virtual network that places your website in a non-internet routable network that's accessible to only you and your team. Later, when you're ready, you can reconfigure your network to make the website available to your users.

## Create a service connection

Here, you create a service connection that enables Azure Pipelines to access your Azure subscription. Azure Pipelines uses this service connection to deploy the website to App Service.

> [!IMPORTANT]
> Make sure that you're signed in to both the Azure portal and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Release** project.
1. Select **Project settings** from the bottom corner of the page.
1. Under **Pipelines**, select **Service connections**.
1. Select **+ New service connection** and then choose **Azure Resource Manager**.

    The **Add an Azure Resource Manager service connection** dialog appears.
1. From the dialog, ensure **Service Principal Authentication** is selected. Then fill in these fields:

    | Field               | Value                         |
    |---------------------|-------------------------------|
    | **Connection name** | **TailspinServiceConnection** |
    | **Scope level**     | **Subscription**              |
    | **Subscription**    | Your Azure subscription       |
    | **Resource Group**  | **TailspinAppServiceRG**      |

    During the process, you'll likely be prompted to sign in to your Microsoft account.

1. Select **OK**.

    Azure DevOps performs a test connection to verify that it can connect to your Azure subscription. If Azure DevOps is unable to connect, you'll have the chance to sign in a second time.

## Add the build stage to the pipeline

Here you convert your existing build pipeline to use the multi-stage feature of Azure Pipelines. You update your build configuration to define one stage that performs the build and then you watch the pipeline run.

Recall that your build pipeline defines the agent pool, variables, and tasks that are required to build your app. As a refresher, here are the first few lines from your current build configuration:

```yml
pool:
  vmImage: 'Ubuntu-16.04'
  demands:
    - npm

variables:
  buildConfiguration: 'Release'
  wwwrootDir: 'Tailspin.SpaceGame.Web/wwwroot'
  dotnetSdkVersion: '2.1.505'

steps:
- task: DotNetCoreInstaller@0
  displayName: 'Use .NET Core SDK $(dotnetSdkVersion)'
  inputs:
    version: '$(dotnetSdkVersion)'

...
```

A _multi-stage pipeline_ enables you to define distinct deployment phases as your change makes its way through the pipeline. Each stage defines the agent, variable, and steps required to carry out that phase of the deployment. In this module, you define one stage to perform the build, and a second stage to deploy the web application to App Service.

To convert your existing build configuration to a multi-stage pipeline, you add a `stages` section to your configuration. You then add one or more `stage` sections to define each phase of your deployment.

Stages also break down into jobs, A _job_ is a series of steps that run sequentially as a unit. You'll work with jobs shortly.

Before we add the deployment stage to the pipeline, let's first convert the existing build configuration to be multi-stage.

1. From your project in Visual Studio Code, open *azure-pipelines.yml* file and replace its contents with this.

    [!code-yml[](code/5-azure-pipelines-1.yml?highlight=1-6)]

    > [!TIP]
    > In YAML, whitespace is important. This change affects all of the whitespace in your file, so we recommend that you replace the entire file with what you see here. The highlighted sections illustrate the use of stages and jobs.
1. From the integrated terminal, add *azure-pipelines.yml* to the index, commit the change, and push the change up to GitHub.

    > [!TIP]
    > Remember to save *azure-pipelines.yml* before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add a build stage to the pipeline"
    git push origin release-pipeline
    ```
1. From Azure Pipelines, go to the build and trace the build as it runs.
1. After the build completes, press the back button to return to the summary page.

    ![](../media/5-pipeline-build-stage-summary.png)

    You see that the build completed successfully. Your build pipeline accomplishes the same task as before, which is to build the web app and publish the artifact to the pipeline. But with this change, you're now prepared to add additional stages.

## Add your web app name to a pipeline variable

Here you add a variable to your pipeline that stores the name of your web app in App Service.

When you set up App Service earlier, you assigned it a name, such as **TailspinSpaceGame1234**.

The deployment stage you'll define shortly uses this name to identify which App Service instance to deploy to.

Although you could hard code this name in your pipeline configuration, defining this name as a variable makes your configuration more reusable.

A pipeline variable enables you to define a value in Azure Pipelines and read that value from your pipeline configuration. If the name of your App Service instance changes, you can update the variable and trigger your pipeline without the need to modify your configuration.

To add the variable:

1. In Azure DevOps, under **Pipelines**, select **Library**.

    ![](../media/5-pipelines-library.png)
1. Under **Properties**, enter **Release Pipeline** for the variable group name.
1. Under **Variables**, select **+ Add**.
1. Enter **WebAppName** as the name of your variable. Enter your App Service instance's name, such as **TailspinSpaceGame1234**, as its value.
1. Select **Save** near the top of the page to save your variable group to the pipeline.

## Add the deployment stage to the pipeline

Here, you extend your configuration by adding a deployment stage that deploys the _Space Game_ web application to App Service.

To do so, you define a second stage and use the `DownloadBuildArtifacts@0` and `AzureRmWebAppDeployment@4` tasks to download the build artifact from the pipeline and perform the deployment.

1. From Visual Studio Code, replace the contents of *azure-pipelines.yml* with this.

    [!code-yml[](code/5-azure-pipelines-2.yml?highlight=64-)]

    Notice the use of the `DownloadBuildArtifacts@0` and `AzureRmWebAppDeployment@4` tasks. `$(WebAppName)` reads the web app name from your pipeline variables.

1. From the integrated terminal, add *azure-pipelines.yml* to the index, commit the change, and push the change up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add a deployment stage to the pipeline"
    git push origin release-pipeline
    ```

1. From Azure Pipelines, trace the build and deploy through each of the stages.
1. After the pipeline finishes, press the back button to return to the summary page.

    ![](../media/5-pipeline-deployment-summary.png)

    You see that both the build and deployment stages complete successfully.

## See the deployed website on App Service

When you created your App Service instance, you saw the default website that's created for you. Here, you revisit your website to see the results of your deployment.

1. From a web browser, navigate to the URL that's associated with your App Service instance.

    If you still have the browser tab open, simply refresh the page.

    If you need a refresher, you can find the URL from the App Service details page in the Azure portal.

    ![](../media/5-app-service-details.png)

1. See that the _Space Game_ website has been successfully deployed to App Service and is running.

    ![](../media/5-deployed-website.png)

Congratulations! You've successfully deployed the _Space Game_ website to App Service using Azure Pipelines.