You can implement Azure Virtual Machine Scale Sets in the Azure portal. You specify the number of virtual machines and their sizes, and indicate preferences for using Azure Spot instances, Azure managed disks, and allocation policies.

In the Azure portal, there are several settings to configure to create an Azure Virtual Machine Scale Sets implementation.

:::image type="content" source="../media/implement-scale-sets-61516afb.png" alt-text="Screenshot that shows how to create Virtual Machine Scale Sets in the Azure portal.":::

- **Initial instance count**: Specify the number of virtual machines to use in your Virtual Machine Scale Sets implementation (0 to 1,000).

- **Size**: Specify the size of each virtual machine in your implementation.

- **Azure Spot instance**: Determine whether to enable the Azure Spot instance feature. When Azure Spot instance is enabled, low-priority virtual machines are allocated from Microsoft Azure's excess compute capacity. Azure Spot instances allow several types of workloads to run at a reduced cost.

- **Use managed disks**: Determine whether to use Azure managed disks for block-level storage.

- **Enable scaling beyond 100 instances**: Identify your scaling allocation preference. If you select **No**, your Virtual Machine Scale Sets implementation is limited to one placement group with a maximum capacity of 100. If you select **Yes**, your implementation can span multiple placement groups with capacity up to 1,000. Selecting **Yes** also changes the availability characteristics of your implementation.

- **Spreading algorithm**: Microsoft recommends allocating **Max spreading** for your implementation. This approach provides the optimal spreading.