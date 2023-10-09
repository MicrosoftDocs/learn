You can implement Azure Virtual Machine Scale Sets in the Azure portal. You specify the number of virtual machines and their sizes, and indicate preferences for using Azure Spot instances, Azure managed disks, and allocation policies.

In the Azure portal, there are several settings to configure to create an Azure Virtual Machine Scale Sets implementation.

:::image type="content" source="../media/implement-scale-sets-61516afb.png" alt-text="Screenshot that shows how to create Virtual Machine Scale Sets in the Azure portal.":::


- **Orchestration mode**: Choose how virtual machines are managed by the scale set. In flexible orchestration mode, you manually create and add a virtual machine of any configuration to the scale set. In uniform orchestration mode, you define a virtual machine model and Azure will generate identical instances based on that model.

- **Image**: Choose the base operating system or application for the VM.

- **VM Architecture**: Azure provides a choice of x64 or Arm64-based virtual machines to run your applications. 

- **Run with Azure Spot discount**: Azure Spot offers unused Azure capacity at a discounted rate versus pay as you go prices. Workloads should be tolerant to infrastructure loss as Azure may recall capacity.

- **Size**: Select a VM size to support the workload that you want to run. The size that you choose then determines factors such as processing power, memory, and storage capacity. Azure offers a wide variety of sizes to support many types of uses. Azure charges an hourly price based on the VM's size and operating system.

Under the **Advanced** tab, you can also select the following: 

- **Enable scaling beyond 100 instances**: Identify your scaling allocation preference. If you select **No**, your Virtual Machine Scale Sets implementation is limited to one placement group with a maximum capacity of 100. If you select **Yes**, your implementation can span multiple placement groups with capacity up to 1,000. Selecting **Yes** also changes the availability characteristics of your implementation.

- **Spreading algorithm**: Microsoft recommends allocating **Max spreading** for your implementation. This approach provides the optimal spreading.