In this unit, we'll look at autoscaling rules, and then in the next exercise, trigger the rules.

## Autoscale conditions

Azure provides two options for autoscaling:

- Scale based on a metric, such as the length of the disk queue, or the number of HTTP requests awaiting processing,
- Scale to a specific instance count according to a schedule. For example, you can arrange to scale out at a particular time of day, or on a specific date or day of the week. You also specify an end date, and the system will scale back in at this time.

Scaling to a specific instance count only enables you to scale out to a defined number of instances. If you need to scale out incrementally, you can combine metric and schedule-based autoscaling in the same autoscale condition. So, you could arrange for the system to scale out if the number of HTTP requests exceeds some threshold, but only between certain hours of the day.

## Autoscale profiles

There are three types of Autoscale profiles:

- Regular profile: The most common profile. If you don’t need to scale your resource based on the day of the week, or on a particular day, you can use a regular profile. This profile can then be configured with metric rules that dictate when to scale out and when to scale in. You should only have one regular profile defined.

- Fixed date profile: This profile is for special cases. For example, let’s say you have an important event coming up on December 26, 2017 (PST). You want the minimum and maximum capacities of your resource to be different on that day, but still scale on the same metrics. In this case, you should add a fixed date profile to your setting’s list of profiles. The profile is configured to run only on the event’s day. For any other day, Autoscale uses the regular profile.

- Recurrence profile: This type of profile enables you to ensure that this profile is always used on a particular day of the week. Recurrence profiles only have a start time. They run until the next recurrence profile or fixed date profile is set to start. An Autoscale setting with only one recurrence profile runs that profile, even if there is a regular profile defined in the same setting. The following two examples illustrate how this profile is used:

Example 1: Weekdays vs. weekends

Let’s say that on weekends, you want your maximum capacity to be 4. On weekdays, because you expect more load, you want your maximum capacity to be 10. In this case, your setting would contain two recurrence profiles, one to run on weekends and the other on weekdays. The setting looks like this:

You can create multiple autoscale conditions to handle different schedules and metrics. Azure will autoscale your service when any of these conditions apply. An App Service Plan also has a default condition that will be used if none of the other conditions are applicable. This condition is always active and doesn't have a schedule.

## Metrics for autoscale rules

Autoscaling by metric requires that you define one or more autoscale rules. An autoscale rule specifies a metric to monitor, and how autoscaling should respond when this metric crosses a defined threshold. The metrics you can monitor for a web app are:

- CPU Percentage. This metric is an indication of the CPU utilization across all instances. A high value shows that instances are becoming CPU-bound, which could cause delays in processing client requests.
- Memory Percentage. This metric captures the memory occupancy of the application across all instances. A high value indicates that free memory could be running low, and could cause one or more instances to fail.
- Disk Queue Length. This metric is a measure of the number of outstanding I/O requests across all instances. A high value means that disk contention could be occurring.
- Http Queue Length. This metric shows how many client requests are waiting for processing by the web app. If this number is large, client requests might fail with HTTP 408 (Timeout) errors.
- Data In. This metric is the number of bytes received across all instances.
- Data Out. This metric is the number of bytes sent by all instances.
You can also scale based on metrics for other Azure services. For example, if the web app processes requests received from a Service Bus Queue, you might want to spin up additional instances of a web app if the number of items held in an Azure Service Bus Queue exceeds a critical length.

## How an autoscale rule analyzes metrics

Autoscaling works by analyzing trends in metric values over time across and all instances. Analysis is a multi-step process.

In the first step, an autoscale rule aggregates the values retrieved for a metric for all instances across a period of time known as the time grain. Each metric has its own intrinsic time grain, but in most cases this period is 1 minute. The aggregated value is known as the time aggregation. The options available are Average, Minimum, Maximum, Total, Last, and Count.

An interval of one minute is a very short interval in which to determine whether any change in metric is long-lasting enough to make autoscaling worthwhile. So, an autoscale rule performs a second step that performs a further aggregation of the value calculated by the time aggregation over a longer, user-specified period, known as the Duration. The minimum Duration is 5 minutes. If the Duration is set to 10 minutes for example, the autoscale rule will aggregate the 10 values calculated for the time grain.

The aggregation calculation for the Duration can be different for that of the time grain. For example, if the time aggregation is Average and the statistic gathered is CPU Percentage across a one-minute time grain, each minute the average CPU percentage utilization across all instances for that minute will be calculated. If the time grain statistic is set to Maximum, and the Duration of the rule is set to 10 minutes, the maximum of the 10 average values for the CPU percentage utilization will be used to determine whether the rule threshold has been crossed.

## Autoscale actions

When an autoscale rule detects that a metric has crossed a threshold, it can perform an autoscale action. An autoscale action can be scale-out or scale-in. A scale-out action increases the number of instances, and a scale-in action reduces the instance count. An autoscale action uses an operator (such as less than, greater than, equal to, and so on) to determine how to react to the threshold. Scale-out actions typically use the greater than operator to compare the metric value to the threshold. Scale-in actions tend to compare the metric value to the threshold with the less than operator. An autoscale action can also set the instance count to a specific level, rather than incrementing or decrementing the number available.

An autoscale action has a cool down period, specified in minutes. During this interval, the scale rule won't be triggered again. This is to allow the system to stabilize between autoscale events. Remember that it takes time to start up or shut down instances, and so any metrics gathered might not show any significant changes for several minutes. The minimum cool down period is five minutes.

## Pairing autoscale rules

You should plan for scaling-in when a workload decreases. Consider defining autoscale rules in pairs in the same autoscale condition. One autoscale rule should indicate how to scale the system out when a metric exceeds an upper threshold. Then other rule should define how to scale the system back in again when the same metric drops below a lower threshold.

## Combining autoscale rules

A single autoscale condition can contain several autoscale rules (for example, a scale-out rule and the corresponding scale-in rule). However, the autoscale rules in an autoscale condition don't have to be directly related. You could define the following four rules in the same autoscale condition:

- If the HTTP queue length exceeds 10, scale out by 1
- If the CPU utilization exceeds 70%, scale out by 1
- If the HTTP queue length is zero, scale in by 1
- If the CPU utilization drops below 50%, scale in by 1

When determining whether to scale out, the autoscale action will be performed if any of the scale-out rules are met (HTTP queue length exceeds 10 or CPU utilization exceeds 70%). When scaling in, the autoscale action will run only if all of the scale-in rules are met (HTTP queue length drops to zero and CPU utilization falls below 50%). If you need to scale in if only one the scale-in rules are met, you must define the rules in separate autoscale conditions.
