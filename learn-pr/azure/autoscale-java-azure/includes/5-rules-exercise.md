In this exercise, we'll look at exercises for setting up and triggering autoscaling of your sample application.

# Introduction

To test the autoscale rules, we will generate some load on the instances. This simulated load causes the autoscale rules to scale out and increase the number of instances. As the simulated load is then decreased, the autoscale rules scale in and reduce the number of instances.

In your sample application, we've already setup autoscale to trigger on the customer service microservice when the tomcat request count exceeds ten sessions per minute on average.

After the autoscale is triggered, it will then scale down if the request count is less than, or equal to ten.
In the next exercises, you'll trigger autoscaling via manually via a web browser and also a shell script.

## View Autoscale setup on the Autoscale page in the Azure portal

1. Sign in to the Azure portal
2. Go to the Azure Spring Cloud **Overview** page.
3. Select the resource group that contains your service.
4. Select the **Apps** tab under **Settings** in the menu on the left navigation pane.
5. Select the customers-service application. You should then see the application's **Overview** page.
6. Go to the **Scale out** tab under **Settings** in the menu on the left navigation pane.

### Viewing autoscale events

In the autoscale setting screen, go to the Run history tab to see the most recent scale actions. The tab also shows the change in Observed Capacity over time. To find more details about all autoscale actions including operations such as update/delete autoscale settings, view the activity log and filter by autoscale operations.

## Trigger the scale-out action manually via a web browser

To trigger the scale-out condition in the autoscale setting created, the Web App must have more than ten requests in less than 1 minute.

1. Open a new browser window and navigate to the customer-service:

```bash
https://<your-spring-cloud-service>-api-gateway.azuremicroservices.io/api/customer/owners
```

1. In quick succession, reload the page more than 10 times.

1. Back in the original browser window, from the left-hand navigation pane, select the Monitor option. Once the page loads select the Autoscale tab.

1. From the list, select the App Service Plan used throughout this tutorial.

1. On the autoscale setting, select the Run history tab.

1. You see a chart reflecting the instance count of the App Service Plan over time.

1. In a few minutes, the instance count should rise from 1, to 2.

1. Under the chart, you see the activity log entries for each scale action taken by this autoscale setting.

## Trigger a scale-in action manually

The scale-in condition in the autoscale setting triggers if there are fewer than, or equal to, ten requests to the Web App over a period of 1 minute.

1. Ensure no requests are being sent to your Web App and the browser window to your app/service is closed.

1. Load the Azure portal.

1. From the left-hand navigation pane, select the Monitor option. Once the page loads select the Autoscale tab.

1. From the list, select the App Service Plan used throughout this tutorial.

1. On the autoscale setting, select the Run history tab.

1. You see a chart reflecting the instance count of the App Service Plan over time.

1. In a few minutes, the instance count should drop from 2, to 1. The process takes at least 5 minutes.

1. Under the chart, are the corresponding set of activity log entries for each scale action taken by this autoscale setting.

![Autoscale log](../media/scale-in-chart.png)

## Trigger the scale-out action with a script

To allow you to trigger the autoscale manually, we have also provided a shell script.

In your https://shell.azure.com bash window, run the following commands to set your spring cloud instance name (same azure spring cloud service name you used in the previous exercise):

```bash
export SPRING_CLOUD_SERVICE=<spring-cloud-instance-name>
```

Next, in the bash window, run the following commands to execute transactions against your spring cloud customers-service

```bash
cd mslearn-autoscale-java
sh loadTest.sh
```

You'll see the output of the customers-service load test that will send 100 requests to your instance.
