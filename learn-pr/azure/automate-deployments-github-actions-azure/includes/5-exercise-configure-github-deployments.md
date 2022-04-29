GitHub Actions are useful for maintaining CI/CD with your applications.

Here, you'll leverage GitHub Actions to configure and deploy the services you deployed in the previous exercise. You'll build out the entire solution for catching the bus and monitor it in action.

## Deploy database schema using GitHub Actions

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

1. Select the **...** > **Push** which will kick off a build. Confirm the **Deploy Azure SQL Database schema** workflow completes successfully by navigating to the repository in GitHub and selecting **Actions**.

## Import route reference data into Azure SQL Database

Next, you need to import the bus route information data into Azure SQL Database from a flat file.

1. Start a sqlcmd session with the below commands. Note you'll need to add your server name and password.

    ```bash
    TERM=dumb
    sqlcmd -S [server-name].database.windows.net -P [password] -U cloudadmin -d bus-db
    ```

1. In sqlcmd to the right, copy and paste the following script to import the flat file of routes data.

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

1. Finally, select **CTRL+C** to exit sqlcmd.

## Configure the Azure Function App using GitHub Actions

Next, to publish the function to the Azure Function app you deployed in the previous exercise, you'll need to download the publish profile, configure settings in GitHub, and push your changes with Visual Studio Code.

1. Navigate to your Resource Group in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

2. Select your **Function App**.

3. In the **Overview** tab, select **Get publish profile** to download the publish profile for your function.

4. Navigate to your GitHub repository for this sample and select **Settings** > **Secrets** > **New repository secret**.

5. Name the secret **AZURE_FUNCTIONAPP_PUBLISH_PROFILE** and for the *Value*, copy and paste the contents from the publish profile you downloaded.

6. Select **Add secret** to store it.

::: zone pivot="node"

7. Next, go back to Visual Studio Code. Use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **nodefunction.yml.template** to **nodefunctions.yml**.

::: zone-end

::: zone pivot="python"

8. Next, go back to Visual Studio Code. Use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **pythonfunction.yml.template** to **pythonfunctions.yml**.

::: zone-end

::: zone pivot="csharp"

7. Next, go back to Visual Studio Code. Use the **Explorer** tab in Visual Studio Code to rename the corresponding workflow file under **.github** > **workflows** from **dotnetfunction.yml.template** to **dotnetfunctions.yml**.

::: zone-end

8. Select **Source Control** and add a commit message of **`enable function workflow`**.

9. Select the **checkmark**, and then select the **...** > **Push** to kick off the workflow.

10. Navigate to your GitHub repository for this sample and select **Actions** to monitor the deployment of your Azure Function App action.

## Monitor and observe Azure Function results

Now that everything is updated, it's time to monitor the results (and your inbox).

1. Navigate to your Azure Function App in the Azure portal and select **Functions** > **GetBusData** > **Monitor**.

1. The **Invocations** tab has about a 5-minute delay, but the **Logs** tab is closer to real time. Review the **Logs**.

1. When a bus activates a geofence, what do you see? Did you receive an email? The answers to these questions should help you understand if your application is working properly.

> [!TIP]
> Depending on what time you are testing this out, you may have to wait a significant time for a bus to enter a geofence.

## Configure GitHub Actions for Azure Static Web Apps

Before you can configure the application settings for Azure Static Web Apps, you have to update the autogenerated GitHub Action workflow to reflect the folders in the GitHub repository.

1. In Visual Studio Code, select **Source Control** > **...** > **Pull** to pull down the new workflow file.

2. Navigate to the file **azure-static-wep-apps-random-words-lettersAndNumbers.yml**.

::: zone pivot="csharp"

3. Update the *app_location* from **.** to **azure-static-web-app/client**.

4. Update the *api_location* from **.** to **azure-static-web-app/api/dotnet**.

::: zone-end

::: zone pivot="python"

3. Update the *app_location* from **.** to **azure-static-web-app/client**.

4. Update the *api_location* from **.** to **azure-static-web-app/api/python**.

::: zone-end

::: zone pivot="node"

3. Update the *app_location* from **.** to **azure-static-web-app/client/**.

4. Update the *api_location* from **.** to **azure-static-web-app/api/node**.

::: zone-end

5. **Save** the file.

6. Select **Source Control** and add a commit message of **`enable app workflow`**.

7. Select the **checkmark**, and then select the **...** > **Push** to kick off the workflow.

8. Navigate to your GitHub repository for this sample and select **Actions** Review the *Azure Static Web Apps CI/CD* workflow run to understand how GitHub Actions are deploying and updating your application. If you make any changes to your application and push them to the repository, a new workflow will spin up to deploy the changes.

## Configure application settings for Azure Static Web Apps

In order for your Azure Static Web App to access your Azure SQL Database, you must configure an application setting, which contains the Azure SQL Database connection string that works with the language you chose in and earlier exercise (.NET, Python, or Node.js).

1. In a text file, determine the connection string that you will need to be able to connect to your Azure SQL Database. The format should be as follows:

::: zone pivot="python"

```cmd
Driver={ODBC Driver 17 for SQL Server};Server=[serverName].database.windows.net,1433;Database=bus-db;UID=cloudadmin;PWD=[yourPassword];Connection Timeout=30;
```

::: zone-end

::: zone pivot="csharp"

```cmd
Server=tcp:[serverName].database.windows.net,1433;Database=bus-db;User ID=cloudadmin;Password=[yourPassword];Encrypt=true;Connection Timeout=30;
```

::: zone-end

::: zone pivot="node"

```cmd
mssql://cloudadmin:[yourPassword]@[serverName].database.windows.net/bus-db?encrypt=true
```

::: zone-end

2. Navigate to your Azure Static Web App in the Azure portal.

    > [!div class="nextstepaction"]
    > [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

3. From the *Overview* pane of your Azure Static Web App in the Azure portal, select **Configuration** under *Settings* on the left-hand menu.

4. Select **+ Add** and create a new setting named **AzureSQLConnectionString** with the value set to the connection string obtained in an earlier step.

5. Select **OK**.

6. Check the box next to the new application settings and select **Save**.

## View the published `bus-app`

1. Navigate to your Azure Static Web App in the Azure portal.

> [!div class="nextstepaction"]
> [The Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

2. From the *Overview* pane of your Azure Static Web App in the Azure portal, select the **URL**.

3. To view results for the specific bus route and geofence configured, add **`?rid=100113&gid=2`** to the end of the URL in the browser and refresh the page.

4. You should now see a geofence and bus points. You may need to use the **+** or **-** buttons create a zoom fit.
