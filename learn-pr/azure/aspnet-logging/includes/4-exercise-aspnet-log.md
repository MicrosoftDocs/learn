There are many different logging frameworks available for .NET developers to use, including custom designed solutions. The web application in this module is configured to use the popular Log4Net framework. Log4Net is designed to work with log levels and appenders. You can mix and match which appenders are active for which log levels. If you're unfamiliar with this approach to logging, take a look at the [Log4Net](https://logging.apache.org/log4net/) documentation before proceeding.

The logger currently writes to a local file. While this approach is fine for a web app running on your desktop, it isn't appropriate for a web app hosted by Azure App Service. In this exercise, you'll modify the logger to record information in Azure Blob storage. You'll also configure the logger to write to Application Insights (AppInsights). This approach enables you to consolidate the logs into a common location in Azure, and then use AppInsights to capture custom telemetry based on information in the logs.

## Create a Blob storage account for holding log data

1. In the Cloud Shell window on the right, run the command shown below to define PowerShell variables containing the names of the storage account and blob container to be created. 

    ```PowerShell
    $storageaccountname = (-join($useralias, "storage"))
    $storagecontainername = "workshopcontainer"
    ```

1. Create an Azure Blob storage account.

    ```PowerShell
    $storageaccount = New-AzStorageAccount `
        -ResourceGroupName $resourcegroupname `
        -Location $location `
        -AccountName $storageaccountname `
        -SkuName Standard_LRS 
    ```

1. Create a container to hold the log data, in the storage account.

    ```PowerShell
    New-AzStorageContainer `
        -Name $storagecontainername `
        -Permission Blob `
        -Context $storageaccount.Context
    ```

1. Generate the connection string for this storage account, and record it to use later.

    ```PowerShell
    $storageaccountkey = (Get-AzStorageAccountKey `
        -ResourceGroupName $resourcegroupname `
        -Name $storageaccountname)[0].Value

    $storageconnectionstring = `
        ((-join('DefaultEndpointsProtocol=https;AccountName=', `
        $storageaccountname, ';AccountKey=', $storageaccountkey,`
        ';EndpointSuffix=core.windows.net' )))
    ```

1. Define a PowerShell variable containing the name of the AppInsights instance to be created.

    ```PowerShell
    $appinsightsname = (-join($useralias, "-insights"))
    ```

1. Create an AppInsights instance. 

    > [!NOTE]
    > Neither the Azure PowerShell nor the Azure CLI have a direct command for creating this resource type at this time. You must use the general purpose Azure Resource creation command shown below. When prompted, select **Y** and press Enter to create the AppInsights instance.

    ```PowerShell
    $appinsights = New-AzResource `
        -ResourceName $appinsightsname `
        -ResourceGroupName $resourcegroupname `
        -Location $location `
        -ResourceType "Microsoft.Insights/components" `
        -Properties (-join('{"ApplicationId":"', $appinsightsname, '", "Application_Type":"other"}'))
    ```

1. Retrieve the AppInsights instrumentation key.

    ```PowerShell
    $appinsightskey = $appinsights.Properties.InstrumentationKey 
    ```

## Examine the current logging implementation in the web app

1. Return to Visual Studio, editing the **eShopLegacyWebForms** solution.

1. In the **Solution Explorer** window, click the **log4Net.xml** file. This file contains the configuration information for the Log4Net logger. You should see the following XML markup:

    ```xml
    <log4net>
      <root>
        <level value="ALL" />
        <appender-ref ref="file" />
      </root>
      <appender name="file" type="log4net.Appender.RollingFileAppender">
        <file value="logFiles\myapp.log" />
        <appendToFile value="true" />
        <rollingStyle value="Size" />
        <maxSizeRollBackups value="5" />
        <maximumFileSize value="10MB" />
        <staticLogFileName value="true" />
        <layout type="log4net.Layout.PatternLayout">
          <conversionPattern value="%date [%thread] %property{activity} %level %logger - %property{requestinfo}%newline%message%newline%newline" />
        </layout>
      </appender>
    </log4net>
    ```

    The important points to note about this configuration are:

    - The logging level is set to **ALL**, so all events are recorded
    - The log is implemented using a single **file** appender
    - The log file is written to the file **myapp.log** in the **logFiles** folder
    - The ***\<layout\>*** element specifies how the log data is formatted

1. In the **Solution Explorer** window, expand the **Default.aspx** node, and click **Default.aspx.cs**. This file contains the C# code that runs when the home page is viewed.

1. In the **Code View** window, at the start of the **_Default** class, note that the page creates a reference to the logger in a variable named **_log**, as shown below:

    ```csharp
    public partial class _Default : Page
    {
        private static readonly ILog _log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        ...
    }
    ```

1. Examine the **Page_Load** method. This method contains the logic that runs when the page is displayed. The method includes statements that write log data using the **_log** variable as the operation takes place:

    ```csharp
    protected void Page_Load(object sender, EventArgs e)
    {
        if (PaginationParamsAreSet())
        {
            ...
            _log.Info($"Now loading... /Default.aspx?size={size}&index={index}");
        }
         else
        {
            ...
            _log.Info($"Now loading... /Default.aspx?size={DefaultPageSize}&index={DefaultPageIndex}");
        }
        ...
        }
    ```

1. In the **Solution Explorer** window, expand the **Catalog** folder, expand the **Create.aspx** node, and click **Create.aspx.cs**. This file contains the C# code that runs when the user creates a new item in the product catalog.

1. Notice that the code in this file also creates a reference to the logger, and records a message when a new item is being created:

    ```csharp
    public partial class Create : System.Web.UI.Page
    {
        private static readonly ILog _log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        ...
        
        protected void Page_Load(object sender, EventArgs e)
        {
            _log.Info($"Now loading... /Catalog/Create.aspx");
        }

        ...
    }
    ```

1. If you have time, examine the **Delete.aspx.cs**, **Details.aspx.cs**, and **Edit.aspx.cs** files. You should notice the same pattern of logging in each of these files.

1. Using Windows Explorer on your computer, move to the **MigrationWorkshop\eShopModernizing\eShopLegacyWebFormsSolution\src\eShopLegacyWebForms** folder.

1. Verify that this file contains a subfolder named **logFiles**.

    > [!div class="mx-imgBorder"]
    > ![Image of Windows Explorer showing the contents of the folder for the web app. The **logFiles** folder is highlighted](..\media\4-logfiles-folder.png)

1. Move to the **logFiles** folder, and verify that it contains a text file named **myapp**. This file is a log file created when you ran the web app earlier, during the Setup unit.

1. Open the file using Notepad. The file should contain text that resembles that shown below. Each line is a log message containing the date, time, log level, and text output by the various webpages. The messages are formatted using the layout described by the ***\<layout\>*** element in the **log4Net.xml** file.

    ```text
    2020-04-29 12:53:42,629 [26] (null) DEBUG eShopLegacyWebForms.Global - /, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363
    Application_BeginRequest

    2020-04-29 12:53:42,629 [26] (null) INFO eShopLegacyWebForms._Default - /, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363
    Now loading... /Default.aspx?size=10&index=0

    2020-04-29 12:53:48,004 [26] (null) DEBUG eShopLegacyWebForms.Global - /Catalog/Edit/2, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363
    Application_BeginRequest

    2020-04-29 12:53:48,035 [26] (null) INFO eShopLegacyWebForms.Catalog.Edit - /Catalog/Edit/2, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363
    Now loading... /Catalog/Edit.aspx?id=2

    2020-04-29 12:53:57,426 [24] (null) DEBUG eShopLegacyWebForms.Global - /Catalog/Edit/2, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18363
    Application_BeginRequest

    ...
    ```

## Modify the logging configuration to write to an Azure storage blob

1. Return to Visual Studio, and open the **Log4Net.xml** file in the **Code View** window.

1. Replace the contents of the file with the text shown below. This configuration defines two new appenders:
    
    - The **aiAppender** appender writes to AppInsights.
    - The **azureAppendBlobAppender** appender writes to a blob in your storage account. In this appender, replace *YourStorageAccountConnectionString* with the value in the **$storageconnectionstring** PowerShell variable. You can display the value of this variable with the command `Write-Host $storageconnectionstring`.

    ```xml
    <log4net> 
      <root> 
        <level value="ALL" /> 
        <appender-ref ref="aiAppender" /> 
        <appender-ref ref="azureAppendBlobAppender" /> 
      </root> 
      <!-- https://blog.ehn.nu/2014/11/using-log4net-for-application-insights/ --> 
      <appender name="aiAppender" type="Microsoft.ApplicationInsights.Log4NetAppender.ApplicationInsightsAppender, Microsoft.ApplicationInsights.Log4NetAppender"> 
        <layout type="log4net.Layout.PatternLayout"> 
          <conversionPattern value="%date [%thread] %property{activity} %level %logger - %property{requestinfo}%newline%message%newline%newline" /> 
        </layout> 
      </appender> 
      <!-- http://stemarie.github.io/log4net.Azure/ --> 
      <appender name="azureAppendBlobAppender" type="log4net.Appender.AzureAppendBlobAppender, log4net.Appender.Azure"> 
        <param name="ContainerName" value="workshopcontainer"/> 
        <param name="DirectoryName" value="eShopModernizedLogs"/> 
        <!--You can either specify a connection string or use the ConnectionStringName property instead--> 
        <param name="ConnectionString" value="YourStorageAccountConnectionString"/> 
        <bufferSize value="1" /> 
      </appender> 
    </log4net>
    ```

1. In the **Solution Explorer** window, click the **ApplicationInsights.config** file to display it in the **Code View** window.

1. Add the instrumentation key for your AppInsights instance above the **\<TelemetryInitializers\>** node, as shown below. Replace *YourAppinsightsKey* with the value in the **$appinsightskey** PowerShell variable. 

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <ApplicationInsights xmlns="http://schemas.microsoft.com/ApplicationInsights/2013/Settings">
      <InstrumentationKey>
        YourAppinsightsKey
      </InstrumentationKey>
	  <TelemetryInitializers>
		...
	  </TelemetryInitializers>
      ...
    </ApplicationInsights>
    ```

1. On the **Tools** menu, click **NuGet Package Manager**, and then click **Package Manager Console**.

1. In the **Package Manager Console** window, run the following commands to install the Log4Net packages required for writing to AppInsights and Azure Blob storage.

    ```PowerShell
    Install-Package Microsoft.ApplicationInsights.Log4NetAppender
    Install-Package log4net.Appender.Azure
    ```

1. Open the **web.config** file in the **Code View** window, and scroll to the end of the file. 

1. Comment out the **\<log4net\>** section at the end of the file. This section was generated by NuGet. If it's left in place, it will override the settings in the **log4net.xml** file.

    ```xml
    <configuration>
      ... 
      <!--log4net>
        <root>
          <level value="ALL" />
          <appender-ref ref="aiAppender" />
        </root>
        <appender name="aiAppender" type="Microsoft.ApplicationInsights.Log4NetAppender.ApplicationInsightsAppender, Microsoft.ApplicationInsights.Log4NetAppender">
          <layout type="log4net.Layout.PatternLayout">
            <conversionPattern value="%message%newline" />
          </layout>
        </appender>
      </log4net-->
    </configuration>
    ```

## Deploy the web app to Azure

1.  In the **Solution Explorer** window, expand the **Models** folder, expand the **Infrastructure** folder, and then click the **dbo.catalog_brand_hilo.Sequence.sql** file.

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window. The user has selected the **dbo.catalog_brand_hilo.Sequence.sql** file.](..\media\4-edit-sql-file.png)

1. In the SQL file, comment out the **USE** statement at the start of the file, as shown below.

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

1. If you haven't previously deployed the web app and configured the connection to Azure SQL Database, complete the following substeps, otherwise go to Step 7 below.

    1. Switch back to the Azure PowerShell window, and run the following command to allow your computer to access the Azure SQL Database server you created in the Setup unit. Replace ***YourIPAddress*** with the public IP address of your computer.

        ```PowerShell
        New-AzSqlServerFirewallRule `
            -ResourceGroupName $resourcegroupname `
            -ServerName $servername `
            -FirewallRuleName "AllowDesktop" `
            -StartIpAddress YourIPAddress `
            -EndIpAddress YourIPAddress
        ``` 

        > [!NOTE]
        > Make sure you specify the public IP address of your computer, and not the IP address of the host running the Cloud Shell.

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

1. Wait while the web app is built and deployed to the App Service. When deployment is complete, the web app will start and Visual Studio opens a web browser. Verify that the web app operates in the same manner as it did before, when running locally. Browse the website, edit one or more products, create a new product, and then delete it.

## View the log data and examine the AppInsights telemetry

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the home page, in the search box, type **Storage**, select **Storage accounts**, and then press Enter.

    > [!div class="mx-imgBorder"]
    > ![Image of the Home page in the Azure portal. The user is searching for **Storage accounts**.](..\media\4-search-storage.png)

1. On the **Storage accounts** page, click the storage account you created earlier for storing the web application logs. In this exercise, the storage account name will be prefixed with your ID and the number you specified when you created you user alias in the Setup unit. Other storage accounts might exist for use by the Cloud Shell, and other services.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Storage accounts** page in the Azure portal. The user has clicked the storage account containing the web application logs.](..\media\4-select-storage.png)

1. On the **Storage account** page, click **Overview**, and then click **Containers**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Storage account** page in the Azure portal. The user has clicked **Containers**.](..\media\4-containers.png)

1. On the **Containers** page, click the **workshopcontainer** container.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Containers** page in the Azure portal. The user has clicked the **workshopcontainer** container.](..\media\4-workshop-container.png)

1. On the **Blobs** page, click the **eShopModernizedLogs** folder. 

    > [!div class="mx-imgBorder"]
    > ![Image of the **Blob folders** page in the Azure portal. The user has clicked the **eShopModernizedLogs** folder.](..\media\4-workshop-blob.png)

1. Click the append blob that appears in this folder. This blob will be named after the current date, with the suffix **.entry.log.xml**. 

    > [!div class="mx-imgBorder"]
    > ![Image of the **Blobs** page in the Azure portal. The user has clicked the blob containing the log entries generated by the web app.](..\media\4-log-blob.png)

1. On the details pane for the blob, click **Download**.

    > [!div class="mx-imgBorder"]
    > ![Image of the blob details page in the Azure portal. The user has clicked **Download**.](..\media\4-blob-download.png)

1. Open the file you downloaded using Notepad, and browse the contents. The file contains the log entries written by the web app. The log entries should resemble the ones shown in the following example:

    ```xml
    <LogEntry>
      <UserName>IIS APPPOOL\jpws-1671809210-webapp</UserName>
      <TimeStamp>04/30/2020 11:01:05</TimeStamp>
      <ThreadName>102</ThreadName>
      <LoggerName>eShopLegacyWebForms._Default</LoggerName>
      <Level>INFO</Level>
      <Identity></Identity>
      <Domain>/LM/W3SVC/1519868627/ROOT-2-132327180384305201</Domain>
      <CreatedOn>04/30/2020 11:01:05</CreatedOn>
      <RenderedMessage>Now loading... /Default.aspx?size=10&amp;index=0</RenderedMessage>
      <Location>eShopLegacyWebForms._Default.Page_Load(C:\MigrationWorkshop\eShopModernizing\eShopLegacyWebFormsSolution\src\eShopLegacyWebForms\Default.aspx.cs:37)</Location>
    </LogEntry>
    <LogEntry>
      <UserName>IIS APPPOOL\jpws-1671809210-webapp</UserName>
      <TimeStamp>04/30/2020 11:01:14</TimeStamp>
      <ThreadName>110</ThreadName>
      <LoggerName>eShopLegacyWebForms.Global</LoggerName>
      <Level>DEBUG</Level>
      <Identity></Identity>
      <Domain>/LM/W3SVC/1519868627/ROOT-2-132327180384305201</Domain>
      <CreatedOn>04/30/2020 11:01:14</CreatedOn>
      <RenderedMessage>Application_BeginRequest</RenderedMessage>
      <Location>eShopLegacyWebForms.Global.Application_BeginRequest(C:\MigrationWorkshop\eShopModernizing\eShopLegacyWebFormsSolution\src\eShopLegacyWebForms\Global.asax.cs:77)</Location>
    </LogEntry>
    ```

    The **\<RenderedMessage\>** element in each entry contains the data written using the **_log** object in the application code.

1. Close Notepad and return to the Azure portal.

1. On the hamburger menu in the portal, click **All services**.

    > [!div class="mx-imgBorder"]
    > ![Image of the hamburger menu in the Azure portal. The user has clicked **All services**.](..\media\4-hamburger-services.png)

1. On the **All service** page, in the search box, type **Application Insights**, and then press Enter.

1. On the **Application Insights** page, click the AppInsights instance you created earlier. The **Overview** page should appear, displaying the general statistics for the web app.

1. Under **Investigate**, click **Performance**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Application Insights blade. The user has clicked **Performance**.](..\media\4-performance.png)

1. On the **Performance** blade, select any operation, and then click **Samples** in the **Drill into..." section**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Performance** blade. The user has selected an operation and is drilling into the details.](..\media\4-select-operation.png)

    > [!NOTE]
    > It can take several minutes for the logging data to appear in Blob storage. You might need to wait and refresh the page if no operations are displayed.

1. In the **Select a sample operation** blade, click any of the samples displayed.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Select a sample operation** blade. The user has selected a sample operation.](..\media\4-select-sample.png)

1. On the **End-to-end transaction details** blade, click **View all telemetry**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **End-to-end transaction details** blade. The user has clicked **View all telemetry**.](..\media\4-end-to-end-details.png)

1. On the detailed telemetry page, select any logging event. Logging events are identified as **Verbose** or **Information**. If the sample operation doesn't display any logging events, click a different sample in the left pane.

    > [!div class="mx-imgBorder"]
    > ![Image of the **End-to-end transaction details** blade. The user has selected a logging event.](..\media\4-select-logging.png)

1. On the **Trace** pane, in the **Message** box, click **Show more**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Trace** pane.](..\media\4-trace-pane.png)

    The entire log message will appear in a new window. The log message includes the data written using the **_log** object in the application code.

    > [!div class="mx-imgBorder"]
    > ![Image of the window displaying the full log message.](..\media\4-log-message.png)

1. If you have time, examine the log events for other operations, and verify that the logging messages written by the web app are included.
