In this unit, we look at patterns for autoscaling.

## Common patterns to scale your resource in Azure

### Scale based on CPU

You have a web app and

- You want to scale out/scale in based on CPU.
- Additionally, you want to ensure there is a minimum number of instances.
- Also, you want to ensure that you set a maximum limit to the number of instances you can scale to.

### Scale differently on weekdays vs weekends

You have a web app and

- You want three instances by default (on weekdays)
- You don't expect traffic on weekends and hence you want to scale down to one instance on weekends.

### Scale differently during holidays

You have a web app and

- You want to scale up/down based on CPU usage by default
- However, during holiday season (or specific days that are important for your business) you want to override the defaults and have more capacity at your disposal.

### Scale based on custom metric

You have a web front end and an API tier that communicates with the backend.

- You want to scale the API tier based on custom events in the front end (example: You want to scale your checkout process based on the number of items in the shopping cart)

## Autoscale best practices

- A resource can have only *one* autoscale setting
- An autoscale setting can have one or more profiles and each profile can have one or more autoscale rules.
- An autoscale setting scales instances horizontally, which is *out* by increasing the instances and *in* by decreasing the number of instances.
  An autoscale setting has a maximum, minimum, and default value of instances.
- An autoscale job always reads the associated metric to scale by, checking if it has crossed the configured threshold for scale-out or scale-in. You can view a list of metrics that autoscale can scale by at Azure Monitor autoscaling common metrics.
- All thresholds are calculated at an instance level. For example, "scale out by one instance when average CPU > 80% when instance count is 2", means scale-out when the average CPU across all instances is greater than 80%.
- All autoscale failures are logged to the Activity Log. You can then configure an activity log alert so that you can be notified via email, SMS, or webhooks whenever there is an autoscale failure.
- Similarly, all successful scale actions are posted to the Activity Log. You can then configure an activity log alert so that you can be notified via email, SMS, or webhooks whenever there is a successful autoscale action. You can also configure email or webhook notifications to get notified for successful scale actions via the notifications tab on the autoscale setting.

### Troubleshoot Autoscale via the Activity Log

Autoscale will post to the Activity Log if any of the following conditions occur:

- Autoscale issues a scale operation.
- Autoscale service successfully completes a scale action.
- Autoscale service fails to take a scale action.
- Metrics are not available for autoscale service to make a scale decision.
- Metrics are available (recovery) again to make a scale decision.
- Autoscale detects flapping and aborts the scale attempt. You will see a log type of `Flapping` in this situation. If you see this, consider whether your thresholds are too narrow.
- Autoscale detects flapping but is still able to successfully scale. You will see a log type of `FlappingOccurred` in this situation. If you see this, the autoscale engine has attempted to scale (for example, from four instances to 2), but has determined that this would cause flapping. Instead, the autoscale engine has scaled to a different number of instances (for example, using three instances instead of 2), which no longer causes flapping, so it has scaled to this number of instances.
