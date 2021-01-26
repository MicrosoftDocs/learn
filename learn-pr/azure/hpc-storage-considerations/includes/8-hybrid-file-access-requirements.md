The previous units were largely focused on **what** your storage solution was doing. This unit will focus on **where** your data is located. We will discuss *hybrid* file access considerations and how to approach them.

## Overview of Hybrid File Access ##

You have decided to run a workload in Azure that is currently running in your datacenter. Your compute environment is access data on your NAS, which is serving NFSv3 ops to your workload. It's been running there for years but perhaps your NAS environment is reaching the end of its cycle and rather than replace it you're considering a long-term migration into the cloud.

There is a period of time between this decision and what I'll call "cloud steady-state" where you have determined your Azure strategy and established your baseline account/subscription/security setup. Now the hard part...moving workloads!

The buildout of your HPC cluster and its management plane are outside the scope of this module, so we will assume that you have determined which virtual machine types your cluster will run, how many, and so on. 

Further we will assume for the moment that your objective is to run the workload "as-is"; that is without modifying the logic or access methods in any meaningful way. The implication is that your code expects to see data at directory paths in the cluster members' local filesystem.

The first objective is to understand what data is required, and from where it is currently sourced. All of your data may be located in a single directory on a single NAS environment, or it may be spread out across different environments.

The next objective is to determine *how much* data is required to run the workload. Is the source data a couple of Gigabytes or is it hundreds of Terabytes?

Finally, you have to determine how the data is presented in Azure Compute. Is it served locally to each HPC cluster machine, or is it shared by a cloud-based NAS solution?

## Remote data access considerations ##


    - Are there consumers not in Azure that require local access?
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
