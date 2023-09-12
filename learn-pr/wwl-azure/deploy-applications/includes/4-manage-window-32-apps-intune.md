Intune standalone now supports Win32 app management capabilities. While there are some limitations on what types of apps that can be deployed, customers now have a choice on whether to use Intune or Configuration Manager for Win32 app deployment. With the Intune Management Extension, deployment is no longer limited to a single MSI installation file.

In order to deploy Win32 apps, the following criteria must be met:

 -  Windows 10 version 1607 or later (Enterprise, Pro, and Education versions)
 -  Devices must be joined to Azure AD and auto enrolled.
 -  Windows application size has a maximum of 8 GB per app.

Some features worth noting include:

 -  Both 32-bit and 64-bit apps are supported.
 -  Dependencies of other apps and install requirements can be defined.
 -  The Intune Management Extension supports Azure AD joined, hybrid domain joined, group policy enrolled devices are supported.

Before the Win32 app can be deployed with Intune, it must be prepped. The following chart illustrates the steps for preparing the app.

:::image type="content" source="../media/prepare-window-32-app-e7c0051e.png" alt-text="Diagram of the process to prepare an app for Intune. Steps include validating the command, creating an IntuneWin file, specifying the source installer folder, and output folder.":::


The Win32 Content Prep Tool (IntuneWinAppUtil.exe) is a command line tool used to compress the Win32 app into a `.intunewin` file. The folder, install file (such as setup.exe) and output folder must be specified. Running the tool with the -h switch displays usage information.

A sample command might look like this:

```
IntuneWinAppUtil -c c:\testapp\\v1.0 -s c:\testapp\v1.0\setup.exe -o
c:\testappoutput\v1.0 -q

```

Once the Intunewin file has been created, it can be added to Intune. The steps for adding the app are as follows:

1.  In the **Intune** pane, select **Client apps** > **Apps** > **Add** and select **Windows app (Win32)** from the drop-down list.
2.  Select **App package file** and browse to the intunewin file you created to upload the package to Intune.
3.  **Add the App information.** This will include information such as the name, description, publisher, category, owner, etc.
4.  **Configure app installation install and uninstall commands.** This might look like the following for installing and uninstalling, respectively:
    
    ```
    msiexec /p “MyApp.msp”
    
    msiexec /x “{12345A67-89B0-1234-5678-000001000000}
    
    ```

5.  **Define the app requirements.** This might include if it’s x86/x64, minimum OS version, disk space required, minimum memory, etc.
6.  **Add requirement rules.** These define a specific configuration to look for, such as an existing file or folder, a registry value, or a script to execute and compare against the results of the script.
7.  **Configure app detection rules.** If the Win32 app has dependencies on other apps, the detection rule can bet set to check for information such as an MSI product code or the presence of a path/file, a registry key/value, or the results of a script.
8.  **Configure App return codes.** This defines the result of the installation. Default values such as Success, Failure, Reboot required, and Retry are available. More codes can be created.

Once the process of adding the app is complete, it can be assigned like any other app. Delivery optimization is supported and toast notifications can be suppressed as well.

> [!NOTE]
> When deploying both Win32 apps and LOB apps, consider using the Intune Management Extension exclusively. Deploying both types during an Autopilot enrollment may fail.