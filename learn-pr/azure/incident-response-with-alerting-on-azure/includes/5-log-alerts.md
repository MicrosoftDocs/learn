You can use Azure Monitor to capture important information from log files. These log files can be created by applications, operating systems, other hardware, or Azure services.

As a solution architect, you want to explore ways that monitoring log data can detect issues before they become problems for your customers. You know that Azure Monitor supports the use of log data.

In this unit, you want to understand how using log data can improve resilience in your system.

## When to use log alerts

Log alerts use log data to assess the rule logic and, if necessary, trigger an alert. This data can come from any Azure resource: server logs, application server logs, or application logs. 

By its nature, log data is historical. So usage is focused on analytics and trends. 

You use these types of logs to assess if any of your servers have exceeded their CPU utilization by a given threshold during the last 30 minutes. Or, you can evaluate response codes issued on your web application server in the last hour.

## How log alerts work

Log alerts behave in a slightly different way from other alert mechanisms. The first part of a log alert defines the log search rule. The rule defines how often it should run, the time period under evaluation, and the query to be run.

When a log search evaluates as positive, an alert record is created and any associated actions are triggered.

## Composition of log search rules

Every log alert has an associated search rule. The composition of these rules is:

- **Log query**: The query that runs every time the alert rule fires.
- **Time period**: The time range for the query.
- **Frequency**: How often the query should run.
- **Threshold**: The trigger point for an alert to be created.

Log search results are one of two types: number of records or metric measurement.

### Number of records

Consider using the number-of-records type of log search when you're working with an event or event-driven data. Examples are syslog and web app responses. 

This type of log search returns a single alert when the number of records in a search result reaches or exceeds the value for the number of records (threshold). For example, when the threshold for the search rule is greater or equal to five, the query results have to return five or more rows of data before the alert is triggered.

### Metric measurement

Metric measurement logs offer the same basic functionality as metric alert logs.

Unlike number-of-records search logs, metric measurement logs require additional criteria to be set:

- **Aggregate function**: The calculation that will be made against the result data. An example is count or average. The result of the function is called **AggregatedValue**.
- **Group field**: A field by which the result will be grouped. This criterion is used in conjunction with the aggregated value. For example, you might specify that you want the average grouped by computer.
- **Interval**: The time interval by which data is aggregated. For example, if you specify 10 minutes, an alert record is created for each aggregated block of 10 minutes.
- **Threshold**: A point defined by an aggregated value and the total number of breaches.

Consider using this type of alert when you need to add a level of tolerance to the results found. One use for this type of alert is to respond if a particular trend or pattern is found. For example, if the number of breaches is five, and any server in your group exceeds 85 percent CPU utilization more than five times within the given time period, an alert is fired.

As you can see, metric measurements greatly reduce the volume of alerts that are produced. Still, give careful consideration when you're setting the threshold parameters to avoid missing critical alerts.

## Stateless nature of log alerts

One of the primary considerations when you're evaluating the use of log alerts is that they are stateless. This means that a log alert will generate new alerts every time the rule criteria are triggered, regardless of whether the alert was previously recorded.
