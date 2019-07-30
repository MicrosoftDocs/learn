A powerful feature of Azure Monitor is its ability to use thresholds to monitor specific resources. In an organization, it's far more useful to be notified when the free disk space on a server is less than 5%, instead of being alerted every time a file is saved.

As a solution architect, you want to implement regular threshold monitoring for a number of your target resources and instances – this monitoring will help to head off potential issues before they can impact your customers.

In this unit, you'll investigate the different kinds of metric alerts supported by Azure Monitor.

## When would you use metric alerts?

In Azure Monitor, you can use metric alerts to achieve regular threshold monitoring of Azure resources. Metric alert trigger conditions are run at regular intervals. When the evaluation is true, a notification is sent. Metric alerts are stateful, and will only send a notification when the prerequisite conditions are met.

Metric alerts can be useful if, for instance, you need to know when your server CPU use is reaching a critical threshold – say greater than 90% – or when your database storage is getting too low, or network latency is about to reach unacceptable levels.

## Composition of a metric alert
As you learned in the previous unit, all alerts are governed by their rules. For metric alerts, there's one additional factor to define – the condition type, which can be static or dynamic.

### Example scenario
With both static and dynamic metric alerts, you must define the type of statistical analysis to be used – for example, min, max, average, or total. In the example here, you will define the period of data to be assessed – such as the last 10 minutes. Finally, you will set the frequency by which the alert conditions are checked – for instance, every two minutes. 

### Using static threshold metric alerts
Static metric alerts are based on simple static conditions and thresholds that you define. With static metrics, you specify the threshold that will be used to trigger the alert or notification.

In the previously defined scenario, a static alert with a threshold of 85% – using CPU utilization as the metric – would check the rule every two minutes. It would evaluate the last 10 minutes of CPU utilization data to assess if it was above the 85% threshold.  If the evaluation is true, the actions associated with the action group would trigger.

### Using dynamic threshold metric alerts
Dynamic metric alerts use machine learning tools that Azure provides to automatically improve the accuracy of the thresholds defined by the initial rule.

There's no hard threshold in dynamic metrics. However, you'll need to define two more parameters: a look back period and the number of violations.

- The **look back period** defines how many previous periods need to be evaluated. For example, if you set the look back period to 3 then, in the example used here, the data range assessed would be 30 minutes (three sets of 10 minutes).

- The **number of violations** expresses how many times the logic condition has to deviate from the expected behavior before the alert rule fires a notification.  In this example, if you set the number of violations to 2, the alert would only get triggered after two deviations from the calculated threshold.

## Understanding dimensions
Until now, the metric alerts assessed have focused on a single target instance. Azure Monitor supports dimensions, which enable monitoring data to be supplied from multiple target instances.

You use dimensions to define one metric alert rule and have it applied to multiple related instances. For example, you could monitor CPU utilization across all the servers running your application, and receive individual notification for each server instance as and when the rule conditions are triggered.

You can define the dimensions either by naming each target instance specifically, or by employing the asterisk (\*) wild card, which will use all available instances.

## Scaling metric alerts
Much like dimensions, Azure Monitor also supports the creation of metric alerts that monitor multiple resources. Scaling is currently limited to Azure virtual machines. However, a single metric alert can monitor resources in one Azure region.

The creation of scaling metric alert rules to monitor multiple resources is no different from creating any other metric alert rule. You just select all the resource you want to monitor.

Like dimensions, a scaling metric alert is individual to the resource that triggered it.

## Configure and set up metric alerts
You've been introduced to metric-based alerts – now it's time to face a practical hands-on exercise where you'll create your own.
