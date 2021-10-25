In this exercise, we'll look at exercises for setting up and triggering autoscaling of your sample application.

# Introduction

In your sample Azure Spring Cloud application, when your application was created, it already triggered a scale-up action on the customer service microservice.

The customer-service will scale-up when the tomcat request count exceeds 10 sessions, per minute, on average.
After the autoscale is triggered, it will then scale down if the request count is less than, or equal to 10 sessions, per minute, on average.

## View Autoscale setup in the Azure portal

1. Sign in to the Azure portal
2. Go to the Azure Spring Cloud **Overview** page.
3. Select the resource group that contains your service.
4. Select the **Apps** tab under **Settings** in the menu on the left navigation pane.
5. Select the customers-service application. You should then see the application's **Overview** page.
6. Go to the **Scale-out** tab under Settings in the menu on the left side of the page.

:::image type="content" source="../media/scalesettings2.png" alt-text="scale setting" lightbox="../media/scalesettings2.png":::

There are two options for Autoscale demand management:

1. Manual scale: Maintains a fixed instance count. In the Standard tier, you can scale out to a maximum of 500 instances. This value changes the number of separate running instances of the microservice application.
1. Custom autoscale: Scales on any schedule, based on any metrics.

In the Azure portal, view the pre-setup configuration for your application. The following figure shows the Custom autoscale setup to scale on the tomcat request count.

:::image type="content" source="../media/scalesettings.png" alt-text="scale rules" lightbox="../media/scalesettings.png":::

### Viewing the finished autoscale events

In the Scale-out setting screen, go to the Run history tab to see the most recent scale actions. The tab shows the change in Observed Capacity over time graphically, and a log of every autoscale action.

:::image type="content" source="../media/scaleresult.png" alt-text="autoscale run history" lightbox="../media/scaleresult.png":::

## Trigger the scale-out action with a script

You can also trigger autoscaling, manually via a web browser or a shell script.
To test the autoscale rules, we'll generate some load on the instances. This simulated load causes the autoscale rules to scale out and increase the number of instances. As the simulated load is then stopped, the autoscale rules scale-in and reduce the number of instances.

To allow you to trigger the autoscale, we've provided a shell script in the same GIT repo you used to create your Azure Spring Cloud application.

In your https://shell.azure.com bash window, run the following commands to set your spring cloud instance name (same Azure spring cloud service name you used in the previous exercise):

```bash
export SPRING_CLOUD_SERVICE=<spring-cloud-instance-name>
```

Next, in the bash window, run the following commands to execute transactions against your spring cloud customers-service

```bash
cd mslearn-autoscale-java
sh loadTest.sh
```

You'll see the output of the customers-service load test that will send 100 requests to your instance.

## Trigger the scale-out action manually via a web browser (Optional)

To manually trigger the scale-out condition in the autoscale setting created, the customer-service microservice must have more than 10 requests in less than 1 minute.

1. Open a new browser window and navigate to the customer-service:

```bash
https://<your-spring-cloud-service>-api-gateway.azuremicroservices.io/api/customer/owners
```

1. In quick succession, reload the page more than 10 times.

## Viewing the scale-out action

1. Back in the original browser window, on the autoscale setting, select the Run history tab.

1. You should see a chart reflecting the instance count.

1. In a few minutes, the instance count should rise from 1, to 2.

1. Under the chart, you should see the activity log entries for each scale action taken by this autoscale setting.

## Scale-in action

The scale-in condition in the autoscale setting triggers if there are fewer than, or equal to, 10 requests to the customer service over a period of 1 minute.

1. Ensure no requests are being sent to your customer-service and the browser window to your app/service is closed.

1. In a few minutes, the instance count could fall from 2, to 1 (see below point).

> [!IMPORTANT]
> Your Azure Spring Cloud might not scale down as before scaling down, autoscale tries to estimate what the final state will be if it scaled in. This means autoscale would have to immediately scale out again even after it scaled in, if the average tomcat request count remains the same or even falls only a small amount.
