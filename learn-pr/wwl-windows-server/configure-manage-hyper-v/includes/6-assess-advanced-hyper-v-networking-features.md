Several advanced features in Windows Server Hyper-V networking can improve network performance and increase the flexibility of VMs in private and public cloud environments. The Contoso Hyper-V administrator needs to determine which of these advanced network features is suitable for various workloads. The following table summarizes the advanced features that Windows Server Hyper-V networking supports.

|Feature|Description|
|---|---|
|Hyper-V Network Virtualization|This feature decouples virtual networks from the physical network infrastructure, in much the same way as a hypervisor does for host hardware. It removes the constraints of VLAN and hierarchical IP address assignment from VM provisioning and provides more agility and mobility when managing VMs and tenant workloads. Hyper-V Network Virtualization can be implemented using various components, including the Microsoft Network Controller server role, or network virtualization gateways and load balancers in either Windows Server or System Center Virtual Machine Manager.|
|Bandwidth management|You can use this feature to specify the minimum and maximum bandwidth that Hyper-V allocates to a virtual network adapter. Hyper-V reserves the minimum bandwidth allocation for the adapter even when other adapters for VMs on the same Hyper-V host are functioning at capacity.|
|DHCP guard|This feature drops DHCP messages from VMs that are functioning as rogue DHCP servers. This might be necessary in scenarios where you don't have direct control over a VM's configuration and the VM is hosted on a Hyper-V Server you manage.|
|Router guard|This feature drops router advertisement and redirection messages from VMs that are configured as unauthorized routers. This feature might be useful when you don't have control over the configuration of VMs hosted on a Hyper-V Server you manage.|
|Port mirroring|You can use this feature to copy incoming and outgoing packets from a network adapter to another VM that you have configured for monitoring.|
|NIC Teaming|You can use this feature to add a virtual network adapter to an existing team on the host Hyper-V Server.|
|Virtual Machine Queue (VMQ)|This feature requires the host computer to have a network adapter that supports the feature. VMQ uses hardware packet filtering to deliver network traffic directly to a guest. This improves performance because the packet doesn't need to be copied from the host OS to the VM. Only network adapters specific to Hyper-V support this feature.|
|Single-root I/O virtualization (SR-IOV)|To use this feature, you must install specific hardware and special drivers on the guest OS. SR-IOV enables multiple VMs to share the same physical Peripheral Component Interconnect Express hardware resources. If sufficient resources aren't available, the virtual switch provides network connectivity. Only network adapters specific to Hyper-V support this feature.|
|IP security (IPsec) task offloading|The guest OS and network adapter must provide explicit support for this feature. This feature enables a host's network adapter to perform calculation-intensive, security-association tasks. If sufficient hardware resources aren't available, the guest OS performs these tasks. You can set the maximum number of offloaded security associations from 1 to 4,096. Only network adapters specific to Hyper-V support this feature.|

## Additional networking features in Windows Server for SDN infrastructures

Windows Server 2016 and newer provides additional networking features to support Software-Defined Networking (SDN) infrastructures. These features include:

- Switch Embedded Teaming (SET). SET is a NIC Teaming option that you can use for Hyper-V networks. Hyper-V can integrate with SET to provide faster performance and better fault tolerance than traditional teams. Unlike traditional teams, with SET you can add multiple Remote Direct Memory Access (RDMA) network adapters.
- RDMA with Hyper-V. Also known as *Server Message Block (SMB) Direct*, *RDMA with Hyper-V* is a feature that requires hardware support in the network adapter. A network adapter with RDMA functions at full speed with low resource utilization. Effectively, this means that there's higher throughput, which is an important consideration for busy servers with high-speed network adapters such as 10 Gbps.

    > [!NOTE] 
    > RDMA services can  use Hyper-V switches. You can enable this feature with or without SET.

- Virtual Machine Multi-Queue (VMMQ). *VMMQ* improves on VMQ by allocating multiple queues per VM and by spreading traffic across the queues.
- Converged network adapters. A converged network adapter supports using a single network adapter or a team of network adapters to manage multiple forms of management, RDMA, and VM traffic. This reduces the number of specialized adapters that each host needs.
- Network address translation (NAT) object. Windows Server includes a *NAT* object that translates an internal network address to an external address. This can be useful to IP address management, particularly when there are many VMs that require access to the internet. However, there's no requirement for communication to be initiated from the internet back to the internal VMs.

    > [!TIP]
    > You can use the `New-NetNat` Windows PowerShell cmdlet to create a NAT object.

## Additional networking features in Windows Server

Windows Server provides further network improvements with the following additional networking features (introduced in Windows Server 2019):

- Receive Segment Coalescing (RSC) in the vSwitch. *RSC* is a stateless offload technology that helps reduce CPU utilization for network processing on the receive side by offloading tasks from the CPU to an RSC-capable network adapter. In Windows Server 2019, RSC in the vSwitch is enabled by default and it supports Hyper-V workloads.
- Dynamic Virtual Machine Multi-Queue (d.VMMQ). *d.VMMQ* improves on VMMQ by allocating traffic to CPUs dynamically. With d.VMMQ enabled, as network throughput changes, Windows Server 2019  automatically coalesces network packets onto more (or less) CPUs for processing. This helps maximize CPU efficiency in the Hyper-V host server and maintains consistent network throughput for each hosted VM. To use d.VMMQ, you must install a d.VMMQ-capable driver for your network adapters. However, no additional setup is required to use d.VMMQ with virtual workloads in Hyper-V.
