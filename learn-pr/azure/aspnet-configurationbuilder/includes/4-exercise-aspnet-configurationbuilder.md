In an e-commerce system, it's important to avoid exposing the keys that the warehouse web app uses to connect to the SQL Server database. Failure here could lead to the database being compromised and its valuable information being corrupted or amended in an unauthorized manner.

In this unit, you store the SQL Server connection string in your Azure key vault. The key vault is a secure repository that uses Azure Active Directory (Azure AD) to authenticate and authorize users. To make the connection string available only to the web app, you specify that a client attempting to retrieve the string must be running with the service principal of the web app. Finally, you deploy the warehouse web app to the Azure App Service web app that you created earlier, and verify that it still functions correctly.

## Create an Azure key vault and store the connection string

1. In the Cloud Shell window on the right, to define a PowerShell variable that contains the name of the key vault to be created, run the following command: 

    ```PowerShell
    $vaultname = (-join("shopvault", $useralias))
    ```

1. Create the Azure key vault.

    ```PowerShell
    New-AzKeyVault `
        -Name $vaultname `
        -ResourceGroupName $resourcegroupname `
        -location $location 
    ```

    When the key vault is created, you'll receive the following warning:

    ```output
    WARNING: Access policy is not set. No user or application have access permission to use this vault. This can happen if the vault was created by a service principal. Please use Set-AzKeyVaultAccessPolicy to set access policies.
    ```

1. Retrieve the service principal ID of the web app.

    ```PowerShell
    $appId=(Get-AzWebApp `
        -ResourceGroupName $resourcegroupname `
        -Name $webappname).Identity.PrincipalId
    ```

1. Set the access policy of the key vault to allow the web app, which you identify by using the service principal, to access the key vault.

    ```PowerShell
    Set-AzKeyVaultAccessPolicy `
        -VaultName $vaultname `
        -ResourceGroupName $resourcegroupname `
        -ObjectId $appId `
        -PermissionsToSecrets Get
    ```

1. Generate the connection string for the SQL Server database by using the PowerShell variables that you created earlier.

    ```PowerShell
    $connectionstringplaintext = `
        (-join("Server=tcp:", $servername, ".database.windows.net,1433;Database=", `
        $dbname, ";User ID=", $serveradminname, ";Password=", $serveradminpassword, `
        ";Encrypt=true;Connection Timeout=30;"))
    ```

1. Convert the connection string into a secure string.

    ```PowerShell
    $connectionstring = ConvertTo-SecureString $connectionstringplaintext `
        -AsPlainText `
        -Force
    ```

    > [!NOTE]
    > A secure string is a string object that can be held only once in memory. It can't be copied elsewhere in memory. This feature helps to reduce the vulnerability of the information in the string to attacks that attempt to examine and copy blocks of memory, looking for passwords and other sensitive information.

1. Find the object ID of your account in Azure AD.

    ```PowerShell
    $objectId = az ad signed-in-user show `
        --query id -o tsv
    ```

1. Grant your account privileges to create and retrieve secrets and keys from the key vault.

    ```PowerShell
    Set-AzKeyVaultAccessPolicy `
        -VaultName $vaultname `
        -PermissionsToKeys create,decrypt,delete,encrypt,get,list,unwrapKey,wrapKey `
        -PermissionsToSecrets get,list,set,delete `
        -ObjectId $objectId
    ```

1. Store the secure string in the key vault by using the key **CatalogDBContext**.

    ```PowerShell
    Set-AzKeyVaultSecret `
        -VaultName $vaultname `
        -Name "CatalogDBContext" `
        -SecretValue $connectionstring 
    ```

1. Verify that the **CatalogDBContext** secret has been stored in the key vault.

    ```PowerShell
    Get-AzKeyVaultSecret `
        -VaultName $vaultname `
        -Name "CatalogDBContext"
    ```

1. Set the vault name as an AppSetting named **KeyVaultName** for the web app. By using this setting, the application is configured to retrieve the name of the key vault.

    ```PowerShell
    Set-AzWebApp `
        -Name $webappname `
        -ResourceGroupName $resourcegroupname `
        -AppSettings @{KeyVaultName = $vaultname}
    ```

## Configure the web app

1. Switch to Visual Studio on your computer, and return to the **eShopLegacyWebForms** solution that contains the web app.

1. On the **Tools** menu, select **NuGet Package Manager**, and then select **Package Manager Console**.

1. In the **Package Manager Console** window, run the following command to install the ConfigurationBuilder library that's required for reading secrets from the Azure key vault.

    ```PowerShell
    Install-Package Microsoft.Configuration.ConfigurationBuilders.Azure -Version 2.0.0
    ```

1. In the **Solution Explorer** window, select the *Web.config* file. The  **\<configBuilders\>** section has been added to this file.

    ```xml
    <configuration>
      <configSections>
        ...
      </configSections>
      <configBuilders>
        <builders>
          <add name="AzureKeyVault" vaultName="[VaultName]" type="Microsoft.Configuration.ConfigurationBuilders.AzureKeyVaultConfigBuilder, Microsoft.Configuration.ConfigurationBuilders.Azure, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
        </builders>
      </configBuilders>
    ...
    </configuration>
    ```

1. In the **\<builders\>** section, in the **AzureKeyVault** setting, change **[VaultName]** to **${KeyVaultName}**, and add the attribute **optional="true"**, as shown in the following code. This setting will use the value in the **KeyVaultName** app setting as the name of the key vault. You'll add this app setting shortly.

    ```xml
    ...
    <builders>
      <add name="AzureKeyVault" vaultName="${KeyVaultName}" optional="true" type=... />
    </builders>
    ...
    ```

1. Modify the **\<connectionStrings\>** node by adding the **configBuilders** attribute with the value **AzureKeyVault**, as shown in the following code. This attribute enables application settings and connection strings to be configured by using the named ConfigurationBuilder type at runtime. In this case, rather than use the **connectionString** value that's hard-coded into the configuration file, the web app retrieves the connection string for **CatalogDBContext** from the Azure key vault.

    ```xml
    ...
    <connectionStrings configBuilders="AzureKeyVault">
      <add name="CatalogDBContext" connectionString="..." providerName="System.Data.SqlClient" />
    </connectionStrings>
    ...
    ```

1.  Add an empty key to the **\<appSettings\>** section, with the name **KeyVaultName**. This key vault will be used as the source for the connection string. However, this setting is only a placeholder. At runtime, the web app will retrieve the value from the **KeyVaultName** app setting that you specified earlier for the Azure web app.

    ```xml
    ...
    <appSettings>
      ...
      <add key="KeyVaultName" value="" />
    </appSettings>
    ...
    ```

## Deploy the web app to Azure

1.  In the **Solution Explorer** window, expand the **Models** folder, expand the **Infrastructure** folder, and then select the *dbo.catalog_brand_hilo.Sequence.sql* file.

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window, with the "dbo.catalog_brand_hilo.Sequence.sql" file highlighted.](..\media\4-edit-sql-file.png)

1. In the *dbo.catalog_brand_hilo.Sequence.sql* file, comment out the **USE** statement at the start of the file, as shown below.

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
    > The scripts in these files run when the database is seeded with data. This seeding happens automatically the first time you run the application against a new database. The statements that you've commented out are required only when you run the application locally. When you run the application by using the Azure SQL Server database, you specify the database to be used as part of the connection string.

1. If you aren't currently signed in to your Azure account in Visual Studio, at the upper right, select **Sign in**, and then follow the instructions for signing in.

    > [!div class="mx-imgBorder"]
    > ![Image of the Visual Studio toolbar, with the "Sign in" link highlighted.](..\media\4-toolbar-sign-in.png)

1. In the **Solution Explorer** window, right-click the **eShopLegacyWebForms** project, and then select **Publish**.

    > [!div class="mx-imgBorder"]
    > ![Image of the "Solution Explorer" window, with the "eShopLegacyWebForms" project and "Publish" command highlighted.](..\media\4-project-publish.png)

1. In the **Pick a publish target** window, select **App Service**, select **Select Existing**, and then select **Create Profile**.

    > [!div class="mx-imgBorder"]
    > ![Image of the "Pick a publish target" window, where you create a new profile for publishing the web app to Azure App Service.](..\media\4-pick-publishing-target.png)

1. In the **App Service** window, in the **Subscription** drop-down list, select your Azure subscription, set the **View** to **Resource type**, expand **Web App**, select the Azure web app you created during the Setup unit, and then select **OK**.

    > [!div class="mx-imgBorder"]
    > ![Image of the "App Service" window, with the name of the Azure web app highlighted.](..\media\4-select-app-service.png)

1. On the **Publish** page, select **Publish**.

    > [!div class="mx-imgBorder"]
    > ![Image of the "Publish" page, with the "Publish" button highlighted.](..\media\4-webapp-publish.png)

    Wait for the web app to be built and deployed to the App Service. When the deployment is complete, the web app starts, and Visual Studio opens a web browser. 
    
1. Verify that the web app operates in the same manner as it did before, when it was running locally. For the web app to connect to the database, it must have retrieved the connection string from the key vault.

    > [!div class="mx-imgBorder"]
    > ![Image of the web app running by using Azure App Service.](..\media\4-web-app.png)

