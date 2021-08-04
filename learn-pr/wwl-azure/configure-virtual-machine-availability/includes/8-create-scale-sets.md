:::image type="content" source="../media/implement-scale-sets-61516afb.png" alt-text="Screenshot of the Create virtual machine scale set page in the portal.":::


When you create a scale set, consider these parameters.

 -  **Initial instance count.** Number of virtual machines in the scale set (0 to 1000).
 -  **Instance size.** The size of each virtual machine in the scale set.
 -  **Azure spot instance**. Low-priority VMs are allocated from Microsoft Azure's excess compute capacity. Spot instances enable several types of workloads to run at a reduced cost.
 -  **Use managed disks.** Managed disks hide the underlying storage accounts and instead shows the abstraction of a disk. Unmanaged disks expose the underlying storage accounts and VHD blobs.
 -  **Enable scaling beyond 100 instances.** If No, the scale set will be limited to one placement group with a max capacity of 100. If Yes, the scale set can span multiple placement groups. This allows for capacity to be up to 1,000 but changes the availability characteristics of the scale set.
 -  **Spreading algorithm**. We recommend deploying with max spreading for most workloads. This approach provides the best spreading.
