With Azure Virtual Machines (VMs), you can run virtualized servers in Azure as infrastructure as a service (IaaS). Like a physical server, you control the operating system and installed software. VMs are a good fit when you need:

 -  Total control over the operating system (OS).
 -  The ability to run custom software.
 -  To use custom hosting configurations.

Azure VMs remove the need to buy and maintain physical server hardware. As an IaaS service, you still manage patching, updates, and configuration inside the VM.

You can deploy VMs quickly from prebuilt images. An image is a template that already includes an operating system and tools such as web hosting components.

## Examples of when to use VMs

Common VM use cases include:

 -  **Testing and development**. Create different OS and app configurations quickly, then remove the VM when testing is complete.
 -  **Cloud application hosting**. Run applications in Azure and scale capacity up or down as demand changes.
 -  **Datacenter extension**. Extend an on-premises network into Azure and host workloads in a connected virtual network.
 -  **Disaster recovery**. Keep failover capacity in Azure and run critical workloads there if your primary site is unavailable.
 -  **Lift and shift migration**. Move existing server workloads with minimal application redesign.

## VM resources and sizing

When you provision a VM, you choose resources such as:

 -  Size (purpose, number of processor cores, and amount of RAM)
 -  Storage disks (hard disk drives, solid state drives, etc.)
 -  Networking (virtual network, public IP address, and port configuration)

### Understand VM size families and names

Azure VM sizes are grouped into families so you can quickly choose a size based on your workload needs.

:::image type="content" source="../media/virtual-machines-size-families-row.png" alt-text="Diagram depicting Azure VM families.":::

The following table highlights common use cases for the Azure VM families.

| Family | Typical focus | Example use |
| --- | --- | --- |
| B-series | Burstable, cost-efficient | Dev/test workloads with occasional CPU spikes |
| D-series | General purpose | Web servers, small-to-medium app servers |
| E-series | Memory optimized | In-memory databases, analytics workloads |
| F-series | Compute optimized | CPU-intensive application tiers |
| M-series | Large memory footprint | Large enterprise databases |
| L-series | Storage optimized | High-throughput storage and data processing |
| N-series | GPU enabled | AI training/inference and graphics workloads |

Each VM also has options that you can customize based on your needs. You can adjust the number of virtual CPUs (vCPUs), the amount of RAM, and the storage disk configuration.

:::image type="content" source="../media/virtual-machines-sizing-dimensions.png" alt-text="Key VM sizing dimensions: vCPU, RAM, Disk, Network, Premium SSD support, and hardware generation.":::

Some of the adjustments you can make are:

 -  **vCPU count**: affects compute capacity for concurrent and CPU-bound workloads.
 -  **RAM**: affects how much working data the VM can keep in memory.
 -  **Disk configuration**: affects storage capacity, IOPS, and throughput.
 -  **Network throughput**: affects data transfer performance in and out of the VM.
 -  **Premium SSD support**: indicates whether the size supports premium managed disks.
 -  **Hardware generation**: indicates platform generation and can affect baseline performance.

VM names also carry useful sizing information. The base name indicates the family (or purpose), the number of vCPUs, and the hardware generation. It may also indicate features such as premium storage support.

:::image type="content" source="../media/virtual-machines-name-decode.png" alt-text="Breakdown of Standard_D2s_v5 showing D as family, 2 as vCPU count, s as premium disk support, and v5 as hardware generation.":::

 -  `D`: the VM family (general purpose in this case)
 -  `2`: the number of vCPUs in this size
 -  `s`: supports Premium SSD storage
 -  `v5`: hardware generation for that family

At a fundamentals level, start by selecting a family that matches workload behavior, then choose the size that meets performance needs and scale as demand grows.

## Scale and resiliency options for VMs

You can run single VMs for testing, development, or minor tasks. Or you can group VMs together to provide high availability, scalability, and redundancy. Azure can manage these groupings with features such as scale sets and availability sets.

### Virtual machine scale sets

Virtual machine scale sets let you create and manage groups of identical, load-balanced VMs. Without scale sets, you must manually keep VM configuration consistent, monitor utilization, and adjust instance counts. Scale sets centralize configuration and can automatically scale out or in based on demand or schedules. They also integrate with load balancing so traffic is distributed efficiently.

### Virtual machine availability sets

Virtual machine availability sets improve VM resiliency inside a region. They reduce the chance that all VMs are affected by one maintenance event or hardware failure.

Availability sets group VMs by:

 -  **Update domain**: VMs that can be rebooted together during planned maintenance.
 -  **Fault domain**: VMs that share a potential power or network failure point.

Use availability sets for VM-level redundancy. In regions that support Availability Zones, zone-based designs are often preferred because they provide broader failure isolation. Availability sets themselves don't add cost; you pay for the VM instances.

