A deployment slot is an instance of a web app in which you can test a new version of a web app before deployment. You can deploy a new version of an app without any downtime by swapping slots.

You have chosen to use Azure App Service deployment slots to streamline the deployment of new versions of your social media web app. Now you want to set up the web app in Azure and configure those deployment slots.

Here, you will set up a web app and add a new deployment slot to it for staging. You will also deploy different versions of the web app to those slots.

[!INCLUDE [Activate the Sandbox](../../../includes/azure-sandbox-activate.md)]

[!INCLUDE [Select an Azure Region](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

## Create a new web app

Start by creating a new web app resource in the Azure portal:

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.
1. Select **+ Create a resource**.
1. Select **Web** > **Web App**.
1. Fill out the form like this:

    | Field                     | Value                                                                |
    |---------------------------|----------------------------------------------------------------------|
    | App Name                  | Enter a unique name for the site                                     |
    | Subscription              | Concierge Subscription                                               |
    | Resource group            | Select *use existing* and choose <rgn>[Sandbox resource group]</rgn> |
    | OS                        | Windows                                                              |
    | Publish                   | Code                                                                 |
    | App Service plan/Location | Leave default                                                        |
    | Application Insights      | Leave default                                                        |

    ![Create a web app](../media/3-create-a-web-app.png)

1. Click **Create**. Azure creates the web app and the production deployment slot.

## Configure git deployment

You can use any of the usual deployment tools with your web app and its deployment slots. In this exercise, you will use a local git repository for deployment. Configure the web app to use git by following these steps:

1. In the Azure portal, in the navigation on the left, click **All resources** and then click the web app you just created.
1. In the **App Service** page, under **Deployment**, click **Deployment Center**.
1. Click **Local Git** and then click **Continue**.
1. Click **App Service Kudu build server**, click **Continue**, and then click **Finish**.
1. In the **Deployment Center** page, click **Deployment Credentials**, and then click the **User Credentials** tab.
1. Enter a new password and save the credentials. Note the password for later.

## Configure the git client and clone the web app source code

Now you must set up the git client in the Cloud Shell and use it to clone a sample web app. Follow these steps:

1. In the Cloud Shell window on the right, enter the following commands to configure your git username and email address. These are not associated with any kind of account or sign-up, and you can use whatever values you like.

    ```bash
    git config --global user.name "<Your name>"
    git config --global user.email "<Your email address>"
    ```

1. To create a folder for the source code, enter the following commands:

    ```bash
    mkdir demoapp
    cd demoapp
    ```

1. To clone the source for the web app, enter the following commands:

    ```bash
    git clone https://github.com/Azure-Samples/app-service-web-dotnet-get-started.git
    cd app-service-web-dotnet-get-started
    ```

## Configure a git remote to deploy the app to production

To use git to deploy the source code to the web app's production slot, you configure the git URL of your app as a remote repository. Follow these steps:

1. In the Azure portal, on the web app's **Overview** page, next to the **Git clone url** click the **Copy** button.

    ![Copy the git clone URL](../media/3-copy-git-clone-url.png)

    > [!NOTE]
    > If you don't see the Git clone URL where it is shown in the screenshot, refresh the portal.

1. In the Cloud Shell, run the following command to configure the URL as a git remote named "production". Replace `git-clone-url` with the URL from the previous step.

    ```bash
    git remote add production <git-clone-url>
    ```

1. To deploy the web app to the production slot, type the following command and then press enter. When you are prompted for the password, type **Pa$$w0rd** and then press Enter:

    ```bash
    git push production
    ```

1. When the deployment is complete, in the Azure portal, browse to the web app's **Overview** page and then click **Browse**. Azure displays the web app:

    ![The web app in the production slot](../media/3-web-app-production-slot.png)

1. Close the browser tab that displays the web app.

## Create a new staging slot

When you created the web app, only one slot was created: the production slot. This is the slot that you just deploy source code to. Next, let's create a second deployment slot for staging new versions of the web app:

1. In the Azure portal, click **All resources** and then click the web app.
1. Under **Deployment** click **Deployment slots**.

    ![Access deployment slots](../media/3-access-deployment-slots.png)

1. On the **Deployment slots** page, click **+ Add slot**.
1. In the **Name** textbox, type **Staging** and then click **Add**.
1. When the deployment slot has been added, click **Close**.

## Configure git deployment for the staging slot

You have to configure the new slot to use git deployment, just like you did for the production slot. Follow these steps:

1. In the Azure portal, in the navigation on the left, click **All resources**. In the list of all resources, you'll see both the production web app and the Staging slot represented as separate apps. Select the Staging slot to navigate to its Overview page.
1. Under **Deployment**, click **Deployment Center**.
1. Click **Local Git** and then click **Continue**.
1. Click **App Service Kudu build server**, click **Continue**, and then click **Finish**.

## Configure git to deploy the app to the staging slot

To use the git client to deploy source code to the new slot, you can add an extra remote to the git configuration. Follow these steps:

1. In the Azure portal, navigate to the Overpage of the Staging slot. Near the top of the page, click the **Copy** button next to the **Git clone url**.

    > [!NOTE]
    > Note that the git URL for the staging slot is slightly different than the URL for the production slot.

1. To add the remote for the **Staging** slot, type the following command. Paste the git clone URL to replace the token:

    ```bash
    git remote add staging <git clone url>
    ```

## Modify the app source code and deploy the app to the staging

Next, let's make a small change to the web app, and then use git to deploy the new version to the **Staging** slot:

1. In the Cloud Shell, type the following command and then press Enter:

    ```bash
    code .
    ```

1. In the list of **Files**, expand **aspnet-get-started**, expand **Views**, and then expand **Home**.
1. Click **Index.cshtml**
1. Locate the following code:

    ```html
    <h1>ASP.NET</h1>
    ```

1. Replace that code with:

    ```html
    <h1>Web App Version 2</h1>
    ```

1. To save your changes, type CTRL+S.
1. In the Cloud Shell, enter the following commands to commit the new version of the app to git and deploy it to the staging slot. Enter your deployment password when prompted.

    ```bash
    git add .
    git commit -m "New version of web app."
    git push staging
    ```

## Browse the staging slot

Now, you can view the new version of the web app by browsing to the **Staging** deployment slot's URL.

In the Azure portal, navigate to the Overview page for the staging slot and click the **Browse** button near the top. You'll see the new version of the web app in a new browser tab:

    ![The updated web app in the staging slot](../media/3-web-app-staging-slot.png)

    At this point, the staging slot has the new version of the code and you can run your tests on it. Remember that the production slot has the previous web app version, and users cannot yet see your new code.
