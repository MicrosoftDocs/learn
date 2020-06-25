In the e-commerce system, it's important not to expose the keys used by the warehouse web app to connect to the SQL Server database. Failure to do so, could lead to the database being compromised, and the valuable information it contains being corrupted or amended in an authorized manner.

Here, you'll store the SQL Server connection string in Azure Key Vault. Key Vault is a secure repository that uses Azure Active Directory to authenticate and authorize users. You'll make the connection string available only to the web app, by specifying that a client attempting to retrieve the string must be running with the service principal of the web app. You'll then deploy the warehouse web app to the Azure App Service you created earlier, and verify that it still functions correctly.

## Create an Azure Key Vault and store the connection string

1. In the Cloud Shell window on the right, run the commands shown below to ensure that your environment is still set up correctly. If necessary, recreate any missing environment variables with the values you used earler in the Setup unit.

    ```PowerShell
    cd ~/eShopModernizing/Setup
    . ./environment.ps1
    ```

2. Define a PowerShell variable containing the name of the key vault to be created. 

    ```PowerShell
    $vaultname = (-join("shopvault", $useralias))
    ```

3. Create an Azure key vault.

    ```PowerShell
    New-AzKeyVault -Name $vaultname -ResourceGroupName $resourcegroupname -location $location -Tag @{Name="WebAppKeyVault"}
    ```

    You'll receive the following warning when the key vault is created:
    
    ```output
    WARNING: Access policy is not set. No user or application have access permission to use this vault. This can happen if the vault was created by a service principal. Please use Set-AzKeyVaultAccessPolicy to set access policies.
    ```

4. Retrieve the service principal ID of the web app.

    ```PowerShell
    $appId=(Get-AzWebApp -ResourceGroupName $resourcegroupname -Name $webappname).Identity.PrincipalId
    ```

5. Set the access policy of the key vault to allow the web app (identified using the service principal), to access the key vault.

    ```PowerShell
    Set-AzKeyVaultAccessPolicy -VaultName $vaultname -ResourceGroupName $resourcegroupname -ObjectId $appId -PermissionsToSecrets Get
    ```

6. Generate the connection string for the SQL Server database, using the PowerShell variables you created earlier.

    ```PowerShell
    $connectionstringplaintext = (-join("Server=tcp:", $servername, ".database.windows.net,1433;Database=", $dbname, ";User ID=", $serveradminname, ";Password=", $serveradminpassword, ";Encrypt=true;Connection Timeout=30;"))
    ```

7. Convert the connection string into a secure string.

    ```PowerShell
    $connectionstring = ConvertTo-SecureString $connectionstringplaintext -AsPlainText -Force
    ```

    > [!NOTE]
    > A secure string is a string object that can only be held once in memory. It can't be copied elsewhere in memory. This feature helps to reduce the vulnerability of the information in the string to attacks that attempt to examine and copy blocks of memory, looking for passwords and other sensitive information.

8. Find the Object ID of your account in Azure AD.

    ```PowerShell
    $objectId = az ad signed-in-user show --query objectId -o tsv
    ```

9. Grant your account privileges to create and retrieve secrets and keys from the key vault.

    ```PowerShell
    Set-AzKeyVaultAccessPolicy -VaultName $vaultName -PermissionsToKeys create,decrypt,delete,encrypt,get,list,unwrapKey,wrapKey -PermissionsToSecrets get,list,set,delete -ObjectId $objectId
    ```

10. Store the secure string in the key vault, with the key **CatalogDBContext**.

    ```PowerShell
    Set-AzKeyVaultSecret -VaultName $vaultname -Name "CatalogDBContext" -SecretValue $connectionstring 
    ```

11. Verify that the **CatalogDBContext** secret has been stored in the key vault.

    ```PowerShell
    Get-AzKeyVaultSecret -VaultName $vaultname -Name "CatalogDBContext"
    ```

12. Set the vault name as an AppSetting named **KeyVaultName** for the web app. The application will be configured to retrieve the name of the key vault using this setting.

    ```PowerShell
    Set-AzWebApp -Name $webappname -ResourceGroupName $resourcegroupname -AppSettings @{KeyVaultName = $vaultname}
    ```

## Configure the web app

1. Switch to Visual Studio on your computer, and return to the **eShopLegacyWebFormsSolution** solution containing the web app.

2. On the **Tools** menu, click **NuGet Package Manager**, and then click **Package Manager Console**.

3. In the **Package Manager Console** window, run the following command to install the ConfigurationBuilder library required for reading secrets from Azure Key Vault.

    ```PowerShell
    Install-Package Microsoft.Configuration.ConfigurationBuilders.Azure -Version 2.0.0
    ```

4. In the **Solution Explorer** window, click the **Web.config** file. You should see the following **\<configBuilders\>** section that has been added to this file:

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

5. In the **\<builders\>** section, in the **AzureKeyVault** setting, change **[VaultName]** to **${KeyVaultName}**, and add the attribute **optional="true"**, as shown below. This setting will use the value in the **KeyVaultName** app setting as the name of the key vault. You'll add this app setting shortly.

    ```xml
    ...
    <builders>
      <add name="AzureKeyVault" vaultName="${KeyVaultName}" optional="true" type=... />
    </builders>
    ...
    ```

6. Modify the **\<connectionStrings\>** node, and add the **configBuilders** attribute with the value **AzureKeyVault**, as shown below. This attribute enables application settings and connection strings to be configured using the named ConfigurationBuilder type at runtime. In this case, rather than using the **connectionString** value hard-coded into the configuration file, the web app will retrieve the connection string for **CatalogDBContext** from Azure Key Vault.

    ```xml
    ...
    <connectionStrings configBuilders="AzureKeyVault">
      <add name="CatalogDBContext" connectionString="..." providerName="System.Data.SqlClient" />
    </connectionStrings>
    ...
    ```

7.  Add an empty key to the **\<appSettings\>** section, with the name **KeyVaultName**. This key vault will be used as the source for the connection string. However, this setting is simply a placeholder. At runtime, the web app will retrieve the value from the **KeyVaultName** app setting that you specified earlier, for the Azure web app.

    ```xml
    ...
    <appSettings>
      ...
      <add key="KeyVaultName" value="" />
    </appSettings>
    ...
    ```

## Deploy the web app to Azure

1.  In the **Solution Explorer** window, expand the **Models** folder, expand the **Infrastructure** folder, and then click the **dbo.catalog_brand_hilo.Sequence.sql** file.

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window. The user has selected the **dbo.catalog_brand_hilo.Sequence.sql** file.](..\media\4-edit-sql-file.png)

2. In the SQL file, comment out the **USE** statement at the start of the file, as shown below.

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

3. Repeat step 2 for the **dbo.catalog_hilo.Sequence.sql** file and the **dbo.catalog_type_hilo.Sequence.sql** file.

    > [!NOTE]
    > The scripts in these files run when the database is seeded with data. This seeding happens automatically the first time the application is run against a new database. The statements that you've commented out are only required when running the application locally. When the application runs using the Azure SQL Server database, the database to be used is specified as part of the connection string.

4. If you aren't currently signed in to your Azure account in Visual Studio, in the upper right of the toolbar, click **Sign in**. Follow the instructions and sign in.

    > [!div class="mx-imgBorder"]
    > ![Image of the Visual Studio toolbar. The user has clicked **Sign in**.](..\media\4-toolbar-sign-in.png)

5. In the **Solution Explorer** window, right-click the **eShopLegacyWebForms** project, and then click **Publish**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window. The user has selected the **Publish** command on the context menu for the **eShopLegacyWebForms** project.](..\media\4-project-publish.png)

6. In the **Pick a publish target** window, select **Azure App Service**, click **Select Existing**, and then click **Create Profile**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Pick a publish target** window. The user is about to create a new profile for publishing the web app to Azure App Service.](..\media\4-pick-publishing-target.png)

7. In the **App Service** window, select your Azure subscription, set the **View** to **Resource type**, expand **Web App**, select the Azure web app you created during the Setup unit, and then click **OK**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **App Service** window. The user has selected the Azure web app created earlier.](..\media\4-select-app-service.png)

8. On the **Publish** page, click **Publish**.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Publish** page. The user has clicked **Publish**.](..\media\4-webapp-publish.png)

9. Wait while the web app is built and deployed to the App Service. When deployment is complete, the web app starts and Visual Studio opens a web browser. Verify that the web app operates in the same manner as it did before, when running locally. In order for the web app to connect to the database, it must have retrieved the connection string from the key vault.

    > [!div class="mx-imgBorder"]
    > ![Image of the web app running using Azure App Service.](..\media\4-web-app.png)




