Autoscaling enables you to specify the conditions under which a web app should scale out and then scale back in again. Effective autoscaling ensures sufficient resources are available to handle large volumes of requests at peak times, while also keeping overhead costs down when the demand drops.

You can configure autoscaling to detect when to scale out and scale in according to a combination of factors based on resource usage. You can also configure autoscaling according to a schedule.

In this unit, you learn how to specify the factors that can be used to autoscale a web service.

## Autoscaling and App Service Plans

When you create a web app, you also create an App Service Plan. The App Service Plan defines the operating system (Windows or Linux) used to host the web app. The pricing tier of the plan specifies the hardware available (memory capacity, CPU processing capacity, disk storage) and other services, such as regular backups for each instance of the web app.

Autoscaling is a feature of the App Service Plan used by the web app. When the web app scales out, Azure starts more instances of the hardware defined by the App Service Plan to the app.

To prevent costly runaway autoscaling, an App Service Plan has an instance limit. Plans in more expensive pricing tiers have higher instance limits. Autoscaling can't exceed its App Service Plan's instance limit. As an example, the Standard series of service plans support up to 10 instances at an estimated cost of $0.40/hour for each instance. The Premium series of service plans enable up to 20 instances at an estimated cost of $0.80/hour for each instance. The Isolated service plans allow up to 100 instances at an estimated cost of $1.60/hour for each instance.

> [!NOTE]
> Not all App Service Plan pricing tiers support autoscaling.

## Autoscale conditions

You indicate how to autoscale by creating autoscale conditions. Azure provides two options for autoscaling:

- Scale based on a metric, such as the length of the disk queue or the number of HTTP requests awaiting processing.
- Scale to a specific instance count according to a schedule. For example, you can arrange to scale out at a particular time of day or on a specific date or day of the week. You can also specify a time or date for the system to scale back in.

Scaling to a specific instance count only enables you to scale out to a defined number of instances. To scale out incrementally, you can combine metric-based and schedule-based autoscaling in a single autoscale condition. For example, you could arrange for the system to scale out if the number of HTTP requests exceeds a set threshold, but only between certain hours of the day.

You can create multiple autoscale conditions to handle different schedules and metrics. Azure autoscales your service when any of your established conditions apply. Each App Service Plan also has a default autoscale condition that's used if no other conditions apply. The default autoscale condition is always active and doesn't have a schedule.

## Metrics for autoscale rules

Autoscaling by metric requires that you define one or more autoscale rules. An autoscale rule specifies a metric to monitor, and how autoscaling should respond when this metric crosses a defined threshold. The following list describes the metrics you can monitor for a web app:

- **CPU Percentage** indicates the CPU utilization across all instances. A high **CPU Percentage** shows that instances are becoming CPU-bound, which could cause delays in processing client requests.
- **Memory Percentage** captures the memory occupancy of the application across all instances. A high **Memory Percentage** indicates that free memory could be running low, which could cause one or more instances to fail.
- **Disk Queue Length** measures the number of outstanding I/O requests across all instances. A high **Disk Queue Length** means that disk contention could be occurring.
- **Http Queue Length** shows how many client requests are waiting for processing by the web app. If **Http Queue Length** is large, client requests might fail with HTTP 408 (Timeout) errors.
- **Data In** is the number of bytes received across all instances.
- **Data Out** is the number of bytes sent across all instances.

You can also scale based on metrics for other Azure services. For example, if a web app processes requests received from a Service Bus Queue, you might want to spin up more instances of that app if the number of items held in an Azure Service Bus Queue exceeds a critical length.

## How an autoscale rule analyzes metrics

Autoscaling works by analyzing trends in metric values over time and across all instances. Analysis is a multistep process.

In the first step, an autoscale rule aggregates the values retrieved for a metric for all instances across a period of time known as the *time grain*. Each metric has its own intrinsic time grain, but in most cases this period is one minute. The aggregated value is known as the *time aggregation*. The time-aggregation options are *Average*, *Minimum*, *Maximum*, *Total*, *Last*, and *Count*.

One minute is a short interval in which to determine whether any change in metric is long-lasting enough to make autoscaling worthwhile. So, an autoscale rule performs a second aggregation of the value calculated by the *time aggregation* over a longer, user-specified period, known as the *Duration*. The minimum *Duration* is five minutes. If the *Duration* is set to 10 minutes, for example, the autoscale rule aggregates the 10 values calculated for the *time grain*.

The aggregation calculation for the *Duration* can be different from the aggregation calculation for the *time grain*. For example, if the *time aggregation* is *Average* and the metric gathered is *CPU Percentage* across a one-minute *time grain*, then every minute the average CPU percentage utilization across all instances for that minute is calculated.

For another example, let's say the *time aggregation* is set to *Maximum* and the *Duration* of the rule is set to 10 minutes. This example configuration would use the maximum of the 10 average values for the CPU percentage utilization to determine whether the rule threshold has been crossed.

## Autoscale actions

When an autoscale rule detects that a metric crossed a threshold, the autoscale rule can perform an autoscale action. An autoscale action can be *scale-out* or *scale-in*. A scale-out action increases the number of instances, and a scale-in action reduces the instance count. An autoscale action uses an operator (such as *less than*, *greater than*, *equal to*, and so on) to determine how to react to the threshold. Scale-out actions typically use the *greater than* operator to compare the metric value to the threshold. Scale-in actions tend to compare the metric value to the threshold with the *less than* operator. An autoscale action can also set the instance count to a specific level, rather than incrementing or decrementing the number available.

An autoscale action has a *cool-down* period, specified in minutes. During the cool-down period, the scale rule isn't triggered again. The cool-down period allows the system to stabilize between autoscale events. Remember that it takes time to start up or shut down instances, and so any metrics gathered might not show significant changes for several minutes. The minimum cool-down period is five minutes.

## Pairing autoscale rules

You should plan for scaling-in when a workload decreases. Consider defining autoscale rules in pairs in the same autoscale condition. One autoscale rule should indicate how to scale out the system when a metric exceeds an upper threshold. Then another rule should define how to scale the system back in again when the same metric drops below a lower threshold.

## Combining autoscale rules

A single autoscale condition can contain several autoscale rules (such as a scale-out rule and the corresponding scale-in rule). However, the autoscale rules in an autoscale condition don't have to be directly related. For example, you could define the following four autoscale rules in a single autoscale condition:

- If the HTTP queue length exceeds 10, scale out by one
- If the CPU utilization exceeds 70 percent, scale out by one
- If the HTTP queue length equals zero, scale in by one
- If the CPU utilization drops below 50 percent, scale in by one

When determining whether to scale out, the autoscale action is performed if **any** of the scale-out rules are met (HTTP queue length exceeds 10 **or** CPU utilization exceeds 70 percent). When scaling in, the autoscale action runs **only if all** of the scale-in rules are met (HTTP queue length drops to zero **and** CPU utilization falls below 50 percent). If you need to scale in if only one scale-in rule is met, you must define the rules in separate autoscale conditions.
