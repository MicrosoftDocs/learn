:::row:::
  :::column span="3":::
Disk Storage provides disks for Azure virtual machines. Applications and other services can access and use as these disks as needed, similar to how they would in on-premises scenarios. Disk Storage allows data to be persistently stored and accessed from an attached virtual hard disk.
  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-azure-standard-storage.png" border="false":::
  :::column-end:::
:::row-end:::

Disks come in many different sizes and performance levels, from solid-state drives (SSDs) to traditional spinning hard disk drives (HDDs), with varying performance tiers. When working with VMs, you can use standard SSD and HDD disks for less critical workloads, premium SSD disks for mission-critical production applications, and ultra disks for data-intensive workloads such as SAP HANA, top tier databases, and transaction-heavy workloads. Azure has consistently delivered enterprise-grade durability for infrastructure as a service (Iaas) disks, with an industry-leading ZERO% annualized failure rate.

The following illustration shows an Azure virtual machine using separate disks to store different data.

![Illustration showing two disks inside a virtual machine, one that stores the operating system and one that stores data.](../media/Azure-disks.png)
