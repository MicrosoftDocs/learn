The goal of this module was to discuss key factors involved in choosing HPC storage in Azure. Now it's time to consolidate the information and create a tool you can utilize when evaluating the various Azure storage options.

We will create a checklist that encapsulates the major storage considerations. You may wonder why this is necessary, particularly if you have overseen your current storage environment. The goal is to consolidate information for other stakeholders, including Azure team members and partners you may be working with. In turn this will help to streamline the decision process and minimize any misunderstandings around a particular storage solution's capabilities (or lack of capabilities).

You will create your checklist based on the following list of considerations.

**Distribution of workload traffic**

You must account for the types of traffic to be generated and processed by your HPC environment, especially if you intend to run multiple types of workloads, and if you intend to leverage this storage for other purposes.

For example, while your HPC job may read sequential data from a large file (such as a media asset from a render job, or a genomic sequence file) from a large number of HPC machines. But at the same time there may be a need to operate a database (for example, to work with your HPC scheduler). The traffic types are different and may need to be deployed on different solutions.

The fact is storage solutions may be designed to optimize for different things. A NAS filer built from Ubuntu running local NVMe disks will likely be fantastic at single-stream activities (such as a single client copying data from the NAS to local disks), but may not be able to scale for concurrent access by large numbers of clients.

Also, you may have a need for a solution that optimizes for very large numbers of very small files. Using a traditional NAS solution, such as Azure NetApp Files, offers optimal performance for such traffic. However, you may also have a need to process then store very large files, and wish to minimize the cost of doing so. Using Azure Blob with tiering offers flexibility in these cases, but may not exhibit incredible performance for a single-stream copy operation.

You will want to record the following in your checklist:

    - single-stream vs multi-stream
    - ratio of read traffic to write traffic
    - average file sizes and counts
    - Random vs sequential access patterns

For example, your checklist may reflect:

    - multi-stream traffic
    - read heavy (75-25)
    - average file sizes between 10 and 200 GB, approximately 50,000 files
    - sequential heavy (80-20)

You will also want to account for the *major* workloads you intend to run on this architecture, if there are more than one or two, to ensure that there is not a divergence in requirements.

**Data locality**

The next category should account for the *location* of the data. Is there a requirement to keep the data on-premises? If yes, how do you envision the working data movement to Azure? Will you have concerns over data modifications while running your HPC job? 


- Data location
    - must reside on-prem
        - cache, copy or synchronize
    - level of security
        - PII data, HIPAA requirements

- Performance requirements
    - throughput requirement
    - latency
    - IOPs
    
- Access methods
    - NFS
    - SMB
    - Parallel FS (which solution is being used)

- Total capacity requirement
    - Hot/warm data
    - Cold / archive data

- Authentication / Authorization method
    - Local (UID/GID on file server only)
    - Directory (LDAP, Active Directory)

- Data location
    - must reside on-prem
        - cache, copy or synchronize
    - level of security
        - PII data, HIPAA requirements