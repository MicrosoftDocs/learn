** Overview of Hybrid File Access **

    - Historically data located in on-premises NAS environment
    - Can it be migrated to Azure? Does some of it have to stay in place on-prem?
    - Are there consumers not in Azure that require local access?
    - Is the data located in a single source (one NAS environment) or more

** Remote data access considerations **

    - If data stays in local datacenter, what considerations?
    - WAN connectivity and costs
    - multiple consumers using the WAN pipe
    - Security issues

** Caching vs Copying vs Sync **

    - caching defined
    - copying vs synchronizing defined
    - tools for caching
    - tools for copying or synchronization
    - pros and cons for each approach
    - implications of data movement across networks or regions

** Hybrid access authentication/authorization considerations **

    - Directory services placement relative to storage

** Managing writes in a hybrid environment **

    - multiple sites writing to same data
    - "write-around" defined
    - writing and synchronization considerations
        - coordinating updates with HPC job starts
