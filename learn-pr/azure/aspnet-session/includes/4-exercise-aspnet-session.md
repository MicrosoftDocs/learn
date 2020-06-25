There are many session state providers available for ASP.NET web applications. For a web app running under Azure App Services, using the Azure Cache for Redis provider can offer the scalability and performance required to support large numbers of concurrent sessions, especially when requests to the same session are directed to different instances of the web app.

In this exercise, you'll create an instance of the Azure Cache for Redis service. You'll configure the session provider for the example web app to use this cache. You'll then verify that the application is using the cache to store session state information.

## Create an instance of Azure Cache for Redis

1. In the Cloud Shell window on the right, run the commands shown below to ensure that your environment is still set up correctly. If necessary, recreate any missing environment variables with the values you used earler in the Setup unit.

    ````PowerShell
    cd ~/eShopModernizing/Setup
    . ./environment.ps1
    ```

1. Define a PowerShell variable containing the name of the Azure Cache for Redis instance to be created. 

    ```PowerShell
    $rediscachename = (-join($useralias, "-workshop-cache"))
    ```

1. Create an Azure Cache for Redis instance.

    ```PowerShell
    New-AzRedisCache -ResourceGroupName $resourcegroupname -Name $rediscachename -Location $location -Sku Basic -Size c1 -Tag @{Name="SessionCache"}
    ```

1. Run the following command to check the provisioning state of the cache. Repeat this command every 30 seconds until it displays the message ***Succeeded***.

    ```PowerShell
    (Get-AzRedisCache -ResourceGroupName $resourcegroupname -Name $rediscachename).ProvisioningState
    ```

1. Retrieve the primary access key for the cache, and record it to use later.

    ```PowerShell
    $rediskey = (Get-AzRedisCacheKey -Name $rediscachename -ResourceGroup $resourcegroupname).PrimaryKey
    ```

## Configure the session provider in the web app

1. Return to Visual Studio, editing the **eShopLegacyWebForms** solution.

1. In the **Solution Explorer** window, right-click the **eShopLegacyWebForms** project, and then click **Manage NuGet Packages**.

    > [!div class="mx-imgBorder"]
    > ![Image of the context menu for the **eShopLegacyWebForms** project in the Solution Explorer window. The user has clicked **Manage NuGet Packages**](..\media\4-manage-nuget.png)

1. In the **NuGet Package Manager** window, click **Browse**. In the **Search** box, type **Microsoft.Web.RedisSessionStateProvider**, select the **Microsoft.Web.RedisSessionStateProvider** package, and then click **Install**.


    > [!div class="mx-imgBorder"]
    > ![Image of the **NuGet Package Manager** window. The user is installing the **Microsoft.Web.RedisSessionStateProvider** package](..\media\4-install-package.png)

1. If the **Preview Changes** window appears, click **OK**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Preview Changes** window. The user has clicked **OK**](..\media\4-preview-changes.png)

1. In the **License Acceptance** window, click **I Accept**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **License Acceptance** window. The user has clicked **I Accept**](..\media\4-license.png)


1. In the **Solution Explorer** window, select the **Web.config** file.

1. In the **web.config** file, find the **sessionState** section. It looks like this:

    ```xml
    <sessionState mode="Custom" customProvider="MySessionStateStore">
      <providers>
        <!-- For more details check https://github.com/Azure/aspnet-redis-providers/wiki -->
        <!-- Either use 'connectionString' OR 'settingsClassName' and 'settingsMethodName' OR use 'host','port','accessKey','ssl','connectionTimeoutInMilliseconds' and 'operationTimeoutInMilliseconds'. -->
        <!-- 'throwOnError','retryTimeoutInMilliseconds','databaseId' and 'applicationName' can be used with both options. -->
        <!--
          <add name="MySessionStateStore" 
            host = "127.0.0.1" [String]
            port = "" [number]
            accessKey = "" [String]
            ssl = "false" [true|false]
            throwOnError = "true" [true|false]
            retryTimeoutInMilliseconds = "5000" [number]
            databaseId = "0" [number]
            applicationName = "" [String]
            connectionTimeoutInMilliseconds = "5000" [number]
            operationTimeoutInMilliseconds = "1000" [number]
            connectionString = "<Valid StackExchange.Redis connection string>" [String]
            settingsClassName = "<Assembly qualified class name that contains settings method specified below. Which basically return 'connectionString' value>" [String]
            settingsMethodName = "<Settings method should be defined in settingsClass. It should be public, static, does not take any parameters and should have a return type of 'String', which is basically 'connectionString' value.>" [String]
            loggingClassName = "<Assembly qualified class name that contains logging method specified below>" [String]
            loggingMethodName = "<Logging method should be defined in loggingClass. It should be public, static, does not take any parameters and should have a return type of System.IO.TextWriter.>" [String]
            redisSerializerType = "<Assembly qualified class name that implements Microsoft.Web.Redis.ISerializer>" [String]
          />
        --> 
        <add name="MySessionStateStore" type="Microsoft.Web.Redis.RedisSessionStateProvider" host="" accessKey="" ssl="true" />
      </providers>
    </sessionState>
    ```

1. Remove the commented out content, and amend the entry for **MySessionStateStore** as shown below. Replace *\<youralias>\>* with the value of the *$useralias* PowerShell variable, and replace *\<primarykey\>* with the value of the *$rediskey* PowerShell variable.

    ```xml
    <sessionState mode="Custom" customProvider="MySessionStateStore">
      <providers>
        <add name="MySessionStateStore" 
             type="Microsoft.Web.Redis.RedisSessionStateProvider" 
             host="<youralias>-workshop-cache.redis.cache.windows.net" 
             accessKey="<primarykey"> 
             ssl="true" />
      </providers>
    </sessionState>
    ```

1. Find the **\<sessionState mode="InProc" />** element near the start of the **\<system.web>** section, and comment it out, as shown below:

    ```xml
    ...
    <system.web>
      <compilation debug="true" targetFramework="4.7.2" />
      <httpRuntime targetFramework="4.6.1" requestValidationMode="2.0" />
      <!--sessionState mode="InProc" /-->
      ...
    </system.web>
    ```

## Deploy the web app to Azure

1.  In the **Solution Explorer** window, expand the **Models** folder, expand the **Infrastructure** folder, and then click the **dbo.catalog_brand_hilo.Sequence.sql** file.

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window. The user has selected the **dbo.catalog_brand_hilo.Sequence.sql** file.](..\media\4-edit-sql-file.png)

1. In the SQL file, comment out the **USE** statement at the start of the file, as shown below:

    ```sql
    -- USE [Microsoft.eShopOnContainers.Services.CatalogDb]
    /****** Object:  Sequence [dbo].[catalog_brand_hilo]    Script Date: 16/08/2017 11:21:49 ******/
    CREATE SEQUENCE [dbo].[catalog_brand_hilo] 
      AS [bigint]
      START WITH 1
      INCREMENT BY 10
      MINVALUE -9223372036854775808
      MAXVALUE 9223372036854775807
    CACHE 
    ```

1. Repeat step 2 for the **dbo.catalog_hilo.Sequence.sql** file, and the **dbo.catalog_type_hilo.Sequence.sql** file.

    > [!NOTE]
    > The scripts in these files run when the database is seeded with data. This seeding happens automatically the first time the application is run against a new database. The statements that you've commented out are only required when running the application locally. When the application runs using the Azure SQL Server database, the database to be used is specified as part of the connection string.

1. If you aren't currently signed in to your Azure account in Visual Studio, in the upper right of the toolbar, click **Sign in**. Follow the instructions and sign in.

    > [!div class="mx-imgBorder"]
    > ![Image of the Visual Studio toolbar. The user has clicked **Sign in**.](..\media\4-toolbar-sign-in.png)

1. In the **Solution Explorer** window, right-click the **eShopLegacyWebForms** project, and then click **Publish**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window. The user has selected the **Publish** command on the context menu for the **eShopLegacyWebForms** project.](..\media\4-project-publish.png)

1. If you haven't previously deployed the web app and configured the connection to the Azure SQL Database, either complete the following substeps, or go to Step 7 below.

    1. Switch back to the Azure PowerShell window, and run the following command to allow your computer to access the Azure SQL Database server you created in the Setup unit. Replace ***YourIPAddress*** with the public IP address of your computer.

        ```PowerShell
        New-AzSqlServerFirewallRule -ResourceGroupName $resourcegroupname -ServerName $servername -FirewallRuleName "AllowDesktop" -StartIpAddress YourIPAddress -EndIpAddress YourIPAddress
        ``` 

        > [!NOTE]
        > Make sure you specify the IP address of your computer, and not the IP address of the host running the Cloud Shell.

    1. Return to the **Pick a publish target** window in Visual Studio, select **Azure App Service**, click **Select Existing**, and then click **Create Profile**.

        > [!div class="mx-imgBorder"]
        > ![Image of the **Pick a publish target** window. The user is about to create a new profile for publishing the web app to Azure App Service.](..\media\4-pick-publishing-target.png)

    1. In the **App Service** window, select your Azure subscription, set the **View** to **Resource type**, expand **Web App**, select the Azure web app you created during the Setup unit, and then click **OK**.

        > [!div class="mx-imgBorder"]
        > ![Image of the **App Service** window. The user has selected the Azure web app created earlier.](..\media\4-select-app-service.png)

    1. On the **Publish** page, click **Edit**.

        > [!div class="mx-imgBorder"]
        > ![Image of the Publish page. The user has clicked **Edit**.](..\media\4-publish-edit.png)

    1. On the **Connection** page of the **Publish** dialog box, click **Next**.

        > [!div class="mx-imgBorder"]
        > ![Image of the **Connection** page of the Publish dialog box. The user has clicked **Next**.](..\media\4-publish-next.png)

    1. On the **Settings** page, by the ***Remote connection string*** text box, click the ellipsis button (...)

        > [!div class="mx-imgBorder"]
        > ![Image of the **Settings** page of the Publish dialog box. The user has clicked the ellipsis button for the remote connection string.](..\media\4-publish-ellipsis.png)

    1. In the **Destination Connection String** dialog box, specify the values in the following table, and then click **OK**.

        | Field | Value |
        |-|-|
        | Data source | Microsoft SQL Server (SqlClient) |
        | Server name |  Specify the value in the **$servername** PowerShell variable. Append the text **".database.windows.net"** to the end of the server name |
        | Authentication | SQL Server Authentication |
        | User name | Specify the value in the **$serveradminname** PowerShell variable |
        | Password | Specify the value in the **$serveradminpassword** PowerShell variable |
        | Save my password | Checked |
        | Select or enter a database name | eShop |


        > [!div class="mx-imgBorder"]
        > ![Image of the **Destination Connection String** dialog box. The user has entered the settings required to connect to the **eShop** database running in Azure SQL Database.](..\media\4-connection-string.png)

    1. Back on the **Settings** page, check **Use this connection string at runtime (update destination web.config)** if it isn't already selected, and then click **Save**.

        > [!div class="mx-imgBorder"]
        > ![Image of the **Settings** page of the Publish dialog box. The user has clicked **Save**.](..\media\4-publish-save.png)

1. On the **Publish** page, click **Publish**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Publish** page. The user has clicked **Publish**.](..\media\4-webapp-publish.png)

1. Wait while the web app is built and deployed to the App Service. When deployment is complete, the web app will start and Visual Studio opens a web browser. Browse the website to verify that the web app operates in the same manner as it did before, when running locally. Leave the page for the web app open in the browser.

## View cache activity

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the hamburger menu, click **All resources**.

    > [!div class="mx-imgBorder"]
    > ![Image of the hamburger menu in the Azure portal. The user has clicked **All resources**.](..\media\4-all-resources.png)

1. On the **All resources** page, click the Azure Cache for Redis instance you created earlier. It will have the name **\<useralias\>-workshop-cache**.

1. On the **Overview** blade for the cache, click **Console**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Overview** blade for the cache. The user has clicked **Console**.](..\media\4-cache-overview.png)

1. In the **Redis Console** window, at the **\>** prompt, type **monitor**, and press return.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Console** window. The user started the Redis monitor.](..\media\4-start-monitor.png)

1. Return to the browser window for the web app, and browse through the details of products.

    > [!NOTE]
    > The Redis *monitor* command affects the performance of all operations that use the cache, so you may notice the web app being slower to respond than normal. You shouldn't use the *monitor* command in a production system.

1. Return to the **Redis Console** window for the cache. You should see messages displaying the cache activity that took place while you browsed products. The keys that have **_Data** and **_Internal** suffices identify session state information.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Console** window, displaying the activity generated while browsing the web app.](..\media\4-monitor-activity.png)

1. Press Enter to stop monitoring activity.