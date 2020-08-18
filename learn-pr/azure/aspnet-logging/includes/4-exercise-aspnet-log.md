.NET developers can choose from many logging frameworks that are available, including custom solutions. The web application in this module is configured to use the popular Log4Net framework. Log4Net is designed to work with log levels and appenders. You can mix and match appenders that are active for different log levels. If you're unfamiliar with this approach to logging, take a look at the [Log4Net](https://logging.apache.org/log4net/) documentation before you proceed.

The sample logger currently is set to write to a local file. Although this approach is fine for a web app running on your desktop, it doesn't meet the needs of a web app that's hosted by Azure App Service. In this exercise, you'll modify the logger to record information in Azure Blob storage. You'll also set the logger to write to Azure Application Insights. You can consolidate the logs in a common location in Azure, and then use Application Insights to capture custom telemetry that's based on information in the logs.

## Create a Blob storage account to hold log data

1. In Azure Cloud Shell on the right, run the following command to define PowerShell variables that contain the names of the storage account and the blob container to create: 

    ```powershell
    $storageaccountname = (-join($useralias, "storage"))
    $storagecontainername = "workshopcontainer"
    ```

1. Create an Azure Blob storage account:

    ```powershell
    $storageaccount = New-AzStorageAccount `
        -ResourceGroupName $resourcegroupname `
        -Location $location `
        -AccountName $storageaccountname `
        -SkuName Standard_LRS 
    ```

1. Create a container in the storage account to hold the log data:

    ```powershell
    New-AzStorageContainer `
        -Name $storagecontainername `
        -Permission Blob `
        -Context $storageaccount.Context
    ```

1. Generate the connection string for this storage account. Be sure to record the connection string to use later.

    ```powershell
    $storageaccountkey = (Get-AzStorageAccountKey `
        -ResourceGroupName $resourcegroupname `
        -Name $storageaccountname)[0].Value

    $storageconnectionstring = `
        ((-join('DefaultEndpointsProtocol=https;AccountName=', `
        $storageaccountname, ';AccountKey=', $storageaccountkey,`
        ';EndpointSuffix=core.windows.net' )))
    ```

1. Define a PowerShell variable that contains the name of the Application Insights instance to create:

    ```powershell
    $appinsightsname = (-join($useralias, "-insights"))
    ```

1. Create an Application Insights instance. 

    > [!NOTE]
    > Currently, Azure PowerShell and the Azure CLI don't have direct commands for creating this resource type. You must use the general purpose Azure resource creation command that's used in the following code. When prompted, select **Y**, and then press Enter to create the Application Insights instance.

    ```powershell
    $appinsights = New-AzResource `
        -ResourceName $appinsightsname `
        -ResourceGroupName $resourcegroupname `
        -Location $location `
        -ResourceType "Microsoft.Insights/components" `
        -Properties (-join('{"ApplicationId":"', $appinsightsname, '", "Application_Type":"other"}'))
    ```

1. Retrieve the Application Insights instrumentation key:

    ```powershell
    $appinsightskey = $appinsights.Properties.InstrumentationKey 
    ```

## Examine the current logging implementation in the web app

1. In Visual Studio, edit the eShopLegacyWebForms solution.

1. In Solution Explorer, select the *log4Net.xml* file. The file contains the configuration information for the Log4Net logger. You should see the following XML markup:

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

    These are important points to note about this configuration:

    - The logging level is set to **ALL** so that all events are recorded.
    - The log is implemented by using a single file appender.
    - The log file is written to the *myapp.log* file in the *logFiles* folder.
    - The **\<layout\>** element sets the formatting for the log data.

1. In Solution Explorer, expand the **Default.aspx** node, and then select **Default.aspx.cs**. This file contains the C# code that runs when the home page is viewed.

1. In Code View, at the start of the **_Default** class, the page creates a reference to the logger in a variable named **_log**:

    ```csharp
    public partial class _Default : Page
    {
        private static readonly ILog _log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        ...
    }
    ```

1. Examine the **Page_Load** method. This method contains the logic that runs when a page is loaded in the app. The method includes statements that write log data by using the **_log** variable as the operation occurs.

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

1. In Solution Explorer, expand the **Catalog** folder, expand the **Create.aspx** node, and then select **Create.aspx.cs**. This file contains the C# code that runs when the user creates a new item in the product catalog. The code in this file also creates a reference to the logger and records a message when a new item is created.

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

   If you take a look at the *Delete.aspx.cs*, *Details.aspx.cs*, and *Edit.aspx.cs* files, you should see the same pattern of logging in each of these files.

1. In File Explorer in Windows, go to the *MigrationWorkshop\eShopModernizing\eShopLegacyWebFormsSolution\src\eShopLegacyWebForms* folder. Verify that this folder contains a subfolder named *logFiles*.

    :::image type="content" source="../media/4-logfiles-folder.png" alt-text="Screenshot of File Explorer in Windows, showing the eShopLegacyWebForms folder, with the logFiles subfolder highlighted.":::
    
1. Verify that the *logFiles* folder contains a text file named *myapp*. This file is a log file that was created when you ran the web app in the setup unit.

1. Use Notepad to open the *myapp* file. The file should contain text that resembles the following example. Each line is a log message that contains the date, time, log level, and text output for pages in the app that were loaded in a browser. The messages are formatted in the layout that's described by the **\<layout\>** element in the *log4Net.xml* file.

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

1. In Visual Studio, in Code View, open the *Log4Net.xml* file.

1. Replace the contents of the file with the following text: 

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

   The configuration text defines two new appenders:
    
   - **aiAppender**: Writes to Application Insights.
   - **azureAppendBlobAppender**: Writes to Blob storage in your storage account. In this appender, replace *YourStorageAccountConnectionString* with the value in the **$storageconnectionstring** PowerShell variable. You can use the command `Write-Host $storageconnectionstring` to see the value of this variable.

1. In Solution Explorer, select the *ApplicationInsights.config* file to open it in Code View.

1. Add the instrumentation key for your Application Insights instance before the **\<TelemetryInitializers\>** node, as shown in the following example. Replace *YourAppinsightsKey* with the value in the **$appinsightskey** PowerShell variable. 

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

1. In the **Tools** menu, select **NuGet Package Manager** > **Package Manager Console**.

1. In Package Manager Console, run the following commands to install the Log4Net packages that are required for writing to Application Insights and Azure Blob storage:

    ```powershell
    Install-Package Microsoft.ApplicationInsights.Log4NetAppender
    Install-Package log4net.Appender.Azure
    ```

1. In Code View, open the *web.config* file and scroll to the end of the file. 

1. Comment out the **\<log4net\>** section at the end of the file. (This section is generated by NuGet. If the section isn't deleted, it overrides the settings in the *log4net.xml* file.)

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

1.  In Solution Explorer, expand the **Models** folder, expand the **Infrastructure** folder, and then select the **dbo.catalog_brand_hilo.Sequence.sql** file to open the file.

    :::image type="content" source="../media/4-edit-sql-file.png" alt-text="Screenshot of Solution Explorer, with the dbo.catalog_brand_hilo.Sequence.sql file highlighted.":::

1. Comment-out the `USE` statement at the start of the file:

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

1. Repeat step 2 for the *dbo.catalog_hilo.Sequence.sql* file and the *dbo.catalog_type_hilo.Sequence.sql* file.

    > [!NOTE]
    > The scripts in these files run when data is added to the database. Data is added automatically the first time the application is run with a new database as the target. The statements that you commented out are required only when you run the application locally. When the application runs with the Azure SQL Database instance as the target, the database to be used is specified as part of the connection string.

1. Ensure that you are signed in to your Azure account in Visual Studio.


   :::image type="content" source="../media/4-toolbar-sign-in.png" alt-text="Screenshot of the Visual Studio toolbar, with the Sign in link highlighted.":::

1. In Solution Explorer, right-click the **eShopLegacyWebForms** project, and then select **Publish**.

   :::image type="content" source="../media/4-project-publish.png" alt-text="Screenshot of Solution Explorer, with the Publish command in the context menu for the eShopLegacyWebForms project highlighted.":::

1. If you didn't previously deploy the web app and configure the connection to Azure SQL Database, complete the following substeps. Otherwise, go to step 7.

    1. In the Azure PowerShell window, run the following command to give your computer access the SQL Database server you created in the setup unit. Replace *YourIPAddress* with the public IP address of your computer.

        ```powershell
        New-AzSqlServerFirewallRule `
            -ResourceGroupName $resourcegroupname `
            -ServerName $servername `
            -FirewallRuleName "AllowDesktop" `
            -StartIpAddress YourIPAddress `
            -EndIpAddress YourIPAddress
        ``` 

        > [!NOTE]
        > Make sure you specify the public IP address of your computer, not the IP address of the host that's running Cloud Shell.

    1. In Visual Studio, on the **Pick a publish target** pane, select **App Service**, select **Select Existing**, and then select **Create Profile**.

        :::image type="content" source="../media/4-pick-publishing-target.png" alt-text="Screenshot of the Pick a publish target pane, with App Service highlighted and the Select Existing option selected.":::
        
    1. In the **App Service** pane:
       1. Select your Azure subscription.
       1. For **View**, select **Resource type**.
       1. Expand **Web App**, and then select the Azure web app you created in the setup unit.
       1. Select **OK**.

       :::image type="content" source="../media/4-select-app-service.png" alt-text="Screenshot of the App Service pane, with the View value and the web app that was created earlier highlighted.":::
    
    1. On the **Publish** page, select **Edit**.

       :::image type="content" source="../media/4-publish-edit.png" alt-text="Screenshot of the Publish page, with the Edit button highlighted.":::

    1. In the **Publish** dialog box, on the **Connection** tab, select **Next**.

        :::image type="content" source="../media/4-publish-next.png" alt-text="Screenshot of the Connection tab of the Publish dialog box, with the Next button highlighted.":::
                
   1. On the **Settings** tab, to the right of the ***Remote connection string*** text box, select the ellipsis (**...**).

        :::image type="content" source="../media/4-publish-ellipsis.png" alt-text="Screenshot of the Settings tab of the Publish dialog box, with the ellipses button highlighted.":::
    
    1. In the **Destination Connection String** dialog box, set the values that are described in the following table, and then select **OK**:

        | Field | Action |
        |-|-|
        | Data source | Select or enter **Microsoft SQL Server (SqlClient)**. |
        | Server name |  Enter the value from the **$servername** PowerShell variable. Append the text ***.database.windows.net*** to the end of the server name. |
        | Authentication | Select **SQL Server Authentication**. |
        | User name | Enter the value from the **$serveradminname** PowerShell variable. |
        | Password | Enter the value from the **$serveradminpassword** PowerShell variable. |
        | Save my password | Make sure that the check box is selected. |
        | Select or enter a database name | Select or enter **eShop**. |

        :::image type="content" source="../media/4-connection-string.png" alt-text="Screenshot of the Destination Connection String dialog box, with the settings required to connect to the eShop database running in Azure SQL Database selected or entered and the OK button highlighted.":::

   1. On the **Settings** tab, select the **Use this connection string at runtime (update destination web.config)** check box, and then select **Save**.

       :::image type="content" source="../media/4-publish-save.png" alt-text="Screenshot of the Settings tab of the Publish dialog box, with the Use this connection string at runtime (update destination web.config) check box select and the Save button highlighted.":::

1. On the **Publish** page, select **Publish**.

    :::image type="content" source="../media/4-webapp-publish.png" alt-text="Screenshot of the Publish page, with the web app displayed and the Publish button highlighted.":::

1. Wait while the web app is built and deployed to App Service. When deployment is finished, the web app starts and Visual Studio opens a web browser. Verify that the web app operates the same way it did when it was running locally. Move around the website: edit one or more products, and then create and delete a new product to test the app.

## View the log data and examine the Application Insights telemetry

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. In the search box, enter **Storage**, select **Storage accounts**, and then press Enter.

    :::image type="content" source="../media/4-search-storage.png" alt-text="Screenshot of the start page in the Azure portal, with Storage in the search box and Storage accounts under Services highlighted.":::

1. On the **Storage accounts** blade, select the storage account you created earlier to store the web application logs. In this exercise, the storage account name is prefixed with your ID and the number you specified when you created you user alias in the setup unit. Other storage accounts might exist and be used by Cloud Shell and other services.

    :::image type="content" source="../media/4-select-storage.png" alt-text="Screenshot of the Storage accounts blade, with the storage account that contains the web application logs highlighted.":::

1. On the **Storage account** blade, select **Overview** > **Containers**.

    :::image type="content" source="../media/4-containers.png" alt-text="Screenshot of the Storage account blade, with Overview in the menu and the Containers tile highlighted.":::
    
1. On the **Containers** blade, select the **workshopcontainer** container.

    :::image type="content" source="../media/4-workshop-container.png" alt-text="Screenshot of the Containers blade, with the workshopcontainer container highlighted.":::
 
1. On the container's blobs blade, select the **eShopModernizedLogs** folder. 

    :::image type="content" source="../media/4-workshop-blob.png" alt-text="Screenshot of the container's blobs blade, with the eShopModernizedLogs folder highlighted.":::

1. Select the append blob that is shown in this folder. The blob is named by using the current date, with the suffix *.entry.log.xml*. 

    :::image type="content" source="../media/4-log-blob.png" alt-text="Screenshot of the Blobs blade, with the blob that contains the log entries that were generated by the web app highlighted.":::
 
1. On the details pane for the blob, select **Download**.

    :::image type="content" source="../media/4-blob-download.png" alt-text="Screenshot of the blob details pane, with the Download button highlighted.":::

1. Use Notepad to open the downloaded file, and then browse the file contents. The file contains the log entries that were written by the web app. The log entries should resemble the ones shown in the following example:

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

    The **\<RenderedMessage\>** element in each entry contains data that was written by using the **_log** object in the application code.

1. Close Notepad and return to the Azure portal.

1. Select **Menu**, and then select **All services**.

    :::image type="content" source="../media/4-menu-services.png" alt-text="Screenshot of the menu button in the Azure portal, with All services highlighted.":::

1. On the **All services** page, in the search box, enter **Application Insights**, and then press Enter.

1. On the **Application Insights** blade, select the Application Insights instance you created earlier. The **Overview** pane should display general statistics for the web app.

1. In the menu, under **Investigate**, select **Performance**.

    :::image type="content" source="../media/4-performance.png" alt-text="Screenshot of the Application Insights blade, with Performance highlighted in the menu.":::

1. On the **Performance** blade, select any operation. In the **Drill into...** section, select **Samples**.

    :::image type="content" source="../media/4-select-operation.png" alt-text="Screenshot of the Performance blade, with a GET operation and the Samples button highlighted.":::
    
    > [!NOTE]
    > It might take several minutes for the logging data to appear in Blob storage. If no operations are shown, refresh the page.

1. On the **Select a sample operation** pane, select any of the samples that are shown.

    :::image type="content" source="../media/4-select-sample.png" alt-text="Screenshot of the Select a sample operation pane, with a sample operation highlighted.":::

1. On the **End-to-end transaction details** blade, select **View all telemetry**.

    :::image type="content" source="../media/4-end-to-end-details.png" alt-text="Screenshot of the End-to-end transaction details blade, with the View all telemetry button highlighted.":::

1. On the detailed telemetry page, select any logging event. Logging events are identified as *Verbose* or *Information*. If the sample operation doesn't display any logging events, in the left pane, select a different sample.

    :::image type="content" source="../media/4-select-logging.png" alt-text="Screenshot of the End-to-end transaction details blade, with a logging event highlighted.":::

1. On the **Trace** pane, in the **Message** box, select **show more**.

    :::image type="content" source="../media/4-trace-pane.png" alt-text="Screenshot of the Trace pane, with the Show more link highlighted.":::

    The entire log message is shown in a new window. The log message includes the data that was written by using the **_log** object in the application code.


    :::image type="content" source="../media/4-log-message.png" alt-text="Screenshot of the View full value pane, with a full log message highlighted.":::

   If you take a look at the log events for other operations, you can verify that the logging messages that were written by the web app are included.
