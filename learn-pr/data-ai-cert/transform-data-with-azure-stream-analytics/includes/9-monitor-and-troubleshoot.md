Monitoring is a key part of any mission or business-critical workload. It helps to proactively detect and prevent issues that might otherwise cause application or service downtime. There are several ways to monitor Azure Stream Analytics jobs:

1. Activity log specific to each running job
1. Real-time dashboards to show service and application health trends
1. Alerts on application or service issues
1. Diagnostic logs to investigate issues

## Activity log

The Azure Stream Analytics activity log provides details about each job you run. It's a low-level troubleshooting capability that can help identify issues with data sources, outputs, or transformation queries. There's an Activity Log blade available with each job you create. You can expand to see each job and then select each event to see the details in JSON as shown here.

![Screenshot of Activity Log](../media/9-activity-log.png)

## Dashboards

To view live dashboards for key health metrics of your Stream Analytics jobs, go to the Azure portal, select your Stream Analytics job, and select Metrics under Monitoring.

![Screenshot of Azure Stream Analytics Dashboard in the Azure portal](../media/9-dashboard.png)

## Alerts

To enable proactive detection of issues, Azure Stream Analytics can be configured to fire alerts based on various metrics and thresholds. To configure alerts in the Azure portal, navigate to your Stream Analytics job, and select **Alert rules** under **Monitoring**. Then select **+ New alert rule**.

![Screenshot of Showing Alert Rule](../media/9-alert-rule.png)

![Screenshot of Creating Alert Rule](../media/9-create-alert-rule.png)

Alerts can be configured to be sent as emails, SMS, or voicemail. Also, alerts can also be used to trigger other workflows.

## Diagnostics
Diagnostic logging is a key part of the operational infrastructure to help root-cause issues in production deployments. Stream Analytics diagnostics, off by default, can be turned on in Azure portal as needed by selecting the Stream Analytics job and selecting **Diagnostic logs** under **Monitoring**. Diagnostic logs can be conveniently delivered to various sinks or destinations for root-cause analysis.

Diagnostics settings can be persisted in an Azure Storage account, sent to Azure Event Hub, or sent to Azure Log Analytics. Diagnostics logs can be generated for job execution or job authoring. 

![Screenshot of Configuring Diagnostic Settings](../media/9-configure-diagnostic-settings.png)