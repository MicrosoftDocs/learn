The goal of this module was to discuss key factors involved in choosing HPC storage in Azure. Now it's time to consolidate the information and create a tool you can utilize when evaluating the various Azure storage options.

We will create a checklist that encapsulates the major storage considerations. You may wonder why this is necessary, particularly if you have overseen your current storage environment. The goal is to consolidate information for other stakeholders, including Azure team members and partners you may be working with. In turn this will help to streamline the decision process and minimize any misunderstandings around a particular storage solution's capabilities (or lack of capabilities).



- distribution of workload traffic
    - Solving for how many workloads
    - single-stream vs multi-stream
    - read vs write, what's the ratio
    - average file sizes and counts
    - Random vs sequential
    - Streaming vs transactional

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