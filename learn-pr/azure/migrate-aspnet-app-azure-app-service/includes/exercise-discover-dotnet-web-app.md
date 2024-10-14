In this exercise, we use the Azure Migrate: App Containerization tool to discover the PartsUnlimited application that needs to be containerized and migrated.

## Complete tool prerequisites 

1. Select **ASP.NET web apps** as the type of application you want to containerize.
1. To specify target Azure service, select **Containers on Azure App Service**.

    ![Default load-up for App Containerization tool.](../media/tool-home.png)

1. Accept the **license terms**, and read the license information.
1. The tool automatically checks for internet connectivity and installs the latest version of the Azure Migrate: App Containerization tool. 
1. Select **verify** to validate the installation of the Microsoft Web Deploy tool. Microsoft Web Deploy is already installed as part of the setup.
1. The tool instructs you to enable PowerShell remoting that was done as part of the setup. Select **continue**.

## Sign in to Azure

Select **Sign in** to sign in to your Azure account.

1. You need a device code to authenticate with Azure. Selecting on sign-in opens a modal with the device code.
1. Select **Copy code & sign in** to copy the device code and open an Azure sign-in prompt in a new browser tab. If it doesn't appear, make sure the pop-up blocker in the browser is disabled.
1. On the new tab, paste the device code and complete the sign in using your Azure account credentials. You can close the browser tab after sign in is complete and return to the App Containerization tool's web interface.
1. Select the **Azure tenant** that you want to use.
1. Specify the **Azure subscription** that you want to use.

## Discover ASP.NET applications

The App Containerization helper tool connects remotely to the application servers using the provided credentials. It attempts to discover ASP.NET applications hosted on the application servers.

1. To discover the PartsUnlimited application, use the following values.

    - **Server IP/FQDN**: In your **LearnAppContainerization** resource group, navigate to *vm-aspserver*, copy the private IP address and specify this value in the App Containerization tool. 
    - **Credentials**: Specify **.\adminuser** as the user name and **Password@123** as the password.

1. Select **Validate** to verify that the application server is reachable from the machine running the tool and that the credentials are valid. Upon successful validation, the status column shows the status as **Mapped**.  

    ![Screenshot for server IP and credentials.](../media/discovery-credentials.png)

1. Select **Continue** to start application discovery on the selected application servers.

1. Upon successful completion of application discovery, you can select the list of applications to containerize.

    ![Screenshot for discovered ASP.NET application.](../media/discovered-app.png)

1. Use the checkbox to select the **PartsUnlimited** application to containerize.
1. **Specify container name**: Specify a name for the target container for each selected application. The container name should be specified as <*name:tag*> where the tag is used for container image. For example, you can specify the target container name as `partsunlimitedtest:v1`.

### Parameterize application configurations

By Parameterizing the configuration, you make it available as a deployment time parameter. This parameter allows you to configure the setting while deploying the application as opposed to having it hard-coded to a specific value in the container image. For example, this option is useful for parameters like database connection strings.

1. Select **app configurations** to review detected configurations.
1. Select the checkbox to parameterize the configuration with attribute name **DefaultConnectionString**.
1. Select **Apply** after selecting the configurations to parameterize.

   ![Screenshot for app configuration parameterization ASP.NET application.](../media/discovered-app-configs.png)

### Externalize file system dependencies

You can add other folders that your application uses. Specify if they should be part of the container image or are to be externalized through persistent volumes on Azure file share. Using persistent volumes works great for stateful applications that store state outside the container or have other static content stored on the file system.

This application doesn't have any file system dependencies that need to be externalized. Select **Continue** to proceed to the container image build phase.
