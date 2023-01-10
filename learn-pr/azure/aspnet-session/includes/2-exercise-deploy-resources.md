The example web application that this module uses is based on part of an e-commerce system. The application enables a warehouse employee to update the details of products sold by the system and maintain the current stock levels.

Here, you'll download and test the application locally, then create the resources needed to deploy the application to Azure and configure it. You'll do the deployment and configuration in a later unit in this module.

## Download and test the sample web application locally

1. By using Windows Explorer, create a folder named **MigrationWorkshop** in a convenient place on your computer.
1. Open a command prompt window, and move to the **MigrationWorkshop** folder.
1. Run the following command to download the sample application from the Microsoft repository on GitHub:

    ```bash
    git clone https://github.com/dotnet-architecture/eShopModernizing.git
    ```

1. Start Visual Studio 2019.
1. Select **Open a project or solution**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Visual Studio 2019 start screen. The user has selected **Open a project or solution**.](..\media\2-open-project-or-solution.png)

1. Browse to the **MigrationWorkshop** > **eShopModernizing** > **eShopLegacyWebFormsSolution** folder. Select the **eShopLegacyWebForms** file, and then select **Open**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Open Project/Solution dialog box in Visual Studio 2019. The user has selected the **eShopLegacyWebForms** solution.](..\media\2-open-solution.png)

    You might be prompted to install additional components in the Solution Explorer window:

    > [!div class="mx-imgBorder"]
    > ![Image of the Solution Explorer window in Visual Studio. The user is being prompted to install additional components to support Visual Studio.](..\media\2-install-components.png)

    If this occurs, select **Install** to install the required items and follow the instructions.

1. This project currently uses v2.0.1 of the **Microsoft.CodeDom.Providers.DotNetCompilerPlatform** assembly, which requires restarting Visual Studio to refresh a cached value. Perform the following steps:

    1. Close Visual Studio, and start it again.
    1. Open the **eShopLegacyWebFormsSolution** solution. On the **Build** menu, select **Rebuild Solution**.

1. In the **Solution Explorer** window, expand the **eShopLegacyWebForms** project, and select the **Web.config** file.

    > [!div class="mx-imgBorder"]
    > ![Image of Solution Explorer window. The user has selected the **Web.config** file.](..\media\2-open-web-config.png).

1. In the **Web.config** file, in the **appSettings** section, set the value of the **UseMockData** key to **false**. This setting will cause the application to use data stored in a local SQL Server database. Save the file.

    ```xml
    ...
    <appSettings>
        <add key="UseMockData" value="false" />
        <add key="UseCustomizationData" value="false" />
    </appSettings>
    ...
    ```

1. Select the F5 key to build and run the application. The application will open a web browser and display the **Catalog Manager** page for the web application.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Catalog Manager** page for the sample application in a web browser window.](..\media\2-catalog-manager.png)

    The Catalog Manager lets you view the products sold by the organization, add new products, modify the details of existing products, and delete products.

1. Experiment with the application. Try adding, editing, and removing products. Close the web browser when you've finished. This action will stop the application and return you to Visual Studio.

## Create Azure resources for running the application as an Azure web app

1. In the Cloud Shell window on the right, run the following commands to define PowerShell variables. The commands that create the Azure resources in later steps use these variables to name the resources. 

    Replace *\<your-initials-with-suffix\>* with your own initials and a numeric suffix of your choice. The purpose of the numeric suffix is to prevent two students with the same initials from attempting to use the same alias. Also, replace *\<your-password\>* with a password of your choice. The instance of Azure SQL Database to which the application connects will use this password.  

    > [!NOTE]
    > The resource group <rgn>[sandbox resource group name]</rgn> has been created automatically. Use this as your resource group name. You won't have permission to create more resource groups in the sandbox.

    ```PowerShell
    $useralias = "<your-initals-with-suffix>"
    ```

    ```PowerShell
    $serveradminpassword = "<your-password>"
    ```

    ```PowerShell
    $resourcegroupname = "<rgn>[sandbox resource group name]</rgn>"
    ```

1. Run the following commands to define more variables that will be used to create the resources for this module:

    ```PowerShell
    $location = "eastus"
    $webappplanname = (-join($useralias,"-webappplan"))
    $webappname = (-join($useralias,"-webapp"))
    $serveradminname = "ServerAdmin"
    $servername = (-join($useralias, "-workshop-server"))
    $dbname = "eShop"
    ```

1. Run the following PowerShell command to create a new Azure App Service plan for hosting the web app:

    ```PowerShell
    New-AzAppServicePlan `
        -Name $webappplanname `
        -ResourceGroup $resourcegroupname `
        -Location $location
    ```

1. Run the following PowerShell command to create a web app by using the App Service plan:

    ```PowerShell
    New-AzWebApp `
        -Name $webappname `
        -AppServicePlan $webappplanname `
        -ResourceGroup $resourcegroupname `
        -Location $location
    ```

1. Run the following PowerShell command to assign a managed identity to the web app. You'll need this identity later.

    ```PowerShell
    Set-AzWebApp `
        -AssignIdentity $true `
        -Name $webappname `
        -ResourceGroupName $resourcegroupname
    ```

1. Run the following PowerShell command to create a new Azure SQL Database server:

    ```PowerShell
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

1. Run the following PowerShell command to open the SQL Database server firewall to allow access to services hosted in Azure:

    ```PowerShell
    New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourcegroupname `
        -ServerName $servername `
        -FirewallRuleName "AllowedIPs" `
        -StartIpAddress "0.0.0.0" `
        -EndIpAddress "0.0.0.0"
    ```

1. Run the following PowerShell command to create a database on the SQL Database server. The database will be populated later, when you migrate the web app.

    ```PowerShell
    New-AzSqlDatabase  `
        -ResourceGroupName $resourcegroupname `
        -ServerName $servername `
        -DatabaseName $dbName `
        -RequestedServiceObjectiveName "S0"
    ```
