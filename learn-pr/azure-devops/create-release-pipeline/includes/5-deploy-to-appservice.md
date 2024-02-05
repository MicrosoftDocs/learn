In this module, you'll create a multistage pipeline to build and deploy your application to Azure App Service. You'll learn how to:

> [!div class="checklist"]
> * Create an App Service instance to host your web application.
> * Create a multistage pipeline.
> * Deploy to Azure App Service.

## Create the App Service instance

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **App Services** from the left pane.

1. Select **Create** > **Web App** to create a new Web App.

1. On the **Basics** tab, enter the following values.

    | Setting | Value |
    |---------|-------|
    | **Project Details** |
    | Subscription | *your subscription* |
    | Resource Group | Select **Create new**, and then enter *tailspin-space-game-rg*, and select **OK**. |
    | **Instance Details** |
    | Name | Provide a unique name, such as *tailspin-space-game-1234*. This name must be unique across Azure. It becomes part of the domain name. In practice, choose a name that describes your service. Note the name for later. |
    | Publish  | Code |
    | Runtime stack | .NET 6 (LTS) |
    | Operating System | Linux |
    | Region | Select a region, preferably one close to you.|
    | **Pricing plans** |
    | Linux Plan | Accept the default.                                                                       |
    | Pricing plan | Select the **Basic B1** pricing tier from the drop-down menu. |

1. Select **Review + create**, review the form and then select **Create**. The deployment takes a few moments to complete.

1. When deployment is complete, select **Go to resource**. The **App Service** Essentials displays details related to your deployment.

    :::image type="content" source="../media/5-app-service-details.png" alt-text="Screenshot showing deployment details, including the deployment URL." lightbox="../media/5-app-service-details.png":::

1. Select the URL to verify the status of your App Service.

    :::image type="content" source="../media/5-default-home-page.png" alt-text="A screenshot of a web browser showing the default App Service home page.":::

> [!IMPORTANT]
> The [Clean up your Azure DevOps environment](/training/modules/create-release-pipeline/8-clean-up-environment?azure-portal=true) page in this module explains how to tear down your App Service instance after you're done with it. Cleaning up helps ensure that you're not charged for Azure resources after you complete this module. Make sure you follow the cleanup steps even if you don't complete this module.

## Create a service connection

> [!IMPORTANT]
> Make sure that you're signed in to Azure and Azure DevOps under the same Microsoft account.

1. In Azure DevOps, go to your **Space Game - web - Release** project.

1. From the lower-left corner of the page, select **Project settings**.

1. Under **Pipelines**, select **Service connections**.

1. Select **New service connection**, and then select **Azure Resource Manager** then select **Next**.

1. Select **Service principal (automatic)**, and then select **Next**.

1. Fill out the required fields as follows: If prompted, sign in to your Microsoft account.

    | Field | Value |
    | ----- | ----- |
    | Scope level | **Subscription** |
    | Subscription | Your Azure subscription |
    | Resource Group | **tailspin-space-game-rg** |
    | Service connection name | *Resource Manager - Tailspin - Space Game* |

1. Ensure that **Grant access permission to all pipelines** is selected.

1. Select **Save**.

## Add the Build stage to your pipeline

A *multistage pipeline* allows you to define distinct phases that your change passes through as it's promoted through the pipeline. Each stage defines the agent, variables, and steps required to carry out that phase of the pipeline. In this section, you'll define one stage to perform the build. You define a second stage to deploy the web application to App Service.

To convert your existing build configuration to a multistage pipeline, you add a `stages` section to your configuration, and then you add one or more `stage` sections for each phase of your pipeline. Stages break down into jobs, which are a series of steps that run sequentially as a unit.

1. From your project in Visual Studio Code, open *azure-pipelines.yml* and replace its contents with this code:

    [!code-yml[](code/5-azure-pipelines-1.yml)]

1. From the integrated terminal, run the following commands to stage, commit, and then push your changes to your remote branch.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add a build stage"
    git push origin release-pipeline
    ```

1. In Azure Pipelines, navigate to your pipeline to view the logs.

1. After the build finishes, select the back button to return to the summary page and check the status of your pipeline and published artifact.

    :::image type="content" source="../media/5-pipeline-build-stage-summary.png" alt-text="A screenshot of Azure Pipelines showing the job summary.":::

## Create the dev environment

An *environment* is an abstract representation of your deployment environment. Environments can be used to define specific criteria for your release such as which pipeline is authorized to deploy to the environment. Environments can also be used to set up manual approvals for specific user/group to approve before deployment is resumed.

1. From Azure Pipelines, select **Environments**.

    :::image type="content" source="../../shared/media/pipelines-environments.png" alt-text="A screenshot of Azure Pipelines showing the location of the Environments menu option.":::

1. Select **Create environment**.

1. Under **Name**, enter *dev*.

1. Leave the remaining fields at their default values.

1. Select **Create**.

## Store your web app name in a pipeline variable

The *Deploy* stage that we will be creating will use the name to identify which App Service instance to deploy to e.g: *tailspin-space-game-web-1234*.

Although you could hard-code this name in your pipeline configuration, defining it as a variable makes your configuration more reusable.

1. In Azure DevOps, select **Pipelines** and then select **Library**.

    :::image type="content" source="../media/5-pipelines-library.png" alt-text="Screenshot of Azure Pipelines showing the location of the Library menu.":::

1. Select **+ Variable group** to create a new variable group.

1. Enter *Release* for the **variable group name**.

1. Select **Add** under **Variables** to add a new variable.

1. Enter *WebAppName* for the variable name and your App Service instance's name for its value: e.g. *tailspin-space-game-web-1234*.

1. Select **Save**.

## Add the deployment stage to your pipeline

We will extend our pipeline by adding a deployment stage to deploy the *Space Game* to App Service using the `download` and `AzureWebApp@1` tasks to download the build artifact and then deploy it.

1. From Visual Studio Code, replace the contents of *azure-pipelines.yml* with the following yaml:

    [!code-yml[](code/5-azure-pipelines-2.yml?highlight=68-89)]

    Notice the highlighted section and how we are using the `download` and `AzureWebApp@1` tasks. The pipeline will fetch the `$(WebAppName)` from the variable group we created earlier.

    Also notice how we are using `environment` to deploy to the **dev** environment.

1. From the integrated terminal, add *azure-pipelines.yml* to the index. Then commit the change and push it up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add a deployment stage"
    git push origin release-pipeline
    ```

1. In Azure Pipelines, navigate to your pipeline to view the logs.

1. After the build finishes, select the back button to return to the summary page and check the status of your stages. Both stages finished successfully in our case.

    :::image type="content" source="../media/5-pipeline-deployment-summary.png" alt-text="A screenshot of Azure Pipelines showing the completed Build and Deploy stages.":::

## View the deployed website on App Service

1. If you still have your App Service tab open, simply refresh the page. Otherwise, navigate to your Azure App Service in the Azure portal and select the instance's **URL**: for example, *`https://tailspin-space-game-web-1234.azurewebsites.net`*

    :::image type="content" source="../media/5-app-service-details.png" alt-text="Screenshot showing deployment details.":::

1. The *Space Game* website has been successfully deployed to Azure App Service.

    :::image type="content" source="../media/5-deployed-website.png" alt-text="Screenshot of web browser showing the Space Game website.":::

Congratulations! You've successfully deployed the *Space Game* website to Azure App Service by using Azure Pipelines.
