In this unit, we look at patterns for autoscaling.

## Autoscale concepts

- A resource can have only *one* autoscale setting
- An autoscale setting can have one or more profiles and each profile can have one or more autoscale rules.
- An autoscale setting scales instances horizontally, which is *out* by increasing the instances and *in* by decreasing the number of instances.
  An autoscale setting has a maximum, minimum, and default value of instances.
- An autoscale job always reads the associated metric to scale by, checking if it has crossed the configured threshold for scale-out or scale-in. You can view a list of metrics that autoscale can scale by at Azure Monitor autoscaling common metrics.
- All thresholds are calculated at an instance level. For example, "scale out by one instance when average CPU > 80% when instance count is 2", means scale-out when the average CPU across all instances is greater than 80%.
- All autoscale failures are logged to the Activity Log. You can then configure an activity log alert so that you can be notified via email, SMS, or webhooks whenever there is an autoscale failure.
- Similarly, all successful scale actions are posted to the Activity Log. You can then configure an activity log alert so that you can be notified via email, SMS, or webhooks whenever there is a successful autoscale action. You can also configure email or webhook notifications to get notified for successful scale actions via the notifications tab on the autoscale setting.

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
