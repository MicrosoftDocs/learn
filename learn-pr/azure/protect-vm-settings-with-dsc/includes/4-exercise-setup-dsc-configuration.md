In this exercise, you'll create an Azure Automation account and upload a PowerShell DSC. You'll also onboard an existing VM into Azure Automation. If the VM is missing IIS, you'll then run code to install and configure IIS on the VM.

## Create a VM

Start by deploying a new VM from a Windows Server 2016 image.

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
      --image win2016datacenter \
      --admin-username $USERNAME \
      --admin-password $PASSWORD
    ```

    It takes a few minutes to create the VM and supporting resources. If the VM is created successfully, you should see output like this:

    ```JSON
    {
      "fqdns": "",
      "id": "/subscriptions/<guid>/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/myVM",
      "location": "eastus",
      "macAddress": "00-0D-3A-23-9A-49",
      "powerState": "virtual machine running",
      "privateIpAddress": "10.0.0.4",
      "publicIpAddress": "52.174.34.95",
      "resourceGroup": "myResourceGroup"
    }
    ```

    Copy the `publicIpAddress` in this output. You'll need this address later to access the VM.

1. Run the following command in Cloud Shell to open your VM's port 80 for web traffic:

    ```azurecli
    az vm open-port \
      --port 80 \
      --resource-group <rgn>[Sandbox resource group name]</rgn> \
      --name myVM
    ```

1. In your web browser, go to `http://[public-ip]`. Here, `[public-ip]` is the public IP address of your VM. Although port 80 is open, you receive an error message that says a website can't be reached. IIS isn't deployed on your VM.

## Create an Azure Automation account

1. Use your Microsoft Learn account to sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Search the Marketplace** text box, enter **Automation**, and press <kbd>Enter</kbd> to view the search results.

1. In the "Automation" search results, select the **Automation** Azure service published by Microsoft.

1. Select **Create**. The **Add Automation Account** pane appears.

1. Enter the following values for each setting. The automation account must have a unique name. We suggest using something like *\[*your name or initials*\]-automation-account*. Use this name wherever you see *\[your-automation-account-name\]* in this exercise.

    | Setting  | Value  |
    |---|---|
    | Name | *\[your-automation-account-name\]* |
    | Subscription | Concierge Subscription  |
    | Resource group | Select existing resource group associated with Concierge Subscription |
    | Location | Accept default location |

1. Ignore the message about permissions for the **Create Azure Run As account**. You don't need it to be created as a Run As account in Azure Active Directory.

1. Select **Create**. Wait until the automation account is created before you continue.

1. Select **Go to resource** when deployment completes. Your **Automation Account** pane appears.

## Create a DSC configuration script

1. In Cloud Shell, run the following command to start a PowerShell session:

    ```bash
    pwsh
    ```

1. At the PowerShell prompt, start the code editor and run the following command to create a file named *MyDscConfiguration.ps1* in your home directory.

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

1. Select <kbd>Ctrl+S</kbd> to save the file. Then, select <kbd>Ctrl+Q</kbd> to close the editor.

1. Run the following PowerShell command to upload your DSC script into your Azure Automation account. Replace the placeholder automation account name with the name you used to create the automation account.

    ```powershell
    Import-AzAutomationDscConfiguration `
        -AutomationAccountName [your-automation-account-name] `
        -ResourceGroupName <rgn>[Sandbox resource group name]</rgn> `
        -SourcePath $HOME/MyDscConfiguration.ps1 `
        -Force `
        -Published
    ```

    The command should produce output that looks like this:

    ```text
    ResourceGroupName     : <rgn>[Sandbox resource group name]</rgn>
    AutomationAccountName : [your-automation-account-name]
    Location              : eastus
    State                 : Published
    Name                  : MyDscConfiguration
    Tags                  : {}
    CreationTime          : 6/25/19 5:44:36 PM +00:00
    LastModifiedTime      : 6/25/19 5:44:36 PM +00:00
    Description           :
    Parameters            : {}
    LogVerbose            : False
    ```

## Add required modules

After you upload your DSC configuration script, you import into your automation account any PowerShell modules that the DSC process needs. Our configuration doesn't need any additional modules, so we can skip this step.

If you needed to add modules, in your automation account you would go to **Shared Resources**, and select **Modules** > **Add a module**.

## Compile the DSC script

1. Return to your Azure Automation account in the Azure portal.

1. In the left menu pane, under **Configuration Management**, select **State configuration (DSC)**. The **State configuration (DSC)** pane appears.

1. Select the **Configurations** tab. Verify that the configuration **MyDscConfiguration** appears.

    ![Screenshot of the Azure portal, showing the state configurations available on the State configuration (DSC) pane.](../media/4-state-configurations.png)

1. Select **MyDscConfiguration**.
  
1. In the top menu bar, select **Compile**.

1. In the **Compile DSC Configuration** message box, select **Yes**.

1. Wait for the compilation job to queue and run. The **Status** will change to **Completed**. You might need to refresh the screen to see the compilation status change.

    ![Screenshot of the Azure portal, showing the state of the compilation job for the configuration.](../media/4-compilation.png)

1. Close the **MyDscConfiguration** pane, and return to the **State configuration (DSC)** pane.

## Register the VM with your Azure Automation account

1. On the **State configuration (DSC)** pane for your *Automation Account*, select the **Nodes** tab, and in the top menu bar, select **Add**.

    ![Screenshot of the Azure portal, showing the Nodes pane.](../media/4-nodes.png)

1. Select the VM you created at the start of this unit: **myVM**. If the VM isn't listed, wait a few minutes and refresh the page until it appears.

1. In the top menu bar, select **Connect**.

    ![Screenshot of the Azure portal, showing the Virtual Machines pane.](../media/4-add-vm.png)

    The **Registration** pane appears.

1. Enter the following values for each setting.

    | Setting  | Value  |
    |---|---|
    | Node configuration name | MyDscConfiguration.localhost |
    | Refresh Frequency | 30  |
    | Configuration Mode frequency | 15 |
    | Configuration Mode | ApplyAndMonitor |
    | Allow Module Override | Select |
    | Reboot Node if Needed | Select |
    | Action after Reboot | ContinueConfiguration |

1. Select **OK**.

1. Wait until the VM is connected, and then close the **myVM** pane. This process might take a few minutes.

1. Close the **Virtual Machines** pane.

1. Return to the **State configuration (DSC)** pane, and in the top menu bar, select **Refresh**.

1. Verify that the node **myVM** appears in the list and that its status is **Compliant**.

    ![Screenshot of the Azure portal, showing the Nodes pane with myVM registered.](../media/4-registered.png)

## Verify that IIS is installed on the VM

In your web browser, go to `http://[public-ip]`. Here, `[public-ip]` is the public IP address of your VM. You recorded this address when you first created the VM.

You should see the default IIS webpage. IIS has been deployed. Azure Automation used the PowerShell DSC script you uploaded to your Azure Automation account.

:::image type="content" source="../media/4-iis.png" alt-text="Screenshot of the web browser, showing the default IIS pane." loc-scope="other"::: <!-- no-loc -->
