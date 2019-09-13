Azure Monitor can be used to capture important information from log files. These log files can be created by applications, operating systems, other hardware, or Azure services. 

As a solution architect, you want to explore the ways monitoring log data can detect issues before they become problems for your customers. You know Azure Monitor supports the use of log data.

In this unit, you want to understand how log data can be used to improve resilience in your system.

## When to use log alerts

Log alerts, as the name suggests, use log data to assess the rule logic and, if necessary, trigger an alert. The source of this data can come from any Azure resource from server logs, application server logs, or application logs. 

By its nature, log data is historical so usage is focused more on analytics and trends. 

You use these types of logs to assess if any of your servers have exceeded their CPU utilization by a given threshold during the last 30 minutes. Or you can evaluate response codes issued on your web application server in the last hour.

## How log alerts work

Log alerts behave in a slightly different way to other alert mechanisms. The first part of a Log alert is used to define the log search rule. The rule defines how often it should run, the time period under evaluation, and the query to be executed.

When a log search evaluates as positive, an alert record is created and any associated actions triggered.

## Composition of Log Search Rules

Every log alert has an associated search rule. The composition of these rules is:
- **Log query**: the query that runs every time the alert rule fires.
- **Time period**: specifies the time range for the query.
- **Frequency**: specifies how often the query should be run.
- **Threshold**: the trigger point for an alert to be created.

Log search results are one of two types, number of records or metric measurements.

## Number of records type

You would consider using this type of log search when working with an event or event-driven data. For example, Syslog or WebApp responses. This type of log search returns a single alert when the number of records in a search result reaches or exceeds the number of records (threshold) value. For example, when the threshold for the search rule is greater or equal to five, the query results would have to return five or more rows of data before the alert will trigger.

## Metric measurement type

Metric measurement logs offer the same basic functionality as metric alert logs.

Unlike a number of records search logs, metric measurement logs require additional criteria to be set, as follows:

- **Aggregate function**: defines the calculation that will be made against the result data. For example, count or average. The result of the function is called AggregatedValue.
- **Group field**: used in conjunction with the aggregated value and specifies a field by which the result will be grouped. For example, you could specify that you want the average [grouped] by computer.
- **Interval**: the time interval by which data is aggregated. For example, if you specify 10 minutes, an alert record is created for each aggregated block of 10 minutes.
- **Threshold**: defined by an aggregated value and the total number of breaches.

You would consider using this type of alert when you need to add a level of tolerance to the results found. One use for this type of alert is to respond if a particular trend or pattern is found. For example, if the number of breaches is five, and any server in your group exceeds 85% CPU utilization more than five times within the given time period, an alert would be fired.
 
As you can see, metric measurements greatly reduce the volume of alerts being produced. However, careful consideration needs to be given when setting the threshold parameters, to avoid missing critical alerts.

## Stateless nature of log alerts
One of the primary considerations when evaluating the use of log alerts is that they are stateless. This means that a log alert will generate new alerts every time the rule criteria is triggered, regardless of whether the alert was previously recorded.
