Enable Azure Arc-enabled servers for Windows or Linux machines by doing a set of steps manually. Or you can use an automated method by running a template script that we provide. This script automates the download and installation of both agents.

This method requires that you have administrator permissions on the machine to install and configure the agent. On Linux, by using the root account, and on Windows, you're a member of the Local Administrators group.

Before you get started, be sure to review the [prerequisites](/azure/azure-arc/servers/prerequisites) and verify that your subscription and resources meet the requirements. For information about supported regions and other related considerations, see [supported Azure regions](/azure/azure-arc/servers/overview#supported-regions).

### Generate the installation script from the Azure portal

The script to automate the download and installation, and to establish the connection with Azure Arc, is available from the Azure portal. To complete the process, perform the following steps:<br>

1.  From your browser, sign in to the [Azure portal](https://portal.azure.com/).
2.  On the **Azure Arc - Machines** page, select **Add/Create** at the upper left, and then select **Add a machine** from the drop-down menu.
3.  On the **Add servers with Azure Arc** page, under the **Add a single server** tile, select **Generate script**.
4.  On the **Basics** page, provide the following information.
    
    
    1.  In the **Project Details** section, select the **Subscription** and **Resource group** the machine will be managed from.
    2.  In the **Region** drop-down list, select the Azure region to store the servers metadata.
    3.  In the **Operating system** drop-down list, select the operating system that the script is configured to run on.
    4.  In the **Connectivity method** section, If the machine is communicating through a proxy server to connect to the internet, select **Proxy server** option. Specify the **proxy server IP addres**s or the **name** and **port** number that the machine will use to communicate with the proxy server. Enter the value in the format `http://<proxyURL>:<proxyport>`. For a machine communicating through a private endpoint select Private endpoint option in the drop-down list. For a machine communicating through a public endpoint then, select **Public endpoint** option.
    5.  In the **Automanage machine best practices** section, you may enable automanage to onboard and configure best practice services based on your server needs.
    6.  Select **Next** to go to the **Tags** page.
5.  On the **Tags** page, review the default Physical location tags suggested and enter a value, or specify **Custom tags** to support your standards.
6.  Select **Next** to **Download and run script** page.
7.  On the **Download and run script** page, review the summary information, and then select **Download**. If you still need to make changes, select **Previous**.

### Install and validate the agent on Windows

You can install the Connected Machine agent manually by running the Windows Installer package *AzureConnectedMachineAgent.msi*. You can download the latest version of the [Windows agent Windows Installer package](https://aka.ms/AzureConnectedMachineAgent) from the Microsoft Download Center.

    > [!NOTE]
    > To install or uninstall the agent, you must have *Administrator* permissions.

    > [!NOTE]
    > You must first download and copy the Installer package to a folder on the target server, or from a shared network folder. If you run the Installer package without any options, it starts a setup wizard that you can follow to install the agent interactively.

If the machine needs to communicate through a proxy server to the service, then run a command that's described in the steps. This command sets the proxy server system environment variable https\_proxy. Using this configuration, the agent communicates through the proxy server using the HTTP protocol.

1.  To install the agent silently and create a setup log file in the `C:\Support\Logs` folder that exist, run the command.
    
    ```powershell
    msiexec.exe /i AzureConnectedMachineAgent.msi /qn /l*v "C:\Support\Logs\Azcmagentsetup.log"
    
    ```
    
    If the agent fails to start after setup is finished, check the logs for detailed error information. The log directory is *%ProgramData%\\AzureConnectedMachineAgent\\log*.<br>
2.  If the machine needs to communicate through a proxy server, to set the proxy server environment variable, run the following command:
    
    ```powershell
    [Environment]::SetEnvironmentVariable("https_proxy", "http://{proxy-url}:{proxy-port}", "Machine")
    $env:https_proxy = [System.Environment]::GetEnvironmentVariable("https_proxy","Machine")
    # For the changes to take effect, the agent service needs to be restarted after the proxy environment variable is set.
    Restart-Service -Name himds
    ```
    
    The agent does not support setting proxy authentication.
3.  After installing the agent, you need to configure it to communicate with the Azure Arc service by running the following command:
    
    ```powershell
    "%ProgramFiles%\AzureConnectedMachineAgent\azcmagent.exe" connect --resource-group "resourceGroupName" --tenant-id "tenantID" --location "regionName" --subscription-id "subscriptionID"
    ```

### Install with the scripted method

1.  Log in to the server.
2.  Open an elevated PowerShell command prompt.
3.  Change to the folder or share that you copied the script to, and execute it on the server by running the `./OnboardingScript.ps1` script.

If the agent fails to start after setup is finished, check the logs for detailed error information. The log directory is *%ProgramData%\\AzureConnectedMachineAgent\\log*.

### Verify the connection with Azure Arc

After you install the agent and configure it to connect to Azure Arc-enabled servers, go to the Azure portal to verify that the server has successfully connected. View your machines in the [Azure portal](https://aka.ms/hybridmachineportal).

:::image type="content" source="../media/arc-servers-successful-onboard-1-bd202596.png" alt-text="Displays a screenshot of the Azure portal to verify that the server has successfully connected.by using installation script.":::
