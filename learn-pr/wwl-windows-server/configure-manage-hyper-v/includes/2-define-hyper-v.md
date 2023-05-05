Hyper-V can subdivide the hardware capacity of a single host computer by allocating the host's hardware resources to multiple VMs. Hyper-V provides an isolated space for each VM to run its own operating system (OS) that's independent of the host's OS and other VMs.

As a new Windows Server administrator for Contoso, you must identify the considerations for installing and configuring Hyper-V on Windows Server to ensure that workloads are optimized and stable.

> [!NOTE]
> Hyper-V is available as a server role for Windows Server, as a feature in 64-bit versions of Windows client OS, and as a standalone product called *Microsoft Hyper-V Server*. Each Hyper-V version includes similar features, and this module focuses on the Hyper-V Server role for Windows Server.

## Features of Hyper-V on Windows Server

Hyper-V's general features can be grouped as listed in the following table.

|Feature|Description|
|---|---|
|Management and connectivity|You can manage your Hyper-V environment with the Hyper-V Manager, Hyper-V module for Windows PowerShell, Virtual Machine Connection (VMConnect), and Windows PowerShell Direct.|
|Portability|To make it easier to move or distribute a VM, Hyper-V provides features such as live migration, storage migration, and standard import/export functionality.|
|Disaster recovery and backup|Hyper-V supports Hyper-V Replica, which creates copies of VMs in other physical locations. These copies can be used to restore VM instances as needed. Other features such as production checkpoints and support for Volume Shadow Copy Service (VSS) facilitate application-consistent backups of VM states.|
|Security|Hyper-V supports security features such as Secure Boot and shielded VMs. Secure Boot verifies digital signatures on files during startup to protect against malware. Virtual disks in shielded VMs are encrypted to secure access, and the VMs can only run on specific, protected hosts.|
|Optimization|For all supported guest operating systems, Hyper-V includes a set of customized services and drivers called *Integration Services*. These Integration Services include Time Synchronization, Operating System Shutdown, Data Exchange, Heartbeat, Backup, and Guest Services.|

## Overview of hypervisors

When you install the Hyper-V Server role, a software layer known as the *hypervisor* is inserted into the boot process. The hypervisor controls access to the host's physical hardware. Hardware drivers are installed only in the host OS (also known as the *parent partition*). All VMs running on the host communicate only with virtualized hardware.

The following diagram depicts a system architecture  with the Hyper-V hypervisor installed. The Hyper-V hypervisor is between the hardware and the Windows root directory, host operating system, and a guest OS in a Hyper-V virtual machine. All interaction with the hardware must go through this hypervisor layer.

The Hyper-V hypervisor takes full control of the hardware virtualization capabilities and doesn't expose them to the guest operating system (guest OS).

:::image type="content" source="../media/m22-nested-virtualization-1.svg" alt-text="A non-nested virtualization architecture diagram in which the Windows operating system and Hyper-V virtual machine guest operating system have to access the hardware on the host via a Hyper-V hypervisor layer." border="false":::

## Guest operating systems supported by Hyper-V

An operating system that runs in a VM is referred to as a *guest operating system*. Hyper-V in Windows Server supports the following guest operating systems:

- All supported Windows versions
- These Linux editions: CentOS, Red Hat Enterprise Linux, Debian, Oracle Linux, SUSE, and Ubuntu
- FreeBSD

> [!IMPORTANT]
> Support is provided by Microsoft only for issues found in Microsoft operating systems and in integration services.

## Example use cases for Hyper-V

Hyper-V supports various scenarios from simple VMs to complex software-defined infrastructures. You can use Hyper-V to:

- Consolidate your server infrastructure. With Hyper-V, you can consolidate multiple physical servers to fewer, more powerful computers that use less space and consume less energy.
- Provide a virtual development or test environment. Virtualization provides the means to reproduce various development or test environments without having to purchase or maintain physical hardware or isolated network systems. Virtualized development or test environments can be configured quickly and reverted as needed without affecting production systems.
- Establish a Virtual Desktop Infrastructure (VDI). Combining Hyper-V and Remote Desktop Virtualization with Windows Server provides a centralized desktop management solution that uses VDI. This scenario helps you provide users with secure, agile, and personalized virtual desktops or virtual desktop pools.
- Implement a private cloud infrastructure. Hyper-V accommodates flexible, on-demand services that function much like public cloud services. Azure Stack hyperconverged infrastructure (HCI) exemplifies how Hyper-V can integrate with other technologies such as Storage Spaces Direct and Software Defined Networking (SDN) to run virtualized workloads on-premises.

## System requirements

Before you deploy production workloads to Hyper-V, to plan appropriately, you should carefully assess requirements, resources, and capacity for your VM service. The following are basic hardware requirements for a Hyper-V host:

- A 64-bit processor with second-level address translation (SLAT)
- A processor with VM Monitor Mode extensions
- Sufficient memory for the host and guest VMs
- Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V) enabled
- Hardware-enforced Data Execution Prevention (DEP) enabled (Intel XD bit, AMD NX bit)

    > [!TIP] 
    > To verify that a system meets the requirements for Hyper-V, you can run `Systeminfo.exe`.

The following is a list of hardware resources that the host needs to run VMs:

- Processor. Ensure the host has sufficient processor cores to support the VMs you plan to run.
- Memory. Ensure there's enough memory in the host to support the number of VMs you intend to run.
- Storage. Ensure your host has enough storage for the virtual hard disks (VHDs) used by your VMs. The storage subsystem also requires high throughput to support multiple VMs concurrently accessing the storage.
- Network. The Hyper-V host must allocate sufficient network capacity to each VM. In some cases, you might need to allocate different network adapters in the host for dedicated purposes.

    > [!TIP]
    > Profile the workloads before deployment to Hyper-V or if migrating to or from Azure. Profile a workload or application for a number of days to identify peaks and troughs for resources. This will give you a data-based understanding of what you require.

## Installation methods for Hyper-V Server role

You can use Server Manager to install the Hyper-V Server role. Run the `Install-WindowsFeature` cmdlet in Windows PowerShell or use Windows Admin Center (WAC) to install the Hyper-V Server role on local or remote Windows hosts.

## Demonstration

The following video demonstrates how to:

- Install Hyper-V using Server Manager.
- Install Hyper-V using WAC.
- Install Hyper-V using Windows PowerShell.

The main steps in the process are:

1. Install **Hyper-V** by using **Server Manager**:
    1. Open **Server Manager** and select **Add Roles and Features**.
    1. Select the **Hyper-V** role and the **Hyper-V Management Tools** feature.
    1. Select **Install**. The server will restart as required.

1. Install the **Hyper-V Server** feature by using **WAC**:
    1. Open **WAC** and select the required server to manage.
    1. Scroll through the **Tools** list and locate **Hyper-V**.
    1. In the **Roles and features** area, select **Hyper-V Management Tools**, and then select **Install**. The server will restart as required.

1. Open **Windows PowerShell** and use the `Install-WindowsFeature` cmdlet to install the **Hyper-V Server** role, replacing *<computer_name>* with the name of the server:
  
       ```powershell
        Install-WindowsFeature -Name Hyper-V -ComputerName <computer_name> -IncludeManagementTools -Restart
        ```

1. After the server restarts, use the **Windows PowerShell** `Get-WindowsFeature` cmdlet to verify that Hyper-V has been installed.

    > [!NOTE]
    > If you install the Hyper-V Server role on a server that contains the Server Core installation option, the `-IncludeManagementTools` parameter will only install the Hyper-V Module for Windows PowerShell.


> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4Mfsh]
---



---