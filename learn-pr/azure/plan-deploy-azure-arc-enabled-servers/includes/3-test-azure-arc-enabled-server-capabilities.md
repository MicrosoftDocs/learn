As you prepare to deploy across Wide World Importers' thousands of machines, you're first interested in testing Azure Arc-enabled servers and its capabilities. While you can't install Azure Arc-enabled servers on an Azure virtual machine (VM) for production scenarios, it's possible to configure Azure Arc-enabled servers to run on an Azure VM for evaluation and testing purposes only. In this unit, we showcase how Azure VMs can be used to test Azure Arc-enabled servers functionality.

## Hypothetical environment description

For this discussion, we'll assume that you already have a Windows Server Azure VM. The version of Windows Server deployed in Azure should be Windows Server 2008 R2 SP1 and later versions (including Server Core).

That being said, Azure Arc-enabled servers also supports the following Linux distributions:

- Ubuntu 16.04, 18.04, and 20.04 LTS (x64)
- CentOS Linux 7 and 8 (x64)
- SUSE Linux Enterprise Server (SLES) 12 and 15 (x64)
- Red Hat Enterprise Linux (RHEL) 7 and 8 (x64)
- Amazon Linux 2 (x64)
- Oracle Linux 7

## Prepare an Azure VM for Azure Arc-enabled servers

Because your Azure VM is already registered and managed as an Azure resource, it's necessary to reconfigure the VM. Reconfiguring the VM involves removing extensions, disabling the Azure VM guest agent, and blocking Azure IMDS access. After you've made these three changes, your Azure VM behaves like any machine or server outside of Azure. This reconfigured Azure VM offers a starting point to install and evaluate Azure Arc-enabled servers.

1. Remove any VM extensions on the Azure VM.

    In the Azure portal, navigate to your Azure VM resource. Under **Settings** in the left-hand pane, select **Extensions + applications**.

    If there are any extensions installed on the VM, select each extension individually and then select **Uninstall**.

    Wait for all extensions to finish uninstalling before proceeding to the next step.

1. Disable the Azure VM Guest Agent.

    To disable the Azure VM Guest Agent, you'll need to connect to your VM using Remote Desktop Connection (Windows) or SSH (Linux).

    When you're connected to a Windows machine, run the following PowerShell commands to disable the guest agent:

    ```powershell
    Set-Service WindowsAzureGuestAgent -StartupType Disabled -Verbose
    Stop-Service WindowsAzureGuestAgent -Force -Verbose
    ```

1. Block access to the Azure IMDS endpoint.

    While still connected to the server, configure your VM to block access to the Azure IMDS endpoint.

    When you're connected to a Windows machine, run the following PowerShell command:

    ```powershell
    New-NetFirewallRule -Name BlockAzureIMDS -DisplayName "Block access to Azure IMDS" -Enabled True -Profile Any -Direction Outbound -Action Block -RemoteAddress 169.254.169.254
    ```

## Reconfigure the Azure VM

The Azure portal has a wizard that will automate the script to automate the download, installation, and connection with Azure Arc. To generate a custom script for your environment, perform the following steps:

1. From your browser, go to the Azure portal.

1. Enter "Azure Arc" in the search field, then select **Azure Arc** from the choices.

1. On the **Azure Arc** page, select **Add** in the **Add your infrastructure for free** tile.

1. Select **Add** in the **Servers** tile.

1. On the **Add servers with Azure Arc** page, select **Generate script** in the **Add a single server** tile.

1. When the **Add a server with Azure Arc** wizard is displayed, select **Next** on the **Prerequisites** tab.

1. On the **Resource details** tab, provide the following:

    1. In the **Resource group** drop-down list, select the resource group from which the machine will be managed.

    1. In the **Region** drop-down list, select the Azure region to store the server's metadata.

    1. In the **Operating system** drop-down list, select **Windows**.

    1. For the **Connectivity method**, select **Public endpoint**.

    1. Select **Next**.

1. On the **Tags** tab, review the default **Physical location tags** suggested and enter any desired values, or specify one or more **Custom tags** to support your standards.

1. Select **Next**.

1. On the **Download and run script** tab, review the summary information. If you need to make any changes, select **Previous**; otherwise, select **Download**. 

    The script downloads as `./OnboardingScript.ps1`.

To install with the script, you must run the downloaded script from PowerShell in your reconfigured Azure Virtual Machine.

1. Connect and log in to your reconfigured Azure VM.

1. Copy the script that you downloaded in the previous steps to a known location on your VM.

1. Open an elevated PowerShell command prompt. The script only supports running from a 64-bit version of Windows PowerShell.

1. Change to the folder or share where you copied the script and execute it on the server by running the `./OnboardingScript.ps1` script.

Now that you have an Azure Arc-enabled server, you can begin to test Microsoft Defender for Cloud, Azure Monitor, Azure Policies, VM Extensions and the range of Azure Arc-enabled server capabilities.
