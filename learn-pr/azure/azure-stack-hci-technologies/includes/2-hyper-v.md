To start your exploration of Azure Stack HCI technologies, you'll start with its core compute virtualization functionality that Hyper-V provides.

> [!CAUTION]
> This content references CentOS, a Linux distribution that is End Of Life (EOL) status. Please consider your use and plan accordingly. For more information, see the [CentOS End Of Life guidance](/azure/virtual-machines/workloads/centos/centos-end-of-life).

## What is Hyper-V?

Hyper-V is the Microsoft implementation of hypervisor. Hyper-V applies the resources of a single *host* computer, distributing them across multiple virtual machines (VMs) running on the same physical hardware. Hyper-V provides an isolated space for each VM to run its own operating system (OS) that's independent of the host's OS and other VMs.

> [!NOTE]
> Hyper-V is available as a server role for Windows Server and Azure Stack HCI, as a feature in 64-bit versions of the Windows client OS, and as a standalone product called Microsoft Hyper-V Server. Each Hyper-V version includes similar features, and this module focuses on the Hyper-V server role for Windows Server.

## Hyper-V architecture

When you install the Hyper-V server role, the installation process implements a software layer known as the *hypervisor*. The hypervisor controls access to the host's physical hardware. The installation process installs all hardware drivers only in the host operating system (also known as the *parent partition*). All VMs running on the host communicate only with virtualized hardware.

The following diagram depicts the high-level architecture of Hyper-V. The Hyper-V hypervisor takes full control of the hardware virtualization capabilities (depicted by the arrow from the CPU layer to the Hypervisor layer) and doesn't expose them to the guest OS.

:::image type="content" source="../media/2-hyper-v-architecture.png" alt-text="Diagram of a non-nested virtualization environment, with the CPU layer at the bottom, on top of which is a Hypervisor layer, followed by the root host OS and guest OS." border="true":::

An OS that runs in a VM is referred to as a *guest OS*. Hyper-V supports all current versions of Windows Server and client operating systems. In addition, Hyper-V supports several Linux distributions, including CentOS, Red Hat Enterprise Linux, Debian, Oracle Linux, SUSE, and Ubuntu, and FreeBSD.

## What is nested virtualization?

Nested virtualization is a Hyper-V feature that allows you to install and run Hyper-V inside a guest VM. Nested virtualization enables a guest VM to be a Hyper-V host, which can then host other guest VMs. Nested virtualization can be useful for implementing virtual test and development environments that would otherwise require physical hardware to run. As the Contoso Hyper-V administrator, you plan to investigate test environments and implement a private cloud, both of which could make use of nested virtualization.

The following diagram depicts Hyper-V with nested virtualization enabled. This feature allows a guest VM to install its own hypervisor and run its own guest VM.

:::image type="content" source="../media/2-nested-hyper-v-architecture.png" alt-text="Graphic of a nested virtualization environment, with the CPU layer at the bottom, on top of which is a Hypervisor layer, followed by the root host OS. There's another hypervisor layer, followed by the guest OS and root OS." border="true":::

## Reasons for using Hyper-V

Hyper-V supports various scenarios ranging from hosting individual VMs to providing a platform for complex, software-defined infrastructures. You can use Hyper-V to:

- Consolidate your server infrastructure. You can use Hyper-V to consolidate multiple physical servers into fewer, more powerful computers, to optimize space and energy usage.
- Provide a virtual development or test environment. Virtualization provides you the means to duplicate and restore development or test environments without having to purchase or maintain physical hardware or isolated network systems. You can configure virtualized development or test environments quickly and revert them as needed without affecting production systems.
- Establish a virtual desktop infrastructure (VDI). Combining Hyper-V and Remote Desktop Virtualization provides a centralized desktop management solution that uses virtual desktop infrastructure (VDI). This scenario helps you provide users with agile and personalized virtual desktops or virtual desktop pools with enhanced security.
- Implement a private cloud infrastructure. Hyper-V accommodates flexible, on-demand services that function much like public cloud services. Azure Stack HCI exemplifies how Hyper-V can integrate with other technologies such as Storage Spaces Direct and SDN to run virtualized workloads on-premises.

## General features of Hyper-V

New releases of Windows Server and updates add features to Hyper-V for supporting different workloads, increase their performance and enhance their security. You can group Hyper-V's general features as follows:

- Management and connectivity. You can manage your Hyper-V environment with the Windows Admin Center, Hyper-V Manager, Hyper-V module for Windows PowerShell, and Virtual Machine Connection. You can install these tools on the computer with the Hyper-V server role, or you can install the tools on a remote management computer.
- Portability. To make it easier to move or distribute a VM, Hyper-V provides features such as live migration, storage migration, and standard import/export functionality. 

> [!NOTE]
> Live Migration is a Hyper-V feature that allows you to move running VMs from one Hyper-V host to another while maintaining the availability of VM workloads. The primary benefit of live migration is flexibility. For example, you can decommission or upgrade a Hyper-V host on an as-needed basis, without having to schedule a maintenance window, by simply live migrating all of its VMs.

> [!NOTE]
> With Storage Migration, you move VM files, including disks, configuration, and checkpoints while the corresponding VM is running. This helps with resolving disk space issues on Hyper-V hosts. For example, if you have storage available on another Hyper-V cluster, you can use storage migration to transfer existing VM disk files to it without affecting availability of your virtualized workloads. Another common reason for moving VM disk files is to update the underlying physical storage. You can also move VM disks between physical storage devices in response to reduced performance resulting from increased I/O demand on one of them.

- Disaster recovery and backup. Hyper-V supports Hyper-V Replica, which creates copies of VMs in other physical locations. You can use these copies to restore VM instances as needed. Other features such as production checkpoints and support for Volume Shadow Copy Service (VSS) facilitate application-consistent backups of VM states.
- Security: Hyper-V supports security features such as secure boot and shielded VMs. Secure boot verifies digital signatures on files during the boot process to help protect against malware. Virtual disks in shielded VMs are encrypted to secure access and the VMs can only run on specific protected hosts.
- Optimization. For all supported guest operating systems, Hyper-V includes a set of customized services and drivers called Integration Services. These Integration Services includes Time Synchronization, Operating System Shutdown, Data Exchange, Heartbeat, Backup, and Guest Services. You can obtain updates for Integration Services through Windows Update.

## System requirements for Hyper-V

Always plan and carefully assess your VM's service, resource, and capacity requirements before deploying production workloads to Hyper-V. The basic hardware requirements for a Hyper-V host include:

- A 64-bit processor with second-level address translation (SLAT) and VM Monitor Mode extensions.
- Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V) enabled.
- Sufficient memory for the host and guest VMs.
- Hardware-enforced Data Execution Prevention (DEP) enabled (Intel XD bit, AMD NX bit).

> [!NOTE]
> To verify that a system meets the requirements for Hyper-V, you can run **Systeminfo.exe**. The output has a section that indicates whether or not the Hyper-V requirements are met.

The list of hardware resources that the host will need for running VMs include:

- Processor. Ensure the host has enough physical processor cores to support the VMs you plan to run.
- Memory. Ensure there's enough memory in the Hyper-V host to support the number of VMs you intend to run.
- Storage. Ensure your host has enough storage for the virtual hard disks used by your VMs. The storage subsystem also requires high throughput to support multiple VMs accessing the storage concurrently.
- Network. The Hyper-V host must allocate sufficient network capacity to each VM. In some cases, you might need to allocate a dedicated network adapter in the host.

## Nested virtualization requirements

To enable nested virtualization, you need to meet the following prerequisites:

- Both the Hyper-V host and the guest VM must be running Windows Server 2016 or Windows Server 2019. This functionality is also available on Azure Stack HCI.
- The physical host computer must have an Intel processor with Virtual Machine Extensions (VT-x) and Extended Page Tables (EPT) capabilities.

## Install the Hyper-V server role

To install the Hyper-V server role on local or remote hosts, you can use **Windows Admin Center (WAC)**, **Server Manager**, or the **Install-WindowsFeature** Windows PowerShell cmdlet.
