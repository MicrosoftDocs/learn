In this exercise, with zero configuration, you'll effortlessly monitor autoscaling for your sample application.

## Monitor the Application's autoscale with Log Analytics

You can validate the evaluations and scale actions better using Log Analytics. In your sample application, we've routed your autoscale logs to Azure Monitor Logs (Log Analytics) through a Log Analytics workspace you created with your sample application setup.

> [!IMPORTANT]
> The Log data ingestion time in Azure Monitor can take up to 15 minutes. If data is not found in Log Analytics, it may take additional time to ingest Azure Spring Cloud log data.

## Use Log Analytics

1. Open the Azure portal
2. Select "Azure Spring Cloud" from the list of Azure services
3. Select your Azure Spring Cloud instance
4. Next, under the Monitoring section, select **Logs**.
5. In the **Query** search box try this query to view the most recent autoscale evaluation logs:

```Kusto
AutoscaleEvaluationsLog
| limit 50
```

Or try the following query to view the most recent scale action logs:

```Kusto
AutoscaleScaleActionsLog
| limit 50
```

## Troubleshooting common scale questions

### A scale action occurred that I didn’t expect

First execute the query for scale action to find the scale action you are interested in. If it's the latest scale action, use the following query:

```Kusto
AutoscaleScaleActionsLog
| take 1
```

Select the CorrelationId field from the scale actions log. Use the CorrelationId to find the right Evaluation log. Executing the below query will display all the rules and conditions evaluated leading to that scale action:

```Kusto
AutoscaleEvaluationsLog
| where CorrelationId = "<correliationId>"
```

### What profile caused a scale action?

A scaled action occurred, but you have overlapping rules and profiles and need to track down which caused the action.

Find the correlationId of the scale action (as explained in example 1) and then execute the query on evaluation logs to learn more about the profile:

```Kusto
AutoscaleEvaluationsLog
| where CorrelationId = "<correliationId_Guid>"
| where ProfileSelected == true
| project ProfileEvaluationTime, Profile, ProfileSelected, EvaluationResult
```

The whole profile evaluation can also be understood better using the following query:

```Kusto
AutoscaleEvaluationsLog
| where TimeGenerated > ago(2h)
| where OperationName contains == "profileEvaluation"
| project OperationName, Profile, ProfileEvaluationTime, ProfileSelected, EvaluationResult
```

### A scale action didn't occur

If you expected a scale action, and it didn't occur, there might have been no scale action events.

Review the autoscale metrics if you're using a metric-based scale rule. It's possible that the **Observed metric value** or **Observed Capacity** aren't what you expected them to be and so the scale rule did not fire. You would still see evaluations, but not a scale-out rule. It's also possible that the cool-down time kept a scale action from occurring.

The below query displays the autoscale evaluation logs during the time period you expected the scale action to occur, allowing you to determine the evaluations it did, and why it decided to not trigger a scale action:

```Kusto
AutoscaleEvaluationsLog
| where TimeGenerated > ago(2h)
| where OperationName == "MetricEvaluation" or OperationName == "ScaleRuleEvaluation"
| project OperationName, MetricData, ObservedValue, Threshold, EstimateScaleResult
```

### Scale action failed

There may be a case where autoscale service took the scale action but the system decided not to scale or failed to complete the scale action. Use this query to find the failed scale actions:

```Kusto
AutoscaleScaleActionsLog
| where ResultType == "Failed"
| project ResultDescription
```
