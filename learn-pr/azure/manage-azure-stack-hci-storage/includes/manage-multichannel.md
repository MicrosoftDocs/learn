After deciding on your optimal choice of drive types, symmetry, and caching, you want to focus on the networking aspects of Azure Stack HCI storage configuration. Your cluster nodes include RDMA adapters, and you intend to take full advantage of their processing capabilities.

## Manage SMB Multichannel in Azure Stack HCI

SMB Multichannel is part of the Server Message Block (SMB) 3.0 protocol. In the context of Azure Stack HCI, its primary purpose is to increase network performance and resiliency of SMB-based communication when accessing highly available file shares. This is accomplished by allowing access via multiple network connections, thereby resulting in bandwidth aggregation and increased fault tolerance.

SMB Multichannel is enabled by default on Azure Stack HCI and it doesn't require any configuration providing the following prerequisites are satisfied:

- Communication takes place between SMB 3.*x*–capable endpoints (such as any version of Windows or Azure Stack HCI operating system).
- At least one communication endpoint includes one of the following:
  - Multiple network adapters (standalone or teamed)
  - One or more network adapters that support Receive Side Scaling (RSS)
  - One or more network adapters that support RDMA

*RDMA* is a networking technology that provides high-throughput, low-latency communication that minimizes central processing unit (CPU) usage. RDMA supports zero-copy networking, which allows the physical network card to transfer data directly to or from the application memory of a physical server or a VM. With RDMA in Hyper-V guest VMs, latency between a guest VM and the physical network is practically the same as between the Hyper-V host and the physical network. 

SMB Multichannel detects the RDMA capabilities of network adapters, which are necessary to enable SMB Direct. It automatically creates two RDMA connections per interface.

SMB Direct optimizes the use of RDMA network adapters for SMB traffic, allowing them to function at full speed with very low latency and low CPU utilization. SMB Direct is available and enabled by default on all currently supported versions of Windows Server and Azure Stack HCI.

If you want to verify the functionality of SMB Multichannel, you can temporarily disable it on the client or server side, measure the resulting performance, and then compare it against the performance with SMB Multichannel enabled. To disable SMB Multichannel, run either of the following PowerShell cmdlets:

- On the Azure Stack HCI side: 'Set-SmbServerConfiguration -EnableMultiChannel $false'

- On an SMB 3.x client side: 'Set-SmbClientConfiguration -EnableMultiChannel $false'

To re-enable SMB Multichannel, rerun the cmdlets by changing the value of the *-EnableMultiChannel* parameter to '$true'.
