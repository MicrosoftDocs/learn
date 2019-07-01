If you need to handle a steady expansion of work over time, then the best approach is to scale horizontally. If the workload increases in complexity rather than volume, and this complexity places more demand on resources, then you might find scaling vertically more appropriate.

Horizontal scaling enables you to add instances to your virtual machine scale set. In the shipping company scenario, horizontal scaling is a useful strategy to handle the fluctuating number of requests over time.

In this unit, you'll learn how to configure autoscaling for a virtual machine scale set. You'll see how to define scale rules that can trigger the allocation and deallocation of virtual machines by monitoring various performance metrics.

## Scaling virtual machine scale sets

You can scale a virtual machine scale set manually by increasing or decreasing the instance count. You can perform this task in the Azure portal, or programmatically. The following code uses the Azure CLI to change the number of instances in a virtual machine scale set.

```azurecli
az vmss scale \
    --name MyVMScaleSet \
    --resource-group MyResourceGroup \
    --new-capacity 6
```

Manual scaling is useful under some circumstances, but in many situations it's better to use autoscaling to let the system itself control the number of instances in a scale set. There are two different strategies available:

- Schedule based. Use this approach if you know you'll have an increased workload during a specified date/time window.
- Metrics-based. With this strategy, you monitor performance metrics associated with the scale set. When these metrics exceed a specified  threshold, the scale set can automatically start new virtual machine instances. When the metrics indicate that the additional resources are no longer required, the scale set can arrange to stop any excess instances.

## Define autoscale conditions, rules, and limits

Autoscaling is based on a set of scale conditions, rules, and limits. A scale condition combines a time and a set of scale rules. If the current time falls within the period defined in the scale condition, the scale rules associated with the condition are evaluated. The results of this evaluation determine whether to add or remove instances in the scale set. The scale condition also contains the limits of scaling, in terms of the maximum and minimum number of instances.

A virtual machine scale set can contain many scale conditions, and each matching scale condition will be acted on. A scale set also contains a default scale condition that will be used if no other scale conditions match the current time and performance metrics.

## Implement schedule-based autoscaling

Schedule-based scaling specifies a start and end time, and the number of instances to add to the scale set. The following screenshot shows an example in the Azure portal. The number of instances is scaled out to 20 between 6AM and 6PM each Monday and Wednesday.

![Example of a schedule-based scale condition](../media/4-schedule-based-scale-rule.png)

## Implement metrics-based autoscaling

A metrics-based scale rule specifies the resources to monitor (such as CPU utilization, response time, and so on), and will add or remove instances from the scale set according to the values of these metrics. You can specify limits on the number of instances to prevent a scale set from scaling in or out excessively. For example, you might want to increase the instance count by one when the average CPU utilization exceeds 70%, up to a limit of 50 instances. Similarly, you might want to scale in when the average CPU utilization drops below 50%.

The commonly used metrics you can monitor for a virtual machine scale set include:

- Percentage CPU. This metric is an indication of the CPU utilization across all instances. A high value shows that instances are becoming CPU-bound, which could cause delays in processing client requests.
- Inbound Flows and Outbound Flows. These metrics show the rate at which network traffic is flowing into and out from virtual machines in the scale set.
- Disk Read Operations/sec and Disk Write Operations/sec. These metrics are a measure of the volume of disk I/O that is occurring across scale set.
- Data Disk Queue Depth. This metric shows how many I/O requests to the data disks (as opposed to the operating system disks) on the virtual machines are waiting to be serviced.

A scale rule aggregates the values retrieved for a metric for all instances across a period of time known as the *time grain*. Each metric has its own intrinsic time grain, but in most cases this period is 1 minute. The aggregated value is known as the *time aggregation*. The options available are *Average*, *Minimum*, *Maximum*, *Total*, *Last*, and *Count*.

An interval of one minute is too short a period in which to determine whether any change in metric is long-lasting enough to make autoscaling worthwhile. So, a scale rule performs a second step that generates a further aggregation of the value calculated by the *time aggregation* over a longer, user-specified period, known as the *Duration*. The minimum *Duration* is 5 minutes. If the *Duration* is set to 10 minutes for example, the scale rule will aggregate the 10 values calculated for the *time grain*.

The aggregation calculation for the *Duration* can be different for that of the *time grain*. For example, if the *time aggregation* is *Average* and the statistic gathered is *Percentage CPU* across a one-minute *time grain*, each minute the average CPU percentage utilization across all instances for that minute will be calculated. If the *time grain statistic* is set to *Maximum*, and the *Duration* of the rule is set to 10 minutes, the maximum of the 10 average values for the CPU percentage utilization will be used to determine whether the rule threshold has been crossed.

When a scale rule detects that a metric has crossed a threshold, it can perform a scale action. A scale action can be *scale-out* or *scale-in*. A scale-out action increases the number of instances, and a scale-in action reduces the instance count. A scale action uses an operator (such as *less than*, *greater than*, *equal to*, and so on) to determine how to react to the threshold. Scale-out actions typically use the *greater than* operator to compare the metric value to the threshold. Scale-in actions tend to compare the metric value to the threshold with the *less than* operator. A scale action can also set the instance count to a specific level, rather than incrementing or decrementing the number available.

A scale action has a *cool down* period, specified in minutes. During this interval, the scale rule won't be triggered again. This is to allow the system to stabilize between scale events. It takes time to start up or shut down instances, and so any metrics gathered might not show any significant changes for several minutes. The minimum cool down period is five minutes.

Finally, you should also plan for scaling-in when a workload decreases. Consider defining scale rules in pairs in the same scale condition. One scale rule should indicate how to scale the system out when a metric exceeds an upper threshold. The the other rule should define how to scale the system back in again when the same metric drops below a lower threshold. Don't make both thresholds the same value otherwise you could end up triggering a series of oscillating events to scale out and back in again.

The image below shows a scale rule defined by using the Azure portal

![Example of a metrics-based scale rule in the Azure portal](../media/4-example-scale-rule.png)
