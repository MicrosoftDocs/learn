In Azure Data Factory, you can raise alerts based upon metrics outputted by the monitoring service. Alerts allow you to get alerted for a variety of scenarios such as, but not limited to, failed pipelines, large factory sizes, and integration runtime CPU utilization.

Alerts in the monitoring experience are based upon high-level metrics such as pipeline failures. For custom alerting on specific conditions that may occur within a pipeline or based upon data quality, it is recommended to configure these using a pipeline activity.

To get started, go to the **Monitor** tab and select **Alerts & metrics**.

## Create an alert

1.  Select **New alert rule** to create a new alert.

    ![New Alert Rule button](../media/new-alerts.png)

1.  Specify the rule name and select the alert severity.

    ![Boxes for rule name and severity](../media/name-severity.png)

1.  Select the alert criteria.

    ![Box for target criteria](../media/add-criteria-1.png)

    > [!div class="mx-imgBorder"]  
    > ![Screenshot that shows where you select one metric to set up the alert condition.](../media/add-criteria-2.png)

    > [!div class="mx-imgBorder"]  
    > ![List of criteria](../media/add-criteria-3.png)

    You can create alerts on various metrics, including Azure Data Factory entity count/size, activity/pipeline/trigger runs, Integration Runtime (IR) CPU utilization/memory/node count/queue, as well as for SSIS package executions and SSIS IR start/stop operations.

1.  Configure the alert logic. You can create an alert for the selected metric for all pipelines and corresponding activities. You can also select a particular activity type, activity name, pipeline name, or failure type.

    ![Options for configuring alert logic](../media/alert-logic.png)

1.  Configure email, SMS, push, and voice notifications for the alert. Create an action group, or choose an existing one, for the alert notifications.

    ![Options for configuring notifications](../media/configure-notification-1.png)

    ![Options for adding a notification](../media/configure-notification-2.png)

1.  Create the alert rule.

    ![Options for creating an alert rule](../media/create-alert-rule.png)

Once you create an alert, you will get notified if the metric conditions are met.

If you have integrated your data factory with Log Analytics, you can use Azure Monitor to send alerts as well.
