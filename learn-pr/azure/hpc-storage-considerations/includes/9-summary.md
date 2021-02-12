The goal of this module was to discuss key factors involved in choosing HPC storage in Azure. Now it's time to consolidate the information and create a tool you can utilize when evaluating the various Azure storage options.

We will create a checklist that encapsulates the major storage considerations. You may wonder why a checklist is necessary, particularly if you have long overseen your current storage environment. The goal is to consolidate information for other stakeholders, including Azure team members and partners you may be working with. The checklist will help to streamline the decision process and minimize any misunderstandings around a particular storage solution's capabilities (or lack of capabilities).

You will create your checklist based on the following list of considerations.

## Distribution of workload traffic ##

Account for the types of traffic to be generated and processed by your HPC environment, especially if you intend to run multiple types of workloads, and if you intend to use this storage for other purposes.

For example, while your HPC workload may read sequential data from a large file (such as a media asset from a render job, or a genomic sequence file) from a large number of HPC machines. But at the same time there may be a need to operate a database (for example, to work with your HPC scheduler). The traffic types are different and may need to be deployed on different storage solutions.

The fact is storage solutions may be designed to optimize for different things. A NAS filer built from Ubuntu running local NVMe disks will be fantastic at single-stream activities (such as a single client copying data from the NAS to local disks), but may not be able to scale for concurrent access by large numbers of clients.

Also, you may have a need for a solution that optimizes for large numbers of small files. Using a traditional NAS solution, such as Azure NetApp Files, offers optimal performance for such traffic. However, you may also have a need to process then store large files, and wish to minimize the cost of doing so. Using Azure Blob with tiering offers flexibility in these cases, but may not exhibit incredible performance for a single-stream copy operation.

You will want to record the following traffic types in your checklist:

- single-stream vs multi-stream
- ratio of read traffic to write traffic
- average file sizes and counts
- Random vs sequential access patterns

For example, your checklist may reflect:

- multi-stream traffic
- read heavy (75-25)
- average file sizes between 10 GB and 200 GB, approximately 50,000 files
- sequential heavy (80-20)

You will also want to account for the *major* workloads you intend to run on this architecture, if there are more than one or two, to ensure that there is not a significant divergence in requirements.

## Data locality ##

The next category should account for the *location* of the data. Is there a requirement to keep the data on-premises? Will you have concerns over data modifications while running your HPC workload? Will modifications happen only on-premises, in Azure, or both locations?

Adding locality to your checklist:

- Source data on-premises, in-Azure, or both
- Results data on-premises, in-Azure, or both
- Will HPC workloads in Azure be coordinated with source data modification timelines?
    - Timelines will help to inform the risk of stale data 
- Data sensitivity
    - PII/HIPAA data?
    - Data sensitivity will help inform the level of authentication and encryption required

Locality awareness will help determine whether you can use copying, caching, or synchronization as your data movement strategy.

## Performance requirements ##

Your performance requirements should look something like this:

- Single-stream throughput (in GB/s)
- Multi-stream throughput (in GB/s)
- Expected maximum IOPS
- Average latency (ms)

Every consideration impacts performance, and so these numbers represent a guide that a particular solution should achieve. For example, you may have an HPC workload that does extensive file creation and deletion as part of the workflow, which can impact the overall throughput.

## Access methods ##

You will want to account for the client access protocol required. As we discussed, there are different versions of NFS (and SMB, the Windows client protocol). If you are intending to use NFSv4, you will want to be clear about what aspects of the protocol are required (such as ACLs).

- NFS versions required
    - If v4: expected protocol behaviors (ACLs, encryption)
- Parallel FS (which solution is being used)

## Total capacity requirement ##

Storage capacity in Azure will be the next consideration, and helps to inform the overall cost of the solution. If you intend to store a large amount of data over the longer term, you may want to consider **tiering** as part of the storage solution, to offer lower-cost storage options combined with higher cost but higher performance storage in a hot tier.

- Total capacity required
- Total "hot tier" capacity required
- Total "warm tier" capacity required
- Total "cold tier" capacity required

A note on "cold tier": Archive tiers offer attractive costs to store the data with higher transaction costs to retrieve the data. Also, archive tiers have long retrieval times for data, and should not be considered part of your hot/warm tiers.

## Authentication / authorization method ##

You will want to add your authentication/authorization requirement to the checklist. At minimum, adding it ensures that you include the appropriate supporting systems to your architecture, such as an LDAP server or Active Directory environment. However, if you must  support capabilities such as UID/GID mapping to Active Directory users, you will need to confirm that the storage solution supports that capability.

- Local (UID/GID on file server only)
- Directory (LDAP, Active Directory)
- UID/GID Mapping to Active Directory users (Y/N)