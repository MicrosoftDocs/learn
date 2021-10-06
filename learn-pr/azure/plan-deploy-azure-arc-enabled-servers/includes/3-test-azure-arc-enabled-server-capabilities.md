As you prepare to deploy across Wide World Importers' thousands of machines, you are first interested in testing Azure Arc-enabled servers and its capabilities. While you cannot install Azure Arc-enabled servers on an Azure VM for production scenarios, it is possible to configure Azure Arc-enabled servers to run on an Azure VM for evaluation and testing purposes only. In this walkthrough, we showcase how Azure VMs can be used to test Azure Arc-enabled servers functionality. 

## Pre-requisites for Arc-enablement 

For this walkthrough, we assume you have a Windows Server Azure VM. The Windows Server Azure VM should be a Windows Server 2008 R2 SP1 or Windows Server 2012 R2 and higher (including Server Core). Note that Azure Arc-enabled servers also supports the following operating systems:

- Ubuntu 16.04, 18.04, and 20.04 LTS (x64)
- CentOS Linux 7 and 8 (x64)
- SUSE Linux Enterprise Server (SLES) 12 and 15 (x64)
- Red Hat Enterprise Linux (RHEL) 7 and 8 (x64)
- Amazon Linux 2 (x64)
- Oracle Linux 7

## Prepare the Azure VM for Arc-enablement

Because your Azure VM is already registered and managed as an Azure resource, it is necessary to reconfigure the VM. Reconfiguring the VM involves removing extensions, disabling the Azure VM guest agent, and blocking Azure IMDS access. After you've made these three changes, your Azure VM behaves like any machine or server outside of Azure. This reconfigured Azure VM will offer a starting point to install and evaluate Azure Arc-enabled servers.

1. Remove any VM extensions on the Azure VM.

    In the Azure portal, navigate to your Azure VM resource and from the left-hand pane, select Extensions. If there are any extensions installed on the VM, select each extension individually and then select Uninstall. Wait for all extensions to finish uninstalling before proceeding to the next step. 

1. Disable the Azure VM Guest Agent.

    To disable the Azure VM Guest Agent, you'll need to connect to your VM using Remote Desktop Connection (Windows) or SSH (Linux). Once connected, run the following commands to disable the guest agent. Run the following PowerShell commands:

    ```powershell
    Set-Service WindowsAzureGuestAgent -StartupType Disabled -Verbose
    Stop-Service WindowsAzureGuestAgent -Force -Verbose
    ```

1. Block access to the Azure IMDS endpoint.

    While still connected to the server, run the following commands to block access to the Azure IMDS endpoint. For Windows, run the following PowerShell command:

    ```powershell
    New-NetFirewallRule -Name BlockAzureIMDS -DisplayName "Block access to Azure IMDS" -Enabled True -Profile Any -Direction Outbound -Action Block -RemoteAddress 169.254.169.254
    ```

## Arc-enable the Reconfigured Azure VM

The script to automate the download and installation, and to establish the connection with Azure Arc, is available from the Azure portal. To complete the process, perform the following steps:

1. From your browser, go to the Azure portal.

1. On the Servers - Azure Arc page, select Add at the upper left.

1. On the Select a method page, select the Add servers using interactive script tile, and then select Generate script.

1. On the Generate script page, select the subscription and resource group where you want the machine to be managed within Azure. Select an Azure location where the machine metadata will be stored. 

1. On the Prerequisites page, review the information and then select Next: Resource details.

1. On the Resource details page, provide the following:

    1. In the Resource group drop-down list, select the resource group the machine will be managed from.

    1. In the Region drop-down list, select the Azure region to store the servers metadata.
    
    1. In the Operating system drop-down list, select Windows
    
    1. Select Next: Tags.

1. On the Tags page, review the default Physical location tags suggested and enter a value, or specify one or more Custom tags to support your standards.

1. Select Next: Download and run script.

1. On the Download and run script page, review the summary information, and then select Download. If you still need to make changes, select Previous.

To install with the script, you must run the downloaded script from PowerShell in the re-configured Azure Virtual Machine 

1. Connect to and Log in to the reconfigured Azure VM

1. Open an elevated PowerShell command prompt. Note: The script only supports running from a 64-bit version of Windows PowerShell.

1. Change to the folder or share that you copied the script to, and execute it on the server by running the `./OnboardingScript.ps1` script.

Now that you have an Azure Arc-enabled server, you can begin to test Azure Security Center, Azure Monitor, Azure Policies, VM Extensions and the range of Azure Arc-enabled server capabilities. 
