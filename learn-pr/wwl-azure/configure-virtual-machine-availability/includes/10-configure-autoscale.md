When you create a scale set you can enable Autoscale. You should also define a minimum, maximum, and default number of VM instances.

:::image type="content" source="../media/implement-autoscale-74d25345.png" alt-text="Screenshot of the instances and autoscale settings.":::


 -  **Minimum number of VMs.** The minimum value for autoscale on this scale set.
 -  **Maximum number of VMs.** The maximum value for autoscale on this scale set.
 -  **Scale out CPU threshold.** The CPU usage percentage threshold for triggering the scale-out autoscale rule.
 -  **Number of VMs to increase by.** The number of virtual machines to add to the scale set when the scale-out autoscale rule is triggered.
 -  **Scale in CPU threshold.** The CPU usage percentage threshold for triggering the scale in autoscale rule.
 -  **Number of VMs to decrease by.** The number of virtual machines to remove from the scale set when the scale in autoscale rule is triggered.
