
If you're not following good practices when creating autoscale settings, you can create conditions that lead to undesirable results. In this unit you'll learn how to avoid creating rules that conflict with each other.

## Autoscale concepts

* An autoscale setting scales instances horizontally, which is *out* by increasing the instances and *in* by decreasing the number of instances. An autoscale setting has a maximum, minimum, and default value of instances.

* An autoscale job always reads the associated metric to scale by, checking if it has crossed the configured threshold for scale out or scale-in.

* All thresholds are calculated at an instance level. For example, "scale out by one instance when average CPU > 80% when instance count is 2", means scale out when the average CPU across all instances is greater than 80%.

* All autoscale successes and failures are logged to the Activity Log. You can then configure an activity log alert so that you can be notified via email, SMS, or webhooks whenever there's activity.

## Autoscale best practices

Use the following best practices as you create your autoscale rules.

### Ensure the maximum and minimum values are different and have an adequate margin between them

If you have a setting that has minimum=two, maximum=two and the current instance count is two, no scale action can occur. Keep an adequate margin between the maximum and minimum instance counts, which are inclusive. Autoscale always scales between these limits.

### Choose the appropriate statistic for your diagnostics metric

For diagnostics metrics, you can choose among *Average*, *Minimum*, *Maximum* and *Total* as a metric to scale by. The most common statistic is Average.

### Choose the thresholds carefully for all metric types

We recommend carefully choosing different thresholds for scale out and scale-in based on practical situations.

We *don't recommend* autoscale settings like the examples below with the same or similar threshold values for out and in conditions:

* Increase instances by one count when Thread Count >= 600
* Decrease instances by one count when Thread Count <= 600

Let's look at an example of what can lead to a behavior that may seem confusing. Consider the following sequence.

1. Assume there are two instances to begin with and then the average number of threads per instance grows to 625.
1. Autoscale scales out adding a third instance.
1. Next, assume that the average thread count across instance falls to 575.
1. Before scaling in, autoscale tries to estimate what the final state will be if it scaled in. For example, 575 x 3 (current instance count) = 1,725 / 2 (final number of instances when scaled in) = 862.5 threads. This means autoscale would have to immediately scale out again even after it scaled in, if the average thread count remains the same or even falls only a small amount. However, if it scaled out again, the whole process would repeat, leading to an infinite loop.
1. To avoid this situation (termed "flapping"), autoscale doesn't scale in at all. Instead, it skips and reevaluates the condition again the next time the service's job executes. This can confuse many people because autoscale wouldn't appear to work when the average thread count was 575.

Estimation during a scale-in is intended to avoid "flapping" situations, where scale-in and scale out actions continually go back and forth. Keep this behavior in mind when you choose the same thresholds for scale out and in.

We recommend choosing an adequate margin between the scale out and in thresholds. As an example, consider the following better rule combination.

* Increase instances by 1 count when CPU% >= 80
* Decrease instances by 1 count when CPU% <= 60

In this case

1. Assume there are 2 instances to start with.
1. If the average CPU% across instances goes to 80, autoscale scales out adding a third instance.
1. Now assume that over time the CPU% falls to 60.
1. Autoscale's scale-in rule estimates the final state if it were to scale-in. For example, 60 x 3 (current instance count) = 180 / 2 (final number of instances when scaled in) = 90. So autoscale doesn't scale-in because it would have to scale out again immediately. Instead, it skips scaling in.
1. The next time autoscale checks, the CPU continues to fall to 50. It estimates again - 50 x 3 instance = 150 / 2 instances = 75, which is below the scale out threshold of 80, so it scales in successfully to 2 instances.

### Considerations for scaling when multiple rules are configured in a profile

There are cases where you may have to set multiple rules in a profile. The following set of autoscale rules are used by services when multiple rules are set.

On *scale out*, autoscale runs if any rule is met. On *scale-in*, autoscale require all rules to be met.

To illustrate, assume that you have the following four autoscale rules:

* If CPU < 30 %, scale-in by 1
* If Memory < 50%, scale-in by 1
* If CPU > 75%, scale out by 1
* If Memory > 75%, scale out by 1

Then the following occurs:

* If CPU is 76% and Memory is 50%, we scale out.
* If CPU is 50% and Memory is 76% we scale out.

On the other hand, if CPU is 25% and memory is 51% autoscale doesn't scale-in. An automatic scale-in would occur if the CPU is 29% and the Memory is 49% since both of the scale-in rules would be true.

### Always select a safe default instance count

The default instance count is important because autoscale scales your service to that count when metrics aren't available. Therefore, select a default instance count that's safe for your workloads.

### Configure autoscale notifications

Autoscale will post to the Activity Log if any of the following conditions occur:

* Autoscale issues a scale operation
* Autoscale service successfully completes a scale action
* Autoscale service fails to take a scale action.
* Metrics aren't available for autoscale service to make a scale decision.
* Metrics are available (recovery) again to make a scale decision.

You can also use an Activity Log alert to monitor the health of the autoscale engine. In addition to using activity log alerts, you can also configure email or webhook notifications to get notified for successful scale actions via the notifications tab on the autoscale setting.
