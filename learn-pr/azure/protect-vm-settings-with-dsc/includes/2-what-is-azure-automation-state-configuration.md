You use Azure Automation State Configuration to make sure that a cluster of virtual machines are in a consistent state with same software installed and the same configurations.

In this unit, you'll learn about the features and capabilities of Azure Automation. You'll review the declarative model of PowerShell Desired State Configuration (DSC), and its benefits.

## What is Azure Automation State Configuration?

Azure Automation State Configuration is an Azure service built on PowerShell that allows you to consistently deploy, reliably monitor, and automatically update the desired state of all your resources. Azure Automation provides the tools to define configurations and apply them to machines, real and virtual.

## Why use Azure Automation State Configuration?

Manually maintaining the correct and a consistent configuration for the servers that run your services can be difficult and error prone. Azure Automation State Configuration helps address these challenges by using PowerShell DSC and providing central management of your DSC artifacts and the DSC process.

Azure Automation State Configuration has a built in pull server. You can target nodes to automatically receive configurations from this pull server, conform to the desired state, and report back on their compliance. You can target virtual or physical Windows or Linux machines, in the cloud or on-premises.

You can use Azure Monitor logs to review the compliance of your nodes by configuring Azure Automation State Configuration to send this data.  

## What is PowerShell DSC?

PowerShell Desired State Configuration (DSC) is a declarative management platform used by Azure Automation State Configuration to configure, deploy, and control systems. A declarative programming language separates intent, or "what you want to do" from execution, or "how do you want to do it". You specify what the desired state should be, and let DSC do the work to get there. You don't have to know how to implement or deploy a feature when a DSC resource is available. Instead, you focus on the structure of your deployment.

If you're already using PowerShell, you may think, "why do I need Desired State Configuration?". Consider the following example. When you want to create a share on a Windows server, you might use the following PowerShell command:

```PowerShell
# Create a file share
New-SmbShare -Name MyFileShare -Path C:\Shared -FullAccess User1 -ReadAccess User2
```

The script is straightforward and easy to understand. However, if you use this script in production, you'll come across several problems. Consider what might happen if the script was run multiple times, or if the user 'User2' already has full access rather than only read access.

This approach isn't *idempotent*. Idempotence  describes an operation that has the same effect whether you run it once or 10,001 times. To achieve this outcome in PowerShell, you would need to add logic and error handling. If the share doesn't exist, you create it; if it does, there's no need.  If User2 exists but doesn't have read access, you add read access. Your PowerShell script would resemble something like:

```PowerShell
$shareExists = $false
$smbShare = Get-SmbShare -Name $Name -ErrorAction SilentlyContinue
if($smbShare -ne $null)
{
    Write-Verbose -Message "Share with name $Name exists"
    $shareExists = $true
}

if ($shareExists -eq $false)
{
    Write-Verbose "Creating share $Name to ensure it is Present"
    New-SmbShare @psboundparameters
}
else
{
    # Need to call either Set-SmbShare or *ShareAccess cmdlets
    if ($psboundparameters.ContainsKey("ChangeAccess"))
    {
       #...etc., etc., etc
    }
}
```

There could be additional cases that you've forgotten about, and which come to light only when problems arise later. DSC handles this process automatically. With DSC, you describe the end result rather than the process to be done to achieve this result. The following DSC code snippet shows an example:

```PowerShell DSC
Configuration Create_Share
{
   Import-DscResource -Module xSmbShare
   # A node describes the virtual machine to be configured

   Node $NodeName
   {
      # A node definition contains one or more resource blocks
      # A resource block describes the resource to be configured on the node
      xSmbShare MySMBShare
      {
          Ensure      = "Present"
          Name        = "MyFileShare"
          Path        = "C:\Shared"
          ReadAccess  = "User1"
          FullAccess  = "User2"
          Description = "This is an updated description for this share"
      }
   }
}
```

The example above uses the `xSmbShare` module that tells DSC *how* to check the state for a file share. The DSC Resource Kit currently contains more than 80 different resource modules, including one for installing an IIS site. You'll find a link to this resource at the end of the module.

You'll learn more about the structure of the PowerShell DSC code in the next unit.

## What is the Local Configuration Manager?

The Local Configuration Manager (LCM) is a component of the Windows Management Framework (WMF) that’s on a Windows operating system. LCM is responsible for updating the state of a node, like a virtual machine, to match the desired state. Every time LCM runs, it completes the following steps:

1. *Get* - Gets current state of the node.
2. *Test* - Compares the current state of a node against the desired state by using a complied DSC script (.mof file).
3. *Set* - Updates the node to match desired state described in the .mof file.

You configure LCM when you register a virtual machine with Azure Automation.

## Push/pull architectures within DSC

The LCM on each node can operate in two modes.

- *Push mode* - The configurations are sent, or *pushed*, manually by an administrator towards one or more nodes. The LCM makes sure that the state on each node matches what's specified by the configuration.

    ![Diagram showing a push architecture in DSC](../media/2-push.png)

- *Pull mode* - A *pull server* holds the configuration information. The LCM on each node polls the pull server at regular intervals, by default every 15 minutes, to get the latest configuration details. These requests are denoted as step 1 in the diagram below. In step 2, the pull server sends the details of any changes to the configuration back to each node.
  
    When using this approach, each node has to be registered with the pull service.

    ![Diagram showing a pull architecture in DSC](../media/2-pull.png)

There are advantages to both approaches. 
- Push mode is easy to set up, doesn't need its own dedicated infrastructure, and can run on your laptop. Push mode is helpful to test the functionality of DSC. You could also use push mode to get a newly imaged machine to the baseline desired state. 
- Pull mode is useful where you have an enterprise deployment that spans a large number of machines. LCM regularly polls the pull server and verifies the nodes are in the desired state. Any hotfixes applied by external tools or teams that result in configuration drift on individual machines are quickly brought back in line with the configuration you've set. This process can help achieve a state of continuous compliance for your security and regulatory obligations.

## Supported platforms and Operating Systems

Azure Automation DSC is supported by the Azure Cloud and other cloud providers, your on-premises infrastructure, or by a hybrid combination spanning all of these environments.

Azure Automation DSC supports the following Operating Systems:
  
- Windows
  - Server 2019
  - Server 2016
  - Server 2012R2
  - Server 2012
  - Server 2008 R2 SP1
  - 10
  - 8.1
  - 7
- Linux
  - Most variants, but excludes all Debian and Ubuntu 18.04

PowerShell DSC is installed on all Linux machines supported by Azure Automation DSC.

## DSC requirements for Windows

For Windows machines, the Azure Desired State Configuration (DSC) VM Extension uses the WMF to manage the versions of Windows features like Windows PowerShell DSC and Windows Remote Management (WinRM). Azure DSC supports WMF 4.0 or later. So Windows machines must run Windows Server 2012, Windows 7, or later.

The first time the Azure DSC extension is called, it installs an OS compatible version of WMF on all Windows versions except Windows Server 2016 or later. Windows Server 2016 and later versions already have the latest version of WMF installed. After WMF is installed, the machine requires a restart.

WinRM is enabled on machines nodes that run Windows Server 2012, Windows 7, or later.

Proxy support for the DSC agent is available in Windows builds 1809 and later. Proxy support isn't available in DSC for previous versions of Windows.

## Other DSC requirements

If your nodes are located in a private network, the following port and URLs are required for DSC to communicate with Automation:

  - *Port* - Only TCP 443 is required for outbound internet access.
  - *Global URL* -  *.azure-automation.net
  - *Global URL of US Gov Virginia* - *.azure-automation.us
  - *Agent service* - https://<workspaceId>.agentsvc.azure-automation.net


