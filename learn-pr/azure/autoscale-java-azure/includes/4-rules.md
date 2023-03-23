In this unit, we'll look at autoscaling rule concepts, then in the next exercise, we'll trigger the rules.

## Rules

Autoscaling is based on a set of scale conditions, rules, and limits. A scale condition combines time and a set of scale rules. If the current time falls within the period defined in the scale condition, the condition's scale rules are evaluated. The results of this evaluation determine whether to add or remove instances. The scale condition also defines the limits of scaling for the maximum and minimum number of instances.

Azure Spring Apps autoscaling allows you to scale the number of running instances out or in, based on metrics. These metrics are processed by autoscaling rules. You can create complex overlapping rules as needed for your situation.

## Autoscale conditions

There are two rule types:

* Metric-based rules
* Schedule-based rules

In metric-based types, your apps are horizontally scaled out to exactly how many apps and resources are needed to handle the load, but never exceeding the maximum limits that you establish. Similarly, the number of apps and resources are horizontally scaled in to the only those necessary to support your load, but never falling below the minimums that you set.

In schedule-based rules, your apps are scaled in and out based on your predefined schedule and limits. This is useful for cases that often follow a predictable pattern and to establish a baseline for more metric-based scaling.

You can create multiple autoscale conditions to handle different schedules and metrics. Azure autoscales your service when any of these conditions apply. You can also define a default condition to be used if none of the other conditions are applicable. This condition is always active and doesn't have a schedule.

## Autoscale actions

When an autoscale rule detects that a metric has crossed a threshold, it does an autoscale action. An autoscale action can be **scale-out** or **scale-in**. A **scale-out** action increases the number of instances, and a **scale-in** action reduces the instance count. An autoscale action uses an operator (such as **less than**, **greater than**, **equal to**, and so on) to determine how to react to the threshold. **Scale-out** actions typically use the **greater than** operator to compare the metric value to the threshold. **Scale-in** actions tend to compare the metric value to the threshold with the **less than** operator. An autoscale action can also set the instance count to a specific level, rather than incrementing or decrementing the number available.

An autoscale action has a cool-down period, specified in minutes. During this interval, the scale rule won't be triggered again. This is to allow the system to stabilize between autoscale events. Remember that it takes time to start up or shut down instances, and so any metrics gathered might not show any significant changes for several minutes.

Estimation during a scale-in is intended to avoid "Flapping" situations, where scale-in and scale-out actions continually go back and forth. Keep this behavior in mind when you choose the same thresholds for scale-out and scale-in.
