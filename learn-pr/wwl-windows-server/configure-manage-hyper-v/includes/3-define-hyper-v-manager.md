As part of the plan to migrate Contoso on-premises servers to Hyper-V on Windows Server 2022, you need to determine the most appropriate management options for the various Hyper-V workloads and their geographical location.

Hyper-V Manager provides a GUI for managing local and remote Hyper-V hosts. Hyper-V Manager is available when you install the Hyper-V Management tools. These are included with a full Hyper-V Server role installation, or you can install them as a tools-only installation.

## Overview of the constituent parts of Hyper-V Manager

The Hyper-V Manager GUI has the panes listed in the following table.

|Pane|Description|
|---|---|
|Navigation|The Hyper-V Manager navigation pane lists the names of the Hyper-V host to which it's currently connected.|
|Virtual Machines|When a host is selected, the VMs associated with the host are listed in the Virtual Machines pane.|
|Checkpoints|When a VM is selected, the checkpoints for the VM are listed in the Checkpoints pane.|
|Details|When a VM or checkpoint is selected, summary details about the VM or checkpoint are listed in the Details pane.|
|Actions|The Actions pane contains a menu of actions that you can perform on each Hyper-V host, VM, or checkpoint.|

:::image type="content" source="../media/m22-hyper-v-manager.png" alt-text="The Hyper-V Manager GUI with its five panes: navigation, Virtual Machines, Checkpoints, Details, and Actions.":::

## General features and functionality of Hyper-V Manager

Hyper-V Manager can perform the Hyper-V management functions listed in the following table.

|Functions|Description|
|---|---|
|Manage remote and local Hyper-V Servers (hosts)|Connect to small numbers of Hyper-V hosts, both remote and local, and manage them from a single Hyper-V Manager console over an encrypted HTTPS connection.|
|Manage Hyper-V VMs|With Hyper-V Manager, you can perform many management actions such as import, export, connect to, create and delete, or stop and start a VM. You can also modify a VM's virtualized hardware settings, such as Memory, CPU, and Network Adapter.|
|Enable Hyper-V Replication|You can enable, disable, and configure Hyper-V Replication on a VM with Hyper-V Manager.|
|Manage VHDs|With Hyper-V Manager, you can create, remove, inspect, and configure VHDs and VHD Set files.|
|Virtual SAN Manager|Hyper-V Manager includes the Virtual SAN (storage area network) Manager tool. You can use the Virtual SAN Manager tool to create and configure Virtual SANs.|
|Virtual Switch Manager|Hyper-V Manager includes the Virtual Switch Manager. With the Virtual Switch Manager you can create vSwitches and configure their connections to external, internal, and private networks.|
|Manage checkpoints|You can enable or disable checkpoint creation for your VMs in Hyper-V Manager, and choose between standard or production checkpoints.|
|Enable Hyper-V Integration Services|With Hyper-V Manager, you can enable and disable Hyper-V Integration Services.|
|Configure settings for Hyper-V features|You can use Hyper-V Manager to configure settings for Hyper-V features. For example, you can select the source and destination computers for live migration or specify a replica server for use with Hyper-V Replica.|
|Previous version support|When using Hyper-V Manager on Windows Server 2022, Windows Server 2019 or Windows 10, you can still manage hosts installed with previous operating systems such as Windows Server 2016, Windows Server 2012, or Windows Server 2012 R2.|
|Support for WS-Management protocol|Hyper-V Manager supports connections to Hyper-V hosts over the Web Services Management Protocol (WS-Management Protocol). This enables Hyper-V Manager to communicate by using the Kerberos protocol NTLM or Credential Security Support Provider (CredSSP). When you use CredSSP, Active Directory Domain Services (AD DS) delegation isn't necessary. This makes it easier to enable remote administration, because WS-Management Protocol communicates either over port 80 or port 443, which are the default open ports.|

Hyper-V Manager supports the following general features:

- Previous version support. When using Hyper-V Manager on Windows Server 2022, Windows Server 2019, or Windows 10, you can still manage hosts installed with previous operating systems such as Windows Server 2016, Windows Server 2012, or Windows Server 2012 R2.
- Support for WS-Management Protocol. Hyper-V Manager supports connections to Hyper-V hosts over the WS-Management Protocol. This enables Hyper-V Manager to communicate by using the Kerberos protocol NTLM or CredSSP. When you use CredSSP, Active Directory Domain Services (AD DS) delegation isn't necessary. This makes it easier to enable remote administration, because WS-Management Protocol communicates either over port 80 or port 443, which are the default open ports.

> [!TIP]
> Run the Hyper-V Server role on Windows Server Core hosts. On hosts that don't have a GUI, manage VMs by using one of the Hyper-V management tools. You can manage your Hyper-V hosts collectively while reducing the Hyper-V Server footprint.

## Other methods to manage Hyper-V on Windows Server

Hyper-V Manager is the most common interface for managing VMs in Hyper-V. You can use other tools that provide similar features for specific management scenarios, including Windows PowerShell and PowerShell Direct.

### Windows PowerShell

- The Hyper-V module for Windows PowerShell provides cmdlets that you can use for scripting or command-line administrative scenarios.
- You can use Windows PowerShell to manage the configuration, display the status, and perform general management tasks for Hyper-V hosts and their guest VMs.

### PowerShell Direct

- By using PowerShell Direct, you can use Windows PowerShell inside a VM regardless of the network configuration or remote management settings on either the Hyper-V host machine or the VM.
- You can use the `Enter-PSSession` cmdlet to connect to a VM. After connecting to the VM, you can issue PowerShell cmdlets directly on the VM.
- To use PowerShell Direct, the VM must be started and you must be signed in to the host computer as a Hyper-V administrator. The host OS and the target VM must be installed with at least Windows 10 or Windows Server 2016. Integration services with a configuration version of 6.2 or higher must be running in the VM you want to manage.

### Windows Admin Center

- Windows Admin Center (WAC) is a browser-based application that's used for remotely managing Windows Servers, clusters, and Windows 10 PCs.
- When you connect to a Hyper-V host using WAC, you can manage VMs and vSwitches. WAC provides functionality that's similar to Hyper-V Manager.
- WAC also provides summary and status information for events, CPU utilization, and memory usage.
