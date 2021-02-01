Storage Replica offers numerous benefits. To implement it successfully though, you must first ensure that your environment meets a number of prerequisites.

## Prerequisites to use Storage Replica

The prerequisites to use Storage Replica include:

- Servers hosting replicated volumes must be members of the same or trusted Active Directory Domain Services (AD DS) forest.
- Each server should have at least 2 GB of RAM and two CPU cores.
- Each server should be running Windows Server 2019 Datacenter or Windows Server 2016 Datacenter edition.

    > [!NOTE] 
    > It's possible to use Windows Server 2019 Standard edition, but this configuration supports replication of only a single volume of up to 2 terabytes (TB) in size.

- Each server should have at minimum one Gigabit Ethernet adapter for synchronous replication, although Remote Direct Memory Access (RDMA) is preferable.
- The source and destination server must both have one set of volumes: one volume for data and one volume for logs, with the following settings:
  
   - Disks must be initialized as a GUID Partition Table (GPT), rather than as a master boot record (MBR).
   - Volumes should be formatted with ReFS or NTFS.
   - The data volumes sizes and sector sizes must match.
   - The log volumes sizes and sector sizes must match.
   - The log volumes should use faster storage than data volumes.
   - The log volumes shouldn't be used for any other workloads.

- Bi-directional connectivity via Internet Control Message Protocol (ICMP), SMB (port 445, plus port 5445 for SMB Direct) and Web Services-Management (WS-MAN) (port 5985), between the servers hosting the replicated volumes.
- A network between servers with enough bandwidth to match I/O write workload, and less than 5-ms round-trip latency when implementing synchronous replication.

> [!NOTE]
> You cannot use Storage Replica to replicate Windows Server operating system volumes.

> [!TIP]
> You can verify that these requirements are satisfied by using the `Test-SRTopology` Windows PowerShell cmdlet. The tool is part of the **Windows Server Storage Replica Management Tools** feature.

## Data Deduplication

Storage Replica supports Data Deduplication. To implement it, you should:

- Install Data Deduplication on both the source and destination servers.
- Enable Data Deduplication on the data volume on the source server. This automatically replicates the deduplicated content of the primary to the secondary on the destination server.

    > [!NOTE]
    > You shouldn't enable Data Deduplication on the destination server.
