:::row:::
  :::column span="3":::

  :::column-end:::
:::row-end:::
:::row:::
  :::column span="2":::
    Disk Storage provides disks for Azure virtual machines. Applications and other services can access and use these disks as needed, similar to how they would in on-premises scenarios. Disk Storage allows data to be persistently stored and accessed from an attached virtual hard disk.
  :::column-end:::
  :::column:::
    :::image type="content" source="../media/icon-azure-standard-storage-083e0065.png" alt-text="Disk Storage icon.":::

  :::column-end:::
:::row-end:::

Disks come in many different sizes and performance levels, from solid-state drives (SSDs) to traditional spinning hard disk drives (HDDs), with varying performance tiers. You can use standard SSD and HDD disks for less critical workloads. Premium SSD disks for mission-critical production applications. Premium SSD v2 offers higher performance than Premium SSDs while also generally being less costly and are suited for a broad range of workloads such as SQL server, Oracle, MariaDB, SAP, Cassandra, Mongo DB, big data/analytics, and gaming. Or, use ultra disks for data-intensive workloads such as SAP HANA, top tier databases, and transaction-heavy workloads. Azure has consistently delivered enterprise-grade durability for infrastructure as a service (Iaas) disks, with an industry-leading ZERO% annualized failure rate.

The following illustration shows an Azure virtual machine that uses separate disks to store different data.

:::image type="content" source="../media/azure-disks-7841e01e.png" alt-text="Diagram of two disks inside a virtual machine. One stores the operating system and one stores data.":::
