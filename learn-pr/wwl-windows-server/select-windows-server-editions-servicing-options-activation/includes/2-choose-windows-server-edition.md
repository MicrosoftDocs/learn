Contoso, Ltd. has its head office in Seattle. Throughout the rest of the world, there are major regional offices. There are also numerous smaller, branch offices in provincial cities. As part of the plan to move its compute environment from Windows Server 2016, a team is determining which editions of Windows Server 2025 should be used in head office datacenter, and at other regions.

## Windows Server 2025 editions

There are four editions of Windows Server:

- Windows Server 2025 Essentials.
- Windows Server 2025 Standard.
- Windows Server 2025 Datacenter.
- Windows Server 2025 Azure.

Each edition supports unique features. The following table describes the Windows Server 2025 editions:

| Edition                                | Description                                                  |
| -------------------------------------- | ------------------------------------------------------------ |
| Windows Server 2025 Essentials         | Similar to its predecessor, Windows Server 2025 Essentials edition is for small businesses. This edition allows up to 25 users and 50 devices. Users don't need Client Access Licenses (CALS) to connect to the server, but you can't increase the 25-user limit. It supports two processor cores and up to 64 gigabytes (GB) of random-access memory (RAM). It includes added support for Microsoft Entra ID through Microsoft Entra Connect. If configured as a domain controller, it must be the only domain controller, must run all Flexible Single Master Operations (FSMO) roles, and can't have two-way trusts with other Active Directory domains.  |
| Windows Server 2025 Standard edition   | Windows Server 2025 Standard edition is for physical server environments with little or no virtualization. It supplies  most of the roles and features available for the Windows Server operating system. This edition supports up to 64 sockets, an unlimited number of cores, and up to 256 terabytes (TB) of RAM for hosts that support 4-level paging and 4 petabytes (PB) for hosts that support 5-level paging. It includes licenses for up to two VMs running Windows Server. You can run two VMs on one physical host by using one standard license if the physical host is only used for hosting and managing the VMs. If the physical host is used to run other services such as DNS, you can only run one VM by using a standard license. |
| Windows Server 2025 Datacenter edition | Windows Server 2025 Datacenter edition is for highly virtualized infrastructures, including private cloud and hybrid cloud environments. It supplies all the roles and features available for the Windows Server operating system. This edition supports up to 64 sockets, an unlimited number of cores, 256 TB of ram for hosts that support 4-level paging and 4 PB for hosts that support 5-level paging. It includes unlimited VM licenses based on Windows Server for VMs that run on the same hardware. It also includes features such as Storage Spaces Direct and Storage Replica, along with Shielded VMs and features for software-defined datacenter scenarios. |
| Windows Server 2025 Azure edition | Windows Server 2025 Azure edition will only run on the Azure Stack HCI platform or as a VM in Azure. You can't run it under Hyper-V, on bare metal, on a 3rd party virtualization platform, or in a 3rd party cloud. Azure edition supports a maximum of 240 TB of RAM and 2048 logical processors. |
