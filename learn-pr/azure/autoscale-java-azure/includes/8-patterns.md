In this unit, we look at patterns for autoscaling.

## Autoscale best practices

## Considerations

- Having a minimum instance count makes sure your application is always running even under no load.
- Having a maximum instance count limits your total possible hourly cost.
- You can automatically scale between the minimum and maximum using rules you create.
- Ensure the maximum and minimum values are different and have an adequate margin between them.
- Always use a scale-out and scale-in rule combination that performs an increase and decrease.
- Choose the appropriate statistic for your diagnostics metric (Average, Minimum, Maximum and Total).
- Always select a safe default instance count. The default instance count is important because autoscale scales your service to that count when metrics are not available.
- Always configure autoscale notifications.

### Configure autoscale notifications

Autoscale will post to the Activity Log if any of the following conditions occur:

- Autoscale issues a scale operation.
- Autoscale service successfully completes a scale action.
- Autoscale service fails to take a scale action.
- Metrics are not available for autoscale service to make a scale decision.
- Metrics are available (recovery) again to make a scale decision.
- Autoscale detects flapping and aborts the scale attempt. You will see a log type of `Flapping` in this situation. If you see this, consider whether your thresholds are too narrow.
- Autoscale detects flapping but is still able to successfully scale. You will see a log type of `FlappingOccurred` in this situation. If you see this, the autoscale engine has attempted to scale (for example, from four instances to 2), but has determined that this would cause flapping. Instead, the autoscale engine has scaled to a different number of instances (for example, using three instances instead of 2), which no longer causes flapping, so it has scaled to this number of instances.

You can also use an Activity Log alert to monitor the health of the autoscale engine. See the summary section for examples to create an Activity Log Alert to monitor all autoscale engine operations on your subscription or to create an Activity Log Alert to monitor all failed autoscale scale in/scale out operations on your subscription.

In addition to using activity log alerts, you can also configure email or webhook notifications to get notified for successful scale actions via the notifications tab on the autoscale setting.
