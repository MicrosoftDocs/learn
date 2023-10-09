In this exercise, we'll look at exercises for setting up and triggering autoscaling of your sample application.

## Rule exercise

In your sample Azure Spring Apps application, your application already triggered a scale-out action on the customer service microservice when it was created.

The customers-service app scales **out** when the tomcat request count exceeds 10 sessions, per minute, on average. After the autoscale is triggered, it then scales **in** if the request count is less than or equal to 10 sessions per minute, on average.

## View Autoscale setup in the Azure portal

1. In a new web browser tab, open the Azure portal.
2. From the top search box, search for **Azure Spring Apps**.
3. From the Azure Spring Apps Overview page, select your Azure Spring Apps instance from the results.
4. Select the **Apps** tab under **Settings** in the menu on the left navigation pane.
5. Select the customers-service application. You should then see the application's **Overview** page.
6. Go to the **Scale-out** tab under Settings in the menu on the left side of the page.

:::image type="content" source="../media/scale-settings-2.png" alt-text="Screenshot of the scale out setting in the Azure portal." lightbox="../media/scale-settings-2.png":::

There are two options for Autoscale demand management:

1. Manual scale: Maintains a fixed instance count. In the Standard tier, you can scale out to a maximum of 500 instances. This value changes the number of separate running instances of the microservice application.
1. Custom autoscale: Scales on any schedule, based on any metrics.

In the Azure portal, view the pre-setup configuration for your application. The following figure shows the **Custom** autoscale setup to scale on the tomcat request count.

:::image type="content" source="../media/scale-settings.png" alt-text="Screenshot of the Custom autoscale setup in the Azure portal." lightbox="../media/scale-settings.png":::

### Viewing the finished autoscale events

In the Scale out setting screen, go to the **Run history** tab to see the most recent scale actions. The tab shows the change in Observed Capacity over time graphically, and a log of every autoscale action.

:::image type="content" source="../media/scale-result.png" alt-text="Screenshot of the autoscale run history in the Azure portal." lightbox="../media/scale-result.png":::

## Trigger the scale-out action with a script

You can also trigger autoscaling manually via a web browser or a shell script.

To test the autoscale rules, we'll generate some load on the instances. This simulated load causes the autoscale rules to scale out and increase the number of instances. As the simulated load is then stopped, the autoscale rules scale-in and reduce the number of instances.

To allow you to trigger the autoscale, we've provided a shell script in the same GIT repo you used to create your Azure Spring Apps application.

1. In your https://shell.azure.com bash window, run the following commands to set your spring apps instance name (the same Azure spring Apps service name you used in the previous exercise):

    ```bash
    export SPRING_APPS_SERVICE=<spring-apps-instance-name>
    ```

1. Next, in the bash window, run the following commands to execute transactions against your Spring Apps *customers-service* microservice:

    ```bash
    cd mslearn-autoscale-java
    sh loadTest.sh
    ```

1. You'll see the output of the *customers-service* load test that sends 100 requests to your instance.

## Trigger the scale-out action manually via a web browser (Optional)

To manually trigger the scale-out condition in the autoscale setting created, the *customers-service* microservice must have more than 10 requests in less than one minute.

1. Open a new browser window and navigate to the *customers-service* microservice:

    ```bash
    https://<your-spring-apps-service>-api-gateway.azuremicroservices.io/api/customer/owners
    ```

1. In quick succession, reload the page more than 10 times.

## Viewing the scale-out action

1. Back in the original browser window, on the autoscale setting, select the **Run history** tab.

1. You should see a chart reflecting the instance count.

1. In a few minutes, the instance count should rise from 1 to 2.

1. Under the chart, you should have the activity log entries for each scale action taken by this autoscale setting.

:::image type="content" source="../media/run-history.png" alt-text="Screenshot of the autoscale scale-out history in the Azure portal." lightbox="../media/run-history.png":::

## Scale-in action

The scale-in condition in the autoscale setting triggers if there are fewer than or equal to 10 requests to the *customers-service* microservice over a period of one minute.

1. Ensure no requests are being sent to your *customers-service* microservice and the browser window to your app/service is closed.

1. In a few minutes, the instance count *could* fall from 2 to 1 (see the important point, following).

:::image type="content" source="../media/scale-down.png" alt-text="Screenshot of the autoscale scale-in action in the Azure portal." lightbox="../media/scale-down.png":::

> [!IMPORTANT]
> Your Azure Spring Apps might not scale, because autoscale will try to estimate what the final state will be after it's scaled. This means autoscale would have to immediately scale again, if the average tomcat request count remains the same or even falls only a small amount.
