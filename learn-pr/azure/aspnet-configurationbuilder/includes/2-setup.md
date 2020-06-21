The example web application used by this module is based on part of an e-commerce system. The sample web application enables a warehouse employee to update the details of products sold by the system, and maintain the current stock levels.

Here, you'll download and test the application locally, and then create the resources needed to deploy the application to Azure and configure it. You'll do the deployment and configuration in a later unit in this module.
 
## Download and test the sample web application locally

1. Using Windows Explorer, create a folder named **MigrationWorkshop** in a convenient place on your computer.
2. Open a command prompt window, and move to the **MigrationWorkshop** folder.
3. Run the following command to download the sample application from the Microsoft repository on GitHub:

    ```bash
    git clone https://github.com/dotnet-architecture/eShopModernizing.git
    ```

4. Start Visual Studio 2019.
5. Click **Open a project or solution**.

    > [!div class="mx-imgBorder"]
    > ![Image of Visual Studio 2019 start screen. The user has selected **Open a project or solution**](..\media\2-open-project-or-solution.png)

6. Browse to the **MigrationWorkshop** folder, move to the **eShopModernizing** folder, move to the **eShopLegacyWebFormsSolution** folder, select the **eShopLegacyWebFormsSolution**, and then click **Open**.

    > [!div class="mx-imgBorder"]
    > ![Image of the Open Project/Solution dialog box in Visual Studio 2019. The user has selected the **eShopLegacyWebForms** solution](..\media\2-open-solution.png)


    > [!NOTE]
    > You might be prompted to install additional components in the Solution Explorer window:
    >
    > > [!div class="mx-imgBorder"]
    > >  ![Image of the Solution Explorer window in Visual Studio. The user is being prompted to install additional components to support Visual Studio.**](..\media\2-install-components.png)
    >
    > If this occurs, click **Install** to install the required items, and follow the instructions.

> [!IMPORTANT]
> This project currently uses v2.0.1 of the **Microsoft.CodeDom.Providers.DotNetCompilerPlatform** assembly, which has an issue that requires restarting Visual Studio to refresh a cached value. Perform the following steps:
> 
> 1. Close Visual Studio, and start it again. 
> 2. Open the **eShopLegacyWebFormsSolution** solution, and on the **Build** menu, select **Rebuild Solution**.

7. In the **Solution Explorer** window, expand the **eShopLegacyWebForms** project, and select the **Web.config** file.

    > [!div class="mx-imgBorder"]
    > ![Image of Solution Explorer window. The user has selected the **Web.config** file](..\media\2-open-web-config.png).

8. In the **Web.config** file, in the **appSettings** section, set the value of the **UseMockData** key to **false**. This setting will cause the application to use data stored in a local SQL Server database:

    ```xml
    ...
    <appSettings>
        <add key="UseMockData" value="false" />
        <add key="UseCustomizationData" value="false" />
    </appSettings>
    ...
    ```

9. Press **F5** to build and run the application. The application will open a web browser and display the **Catalog Manager** page for the web application.

    > [!div class="mx-imgBorder"]
    > ![Image of the **Catalog Manager** page for the sample application in a web browser window](..\media\2-catalog-manager.png)

    The Catalog Manager enables you to view the products sold by the organization, add new products, modify the details of existing products, and delete products.

10. Experiment with the application; try adding, editing, and removing products. Close the web browser when you've finished. This action will stop the application and return you to Visual Studio.

## Create Azure resources for running the application as an Azure web app

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. In the Cloud Shell window on the right, run the following command to download the sample application from the Microsoft repository on GitHub:

    ```bash
    git clone https://github.com/dotnet-architecture/eShopModernizing.git
    ```

2. Run the commands shown below to define the following PowerShell variables. The commands that create the Azure resources in subsequent steps use these variables to name the resources. Replace ***\<your-initials-with-suffix\>*** with your own initials and a numeric suffix of your choice. The purpose of the numeric suffix is to prevent two students with the same initials attempting to use the same alias. Also, replace ***\<your-password\>*** with a password of your choosing. This password will be used by the instance of Azure SQL Database that the application connects to.  

    > [!NOTE]
    > The resource group <rgn>[sandbox resource group name]</rgn> has been created automatically, as part of the sandbox configuration.

    ```PowerShell
    $useralias = "<your-initals-with-suffix>"
    $serveradminpassword = "<your-password>"
    $resourcegroupname = "<rgn>[sandbox resource group name]</rgn>"
    ```

3. Move to the **~/eShopModernizing/Setup** folder.

    ```PowerShell
    cd ~/eShopModernizing/Setup
    ```

4. Run the following PowerShell scripts:

    ```PowerShell
    . ./environment.ps1
    ./setup.ps1
    ```

    > [!NOTE]
    > The "." and the space characters at the start of the first command above are important. Don't omit them.

    Wait for the script to create the resources used by the lab before continuing.

5. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your Azure account.

6. On the home page of the portal, click **Resource groups**.

    > [!div class="mx-imgBorder"]
    > ![Image of home page in the Azure portal. The user has selected **Resource groups**](..\media\2-resource-groups.png)

7. On the **Resource groups** page, select the **<rgn>[sandbox resource group]</rgn>** resource group.

8. Verify that the resource group contains the following resources:

    - A SQL database, named **eShop**
    - An App Service, with the suffix **webapp**
    - An App Service plan, with the suffix **webappplan**
    - A SQL Server, with the suffix **workshop-server**

    > [!div class="mx-imgBorder"]
    > ![Image of the resource group in the Azure portal, showing the resources created by the setup instructions just performed](..\media\2-azure-resources.png)