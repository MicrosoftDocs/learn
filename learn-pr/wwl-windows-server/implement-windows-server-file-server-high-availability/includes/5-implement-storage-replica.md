Availability of data is critical for business continuity. Traditionally, increased storage resiliency required expensive, vendor-specific solutions that relied on high-end hardware. Storage Replica eliminates this dependency, providing cost-efficient, hardware-agnostic high-availability and disaster recovery capabilities.

## What is Storage Replica?

Storage Replica is Windows Server technology that enables unidirectional replication between volumes residing on standalone or clustered-servers for high-availability or disaster recovery purposes.

Storage Replica requires two NTFS-formatted or ReFS-formatted volumes at the source, and two at the destination, with each pair being used for data and replication logs, respectively. Each pair should have matching size and performance characteristics. The source data volume is referred to as *primary*, while the destination volume is known as *secondary*. The servers hosting these volumes form a replication partnership. Such partnership can include multiple data volumes, however, all of them use the same log volume. Each server, together with all of its volumes that are part of a replication partnership, constitutes a replication group.

> [!IMPORTANT]
> You must never use log volumes for other workloads.

## Storage Replica features

The main features of Storage Replica include:

- Block-level replication. With block-level replication, there's no possibility of file locking.
- Simplicity. You can rely on Windows Admin Center to guide you through the process of creating a replication partnership between two servers. To deploy a stretch cluster, you can use a Failover Cluster Manager-based wizard.
- Support for physical servers and virtual machines. All Storage Replica capabilities are available to both virtual guest-based and host-based deployments. This means that guests can replicate their data volumes even if running on non-Windows virtualization platforms or in public clouds.
- Use of SMB 3.0. Storage Replica relies on SMB 3.x. All of SMB's advanced characteristics, such as SMB Multichannel and SMB Direct are available to Storage Replica.
- Security. Storage Replica features a wide range of security mechanisms, including packet signing, AES-128-GCM full data encryption, support for third-party encryption acceleration, and pre-authentication integrity man-in-the-middle attack prevention. Storage Replica also relies on Kerberos AES256 for all authentication between nodes.
- High performance initial sync. Storage Replica supports seeded initial sync, which involves copying a subset of data from a source volume to the target via backup or removable media. This way, initial replication consists only of the difference between the two volumes, shortening duration of the initial sync and limiting bandwidth usage.
- Consistency groups. Write ordering provides assurance that writes of applications such as SQL Server take place in the same sequence at the source and on the replicated volumes.
- Delegated administration. You can delegate permissions to manage replication without having to resort to granting Administrator-level privileges across replicated nodes.
- Network constraints. In cases where there are multiple network paths between replicated volumes, you can configure Storage Replica traffic to use designated network adapters. This allows you minimize potential impact of the replication traffic on production workloads.
- Thin provisioning. You have the option of implementing thin provisioning in Storage Spaces Direct, minimizing initial replication times.

## Prerequisites

The prerequisites to use Storage Replica include:

- Servers hosting replicated volumes must be members of the same or trusted AD DS forest.
- Each server should have at least 2 GB of RAM and two CPU cores per server.
- Each server should be running Windows Server 2019 Datacenter or Windows Server 2016 Datacenter edition. It is possible to use Windows Server 2019 Standard edition, however, such configuration supports replication of a single volume of up to 2 terabytes (TB) in size.
- Each server should have at minimum one Gigabit Ethernet adapter for synchronous replication, although RDMA is preferable.
- Two sets of volumes (one for data and the other for logs) on the source and destination server, with the following settings:
  - Disks must be initialized as GUID Partition Table (GPT), rather than master boot record (MBR).
  - Volumes should be formatted with ReFS or NTFS.
  - The data volumes sizes and sector sizes must match.
  - The log volumes sizes and sector sizes must match.
  - The log volumes should use faster storage than data volumes.
  - The log volumes shouldn't be used for any other workloads.
- Bi-directional connectivity via Internet Control Message Protocol (ICMP), SMB (port 445, plus port 5445 for SMB Direct) and Web Services-Management (WS-MAN) (port 5985) between the servers hosting the replicated volumes.
- A network between servers with enough bandwidth to match I/O write workload, and less than 5 ms round-trip latency when implementing synchronous replication.

> [!NOTE]
> You can't use Storage Replica to replicate Windows Server operating system volumes.

> **Note:** You can verify that these requirements are satisfied by using the `Test-SRTopology` Windows PowerShell cmdlet. This tool is part of the Windows Server Storage Replica Management Tools feature.

## Implementing Storage Replica by using Windows PowerShell

To automate implementation of Storage Replica, use the following Windows PowerShell-based procedure:

1. Use the `Test-SRTopology` cmdlet to determine whether the source and destination volumes meet the Storage Replica requirements. You can use the cmdlet in requirements-only mode by specifying the `IgnorePerfTests` parameter first, and if that's successful, rerun the cmdlet in the performance evaluation mode without the `IgnorePerfTests` parameter, as in the following example:

    ```powershell
    Test-SRTopology -SourceComputerName 'SEA-SVR1.contoso.com' -SourceVolumeName S: -SourceLogVolumeName L: -DestinationComputerName 'SEA-SVR2.contoso.com' -DestinationVolumeName S: -DestinationLogVolumeName L: -DurationInMinutes 1 -ResultPath C:\Temp
    } -Authentication Credssp -Credential $cred
    ```

1. Review the results of the test stored in the C:\temp folder on SEA-SVR1 and verify that there are no issues that need to be addressed.
1. Use the `New-SRPartnership` cmdlet to create a Storage Replica partnership, specifying the source and destination disks, the source and destination logs, the source and destination cluster names, and optionally, the log size:

    ```powershell
    New-SRPartnership -SourceComputerName 'SEA-SVR1' -SourceRGName 'RG01' -SourceVolumeName S: -SourceLogVolumeName L: -DestinationComputerName 'SEA-SVR2' -DestinationRGName 'RG02' -DestinationVolumeName S: -DestinationLogVolumeName L:
    ```

## Demonstration

The following video demonstrates how to implement Storage Replica by using Windows PowerShell.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest including two domain member servers with four data disk each and a management workstation running Windows 10.
1. On each domain member server, initialize the source and destination disks, create a ReFS-formatted volume on each, and assign drive letters to each. On the domain member servers, use Server Manager to initialize the source and destination disks, create a ReFS-formatted volume on each, and assign drive letters to each.
1. On each domain member server, enable CredSSP. Use Windows PowerShell to enable CredSSP on the two domain member servers.
1. Configure Storage Replica between the two domain member servers. Use Windows PowerShell to configure Storage Replica between the two domain member servers.
1. Validate the Storage Replica configuration. Use Windows PowerShell to validate the Storage Replica configuration.

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4MvSn]