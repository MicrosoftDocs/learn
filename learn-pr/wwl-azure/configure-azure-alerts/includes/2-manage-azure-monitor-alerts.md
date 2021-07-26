:::image type="content" source="../media/monitor-alerts-0e2e8659.png" alt-text="Monitor Alerts screenshot.":::


The Monitor Alerts experience has many benefits.

 -  **Better notification system**. All newer alerts use action groups, which are named groups of notifications and actions that can be reused in multiple alerts.
 -  **A unified authoring experience**. All alert creation for metrics, logs and activity log across Azure Monitor, Log Analytics, and Application Insights is in one place.
 -  **View Log Analytics alerts in Azure portal**. You can now also observe Log Analytics alerts in your subscription. Previously these were in a separate portal.
 -  **Separation of Fired Alerts and Alert Rules**. Alert Rules (the definition of the condition that triggers an alert), and Fired Alerts (an instance of the alert rule firing) are differentiated, so the operational and configuration views are separated.
 -  **Better workflow**. The new alerts authoring experience guides the user along the process of configuring an alert rule, which makes it simpler to discover the right things to get alerted on.

## Managing alerts

You can alert on metrics and logs as described in monitoring data sources. These include but are not limited to:

 -  Metric values
 -  Log search queries
 -  Activity Log events
 -  Health of the underlying Azure platform
 -  Tests for web site availability

## Alert states

You can set the state of an alert to specify where it is in the resolution process. When the criteria specified in the alert rule is met, an alert is created or fired, it has a status of **New**. You can change the status when you acknowledge an alert and when you close it. All state changes are stored in the history of the alert. The following alert states are supported.

:::row:::
  :::column:::
    **State**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **New**
  :::column-end:::
  :::column:::
    The issue has been detected and has not yet been reviewed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Acknowledged**
  :::column-end:::
  :::column:::
    An administrator has reviewed the alert and started working on it.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Closed**
  :::column-end:::
  :::column:::
    The issue has been resolved. After an alert has been closed, you can reopen it by changing it to another state.
  :::column-end:::
:::row-end:::


> [!NOTE]
> Alert state is different and independent of the monitor condition. Alert state is set by the user. Monitor condition is set by the system. When an alert fires, the alert's monitor condition is set to fired. When the underlying condition that caused the alert to fire clears, the monitor condition is set to resolved. The alert state isn't changed until the user changes it.
