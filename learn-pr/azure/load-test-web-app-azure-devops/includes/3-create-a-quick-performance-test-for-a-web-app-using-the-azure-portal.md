During app development, it can be helpful to run quick load tests to help you identify code or other issues that might impact on your users' experience. In this exercise, you'll deploy a basic version of the **Contoso Costume Rentals** app, and then configure and run a test using the Azure portal. You'll then modify the app, by adding some media, and then rerun your test to see if this change has had any effect on the app's performance.

[!include[](../../../includes/azure-free-trial-note.md)]

## Create an Azure DevOps account

You'll need a DevOps account for the exercises in this module. Skip this step if you already have a DevOps account associated with your Azure account.

1. Go to https://dev.azure.com, and sign up for a DevOps account (if you don't already have one); use your Azure account as login. ***Do not*** create a new organization.

## Use Azure CLI to deploy a web app

In this step, you're going to use Azure CLI commands to create a php-based Web app using code from a GitHub repository. 

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) using your Azure subscription. 
1. In the Azure portal, click **Cloud Shell** on the portal toolbar, and if prompted, select the **Bash** shell option.

1. Run the following commands in the Cloud Shell to set some variables, replacing  _\<your-local-Azure-region\>_, with the closest region to you (use `az account list-locations` to get a list of valid locations).

    ```azurecli
    gitrepo=https://github.com/MicrosoftDocs/mslearn-load-test-web-app-azure-devops
    appName="contosorentalsapp$RANDOM"
    appPlanName="contosorentalsAppPlan"
    appLocation=<your-local-Azure-region>
    resourcegroupName=contosorentalsRG
    ```

1. Run the following commands in the Cloud Shell to deploy the web app.
    ```azurecli
    # Create a resource group
    az group create --name $resourcegroupName --location $appLocation

    # Create an App Service plan
    az appservice plan create --name $appPlanName --resource-group $resourcegroupName --sku FREE
    
    # Create a web app
    az webapp create --name $appName --resource-group $resourcegroupName --plan $appPlanName
    
    # Deploy code from GitHub repository
    az webapp deployment source config \
        --name $appName \
        --resource-group $resourcegroupName \
        --repo-url $gitrepo \
        --branch master --manual-integration
    ```

1. Wait until the commands have completed before continuing with the exercise.

### Configure and verify your Web app

In this step, you're going to finalize the deployment of your Web app by editing a configuration file, and then verify that the app works.

1. In the Azure portal, click **App Services** in the sidebar menu on the left.
1. In the **App Services** list, click **contosorentals\<_number_\>**, and then in the **Overview** section, click the **Click to copy** to the right of the URL string.
1. In the **Development Tools** section, click **App Service Editor (Preview)**, and then on the App Service Editor (Preview) pane, click **Go**. 
1. In the App Service Editor, in the file list, expand **includes**, then click **config.php**, and then in line 10 paste your copied URL string to replace `app-url-here` (do not remove the quote marks).

![Configure Web app URL](../media/3-configure-webapp.png)

1. Open a new browser tab, paste your copied URL string into the address box, and press Enter.
1. Verify that you get the home page for the **Contoso Costume Rentals** website.

> [!NOTE]
> This website is text-only at this point.

![Web app default page](../media/3-webapp-default-page.png)

## Create and run a performance test
In this step, you're going to create and run a performance test for your Web app. You'll start by creating a new Azure DevOps organization to save the results of the test.

1. Switch back to the Azure portal, and on the **contosorentals\<_number_\>** App Service pane, in the **Development Tools** section, click **Performance test**.
1. On the **Performance test** pane, click **Set organization**, and then click **Create New**.
1. In the **Azure DevOps Organization** box, type **ContosoRentals**.
1. Click **Subscription**, select your Azure subscription, and then click **OK**.
1. Wait until the new organization has been created.
1. Click **+ New** to create a new performance test, with these settings:
   - Test type: **Manual Test**, using the default URL
   - Name: **SimplePerfTest01**
   - Generate load from: Use the default location
   - User load: **40**
   - Duration (minutes): **1**
1. Click **Run test**; the test will initially show as **Queued**, and it may be several minutes before the test run starts.
1. When the test status changes to show. In Progress**, click the test and observe the test as it runs.
1. When the test has completed, close the performance test pane; you'll look at the results in the next unit.

## Modify website and rerun the performance test

You'll now configure and run a new test, after adding graphics to your site.

1. In your browser, switch to the App Service Editor browser tab.
1. In the App Service Editor, in the file list, expand **includes**, then click **config.php**, and then in line 11, change `false` to `true`.
![Configure EWeb app to display graphics](../media/3-configure-webapp-graphics.png)
1. Switch to the Web app's browser tab, and refresh the page; you should now see a colored box at top of page that varies by page, and a colored box with text and circles at the bottom of the page that loads a new set of random colors on each page load.
![Default page with graphics](../media/3-webapp-default-page-with-graphics.png)
1. You might notice that some of the graphics are slow to load, so you'll now rerun the performance test. 
1. Switch back to the Azure portal, and on the **contosorentals\<_number_\>** App Service pane, in the **Development Tools** section, click **Performance test**, then click **SimplePerfTest01**, click **Rerun**, and then on the **Rerun performance test** pane, click **Run test**.
1. Close the performance test pane, and wait for the test run the complete; you'll look at details in the next unit.
1. You can now close the App Service Editor browser tab.

In the next unit, you'll look at how to use performance test results to help optimize your Web apps.
