To start your journey across Azure Stack HCI technologies, you will start with its core compute virtualization functionality provided by Hyper-V. Hyper-V is the Microsoft's implementation of hypervisor. Its role is to leverage the resources of a single *host* computer by dividing them across to multiple virtual machines (VMs) running on the same physical hardware. Hyper-V provides an isolated space for each VM to run its own operating system (OS) that's independent of the host's OS and other VMs.

> [!NOTE]
> Hyper-V is available as a server role for Windows Server, as a feature in 64-bit versions of Windows client OS, and as standalone product called *Microsoft Hyper-V Server*. Each Hyper-V version includes similar features, and this module focuses on the Hyper-V server role for Windows Server.

## What is Hyper-V?

When you install the Hyper-V server role, a software layer known as the *hypervisor* is inserted into the boot process. The hypervisor controls access to the host's physical hardware. Hardware drivers are installed only in the host operating system (also known as the *parent partition*). All VMs running on the host communicate only with virtualized hardware.

The diagram below shows the high-level architecture of Hyper-V. The Hyper-V hypervisor takes full control of the hardware virtualization capabilities (orange arrow), and does not expose them to the guest operating system

:::image type="content" source="../media/2-hyper-v-architecture.png" alt-text="Image of a non-nested virtualization environment, with CPU layer at bottom, on top of that is a Hypervisor layer, and then root host OS ad guest OS." :::

An operating system that runs in a VM is referred to as a *guest operating system*. Hyper-V in Windows Server supports all current version of Windows Server and client operating systems and a number of Linux distributions, including CentOS, Red Hat Enterprise Linux, Debian, Oracle Linux, SUSE, and Ubuntu, as well as FreeBSD.

## What is nested virtualization?

Nested virtualization is a Hyper-V feature that allows you to install and run Hyper-V inside a guest VM. Nested virtualization enables a guest VM to be a Hyper-V host, which can then host other guest VMs. Nested virtualization can be extremely useful for implementing virtual test and development environments that would otherwise require physical hardware to run. The Contoso Hyper-V administrator is investigating test environments and implementing a private cloud and both of which could leverage the use nested virtualization.

The diagram below shows Hyper-V with nested virtualization enabled. This allows a guest VM to install its own hypervisor and run its own guest VM

:::image type="content" source="../media/2-nested-hyper-v-architecture.png" alt-text=“Image of a nested virtualization environment, with CPU layer at bottom, on top of that is a Hypervisor layer, and then root host OS, also present now is an additional hypervisor layer and above that is the guest OS and root OS." :::

## What are the reasons for using Hyper-V?

Hyper-V supports various scenarios ranging from hosting individual VMs to providing platform for complex, software-defined infrastructures. You can use Hyper-V to:

- **Consolidate your server infrastructure**. With Hyper-V you can consolidate multiple physical servers on to fewer, more powerful computers to optimize space and energy usage.
- **Provide a virtual development or test environment**. Virtualization provides the means to duplicate and restore development or test environments without having to purchase or maintain physical hardware or isolated network systems. Virtualized development or test environments can be configured quickly and reverted as needed without affecting production systems.
- **Establish a virtual desktop infrastructure (VDI)**. Combining Hyper-V and Remote Desktop Virtualization with Windows Server provides a centralized desktop management solution that uses VDI. This scenario helps you provide users with secure, agile and personalized virtual desktops or virtual desktop pools.
- **Implement a private cloud infrastructure**. Hyper-V accommodates flexible, on-demand services that function much like public cloud services. Azure Stack hyperconverged infrastructure (HCI) exemplifies how Hyper-V can integrate with other technologies such as Storage Spaces Direct (S2D) and Software Defined Networking (SDN) to run virtualized workloads on-premises.

## What are general features of Hyper-V on Windows Server?

New releases of Windows Server and updates add features to Hyper-V for supporting different workloads, increase their performance and enhance their security. Hyper-V's general features can be grouped as follows:

- **Management and connectivity**. You can manage your Hyper-V environment with the Hyper-V Manager, Hyper-V module for Windows PowerShell, Virtual Machine Connection (also referred to as VMConnect), and Windows PowerShell Direct. You install these tools on the computer with the Hyper-V server role, or you can install the tools on a remote management computer.
- **Portability**. To make it easier to move or distribute a VM, Hyper-V provides features such as live migration, storage migration, and standard import/export functionality.

> [!NOTE] 
> Live Migration is a Hyper-V feature which allows you to seamlessly move running VMs from one Hyper-V host to another while maintaining the availability of VM workloads. The primary benefit of live migration is flexibility. For example, you can decommission or upgrade a Hyper-V host on an as needed basis, without having to schedule a maintenance window, by simply live migrating all of its VMs.

> [!NOTE] 
> With Storage Migration, you move VM disk files while the corresponding VM is running. This helps with resolving disk space issues on Hyper-V hosts. For example, if you have storage available on another Hyper-V cluster, you can use storage migration to transfer existing VM disk files to it without affecting availability of your virtualized workloads.

Another common reason for moving VM disk files is to update the underlying physical storage. You can also move VM disks between physical storage devices in response to reduced performance resulting from increased I/O demand on one of them.
	
- **Disaster recovery and backup**. Hyper-V supports Hyper-V Replica, which creates copies of VMs in other physical locations. These copies can be used to restore VM instances as needed. Other features such as production checkpoints and support for Volume Shadow Copy Service (VSS) facilitate application-consistent backups of VM states.
- **Security**: Hyper-V supports security features such as secure boot and shielded VMs. Secure boot verifies digital signatures on files during the boot process to protect against malware. Virtual disks in shielded VMs are encrypted to secure access and the VMs can only run on specific protected hosts.
- **Optimization**. For all supported guest operating systems, Hyper-V includes a set of customized services and drivers called Integration Services. These Integration Services include Time Synchronization, Operating System Shutdown, Data Exchange, Heartbeat, Backup and Guest Services. Updates for Integration Services are obtained and delivered through Windows Update.

## What are system requirements for Hyper-V on Windows Server?

You should plan and carefully assess your VMs service, resource and capacity requirements before deploying production workloads to Hyper-V. The following are basic hardware requirements for a Hyper-V host:

- A 64-bit processor with second-level address translation (SLAT) and VM Monitor Mode extensions
- Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V) enabled
- Sufficient memory for the host and guest VMs
- Hardware-enforced Data Execution Prevention (DEP) enabled (Intel XD bit, AMD NX bit)

> [!NOTE] 
> To verify that a system meets the requirements for Hyper-V, you can run **Systeminfo.exe**. The output has a section that indicates whether or not the Hyper-V requirements are met.

The following is a list of hardware resources that the host will need for running VMs:

- **Processor**. Ensure the host has enough physical processor cores to support the VMs you plan to run.
- **Memory**. Ensure there's enough memory in the Hyper-V host to support the number of VMs you intend to run.
- **Storage**. Ensure your host has enough storage for the virtual hard disks used by your VMs. The storage subsystem also requires high throughput to support multiple VMs accessing the storage concurrently.
- **Network**. The Hyper-V host must allocate sufficient network capacity to each VMs. In some cases, you might need to allocate a dedicated network adapters in the host.

## What are nested virtualization requirements?

To enable nested virtualization, you need to meet the following prerequisites:

- Both the Hyper-V host and the guest VM must be Windows Server 2016 or later.
- The physical host computer must have a sufficient amount of static RAM.
- The physical host computer must have an Intel processor with Virtual Machine Extensions (VT-x) and Extended Page Tables (EPT) capabilities.

## How to install the Hyper-V Server role on Windows Server?

To install the Hyper-V server role on local or remote Windows hosts, you can use **Windows Admin Center (WAC)**, **Server Manager**, or the **Install-WindowsFeature** Windows PowerShell cmdlet.
