When you create an Azure Virtual Machine Scale Sets implementation in the Azure portal, you can enable autoscaling. For optimal performance, you should define a minimum, maximum, and default number of virtual machine instances to use during the autoscale process.

In the Azure portal, there are several settings to configure to enable autoscaling with Azure Virtual Machine Scale Sets.

:::image type="content" source="../media/implement-autoscale-74d25345.png" alt-text="Screenshot of the settings for configuring virtual machine instances and autoscale in the Azure portal.":::

- **Minimum number of VMs**: Specify the minimum number of virtual machines that should be available when autoscaling is applied on your Virtual Machine Scale Sets implementation.

- **Maximum number of VMs**: Specify the maximum number of virtual machines that can be available when autoscaling is applied on your implementation.

- **CPU threshold**: Specify the CPU usage percentage threshold to trigger the scale-out autoscale rule.

- **Number of VMs to increase by**: Specify the number of virtual machines to add to your Virtual Machine Scale Sets implementation when the scale-out autoscale rule is triggered.

- **Scale in CPU threshold**: Specify the CPU usage percentage threshold to trigger the scale-in autoscale rule.

- **Number of VMs to decrease by**: Specify the number of virtual machines to remove from your implementation when the scale-in autoscale rule is triggered.