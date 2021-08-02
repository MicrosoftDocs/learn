In this exercise, we look at exercises for setting up and triggering autoscaling of your sample application.

## Manually triggering autoscale

```bash
curl https://<your-spring-cloud>-api-gateway.azuremicroservices.io/api/customer/owners
```

## Trigger the autoscaling via a script

```bash
sh trigger.sh
```

## Understanding autoscale events

In the autoscale setting screen, go to the Run history tab to see the most recent scale actions. The tab also shows the change in Observed Capacity over time. To find more details about all autoscale actions including operations such as update/delete autoscale settings, view the activity log and filter by autoscale operations.
