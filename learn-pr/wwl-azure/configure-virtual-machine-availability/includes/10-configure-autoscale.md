When you create a scale set you can enable Autoscale. You should also define a minimum, maximum, and default number of VM instances. When your autoscale rules are applied, these instance limits make sure that you do not scale out beyond the maximum number of instances or scale in beyond the minimum of instances.

:::image type="content" source="../media/implement-autoscale.png" alt-text="Screenshot of the instances and autoscale settings. The instance count is 2 and the instance size is DS1\_v2. Autoscale is enabled. The minimum number of VMs is 1 and the maximum number of VMs is 10.":::


 -  **Minimum number of VMs.** The minimum value for autoscale on this scale set.
 -  **Maximum number of VMs.** The maximum value for autoscale on this scale set.
 -  **Scale out CPU threshold.** The CPU usage percentage threshold for triggering the scale out autoscale rule.
 -  **Number of VMs to increase by.** The number of virtual machines to add to the scale set when the scale out autoscale rule is triggered.
 -  **Scale in CPU threshold.** The CPU usage percentage threshold for triggering the scale in autoscale rule.
 -  **Number of VMs to decrease by.** The number of virtual machines to remove to the scale set when the scale in autoscale rule is triggered.
