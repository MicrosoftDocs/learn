Azure Monitor can proactively notify you when specific conditions are found in your monitoring data. You can create an alert based on any metric or log data source in the Azure Monitor data platform. There are different types of alerts:

- Metric alerts evaluate resource metrics at regular intervals. Metrics can be platform metrics, custom metrics, logs from Azure Monitor converted to metrics, or Application Insights metrics. Metric alerts can also apply multiple conditions and dynamic thresholds.
- Log alerts allow users to use a Log Analytics query to evaluate resource logs at a predefined frequency.
- Activity log alerts trigger when a new activity log event occurs that matches defined conditions. Resource Health alerts and Service Health alerts are activity log alerts that report on your service and resource health.

When monitoring an Azure Machine Learning workspace, you might want to get an alert when a Model deploy fails, when quota utilization exceeds a threshold, or when there are one or more unusable nodes. To create an alert:

1. On the Azure portal, open the Azure Machine Learning resource.
1. On the left-hand side menu, expand Monitoring and select Alerts.
1. Select the + Create drop down menu and select Alert rule.
1. Notice that the wizard starts on the second tab, Condition. This is because the Scope has already been set to Azure Machine Learning resource.
1. On the Signal name, select See all signals.
1. Notice that you can look for a range of signals including Custom log search, Metrics, and Activity log.
1. Under Metrics, select Failed Runs.
1. On the Alert logic, you can provide thresholds for when the condition is met to trigger the alert. On the Threshold enter 5. This means more than 5 failed deployments trigger this alert. You can change the variables to meet your needs. Select Next.
1. In the Actions tab, make sure Use quick actions is selected and provide the details in the right-hand side pane. Select Save and select Next.
1. On the Details tab, confirm the subscription and Resource group to use. Select the appropriate Severity level. In Alert rule name, provide the name of the alert and a description next. Select Review + Create.

The Alerts dashboard shows information if the alert has been triggered:

![A screenshot of the Alerts blade of an Azure Machine Learning workspace in the Azure portal.](../media/machine-learning-alerts.png)

If you configure an Alert to send an e-mail, you should receive a notification:

![A screenshot showing the output of an Azure Monitor alert in the Azure portal.](../media/azure-monitor-alert.png)
