You can work with Azure Monitor alerts in the Azure portal. There are options for creating and managing your alert instances, alert rules and conditions, and alert response actions.

:::image type="content" source="../media/monitor-alerts-0e2e8659.png" alt-text="Screenshot that shows an overview of Azure Monitor alerts in the Azure portal.":::

Let's examine some alert concepts in more detail.

### Things to know about alert types

There are different types of alerts to support various configuration and monitoring scenarios, such as metrics, logs, and events. You define alert rules for the different types of telemetry gathered from your monitored data sources. Trigger alerts according to conditions for your metrics and logs data, or by watching for activity log events. You can also implement alerts to help maintain the health of the underlying Azure platform and test your website availability.

Here are some of the most common types of alerts:

- **Metric alerts**: Evaluate metrics data from your resources at regular intervals. Gather metrics data from your platform, Azure Monitor logs converted to metrics, Azure Application Insights, and custom metrics. Metric alerts can apply multiple conditions and dynamic thresholds.

- **Log alerts**: Use Log Analytics queries in the Azure portal to evaluate resource logs at a predefined frequency.

- **Activity log events**: Implement alerts to trigger when a new activity log event occurs that meets your conditions. _Resource Health_ alerts and _Service Health_ alerts are two types of activity log alerts.

- **Smart detection alerts**: Receive automatic warnings about potential performance issues and failure anomalies in your web apps by using smart detection on your Application Insights resources. Migrate smart detection on your Application Insights resources to create alert rules for the different smart detection modules.

### Things to know about alert states

In the Azure portal, each alert has a _state_ indicator to identify where the alert and corresponding issue are in the monitoring process.

- There are three alert states:
   - **New**: The issue is new (open) and not in review.
   - **Acknowledged**: The issue is in review and work is in progress.
   - **Closed**: The issue is complete.

- During the alert monitoring process, when the conditions of an alert rule match telemetry data for your specified resource, an alert triggers and invokes the specified action groups. The system sets the alert state to _New_. 

- After the system sets an alert state to _New_, you can change the state to specify where the related issue is in the resolution process. 

   > [!Important]
   > Only the initial _New_ state for an alert is set by the system. All other state changes must be made by you as an administrator.

- When the issue for alert is in review, you can change the alert state to _Acknowledged_.
 
- After the issue for an alert clears, you can change the alert state to _Closed_.

- If an alert is in the _Closed_ state, you can "reopen" the alert by changing the alert state to _New_ or _Acknowledged_. |

- The history of the alert stores all state changes.

#### Alert state and Azure Monitor condition

The **alert state** is different and independent of the Azure Monitor **condition** as shown in the Azure portal.

- Upon the initial trigger of an alert, the system changes the alert state to _New_. A local administrator makes all further changes to the alert state.

- For all updates to the Azure Monitor condition for the same alert, the system makes all the changes.

- When an alert triggers, the Azure Monitor condition for the alert changes to _fired_.

- When the issue for the alert clears, the Azure Monitor condition for the alert changes to _resolved_.

#### Stateless and stateful alerts

You can configure most types of alerts as _stateful_ or _stateless_, which corresponds to how many instances of the same alert can be active at the same time.

- **Stateless alerts** trigger each time your alert rule condition matches your data, even if the same alert already exists. You can configure log alerts and metric alerts as stateless.

- **Stateful alerts** trigger when your alert rule condition matches your data and the same alert doesn't exist. A stateful alert doesn't trigger any more actions until the current alert rule conditions clear. You can configure log alerts and metric alerts as stateful. Activity log alerts are always stateless.