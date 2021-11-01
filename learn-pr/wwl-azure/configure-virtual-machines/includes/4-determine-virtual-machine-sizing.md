Once you have the name and location set, you need to decide on the size of your VM. Rather than specify processing power, memory, and storage capacity independently, Azure provides different VM sizes that offer variations of these elements in different sizes. Azure provides a wide range of VM size options allowing you to select the appropriate mix of compute, memory, and storage for what you want to do.

The best way to determine the appropriate VM size is to consider the type of workload your VM needs to run. Based on the workload, you're able to choose from a subset of available VM sizes. Workload options are classified as follows on Azure:

:::row:::
  :::column:::
    **Series**
  :::column-end:::
  :::column:::
    **Purpose**
  :::column-end:::
  :::column:::
    **Example Usage**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    A
  :::column-end:::
  :::column:::
    Entry-level economical VMs for dev or test
  :::column-end:::
  :::column:::
    Development and test servers, low traffic web servers, small to medium databases, servers for proof-of-concepts, and code repositories.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    B
  :::column-end:::
  :::column:::
    Economical burstable VMs
  :::column-end:::
  :::column:::
    Development and test servers, low-traffic web servers, small databases, micro services, servers for proof-of-concepts, build servers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    D
  :::column-end:::
  :::column:::
    General purpose compute
  :::column-end:::
  :::column:::
    Enterprise-grade applications, relational databases, in-memory caching, and analytics. The latest generations are ideal for applications that demand faster CPUs, better local disk performance, or higher memories.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Dc
  :::column-end:::
  :::column:::
    Protect data in use
  :::column-end:::
  :::column:::
    Confidential querying in databases, creation of scalable confidential consortium networks, and secure multiparty machine learning algorithms. The DC-series VMs are ideal to build secure enclave-based applications to protect customers code and data while it's in use.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E
  :::column-end:::
  :::column:::
    Optimized for in-memory hyper-threaded applications
  :::column-end:::
  :::column:::
    SAP HANA (E64s\_v3 only), SAP S/4 HANA application layer, SAP NetWeaver application layer, SQL Hekaton, and other large in-memory business critical workloads.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    F
  :::column-end:::
  :::column:::
    Compute optimized virtual machines
  :::column-end:::
  :::column:::
    Batch processing, web servers, analytics, and gaming.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    G
  :::column-end:::
  :::column:::
    Memory and storage optimized virtual machines
  :::column-end:::
  :::column:::
    Large SQL and NoSQL databases, ERP, SAP, and data warehousing solutions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    H
  :::column-end:::
  :::column:::
    High-Performance Computing virtual machines
  :::column-end:::
  :::column:::
    Fluid dynamics, finite element analysis, seismic processing, reservoir simulation, risk analysis, electronic design automation, rendering, Spark, weather modeling, quantum simulation, computational chemistry, heat transfer simulation.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    L
  :::column-end:::
  :::column:::
    Storage optimized virtual machines
  :::column-end:::
  :::column:::
    NoSQL databases such as Cassandra, MongoDB, Cloudera, and Redis. Data warehousing applications and large transactional databases are great use cases as well.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M and Mv2
  :::column-end:::
  :::column:::
    Memory optimized virtual machines
  :::column-end:::
  :::column:::
    SAP HANA, SAP S/4 HANA, SQL Hekaton and other large in-memory business critical workloads requiring massive parallel compute power.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    N
  :::column-end:::
  :::column:::
    GPU enabled virtual machines
  :::column-end:::
  :::column:::
    Simulation, deep learning, graphics rendering, video editing, gaming, and remote visualization.
  :::column-end:::
:::row-end:::


## Resizing virtual machines

Azure allows you to change the VM size when the existing size no longer meets your needs. You can resize a VM if your current hardware configuration is allowed in the new size. This provides a fully agile and elastic approach to VM management.

When you stop and deallocate the VM, you can select any size available in your region.

> [!NOTE]
> Be cautious when resizing production VMs. Resizing may require a restart that can cause a temporary outage or change configuration settings like the IP address.
