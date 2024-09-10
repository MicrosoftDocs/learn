For servers enabled with Azure Arc, you can take manual steps to enable them for one or more Windows or Linux machines in your environment. Alternatively, you can use the PowerShell cmdlet [Connect-AzConnectedMachine](/powershell/module/az.connectedmachine/remove-azconnectedmachine) to download the Connected Machine agent, install the agent, and register the machine with Azure Arc. The cmdlet downloads the Windows agent package (Windows Installer) from the Microsoft Download Center, and the Linux agent package from the Microsoft package repository.

This method requires that you have administrator permissions on the machine to install and configure the agent. On Linux, by using the root account, and on Windows, you are member of the Local Administrators group. You can complete this process interactively or remotely on a Windows server by using [PowerShell remoting](/powershell/scripting/learn/ps101/08-powershell-remoting).

Before you get started, review the [prerequisites](/azure/azure-arc/servers/prerequisites) and verify that your subscription and resources meet the requirements. For information about supported regions and other related considerations, see [supported Azure regions](/azure/azure-arc/servers/overview#supported-regions).

### Prerequisites<br>

You will need a computer with Azure PowerShell. For instructions, see [Install and configure Azure PowerShell](/powershell/azure/).

You use PowerShell to manage VM extensions on your hybrid servers managed by Azure Arc-enabled servers. Before using PowerShell, install the Az.ConnectedMachine module on the server you want to Arc-enable. Run the command on your server enabled with Azure Arc:

```powershell
Install-Module -Name Az.ConnectedMachine
```

When the installation finishes, you see the following message:

<!--- raw content start --->
The installed extension ``Az.ConnectedMachine`` is experimental and not covered by customer support. Please use with discretion.
<!--- raw content end --->

### Install the agent and connect to Azure

1.  Open a PowerShell console with elevated privileges.
2.  Sign in to Azure by running the command `Connect-AzAccount`.
3.  To install the Connected Machine agent, use `Connect-AzConnectedMachine` with the `-Name, -ResourceGroupName,` and `-Location` parameters. Use the `-SubscriptionId` parameter to override the default subscription as a result of the Azure context created after sign-in. Run one of the following commands:
    
    
     -  To install the Connected Machine agent on the target machine that can directly communicate to Azure, run:
        
        ```powershell
        Azure PowerShellCopyConnect-AzConnectedMachine -ResourceGroupName myResourceGroup -Name myMachineName -Location <region>
        ```
     -  To install the Connected Machine agent on the target machine that communicates through a proxy server, run:
        
        ```powershell
        Connect-AzConnectedMachine -ResourceGroupName myResourceGroup -Name myMachineName -Location <region> -Proxy http://<proxyURL>:<proxyport>
        
        ```
        
        Using this configuration, the agent communicates through the proxy server using the HTTP protocol.

If the agent fails to start after setup is finished, check the logs for detailed error information. On Windows, check this file: *%ProgramData%\\AzureConnectedMachineAgent\\Log\\himds.log*. On Linux, check this file: */var/opt/azcmagent/log/himds.log*.

### Install and connect by using PowerShell remoting

Here's how to configure one or more Windows servers with servers enabled with Azure Arc. You must enable PowerShell remoting on the remote machine. Use the `Enable-PSRemoting` cmdlet.

1.  Open a PowerShell console as an Administrator.
2.  Sign in to Azure by running the command `Connect-AzAccount`.
3.  To install the **Connected Machine** agent, use `Connect-AzConnectedMachine` with the `-ResourceGroupName`, and `-Location` parameters. The Azure resource names will automatically use the hostname of each server. Use the `-SubscriptionId` parameter to override the default subscription as a result of the Azure context created after sign-in.
    
    
     -  To install the **Connected Machine** agent on the target machine that can directly communicate to Azure, run the following command:
        
        ```powershell
        $sessions = New-PSSession -ComputerName myMachineName
        Connect-AzConnectedMachine -ResourceGroupName myResourceGroup -Location <region> -PSSession $sessions
        ```
     -  To install the Connected Machine agent on multiple remote machines at the same time, add a list of remote machine names, each separated by a comma.
        
        ```powershell
        $sessions = New-PSSession -ComputerName myMachineName1, myMachineName2, myMachineName3
        Connect-AzConnectedMachine -ResourceGroupName myResourceGroup -Location <region> -PSSession $sessions
        ```
    
    The following example shows the results of the command targeting a single machine:
    
    :::image type="content" source="../media/powershell-content-example-output-b0c15771.png" alt-text="Screenshot of the output from running the PowerShell script.":::
    

### Verify the connection with Azure Arc

After you install the agent and configure it, go to the Azure portal to verify that the server has successfully connected. View your machines in the [Azure portal](https://aka.ms/hybridmachineportal).

:::image type="content" source="../media/arc-servers-successful-onboard-1-bd202596.png" alt-text="Screenshot of the Azure portal to verify that the server has successfully connected by using PowerShell remoting.":::
