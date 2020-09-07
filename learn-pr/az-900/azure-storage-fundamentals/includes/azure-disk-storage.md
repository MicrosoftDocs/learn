:::row:::
  :::column span="3":::
Disk storage provides disks for virtual machines, applications, and other services to access and use as they need, similar to how they would in on-premises scenarios. Disk storage allows data to be persistently stored and accessed from an attached virtual hard disk. The disks can be managed or unmanaged by Azure, and therefore managed and configured by the user. Typical scenarios for using disk storage are if you want to lift and shift applications that read and write data to persistent disks, or if you are storing data that is not required to be accessed from outside the virtual machine to which the disk is attached.
  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/azure-standard-storage.png" border="false":::
  :::column-end:::
:::row-end:::

Disks come in many different sizes and performance levels, from solid-state drives (SSDs) to traditional spinning hard disk drives (HDDs), with varying performance abilities. Details on pricing are available on the [managed disks pricing page](https://azure.microsoft.com/pricing/details/storage/).

When working with VMs, you can use standard SSD and HDD disks for less critical workloads, and premium SSD disks for mission-critical production applications. Azure Disks have consistently delivered enterprise-grade durability, with an industry-leading ZERO% annualized failure rate.

The following illustration shows an Azure virtual machine using separate disks to store different data.

![Illustration showing two disks inside a virtual machine, one that stores the operating system and one that stores data.](../media/Azure_disks.png)
