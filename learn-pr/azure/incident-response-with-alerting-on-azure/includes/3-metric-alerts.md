Azure Monitor can use thresholds to monitor specific resources. In an organization, it's far more useful to be notified when the free disk space on a server is less than five percent instead of being alerted every time a file is saved.

As a solution architect, you want to implement regular threshold monitoring for many of your target resources and instances. Monitoring helps to head off potential issues before they can affect your customers.

In this unit, you'll investigate the different kinds of metric alerts that Azure Monitor supports.

## When would you use metric alerts?

In Azure Monitor, you can use metric alerts to achieve regular threshold monitoring of Azure resources. Azure Monitor runs metric alert trigger conditions at regular intervals. When the evaluation is true, Azure Monitor sends a notification. Metric alerts are stateful, and Azure Monitor will send a notification only when the prerequisite conditions are met.

Metric alerts can be useful if, for instance, you need to know when your server CPU utilization is reaching a critical threshold of 90 percent. You can receive alerts when your database storage is getting too low, or when network latency is about to reach unacceptable levels.

## Composition of a metric alert

As you learned in the previous unit, all alerts are governed by their rules. For metric alerts, there's another factor to define: the condition type. It can be static or dynamic.

You must define the type of statistical analysis to be used with either static or dynamic metric alerts. Example types are minimum, maximum, average, and total. In this example, you define the period of data to be assessed: the last 10 minutes. Finally, you set the frequency by which the alert conditions are checked: every two minutes.

### Use static threshold metric alerts

Static metric alerts are based on simple static conditions and thresholds that you define. With static metrics, you specify the threshold that's used to trigger the alert or notification.

In the previously defined scenario, a static alert with a threshold of 85 percent CPU utilization checks the rule every two minutes. It evaluates the last 10 minutes of CPU utilization data to assess if it rises above the threshold. If the evaluation is true, the alert triggers the actions associated with the action group.

### Use dynamic threshold metric alerts

Dynamic metric alerts use machine-learning tools that Azure provides to automatically improve the accuracy of the thresholds defined by the initial rule.

There's no hard threshold in dynamic metrics. However, you'll need to define two more parameters:

- The *look-back period* defines how many previous periods need to be evaluated. For example, if you set the look-back period to 3, then in the example used here, the assessed data range would be 30 minutes (three sets of 10 minutes).

- The *number of violations* expresses how many times the logic condition has to deviate from the expected behavior before the alert rule fires a notification. In this example, if you set the number of violations to two, the alert would be triggered after two deviations from the calculated threshold.

## Understand dimensions

Until now, the assessed metric alerts have focused on a single target instance. Azure Monitor supports dimensions, which enable monitoring data to be supplied from multiple target instances.

You can use dimensions to define one metric alert rule and have it applied to multiple related instances. For example, you can monitor CPU utilization across all the servers running your app. You can then receive an individual notification for each server instance when the rule conditions are triggered.

You can define the dimensions by naming each target instance specifically, or you can define the dimensions by using the asterisk (\*) wildcard, which uses all available instances.

## Scale metric alerts

Azure Monitor supports creating metric alerts that, like dimensions, monitor multiple resources. Scaling is currently limited to Azure virtual machines. However, a single metric alert can monitor resources in one Azure region.

Creating scaling metric alert rules to monitor multiple resources is no different than creating any other metric alert rule; you just select all the resources that you want to monitor.

Like dimensions, a scaling metric alert is individual to the resource that triggered it.
