
Azure Monitor Alerts help you detect and address issues before users notice them by proactively notifying you when Azure Monitor data indicates there might be a problem with your infrastructure or application. You can alert on any metric or log data source in the Azure Monitor data platform.

Azure Monitor supports the following types of alert:

- **Metric alerts**. Metric alerts evaluate resource metrics at regular intervals. Metrics can be platform metrics, custom metrics, logs from Azure Monitor converted to metrics, or Application Insights metrics. Metric alerts can also apply multiple conditions and dynamic thresholds.
- **Log alerts**. Log alerts allow users to use a Log Analytics query to evaluate resource logs at a predefined frequency.
- **Activity log alerts**. Activity log alerts are triggered when a new activity log event occurs that matches defined conditions. Resource Health alerts and Service Health alerts are activity log alerts that report on your service and resource health.
- **Smart detection alerts**. Smart detection on an Application Insights resource automatically warns you of potential performance problems and failure anomalies in your web application. You can migrate smart detection on your Application Insights resource to create alert rules for the different smart detection modules.
- **Prometheus alerts**. Prometheus alerts are used for alerting on Prometheus metrics stored in Azure Monitor managed services for Prometheus. The alert rules are based on the PromQL open-source query language.

If you don't have alert rules defined for the selected resource, you can enable recommended out-of-the-box alert rules in the Azure portal.

The system compiles a list of recommended alert rules based on:

- The resource provider’s knowledge of important signals and thresholds for monitoring the resource.
- Data that tells us what customers commonly alert on for this resource.

Recommended alert rules are available for:

- Virtual machines
- AKS resources
- Log Analytics workspaces

## Alert RBAC permissions

You can only access, create, or manage alerts for resources for which you have permissions. To create an alert rule, you must have:

- Read permission on the target resource of the alert rule.
- Write permission on the resource group in which the alert rule is created. If you're creating the alert rule from the Azure portal, the alert rule is created by default in the same resource group in which the target resource resides.
- Read permission on any action group associated with the alert rule, if applicable.

These built-in Azure roles, supported at all Azure Resource Manager scopes, have permissions to and can access alerts information and create alert rules:

- Monitoring contributor: A contributor can create alerts and use resources within their scope.
- Monitoring reader: A reader can view alerts and read resources within their scope.

## Alert state

You can configure whether log or metric alerts are stateful or stateless. Activity log alerts are stateless.

- Stateless alerts fire each time the condition is met, even if fired previously.
- Stateful alerts fire when the condition is met. They don't fire again or trigger any more actions until the conditions are resolved.
