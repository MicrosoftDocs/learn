In this unit, we look at autoscaling monitoring.

## Monitoring

Same as any other Azure resource, the autoscale service provides resource logs. There are two categories of logs.

- Autoscale Evaluations - The autoscale engine records log entries for every single condition evaluation every time it does a check. The entry includes details on the observed values of the metrics, the rules evaluated, and if the evaluation resulted in a scale action or not.

- Autoscale Scale Actions - The engine records scale action events initiated by autoscale service and the results of those scales actions (success, failure, and how much scaling occurred as seen by the autoscale service).

As with any Azure Monitor supported service, you can use Diagnostic Settings to route these logs:

- to your Log Analytics workspace for detailed analytics
- to Event Hubs and then to non-Azure tools
- to your Azure storage account for archival

## Monitor the Application's autoscale with Azure Monitor

Azure Monitor autoscale helps you to have the right amount of resources running to handle the load on your application. It enables you to add resources to handle increases in load and also save money by removing resources that are sitting idle. You can scale based on a schedule, fixed date-time, or resource metric you choose. For more information, see Autoscale Overview.

The autoscale service provides you metrics and logs to understand what scale actions have occurred and the evaluation of the conditions that led to those actions. You can find answers to questions such as:

- Why did my service scale-out or in?
- Why did my service not scale?
- Why did an autoscale action fail?
- Why is an autoscale action taking time to scale?

## Autoscale Metrics

Autoscale provides you with four metrics to understand its operation.

- Observed Metric Value - The value of the metric you chose to take the scale action on, as seen or computed by the autoscale engine. Because a single autoscale setting can have multiple rules and therefore multiple metric sources, you can filter using "metric source" as a dimension.
- Metric Threshold - The threshold you set to take the scale action. Because a single autoscale setting can have multiple rules and therefore multiple metric sources, you can filter using "metric rule" as a dimension.
- Observed Capacity - The active number of instances of the target resource as seen by Autoscale engine.
- Scale Actions Initiated - The number of scale-out and scale-in actions initiated by the autoscale engine. You can filter by scale-out vs. scale in actions.
You can use the Metrics Explorer to chart the above metrics all in one place. The chart should show:

- the actual metric
- the metric as seen/computed by autoscale engine
- the threshold for a scale action
- the change in capacity

## Understanding autoscale events

In the autoscale setting screen, go to the Run history tab to see the most recent scale actions. The tab also shows the change in Observed Capacity over time. To find more details about all autoscale actions including operations such as update/delete autoscale settings, view the activity log and filter by autoscale operations.

### Troubleshoot Autoscale via the Activity Log

Autoscale will post to the Activity Log if any of the following conditions occur:

- Autoscale issues a scale operation.
- Autoscale service successfully completes a scale action.
- Autoscale service fails to take a scale action.
- Metrics are not available for autoscale service to make a scale decision.
- Metrics are available (recovery) again to make a scale decision.
- Autoscale detects flapping and aborts the scale attempt. You will see a log type of `Flapping` in this situation. If you see this, consider whether your thresholds are too narrow.
- Autoscale detects flapping but is still able to successfully scale. You will see a log type of `FlappingOccurred` in this situation. If you see this, the autoscale engine has attempted to scale (for example, from four instances to 2), but has determined that this would cause flapping. Instead, the autoscale engine has scaled to a different number of instances (for example, using three instances instead of 2), which no longer causes flapping, so it has scaled to this number of instances.

## Monitor the Application's autoscale with Log Analytics

You can validate the evaluations and scale actions better using Log Analytics. In your sample application, we've routed your autoscale logs to Azure Monitor Logs (Log Analytics) through a workspace when you created the autoscale setting. In the next exercise, you'll use log analytics to find out more about the autoscale events.
