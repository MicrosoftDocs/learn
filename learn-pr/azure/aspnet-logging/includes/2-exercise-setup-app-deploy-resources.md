The example web application in this module is part of an e-commerce system. The sample web application provides a way for a warehouse employee to update the details of products sold by a company and to maintain current stock levels.

First, you'll download and test the application locally, and then you'll create resources that are needed to deploy the application to Azure and configure the application. You'll configure and deploy the application later in this module.
 
## Download and test the sample web application locally

1. In File Explorer in Windows, create a folder named *MigrationWorkshop* in a convenient place on your computer.
1. Open a Command Prompt window, and then change the directory to the *MigrationWorkshop* folder.
1. Run the following command to download the sample application from the Microsoft repository on GitHub:

    ```bash
    git clone https://github.com/dotnet-architecture/eShopModernizing.git
    ```

1. Start Visual Studio 2019.
1. Select **Open a project or solution**.

    :::image type="content" source="../media/2-open-project-or-solution.png" alt-text="Screenshot of the Visual Studio 2019 start screen with the Open a project or solution tile highlighted.":::
   
1. Go to the *MigrationWorkshop* folder, and then select **eShopModernizing** > **eShopLegacyWebFormsSolution** > **eShopLegacyWebFormsSolution** > **Open**.

    :::image type="content" source="../media/2-open-solution.png" alt-text="Screenshot of the Open Project/Solution dialog box, with the eShopLegacyWebForms solution highlighted.":::

    In Solution Explorer, you might be prompted to install additional components:
    
    :::image type="content" source="../media/2-install-components.png" alt-text="Screenshot of Solution Explorer, with a prompt to install additional components highlighted and an Install button.":::
  
    If the prompt is shown, select **Install** to install the required items, and then follow the instructions.

1. This project currently uses v2.0.1 of the Microsoft.CodeDom.Providers.DotNetCompilerPlatform assembly. The version has an issue that requires you to restart Visual Studio to refresh a cached value:

    1. Close Visual Studio and then restart it. 
    2. Open the eShopLegacyWebFormsSolution solution. On the **Build** menu, select **Rebuild Solution**.

1. In Solution Explorer, expand the **eShopLegacyWebForms** project, and then select the **Web.config** file.

    :::image type="content" source="../media/2-open-web-config.png" alt-text="Screenshot of Solution Explorer, with the Web.config file highlighted.":::

1. In the *Web.config* file, in the **appSettings** section, set the value of the **UseMockData** key to **false**. This setting causes the application to use data that's stored in a local SQL Server database.

    ```xml
    ...
    <appSettings>
        <add key="UseMockData" value="false" />
        <add key="UseCustomizationData" value="false" />
    </appSettings>
    ...
    ```

1. Press **F5** to build and run the application. The application opens a web browser and displays the **Catalog manager** page in the web application:

    :::image type="content" source="../media/2-catalog-manager.png" alt-text="Screenshot of the Catalog manager page in the eShop onContainers sample web application in a web browser window.":::

    You can use the **Catalog manager** page to view the products that are sold by the organization, add new products, modify the details of existing products, and delete products.

1. Experiment with the application. Try adding, editing, and removing products. Close the web browser when you're finished. This action stops the application and returns you to Visual Studio.

## Create Azure resources to run the application as an Azure web app

1. In the Azure Cloud Shell window on the right, run the next commands to define PowerShell variables. The commands that create the Azure resources in subsequent steps use these variables to name the resources. Replace *\<your-initials-with-suffix\>* with your own initials and a numeric suffix of your choice. The purpose of the numeric suffix is to prevent two students with the same initials attempting to use the same alias. Also, replace *\<your-password\>* with a password that you choose. The password will be used by the instance of Azure SQL Database that the application connects to.  

    > [!NOTE]
    > The resource group *<rgn>[sandbox resource group name]</rgn>* is automatically created. Use this as your resource group name. You don't have permissions in the sandbox to create additional resource groups.

    ```powershell
    $useralias = "<your-initals-with-suffix>"
    ```

    ```powershell
    $serveradminpassword = "<your-password>"
    ```

    ```powershell
    $resourcegroupname = "<rgn>[sandbox resource group name]</rgn>"
    ```

1. Run the following commands to define more variables that will be used to create the resources used by this module:

    ```powershell
    $location = "eastus"
    $webappplanname = (-join($useralias,"-webappplan"))
    $webappname = (-join($useralias,"-webapp"))
    $serveradminname = "ServerAdmin"
    $servername = (-join($useralias, "-workshop-server"))
    $dbname = "eShop"
    ```

1. Create a new Azure App Service plan to host the web app:

    ```powershell
    New-AzAppServicePlan `
        -Name $webappplanname `
        -ResourceGroup $resourcegroupname `
        -Location $location
    ```

1. Create a web app by using the App Service plan:

    ```powershell
    New-AzWebApp `
        -Name $webappname `
        -AppServicePlan $webappplanname `
        -ResourceGroup $resourcegroupname `
        -Location $location
    ```

1. Assign a managed identity to the web app. You'll require this identity later.

    ```powershell
    Set-AzWebApp `
        -AssignIdentity $true `
        -Name $webappname `
        -ResourceGroupName $resourcegroupname
    ```

1. Create a new SQL Database server:

    ```powershell
    New-AzSqlServer `
        -ServerName $servername `
        -ResourceGroupName $resourcegroupname `
        -Location $location `
        -SqlAdministratorCredentials $(New-Object `
            -TypeName System.Management.Automation.PSCredential `
            -ArgumentList $serveradminname, `
            $(ConvertTo-SecureString `
            -String $serveradminpassword `
            -AsPlainText -Force))
    ```
1. Open the SQL Database server firewall to allow access to services that are hosted in Azure:

    ```powershell
    New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourcegroupname `
        -ServerName $servername `
        -FirewallRuleName "AllowedIPs" `
        -StartIpAddress "0.0.0.0" `
        -EndIpAddress "0.0.0.0"
    ```

1. Create a database on the SQL Database server. The database will be populated later, when you migrate the web app.

    ```powershell
    New-AzSqlDatabase  `
        -ResourceGroupName $resourcegroupname `
        -ServerName $servername `
        -DatabaseName $dbName `
        -RequestedServiceObjectiveName "S0"
    ```
