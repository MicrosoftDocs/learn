In this exercise, you create an Azure Automation account and upload a PowerShell DSC. Then, you onboard an existing VM into Azure Automation. Finally, you check if the VM is missing IIS. If it is, you run code to install and configure IIS on the VM.

## Create a VM

Start by deploying a new VM from a Windows Server 2019 image.

1. In Azure Cloud Shell, run the following commands to create a username and generate a random password.

    ```bash
    USERNAME=azureuser
    PASSWORD=$(openssl rand -base64 32)
    ```

1. Run the following command in Cloud Shell to create a VM.

    ```azurecli
    az vm create \
      --resource-group <rgn>[Sandbox resource group name]</rgn> \
      --name myVM \
      --image win2019datacenter \
      --admin-username $USERNAME \
      --admin-password $PASSWORD
    ```

    It takes a few minutes to create the VM and supporting resources. If the VM is created successfully, you should see output like this:

    ```JSON
    {
      "fqdns": "",
      "id": "/subscriptions/<guid>/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM",
      "location": "eastus",
      "macAddress": "00-0D-3A-36-BA-28",
      "powerState": "virtual machine running",
      "privateIpAddress": "10.0.0.4",
      "publicIpAddress": "104.40.69.56",
      "resourceGroup": "myResourceGroup"
    }
    ```

1. Copy the `publicIpAddress` in this output and save it. Later in the exercise, you use this address to access the VM.

1. Run the following command in Cloud Shell to open your VM's port 80 for web traffic:

    ```azurecli
    az vm open-port \
      --port 80 \
      --resource-group <rgn>[Sandbox resource group name]</rgn> \
      --name myVM
    ```

1. In your web browser, go to the public IP address of your VM `http://[public-ip]`. Although port 80 is open, your connection should time out with `This site can't be reached`. This error occurs because IIS isn't deployed on your VM. We fix that later in this exercise.

## Create an Azure Automation account

1. Use your Microsoft Learn account to sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure portal resource menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Search services and marketplace** text box, enter *Automation*, and select <kbd>Enter</kbd> to view the search results.

1. In the *Automation* search results, select the **Automation** Azure service published by Microsoft.

1. Select **Create**. The **Create an Automation Account** pane appears.

1. Enter the following values for each setting. 

    | Setting  | Value  |
    |---|---|
    | Subscription | Concierge Subscription  |
    | Resource group | Select the existing resource group in the dropdown list |
    | Name | *\[your-automation-account-name\]* We suggest using *\[*your initials*\]-automation-account*. Use this name wherever you see *\[your-automation-account-name\]* in this exercise.|
    | Region | Accept default location |

1. Select **Review + Create**, then select **Create**. Wait until the automation account is deployed.

1. Select **Go to resource** when deployment completes. The **Automation Account** pane for your resource appears.

## Create a DSC configuration script

1. In Cloud Shell, run the following command to start a PowerShell session:

    ```bash
    pwsh
    ```

1. At the PowerShell prompt,  run the following command to open a new file named *MyDscConfiguration.ps1* in the code editor.

    ```powershell
    code $HOME/MyDscConfiguration.ps1
    ```

1. Enter the following code block in the file. This code creates a configuration to install IIS if it's not already installed. The code then runs the script to compile the configuration.

    ```azurecli
    Configuration MyDscConfiguration {
      Node "localhost" {
        WindowsFeature MyFeatureInstance {
          Ensure = 'Present'
          Name = 'Web-Server'
        }
      }
    }
    ```

1. Select <kbd>Ctrl+S</kbd> to save the file in your home directory, and then select <kbd>Ctrl+Q</kbd> to close the editor.

1. In your PowerShell session in Azure Cloud Shell, enter the following code, replacing `[your-automation-account-name]` with the name for your automation account resource, to upload the DSC script into your Azure Automation account.

    ```powershell
    Import-AzAutomationDscConfiguration `
        -Published `
        -ResourceGroupName <rgn>[Sandbox resource group name]</rgn> `
        -SourcePath $HOME/MyDscConfiguration.ps1 `
        -Force `
        -AutomationAccountName [your-automation-account-name]
    ```

    The command should produce output that looks like this:

    ```text
    ResourceGroupName     : <rgn>[Sandbox resource group name]</rgn>
    AutomationAccountName : [your-automation-account-name]
    Location              : eastus
    State                 : Published
    Name                  : MyDscConfiguration
    Tags                  : {}
    CreationTime          : 6/25/21 5:44:36 PM +00:00
    LastModifiedTime      : 6/25/21 5:44:36 PM +00:00
    Description           :
    Parameters            : {}
    LogVerbose            : False
    ```

## Add required modules (optional)

After you upload your DSC configuration script, import any PowerShell modules that the DSC process needs. Our configuration doesn't need any other modules, so we can skip this step. If you needed to import or add modules into your automation account you would go to **Shared Resources**, and then select **Modules** > **Add a module**.

## Compile the DSC script

1. In the Azure portal, the Overview pane for your Azure Automation account should still be displayed.

1. In the Automation Account menu, under **Configuration Management**, select **State configuration (DSC)**. The **State configuration (DSC)** pane for your automation account appears.

1. Select the **Configurations** tab. Verify that the configuration **MyDscConfiguration** appears, and then select it. The **MyDscConfiguration** Configuration pane appears.

    :::image type="content" source="../media/4-state-configurations.png" alt-text="Screenshot of the Azure portal, showing the state configurations available on the State configuration (DSC) pane.":::

1. In the command bar, select **Compile**.

1. In the **Compile DSC Configuration** dialog box, select **Yes**.

1. Check your notifications (notifications icon is in the global controls in the page header). Wait for the compilation job to show **Status** of **Completed**, which may take several minutes.

    >[!NOTE]
    >You may need to refresh to see the status change. To refresh, in the top left breadcrumb path of the Azure portal, select your automation account. The **State configuration (DSC)** pane appears. In the top menu bar, select **Refresh**. Then, select *MyDscConfiguration* configuration from the list to return to the **MyDscConfiguration** pane. Under the **Compilation jobs** tab, the **Status** should now appear as *Completed*.

    :::image type="content" source="../media/4-compilation.png" alt-text="Screenshot of the Azure portal, showing the state of the compilation job for the configuration.":::

1. When compilation is completed, close the **MyDscConfiguration** pane. Your **State configuration (DSC)** pane appears.

## Register the VM with your Azure Automation account

1. On the **State configuration (DSC)** pane for *[your-automation-account-name]*, select the **Nodes** tab. In the command bar, select **Add**. The **Virtual Machines** pane for your automation account appears.

    :::image type="content" source="../media/4-nodes.png" alt-text="Screenshot of the Azure portal, showing the Nodes pane.":::

1. Select the VM you created in the first task of this exercise: **myVM**. It may take up to 10 minutes for the configuration and VM to propagate in the network. If the VM isn't listed, wait a few minutes, and then select **Refresh** in command bar until it appears.

1. In the command bar, select **Connect**. The **Registration** pane appears.

    :::image type="content" source="../media/4-add-vm.png" alt-text="Screenshot of the Azure portal, showing the Virtual Machines pane.":::

1. Enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | Node configuration name | From the dropdown list, select *MyDscConfiguration.localhost* |
    | Refresh Frequency | 30  |
    | Configuration Mode Frequency | 15 |
    | Configuration Mode | ApplyAndMonitor |
    | Allow Module Override | Select checkbox |
    | Reboot Node if Needed | Select checkbox |
    | Action after Reboot | ContinueConfiguration |

1. Select **OK**.

1. Wait until the VM is connected. This process might take a few minutes. When your **myVM** has connected, in the breadcrumb path in the top left of the portal, select your automation account to close the **Registration** and **Virtual Machines** pane. The **State configuration (DSC)** pane for your automation account appears.

1. In the command bar, select **Refresh**.

1. Verify that the node **myVM** appears in the list and that its status is **Compliant**.

    :::image type="content" source="../media/4-registered.png" alt-text="Screenshot of the Azure portal, showing the Nodes pane with myVM registered.":::

## Verify that IIS is installed on the VM

In your web browser, go to `http://[public-ip]`, where, `[public-ip]` is the public IP address that you recorded earlier in this exercise.

You should see the default IIS webpage. 
:::image type="content" source="../media/4-iis.png" alt-text="Screenshot of the web browser, showing the default IIS pane." loc-scope="other"::: <!-- no-loc -->

Congratulations! IIS has been deployed. Azure Automation used the PowerShell DSC script you uploaded to your Azure Automation account.
