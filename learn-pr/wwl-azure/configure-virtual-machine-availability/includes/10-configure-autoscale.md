When you create an Azure Virtual Machine Scale Sets implementation in the Azure portal, you can enable autoscaling. For optimal performance, you should define a minimum, maximum, and default number of virtual machine instances to use during the autoscale process.

In the Azure portal, there are several settings to configure to enable autoscaling with Azure Virtual Machine Scale Sets.

:::image type="content" source="../media/implement-autoscale-74d25345.png" alt-text="Screenshot of the settings for configuring virtual machine instances and autoscale in the Azure portal.":::

**Scaling policy**: Manual scale maintains a fixed instance count. Custom autoscale scales the capacity on any schedule, based on any metrics.

- **Minimum number of VMs**: Specify the minimum number of virtual machines that should be available when autoscaling is applied on your Virtual Machine Scale Sets implementation.

- **Maximum number of VMs**: Specify the maximum number of virtual machines that can be available when autoscaling is applied on your implementation.

**Scale out**

- **CPU threshold**: Specify the CPU usage percentage threshold to trigger the scale-out autoscale rule.

- **Duration in minutes**: Duration in minutes is the amount of time that Autoscale engine looks back for metrics. For example, 10 minutes means that every time autoscale runs, it queries metrics for the past 10 minutes. This delay allows your metrics to stabilize and avoids reacting to transient spikes.

- **Number of VMs to increase by**: Specify the number of virtual machines to add to your Virtual Machine Scale Sets implementation when the scale-out autoscale rule is triggered.

**Scale in**

- **Scale in CPU threshold**: Specify the CPU usage percentage threshold to trigger the scale-in autoscale rule.

- **Number of VMs to decrease by**: Specify the number of virtual machines to remove from your implementation when the scale-in autoscale rule is triggered.

**Scale in policy**: The [scale-in policy](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-scale-in-policy) feature provides users a way to configure the order in which virtual machines are scaled-in. 