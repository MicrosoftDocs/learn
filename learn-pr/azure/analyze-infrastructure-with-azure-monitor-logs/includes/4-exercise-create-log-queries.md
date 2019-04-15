The operations team does not have enough information about the behavior of their systems to diagnose problems early. In order to be able to highlight and determine any potential issues the team can utilise queries that process data and return results

## Create basic Azure Monitor log queries to extract information from log data

    1. Goto the following URL: https://portal.loganalytics.io/demo#/discover/query/main

[!NOTE]
> You can also run queries in your own subscription under Monitor -> Logs. The results depend on the resources that are in use in your subscription

Enter a basic query where it says Type your query here...

```kusto
        SecurityEvent
        | take 10
```

   1. Click Run and see the output of your query

Try a Sort query by running the following query:

```kusto
    SecurityEvent
    | top 10 by TimeGenerated
```

   1. Enter a query using a Filter clause and Time:

```kusto
    SecurityEvent
    | where TimeGenerated > ago(30m)
    | where toint(Level) >= 10
```

This example searches the Events table for records in which EventLog is Application and RenderedDescription contains cryptographic. Includes records from the last 24 hours.

```kusto
    Event
    | where EventLog == "Application"
    | where TimeGenerated > ago(24h)
    | where RenderedDescription == "cryptographic"
```

```kusto
    Heartbeat
    | where TimeGenerated >= startofweek(ago(21d))
    | summarize dcount(Computer) by endofweek(TimeGenerated) | render barchart kind=default
```

This example returns the last heartbeat record for each computer IP

```kusto
    Heartbeat
    | summarize arg_max(TimeGenerated, *) by ComputerIP
```