# Hyper-V

The Microsoft Hyper-V Windows Server role is a hypervisor-based virtualization technology that allows you to provision virtual compute, storage, and network resources. Hypervisor has direct access to the underlying physical hardware. You can manage the hypervisor and its resources by using a parent partition running Windows Server. The management tasks include creating child partitions, each running a separate instance of a guest operating system.

## Hyper-V functionality

The Hyper-V role offers a number of other features that go far beyond its core capabilities, including:

- Hyper-V scalability. Hyper-V hosts can have up to 24 terabytes (TB) of RAM and 512 logical processors. Each Generation 2 guest virtual machine (VM) can have up to 240 virtual CPUs and 12 TB of RAM, up to 68 virtual network adapters, and up to 256 Internet Small Computer Systems Interface (iSCSI) virtual disks of 64 TB in size. You can create a failover cluster with up to 64 Hyper-V nodes, with each cluster hosting up to 8,000 guest VMs.

- Automatic VM activation. Starting with the Windows Server 2012 R2 Datacenter edition, you can automatically activate guest VMs that are running Windows Server 2012 R2 or newer. Windows Server 2019 Datacenter continues to provide the same functionality, allowing you to activate any edition of Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019. The guest VM will also remain activated if you move it to another host running the same or newer version of the Windows Server Datacenter.

- Host resource protection. You have the option of enabling this functionality, which will automatically protect the parent partition and protect against excessive resource usage of one of guest VMs.

- Discrete device assignment. You can configure guest VMs with direct access to peripheral component interconnect express (PCIe) hardware devices, bypassing the Hyper-V virtualization stack, in order to optimize performance.

- Runtime resize of guest VM memory. If a guest VM is configured to use dynamic memory, you can decrease its minimum RAM settings and increase maximum RAM while the guest VM is running. If the guest VM is configured with static memory, you can increase or decrease its memory while it is running.

- Runtime add and resize VHDX. While the guest VM is running, you can add or remove virtual hard disks that are connected to a SCSI controller. You cannot add or remove virtual hard disks if they are connected to an IDE controller. You can also extend or shrink a VHDX that is connected to a SCSI controller while the guest VM is running.

- Hot-Add and virtual network interface card (vNIC) naming. You can add or remove network adapters to a Generation 2 guest VM while it is running. You can also name the network adapter from the Hyper-V host;  that name is visible from the guest VM that is using the network adapter.

- Checkpoints. Checkpoints are a Hyper-V feature that you can use to create a point-in-time snapshot of a guest VM, including its configuration, memory, and disk state. You can create checkpoints when a guest VM is running, turned off, or in a saved state. Starting with Windows Server 2016, besides standard checkpoints, you also have the ability to create production checkpoints. Production checkpoints are coordinated with the Volume Shadow Copy service in the guest VM.

- Live Migration. Live Migration moves a running guest VM between two Hyper-V hosts without noticeable downtime. The guest VM can be on a cluster shared storage, on a server message block 3.0 (SMB3) share or on local storage. The Hyper-V hosts can be either nodes in the same failover cluster or standalone servers in the same Active Directory Domain Services (AD DS) domain or in different domains. The only requirement is that there must be network connectivity between the Hyper-V hosts. You can use Live Migration to move only running guest VMs or to move guest VMs and all their storage, including checkpoints.  

- Guest VM network and guest VM storage resiliency. If a guest VM is running in a Hyper-V cluster and there is interruption in the network or storage access, the guest VM can automatically fail over to a different Hyper-V cluster node.

- Start order priority for clustered guest VMs. You can control the order in which guest VMs on a Hyper-V cluster are started or restarted.

- Windows PowerShell Direct. You can use Windows PowerShell on the Hyper-V host to connect and run cmdlets and scripts in the guest VM that is running on the same Hyper-V host, without using network connectivity to the guest VM. This feature is similar to PowerShell Remoting, but you can use it to connect to guest VMs even if they do not have an active network connection or if their network is configured incorrectly. PowerShell Direct uses VMbus to connect to the guest VM; you can also use this connection to copy files to or from the guest VM.

- Nested virtualization. Starting with Windows Server 2016, you can install the Hyper-V role in a guest VM and run a guest VM inside another guest VM.

- Virtualization-based security for Generation 2 guest VMs. You can take advantage of this feature in order to implement Device Guard and Credential Guard.

- Rolling upgrades. Starting with Windows Server 2016, you can have cluster nodes running different versions of the Windows Server operating system, as long as all of them support the current cluster functional level. This allows you to perform cluster upgrades without the need for temporary downtime. Keep in mind that this functionality is intended to be used only during an upgrade. Once all cluster nodes are running Windows Server 2019, you should upgrade the cluster to the corresponding functional level (10.x).

- Integration Services for guest VMs running Windows distributed via Windows Update. Guest VM users can update Integration Services at their own schedule, the same way they deploy the operating system updates.
