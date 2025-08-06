You can use Azure Monitor to capture important information from log files. Applications, operating systems, other hardware, or Azure services can create these log files.

As a solution architect, you want to explore ways that monitoring log data can detect issues before they become issues for your customers. You know that Azure Monitor supports the use of log data.

In this unit, you understand how using log data can improve resilience in your system.

## When to use log search alerts

Log search alerts use log data to assess the rule logic and, if necessary, trigger an alert. This data can come from any Azure resource: server logs, application server logs, or application logs.

By its nature, log data is historical, so usage is focused on analytics and trends.

You can use these types of logs to assess if any of your servers exceeded their CPU utilization by a given threshold during the last 30 minutes. Or, you could evaluate response codes issued on your web application server in the last hour.

## How log search alerts work

Log search alerts behave in a slightly different way than other alert mechanisms. The first part of a log search alert defines the log search rule. The rule defines how often it should run, the time period under evaluation, and the query to be run.

When a log search evaluates as positive, it creates an alert record and triggers any associated actions.

## Composition of log search rules

Every log search alert has an associated search rule with the following composition:

- **Log query**: Query that runs every time the alert rule fires.
- **Time period**: Time range for the query.
- **Frequency**: How often the query should run.
- **Threshold**: Trigger point for an alert to be created.

Log search results are one of two types: *number of records* or *metric measurement*.

### Number of records

Consider using the number-of-records type of log search when you're working with an event or event-driven data. Examples are syslog and web-app responses.

This type of log search returns a single alert when the number of records in a search result reaches or exceeds the value for the number of records (threshold). For example, when the threshold for the search rule is greater or equal to five, the query results have to return five or more rows of data before the alert is triggered.

### Metric measurement

Metric measurement logs offer the same basic functionality as metric alert logs.

Unlike number-of-records search logs, metric measurement logs require further criteria to be set:

- **Aggregate function**: The calculation to be made against the result data. An example is count or average. The result of the function is called **AggregatedValue**.
- **Group field**: Indicates how the result should be grouped. This criterion is used with the aggregated value. For example, you might specify that you want the average grouped by computer.
- **Interval**: The time interval by which data is aggregated. For example, if you specify 10 minutes, an alert record is created for each aggregated block of 10 minutes.
- **Threshold**: A point defined by an aggregated value and the total number of breaches.

Consider using this type of alert when you need to add a level of tolerance to the results found. One use for this type of alert is to respond if a particular trend or pattern is found. For example, if the number of breaches is five, and any server in your group exceeds 85 percent CPU utilization more than five times within the given time period, an alert fires.

As you can see, metric measurements greatly reduce the volume of alerts that are produced. Still, give careful consideration when you're setting the threshold parameters to avoid missing critical alerts.

## Log search alerts and state

Alerts can be [stateful or stateless](/azure/azure-monitor/alerts/alerts-types#log-alerts). Stateless alerts fire each time the condition is met, even if fired previously. Stateful alerts fire when the rule conditions are met, and will not fire again or trigger any more actions until the conditions are resolved.
