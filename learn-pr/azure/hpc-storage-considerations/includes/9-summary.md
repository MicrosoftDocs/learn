In this module, we discussed key factors involved in choosing HPC storage in Azure. It's now time to combine the information and create a tool you can use to evaluate the various Azure storage options.

Let's create a checklist that encapsulates the major storage considerations. You might wonder why a checklist is necessary, particularly if you've overseen your current storage environment for a long time. The goal is to consolidate information for other stakeholders, including Azure team members and partners you might be working with. The checklist helps to streamline the decision process and minimize any misunderstandings around a particular storage solution's capabilities (or lack of capabilities).

Create your checklist based on the following list of considerations.

## Distribution of workload traffic ##

Account for the types of traffic your HPC environment generates and processes. This step is especially important if you plan to run multiple types of workloads and plan to use the storage for other purposes.

For example, your HPC workload might read sequential data from a large file (like a media asset from a render job, or a genomic sequence file) from a large number of HPC machines. At the same time, there might be a need to operate a database (for example, to work with your HPC scheduler). The traffic types are different and might need to be deployed on different storage solutions.

Storage solutions might be designed to optimize for different things. A NAS filer built from Ubuntu running local NVMe disks would be great at single-stream activities, like a single client copying data from the NAS to local disk. But it might not scale for concurrent access by large numbers of clients.

Also, you might need a solution that optimizes for large numbers of small files. A traditional NAS solution, like Azure NetApp Files, provides optimal performance for such traffic. But you might also need to process and then store large files and minimize the cost of doing so. Azure Blob Storage with tiering provides flexibility in these cases, but it might not provide great performance for a single-stream copy operation.

Record the following traffic types in your checklist:

- Single stream traffic versus multiple stream traffic
- Ratio of read traffic to write traffic
- Average file sizes and counts
- Random versus sequential access patterns

For example, your checklist might reflect:

- Multi-stream traffic.
- Read heavy (75% versus 25%).
- Average file sizes between 10 GB and 200 GB. About 50,000 files.
- Sequential heavy (80% versus 20%).

You should also account for the major workloads you plan to run on the architecture. If there are more than one or two, ensure that there's not a significant divergence in requirements.

## Data locality ##

The next category accounts for the location of the data. Do you need to keep the data on-premises? Are there concerns about data modifications while you're running your HPC workload? Do you plan for data modifications to happen only on-premises, only in Azure, or in both locations?

Here are some locality items for your checklist:

- Source data on-premises, in Azure, or both?
- Results data on-premises, in Azure, or both?
- Should HPC workloads in Azure be coordinated with source-data modification timelines?
  - Timelines help to inform the risk of stale data.
- Sensitive/HIPAA data?
  - Data sensitivity helps inform the level of authentication and encryption required.

Locality awareness helps you determine whether you can use copying, caching, or synchronization as your data movement strategy.

## Performance requirements ##

Your performance requirements should look something like this:

- Single-stream throughput (in GBps)
- Multi-stream throughput (in GBps)
- Expected maximum IOPS
- Average latency (ms)

Every consideration affects performance, so these numbers represent a guide that a particular solution should achieve. For example, you might have an HPC workload that does extensive file creation and deletion as part of the workflow. Those operations could affect the overall throughput.

## Access methods ##

Account for the client access protocol required. As we discussed, there are different versions of NFS (and SMB, the Windows client protocol). If you plan to use NFSv4, be clear about what features of the protocol are required (like ACLs).

Here are some items for your checklist:

- NFS versions required
  - If v4, expected protocol behaviors (ACLs, encryption)
- Parallel file system solution

## Total capacity requirement ##

Storage capacity in Azure is the next consideration. It helps to inform the overall cost of the solution. If you plan to store a large amount of data for a long time, you might want to consider *tiering* as part of the storage solution. Tiering provides lower-cost storage options combined with higher-cost but higher-performance storage in a hot tier.

Some items for your list:

- Total capacity required
- Total hot-tier capacity required
- Total warm-tier capacity required
- Total cold-tier capacity required

A note on cold-tier capacity: archive tiers combine lower costs for storing data with higher transaction costs for retrieving data. Also, archive tiers have long retrieval times for data. They shouldn't be considered part of your hot or warm tiers.

## Authentication/authorization method ##

Add your authentication/authorization requirements to the checklist. At minimum, adding them ensures you include the appropriate supporting systems, like an LDAP server or Active Directory environment, to your architecture. But if you need to support capabilities like UID/GID mapping to Active Directory users, you need to confirm that the storage solution supports that capability.

For your list:

- Local (UID/GID on file server only)
- Directory (LDAP, Active Directory)
- UID/GID mapping to Active Directory users?

## Further reading ##

- IETF NFS RFCs:

  - [RFC 1813: NFS Version 3 Protocol Specification](https://tools.ietf.org/html/rfc1813)
  - [RFC 2203: RPCSEC_GSS Protocol Specification](https://tools.ietf.org/html/rfc2203)
  - [RFC 3530: Network File System (NFS) Version 4 Protocol](https://tools.ietf.org/html/rfc3530)
  - [RFC 5661: Network File System (NFS) Version 4 Minor Version 1 Protocol](https://tools.ietf.org/html/rfc5661)
  - [RFC 5331: RPC: Remote Procedure Call Protocol Specification Version 2](https://tools.ietf.org/html/rfc5531)
- [Lustre file system](https://www.lustre.org)
- [IBM Spectrum Scale (GPFS)](https://www.ibm.com/products/spectrum-scale)
- [BeeGFS](https://www.beegfs.io)
