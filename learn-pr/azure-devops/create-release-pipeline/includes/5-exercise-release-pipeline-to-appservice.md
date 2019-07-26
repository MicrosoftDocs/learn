The team has been using a build pipeline to automate their build processes. Now, the team has decided to edit the pipeline to add the deployment stage to the pipeline. They will first deploy to an Azure AppService as proof of concept.

Let's follow them as they create their first automated deployment.

Here you create a release pipeline using multistage pipelines. To do this you:

> [!div class="checklist"]
> * Create an App Service in Azure to host the website
> * Use multistage pipelines to create a build and release pipeline
> * See the website deployed to an Azure AppService

<!-- [!include[](../../../includes/azure-sandbox-activate.md)] -->

## Create the App Service

TODO: Since we are not using the sandbox anymore, have them create a resource group.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. On the left side, find **App Services** and click on it to open the App Services page.
1. In the App Services page click the **+ Add** to add a new Azure App Service.
1. On the Web App page
    1. Make sure your subscription says **Concierge Subscription**
    1. Select your existing resource group <rgn>[Resource Group Name]</rgn>.
    1. Give your Web App a unique name. For example *TailspinSpaceGame1234*.
    1. For **Publish** choose **Code**.
    1. For **Runtime stack** choose **.NET Core 2.1**.
    1. For **Operating system** choose **Linux**.
    1. Choose your closest region.
    1. For **Sku and size** click the link and navigate to the **Dev / Test** tab. Choose the **D1** option.
    1. Click **Review and Create** and then **Create**.
    1. Your resource is being created. After it's created, note the name and URL of your Web App for later.
1. TODO: Have the learner browser to the URL and see the default page. Show a screenshot here as well.

TODO - In the summary, link to the Learn learning path on working with App Service

## Build the application and deploy it to App Service

Here you add the deploy stage to the pipeline to deploy your build artifact to App Service you set up previously through the Azure portal.

### Create a service connection to the App Service

Our pipeline will need to access our app service. In order to do this without having to hard code our subscription ID in the pipeline, we will create a service connection.

1. Navigate to the project page for your Tailspin-SpaceGame-Web project.
1. Click **Settings** in the bottom left of the page.
1. Choose **Service connections**
1. Click **+ New service connection** and choose **Azure Resource Manager**.
1. In the new window, leave **Service Principal Authentication** selected and fill in the **Connection name** with *TailspinServiceConnection*.
1. The **Scope level** and **Subscription** will be filled in for you.
1. When you go to choose a **Resource group**, a pop-up will appear where you can sign in. After you sign in, the resource group box will have your sandbox resource group  <rgn>[Resource Group Name]</rgn>.
1. Click **OK**.

### Add stage and deployment tasks to the pipeline

TODO: Remember to add a pipeline variable and reference it in `WebAppName` in the build config.

Here we'll add the stage, job, and tasks we need to deploy the build artifact to our app service.

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
