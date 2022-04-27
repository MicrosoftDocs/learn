## Azure PowerShell for Linux and Windows VMs

To install the Azure Extension for SAP by using PowerShell:

1.  Make sure that you have installed the latest version of the Az PowerShell module.
2.  Run the following PowerShell cmdlet. For a list of available environments, run the commandlet `Get-AzEnvironment`. If you want to use global Azure, your environment is `AzureCloud`. For Azure in China, select `AzureChinaCloud`.
    
    ```powershell
    $env = Get-AzEnvironment -Name [name of the environment]
    
    Connect-AzAccount -Environment $env
    
    Set-AzContext -SubscriptionName [subscription name]
    
    Set-AzVMAEMExtension -ResourceGroupName [resource group name] -VMName [virtual machine name]
    
    ```

The script deploys the required extensions and enables the required features. This can take several minutes. The **Set-AzVMAEMExtension** configuration handles all the steps to configure host monitoring for SAP.

The script output includes the following information:

 -  Confirmation that monitoring for the OS disk and all additional data disks has been configured.
 -  Confirmation of the configuration of storage metrics for a specific storage account.
 -  Status of the update of the monitoring configuration.
 -  Confirmation that configuration has been deployed or updated.
 -  List of options for testing the monitoring configuration.

Wait 15-30 minutes for Azure Diagnostics to collect the relevant data.

## Azure CLI for Linux VMs

To install the Azure Extension for SAP by using Azure CLI:

1.  Install using Azure CLI 2.0.
2.  Sign in with your Azure account:
    
    ```azurecli
    az login
    
    ```
3.  Install Azure CLI AEM Extension:
    
    ```azurecli
    az extension add --name aem
    
    ```
4.  Install the extension:
    
    ```azurecli
    az vm aem set -g [resource-group-name] -n [vm name]
    
    ```

## Checks and troubleshooting for end-to-end monitoring

After you have deployed your Azure VM and set up the relevant Azure monitoring infrastructure, run the readiness check for the Azure Extension for SAP to make sure that all performance metrics that appear inside your SAP application are provided by the underlying Azure monitoring infrastructure.

If all readiness check results are positive and all relevant performance counters appear fine, Azure monitoring has been set up successfully and you can proceed with the installation of SAP Host Agent. If the readiness check indicates that counters are missing, run the health check for the Azure monitoring infrastructure.

### Readiness check on a Windows VM

1.  Sign in to the Azure virtual machine (using an admin account is not necessary).
2.  Open a Command Prompt window.
3.  At the command prompt, change the directory to the installation folder of the Azure Extension for SAP: `C:\Packages\Plugins\Microsoft.AzureCAT.AzureEnhancedMonitoring.AzureCATExtensionHandler\[version]\drop`. The version in the path to the monitoring extension might vary. If you see folders for multiple versions of the monitoring extension in the installation folder, check the configuration of the **AzureEnhancedMonitoring** Windows service, and then switch to the folder indicated as **Path to executable**.
4.  At the command prompt, run azperflib.exe without any parameters. Azperflib.exe runs in a loop and updates the collected counters every 60 seconds. To end the loop, close the Command Prompt window.
    
    > [!NOTE]
    > If the Azure Extension for SAP is not installed, or the **AzureEnhancedMonitoring** service is not running, the extension has not been configured correctly.
5.  Azperflib.exe output shows all populated Azure performance counters for SAP. At the bottom of the list of collected counters, a summary and health indicator show the status of Azure monitoring. Check the result returned for the **Counters total** output, which is reported as empty, and for **Health status**. Next, interpret the resulting values as follows:
    
    :::row:::
      :::column:::
        **Azperflib.exe result values**
      :::column-end:::
      :::column:::
        **Azure Extension for SAP health status**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **API Calls - not available**
      :::column-end:::
      :::column:::
        Counters that are not available might be either not applicable to the virtual machine configuration or are errors. See **Health status**.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Counters total - empty**
      :::column-end:::
      :::column:::
        The following two Azure storage counters can be empty:
    
     -  Storage Read Op Latency Server msec
     -  Storage Read Op Latency E2E msec
    
    All other counters must have values.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Health status**
      :::column-end:::
      :::column:::
        Only OK if return status shows **OK**.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Diagnostics**
      :::column-end:::
      :::column:::
        Detailed information about health status.
      :::column-end:::
    :::row-end:::
    
6.  Make sure that every health check result is **OK**.

### Readiness check on a Linux VM

1.  Connect to the Azure Virtual Machine by using SSH.
2.  Check the output of the Azure Enhanced Monitoring Extension.
    
     -  Run `more /var/lib/AzureEnhancedMonitor/PerfCounters`
        
         -  Expected result: Returns list of performance counters. The file should not be empty.
     -  Run `cat /var/lib/AzureEnhancedMonitor/PerfCounters | grep Error`
        
         -  Expected result: Returns one line where the error is none, for example, `3;config;Error;;0;0;none;0;1456416792;tst-servercs;`
     -  Run `more /var/lib/AzureEnhancedMonitor/LatestErrorRecord`
        
         -  Expected result: Returns as empty or does not exist.
3.  If the preceding check was not successful, run the following additional checks.
4.  Make sure that the **waagent** is installed and enabled:
    
     -  Run `sudo ls -al /var/lib/waagent/`
        
         -  Expected result: Lists the content of the **waagent** directory.
     -  Run `ps -ax | grep waagent`
        
         -  Expected result: Displays one entry similar to: `python /usr/sbin/waagent –daemon`
5.  Make sure that the Azure Enhanced Monitoring Extension is installed and running:
    
     -  Run `sudo sh -c 'ls -al /var/lib/waagent/Microsoft.OSTCExtensions.AzureEnhancedMonitorForLinux-*/'`
        
         -  Expected result: Lists the content of the Azure Enhanced Monitoring Extension directory.
     -  Run `ps -ax | grep AzureEnhancedImplementing HA SAP HANA on Azure VMs`
        
         -  Expected result: Displays one entry similar to: `python /var/lib/waagent/Microsoft.OSTCExtensions.AzureEnhancedMonitorForLinux-2.0.0.2/handler.py daemon`
6.  Install SAP Host Agent as described in [SAP Note \#1031096](https://launchpad.support.sap.com/#/notes/1031096), and check the output of **saposcol**:
    
     -  Run `/usr/sap/hostctrl/exe/saposcol –d`
     -  Run `dump ccm`
7.  Check whether the **Virtualization\_Configuration\\Enhanced Monitoring Access** metric is **true**:
    
     -  If you already have an SAP NetWeaver ABAP application server installed, open transaction ST06 and check whether enhanced monitoring is enabled.

> [!NOTE]
> You can experience some warnings in cases where you use managed Standard Disks. Warnings will be displayed instead of the tests returning **OK**. This is normal and intended in case of that disk type.
