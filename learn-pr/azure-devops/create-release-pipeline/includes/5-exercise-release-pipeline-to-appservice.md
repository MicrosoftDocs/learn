The team has been using a build pipeline to automate their build processes. Now, the team has decided to edit the pipeline to add the deployment stage to the pipeline. They will first deploy to Amita's test environment as an Azure AppService.

Let's follow them as they get their first deployment to Amita's new test environment.

Here you'll create a release pipeline using multistage pipelines. To do this you will:

> [!div class="checklist"]
> * Create an App Service in Azure to host the website
> * Use multistage pipelines to create a build and release pipeline
> * See the website deployed to an Azure AppService

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create the AppService

1. Once the sandbox is activated, navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. On the left side, find **App Services** and click on it to open the App Services page.
1. In the App Services page click the **+ Add** to add a new Azure App Service.
1. On the Web App page
    1. Make sure your subscription says **Concierge Subscription**
    1. Select your existing resource group  <rgn>[Resource Group Name]</rgn>.
    1. Give your Web App a unique name. For example *TailspinSpaceGame1234*.
    1. For **Publish** choose **Code**.
    1. For **Runtime stack** choose **.NET Core 2.1**.
    1. For **Operating system** choose **Windows**. This will help us later when we want to use deployment slots. (TODO - check this)
    1. Choose your closest region.
    1. For **Sku and size** click the link and navigate to the **Dev / Test** tab. Choose the **D1** option. This will help us later when we want to use deployment slots. (Screenshot)
    1. Click **Review and Create** and then **Create**.
    1. Your resource is being created. After it's created, note the name and URL of your Web App for later.

TODO - Link to the MSLearn module on creating an AppService

### Add a deployment slot

1. On the menu to the left, select **Deployment slots**. You'll see that there is one slot already created called **Production**. We will create one for Amita called **Test**.
1. Click **+ Add Slot**.
1. In the window that is now on the right, fill in the **Name** field with **Test** and click **Add**. You should now have two slots. We will deploy to the **Test** slot. Later, you will deploy to multiple slots using your release strategy.

## Create the multistage pipeline to build and deploy to the App Service

Here we'll add the deploy stage to the pipeline to deploy our build artifact to the App Service we set up in the Azure portal.

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

Here we'll add the stage, job, and tasks we need to deploy the build artifact to our app service.

1. Open your **azure-pipelines.yml** file and replace the contents with this.
  [!code-yml[](code/5-azure-pipelines-2.yml?highlight=61-83)]
    You'll notice that we've added a deploy stage to the pipeline to deploy to the App Service. This assumes you called the service connection *TailspinServiceConnection*.
    > [!IMPORTANT]
    > Be sure to replace the **WebAppName** with the name of your web app. And the **resourceGroupName** with <rgn>[Resource Group Name]</rgn>.
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
1. You should see the web site deployed to the App Service at that URL. (Screenshot)

TODO: Add AppService sandbox validation. See create-build-agent.yml
