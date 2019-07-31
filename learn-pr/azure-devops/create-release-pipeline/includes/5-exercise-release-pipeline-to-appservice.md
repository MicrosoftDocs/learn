The team has been using a build pipeline to automate their build processes. They have decided to edit the pipeline to add the deployment stage. They will deploy to an Azure AppService as proof of concept.

Let's follow them as they create their first automated deployment.

Here you create a release pipeline using multistage pipelines. To do this you:

> [!div class="checklist"]
> * Create an App Service in Azure to host the website
> * Use multistage pipelines to create a build and release pipeline
> * See the website deployed to an Azure App Service

## Create the App Service

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. On the left side, find **App Services** and click on it to open the App Services page.
1. In the App Services page click the **+ Add** to add a new Azure App Service.
1. On the Web App page
    1. Choose your subscription.
    1. Create a new Resource Group. This is important since you will want to clean up your subscription after you complete this module to keep from accruing additional costs. Call the Resource Group **TailspinAppServiceRG**.
    1. Give your Web App a unique name. For example *TailspinSpaceGame1234*.
    1. For **Publish** choose **Code**.
    1. For **Runtime stack** choose **.NET Core 2.1**.
    1. For **Operating system** choose **Linux**.
    1. Choose your closest region.
    1. For **Sku and size** click the link and navigate to the **Dev / Test** tab. Choose the **D1** option.
    1. Click **Review and Create** and then **Create**.
    1. Your resource is being created. After it's created, use the provided button go to the resource and note the name and URL of your Web App for later.
1. At the top of the page, select the **Browse** button to see your App Service. The page you see is the default page for an Azure App Service. You will deploy the SpaceGame web site to this App Service.

TODO - In the summary, link to the Learn learning path on working with App Service

## Build the application and deploy it to App Service

Here you add the deploy stage to the pipeline to deploy your build artifact to the App Service you set up previously through the Azure portal.

### Create a service connection to the App Service

> [!Important]
> If the account you used for the App Service in Azure is different from the account you are using for Azure DevOps, add the Azure user account to Azure DevOps. 

TODO: Get the steps.

Your pipeline will need to access your app service. In order to do this without having to hard code your subscription ID in the pipeline, we will create a service connection.

1. Navigate to the project page for your Tailspin-SpaceGame-Web project.
1. Click **Settings** in the bottom left of the page.
1. Choose **Service connections**
1. Click **+ New service connection** and choose **Azure Resource Manager**.
1. In the new window, leave **Service Principal Authentication** selected and fill in the **Connection name** with *TailspinServiceConnection*.
1. The **Scope level** and **Subscription** will be filled in for you.
1. When you go to choose a **Resource group**, a pop-up will appear where you can sign in. After you sign in, the resource group box will the resource group you created when you created the Azure AppService. Choose that one.
1. Click **OK**.

### Add stage and deployment tasks to the pipeline

TODO: Remember to add a pipeline variable and reference it in `WebAppName` in the build config.

Here you add the stage, job, and tasks you need to deploy the build artifact to your app service.

1. Open your **azure-pipelines.yml** file and replace the contents with this.
    [!code-yml[](code/5-azure-pipelines-2.yml?highlight=61-83)]
  You'll notice that we've added a deploy stage to the pipeline to deploy to the App Service. This assumes you called the service connection *TailspinServiceConnection*.
   > [!IMPORTANT]
   > Be sure to replace the **WebAppName** with the name of your web app.

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the change, and push the change up to GitHub.
    > [!TIP]
    > Remember to save **azure-pipelines.yml** before running these Git commands.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Add deploy stage to pipeline"
    git push origin
    ```

1. From Azure Pipelines, trace the build and deploy through each of the steps.
(Screenshot) You may need to manually queue and run the pipeline. (TODO -check this and explain.)

## See your website deployed

1. From the Azure portal, navigate to your App Service and click the **Browse** button.
1. You see the web site deployed to the App Service at that URL. (Screenshot)
