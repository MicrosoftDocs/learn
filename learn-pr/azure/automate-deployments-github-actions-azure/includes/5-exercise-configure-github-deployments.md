
GitHub Actions are very useful for maintaining CI/CD for your applications.

Here, you'll leverage GitHub Actions to configure and deploy the services you deployed in the previous exercise. You'll build out the entire solution for catching the bus and monitor it in action.

## Leverage GitHub Actions to configure Azure SQL Database

1. In a text file, notepad, or on paper, determine the connection string for your Azure SQL Database. It will be something like `Server=<server-name>.database.windows.net,1433;Initial Catalog=bus-db;User Id=cloudadmin;Password=<your-password>;Connection Timeout=30;`

1. Navigate to your repository for this module on GitHub (make sure you are signed in). It will be something like `https://github.com/<your-git-username>/serverless-full-stack-apps-azure-sql`.

1. Select **Settings** for the repository.

1. Select **Secrets** > **New repository secret** and enter the following:
    1. *Name*: **AZURE_SQL_CONNECTION_STRING**
    1. *Value*: **Connection string from prior step**

1. Next, you must configure the yaml file. In Visual Studio Code, select **Explorer** icon on the left-hand taskbar to view the repository files. If you do not see them, select **File** > **Open folder** and navigate to the location where you cloned the repository.

1. Under the folder `.github\workflows`, rename **`azuresqldatabase.yml.template`** to **`azuresqldatabase.yml`**.

1. Select the **Source Control** icon on the left-hand taskbar.

1. In the *Message* box, enter "Enable database yaml" or some other message and select the **checkmark**.

> [!TIP]
> If you've already done this step in the previous module, you can choose to create an empty commit to push and kick off GitHub actions.

1. Select the **...** > **Push** which will kick off a build. Confirm it builds successfully by navigating to the repository in GitHub and selecting **Actions**.

## Import Route Data into Azure SQL Database

1. By this point, the script in the Azure Cloud Shell to the right should be complete. Run the following to start a bash session. The final step is to load in the route reference data, similar to how you did in the previous module.

    ```powershell
    bash
    ```

1. Start a sqlcmd session with the below commands. Note you'll need to add your server name and password.

    ```bash
    TERM=dumb
    sqlcmd -S [server-name].database.windows.net -P [password] -U cloudadmin -d bus-db
    ```

1. In sqlcmd to the right, copy and paste the following script to import the flat file of routes data. For more details on what is done here, review the previous module.

    ```sql
    ALTER DATABASE SCOPED CREDENTIAL AzureBlobCredentials
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sp=r&st=2021-03-12T00:47:24Z&se=2025-03-11T07:47:24Z&spr=https&sv=2020-02-10&sr=c&sig=BmuxFevKhWgbvo%2Bj8TlLYObjbB7gbvWzQaAgvGcg50c%3D';
    DROP EXTERNAL DATA SOURCE RouteData;
    CREATE EXTERNAL DATA SOURCE RouteData
    WITH (
        TYPE = blob_storage,
        LOCATION = 'https://azuresqlworkshopsa.blob.core.windows.net/bus',
        CREDENTIAL = AzureBlobCredentials
    );
    DELETE FROM dbo.[Routes];
    INSERT INTO dbo.[Routes]
    ([Id], [AgencyId], [ShortName], [Description], [Type])
    SELECT 
    [Id], [AgencyId], [ShortName], [Description], [Type]
    FROM
    openrowset
    (
        bulk 'routes.txt', 
        data_source = 'RouteData', 
        formatfile = 'routes.fmt', 
        formatfile_data_source = 'RouteData', 
        firstrow=2,
        format='csv'
    ) t;
    SET QUOTED_IDENTIFIER ON;
    SET ANSI_NULLS ON;
    INSERT INTO dbo.[GeoFences] 
        ([Name], [GeoFence]) 
    VALUES
        ('Crossroads', 0xE6100000010407000000B4A78EA822CF4740E8D7539530895EC03837D51CEACE4740E80BFBE630895EC0ECD7DF53EACE4740E81B2C50F0885EC020389F0D03CF4740E99BD2A1F0885EC00CB8BEB203CF4740E9DB04FC23895EC068C132B920CF4740E9DB04FC23895EC0B4A78EA822CF4740E8D7539530895EC001000000020000000001000000FFFFFFFF0000000003);
    INSERT INTO dbo.[MonitoredRoutes] (RouteId) VALUES (100113);
    GO
    ```

1. Finally, select **CTRL+C** to exit sqlcmd and run **`pwsh`** to switch back to PowerShell.

## Configure Azure Function App with GitHub Actions

Next, in order to publish the function to the Azure Function app you deployed in the previous exercise, you'll need to download the publish profile, configure settings in GitHub, and push your changes with Visual Studio Code.

1. Navigate to your Resource Group in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Select your **Function App**.

1. Under **Settings**, select **Configuration**.

1. Select **New application setting** and add **`RealTimeFeedUrl`** with value **`https://s3.amazonaws.com/kcm-alerts-realtime-prod/vehiclepositions_enhanced.json`**. Select **OK**.

1. Select **New application setting** and add **`AzureSQLConnectionString`** with the value from your **local.settings.json** file. Select **OK**.

1. Select **New application setting** and add **`LogicAppUrl`** with the value **`https://azure.com`**. You will update this later. Select **OK**.

1. Select **Save** to add the new settings. Select **Continue** to confirm.

1. In the **Overview** tab, select **Get publish profile** to download the publish profile for your function.

1. Navigate to your GitHub repository for this sample and select **Settings** > **Secrets** > **New repository secret**.

1. Name the secret **AZURE_FUNCTIONAPP_PUBLISH_PROFILE** and for the *Value*, copy and paste the contents from the publish profile you just downloaded.

1. Select **Add secret** to store it.

::: zone pivot="node"

1. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **nodefunction.yml.template** to **nodefunctions.yml**.

::: zone-end

::: zone pivot="python"

1. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **pythonfunction.yml.template** to **pythonfunctions.yml**.

::: zone-end

::: zone pivot="csharp"

1. Next, use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **dotnetfunction.yml.template** to **dotnetfunctions.yml**.

::: zone-end

1. Select **Source Control** and add a commit message of **`enable function workflow`**.

1. Select the **checkmark**, and then select the **...** > **Push** to kick off the workflow.

1. Navigate to your GitHub repository for this sample and select **Actions** to monitor the deployment of your Azure Function App action.

## Monitor results in the Azure portal

Now that everything is deployed, it's time to monitor the results in the Azure portal and compare to what you saw locally.

1. Once the actions are completed, navigate back to the Azure portal to your Azure Function App.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. Select **Functions** under *Functions* > **GetBusData** > **Monitor**.

1. Review the results under the **Invocations** and **Logs** tabs. They should be similar to what you saw in the terminal when you ran the function locally.

1. Just like locally, you might notice that if a bus enters or exits a GeoFence, there will be an error in calling the Logic App. That's OK for now. In a future exercise, you will deploy and configure the Logic App to push notifications.

## View the published `bus-app`

1. Navigate to your Azure Static Web App in the Azure portal.

> [!div class="nextstepaction"]
> [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. From the *Overview* pane of your Azure Static Web App in the Azure portal, select the **URL**.

1. In order to view results for the specific bus route and GeoFence, add **`?rid=100113&gid=1`** to the end of the URL in the browser and refresh the page.

1. You should now see a GeoFence and several bus points. You may need to use the **+** or **-** buttons create a zoom fit.

> [!NOTE]
> For this module, a few bus points have been manually entered into your Azure SQL Database. In the previous module of this learning path, you set up the Azure Function that runs on a timer trigger to pull down the latest real-time bus data and send notifications when buses enter or exit GeoFence. In the next module of the learning path, you'll put both these pieces together, which will enable your Azure Static Web App to include real-time data.

## Review the GitHub Action runs

1. Navigate to your Azure Static Web App in the Azure portal.

> [!div class="nextstepaction"]
> [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. From the *Overview* pane of your Azure Static Web App in the Azure portal, select **GitHub Action runs** under *Deployment history*.

1. Review the *Azure Static Web Apps CI/CD* workflow run to understand how GitHub Actions are deploying and updating your application. If you make any changes to your application and push them to the repository, a new workflow will spin up to deploy the changes.
