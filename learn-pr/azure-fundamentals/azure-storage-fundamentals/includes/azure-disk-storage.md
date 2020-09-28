:::row:::
  :::column span="3":::
Disk storage provides disks for virtual machines, applications, and other services to access and use as they need, similar to how they would in on-premises scenarios. Disk storage allows data to be persistently stored and accessed from an attached virtual hard disk. Azure can manage the disks for you, or you can manage and configure them yourself.

Let's say that you want to migrate applications that read and write data to persistent disks, or that you want to store data that isn't required to be accessed from outside the virtual machine to which the disk is attached. You might use disk storage to accomplish these goals.
  :::column-end:::
  :::column:::
    :::image type="icon" source="../media/icon-azure-standard-storage.png" border="false":::
  :::column-end:::
:::row-end:::

Disks come in many different sizes and performance levels, from solid-state drives (SSDs) to traditional, spinning, hard disk drives (HDDs), with varying performance abilities. Details on pricing are available on the [managed disks pricing page](https://azure.microsoft.com/pricing/details/storage/?azure-portal=true).

When working with VMs, you can use standard SSD and HDD disks for less critical workloads, and premium SSD disks for mission-critical production applications. Azure disks have consistently delivered enterprise-grade durability, with a 0 percent annualized failure rate.

The following illustration shows an Azure virtual machine that uses separate disks to store different data.

![Diagram of two disks inside a virtual machine. One stores the operating system and one stores data.](../media/Azure-disks.png)
