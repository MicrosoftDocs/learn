An Azure virtual machine scale set can automatically increase or decrease the number of VM instances that run your application. This means you can dynamically scale to meet changing demand.

:::image type="content" source="../media/autoscale-45b054e0.png" alt-text="An example scale set graph is shown with three lines.":::


## Autoscale benefits

 -  **Automatically adjust capacity**. Lets you create rules that define the acceptable performance for a positive customer experience. When those defined thresholds are met, autoscale rules act to adjust the capacity of your scale set.
 -  **Scale out**. If your application demand increases, the load on the VM instances in your scale set increases. If this increased load is consistent, rather than just a brief demand, you can configure autoscale rules to increase the number of VM instances in the scale set.
 -  **Scale in**. On an evening or weekend, your application demand may decrease. If this decreased load is consistent over a period of time, you can configure autoscale rules to decrease the number of VM instances in the scale set. This scale-in action reduces the cost to run your scale set as you only run the number of instances required to meet the current demand.
 -  **Schedule events**. Schedule events to automatically increase or decrease the capacity of your scale set at fixed times.
 -  **Less overhead**. Reduces the management overhead to monitor and optimize the performance of your application.

> [!NOTE]
> Autoscale minimizes the number of unnecessary VM instances that run your application when demand is low, while customers continue to receive an acceptable level of performance as demand grows and additional VM instances are automatically added.
