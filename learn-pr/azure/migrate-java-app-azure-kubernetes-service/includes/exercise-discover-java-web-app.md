In this exercise, we'll use the Azure Migrate: App Containerization tool to discover the Java web application that needs to be containerized and migrated. 

## Complete tool prerequisites 

1. Select **Java web apps** as the type of application you want to containerize.
2. To specify target Azure service, select Containers on Azure Kubernetes Service.

   :::image type="content" source="../media/tool-home.png" alt-text="Screenshot for default load-up of App Containerization tool.":::

3. Accept the license terms and read the third-party information.
4. The tool automatically checks for internet connectivity and installs the latest version of the Azure Migrate: App Containerization tool.  
5. The tool informs you to enable SSH on the application server which was done as part of the setup. Select **Continue**.


## Sign in to Azure

Select **Sign in** to sign in to your Azure account. 

1. You'll need a device code to authenticate with Azure. Clicking on sign-in opens a modal with the device code.
2. Select **Copy code & sign in** to copy the device code and open an Azure sign-in prompt in a new browser tab. If it doesn't appear, make sure you've disabled the pop-up blocker in the browser.
3. On the new tab, paste the device code and complete sign in using your Azure account credentials. You can close the browser tab after sign in is complete and return to the App Containerization tool screen.
4. Select the **Azure tenant** that you want to use.
5. Specify the **Azure subscription** that you want to use.

## Discover Java web applications

The App Containerization helper tool connects remotely to the application servers using the provided credentials and attempts to discover Java web applications hosted on the application servers.

1. To discover the Parts Unlimited application, use the following values: 
    - **Server IP/FQDN**: In your **LearnAppContainerization** resource group, navigate to *TomcatServer* virtual machine, copy the private IP address and specify this value in the App Containerization tool. 
    - **Credentials**: Specify **adminUser** as the username and **Password@123** as the password. 

2. Select **Validate** to verify that the application server is reachable from the machine running the tool and that the credentials are valid. Upon successful validation, the status column shows the status as **Mapped**.  

   :::image type="content" source="../media/discovery-credentials.png" alt-text="Screenshot for server IP and credentials.":::

3. Select **Continue** to start application discovery on the selected application servers.

4. Upon successful completion of application discovery, you can select the list of applications to containerize.

   :::image type="content" source="../media/discovered-app.png" alt-text="Screenshot for discovered Java web application.":::

5. Use the checkbox to select the **airsonic** application to containerize.
6. **Specify container name**: Specify a name for the target container for each selected application. The container name should be specified as <*name:tag*> where the tag is used for container image. For example, you can specify the target container name as *airsonictest:v1*.   

### Parameterize application configurations

Parameterizing the configuration makes it available as a deployment time parameter. This allows you to configure this setting while deploying the application as opposed to having it hard-coded to a specific value in the container image. For example, this option is useful for parameters like database connection strings.

1. Select **app configurations** to review detected configurations.
2. Select all checkboxes to parameterize the configuration (username, password, and url).
3. Select **Apply** after selecting the configurations to parameterize.

   :::image type="content" source="../media/discovered-app-configs.png" alt-text="Screenshot for app configuration parameterization Java web application.":::

### Externalize file system dependencies

 You can add other folders that your application uses. Specify if they should be part of the container image or are to be externalized through persistent volumes on Azure file share. Using persistent volumes works great for stateful applications that store state outside the container or have other static content stored on the file system.

1. Select **Edit** under App Folders to review the detected application folders. The detected application folders have been identified as mandatory artifacts needed by the application and is copied into the container image.
2. Select **Add folder** and specify the folder paths to be added.
3. Add **/var/airsonic** as the folder path in the text box.
4. Select **Persistent Volume** as the storage option to store the folder outside the container on a persistent volume.

   :::image type="content" source="../media/discovered-app-folders.png" alt-text="Screenshot for externalizing app folders for Java web application.":::

5. Select **Save**.