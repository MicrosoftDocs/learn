In this unit, we'll look at autoscaling rules, and then in the next exercise, trigger the rules.

## Rules

Azure Monitor autoscaling allows you to scale the number of running instances up or down, based on metrics, these metrics are processed by autoscaling rules.
You can create complex overlapping rules as needed for your situation.  Rule types include:

* **Metric-based** - For example, do this action when CPU usage is above 50%.
* **Time-based** - For example, trigger a webhook every 8am on Saturday in a given time zone.

Metric-based rules measure application load and add or remove application instances based on that load. Schedule-based rules allow you to scale when you see time patterns in your load and want to scale before a possible load increase or decrease occurs.

## Autoscale conditions

Azure provides two options for autoscaling:

* Scale based on a metric, such as the length of the disk queue, or the number of HTTP requests awaiting processing
* Scale to a specific instance count according to a schedule. For example, you can arrange to scale out at a particular time of day, or on a specific date or day of the week. You also specify an end date, and the system will scale back in at this time.

Scaling to a specific instance count only enables you to scale out to a defined number of instances. If you need to scale out incrementally, you can combine metric and schedule-based autoscaling in the same autoscale condition. So, you could arrange for the system to scale out if the number of HTTP requests exceeds some threshold, but only between certain hours of the day.

You can create multiple autoscale conditions to handle different schedules and metrics. Azure will autoscale your service when any of these conditions apply. An App Service Plan also has a default condition that will be used if none of the other conditions are applicable. This condition is always active and doesn't have a schedule.

## Autoscale actions

When an autoscale rule detects that a metric has crossed a threshold, it can perform an autoscale action. An autoscale action can be scale-out or scale-in. A scale-out action increases the number of instances, and a scale-in action reduces the instance count. An autoscale action uses an operator (such as less than, greater than, equal to, and so on) to determine how to react to the threshold. Scale-out actions typically use the greater than operator to compare the metric value to the threshold. Scale-in actions tend to compare the metric value to the threshold with the less than operator. An autoscale action can also set the instance count to a specific level, rather than incrementing or decrementing the number available.

An autoscale action has a cool down period, specified in minutes. During this interval, the scale rule won't be triggered again. This is to allow the system to stabilize between autoscale events. Remember that it takes time to start up or shut down instances, and so any metrics gathered might not show any significant changes for several minutes. The minimum cool down period is five minutes.
