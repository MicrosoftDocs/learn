The operations team doesn't currently have enough information about the behavior of their systems to diagnose and resolve problems effectively. To address this issue, the team has configured an Azure Monitor workspace with their Azure services. They'll run Kusto queries to interrogate the status of the system, and attempt to identify the causes of any problems that might occur.

In particular, the team is interested in monitoring security events to check for possible attempts to break into the system. An attacker could attempt to manipulate the applications running on the system, so the team also want to gather application data for further analysis. The team also suspect that an attacker might want to halt the computers that comprise the system, so the team also want to examine how and when machines are stopped and restarted.

In this exercise, you will practice performing Azure Monitor log queries. You'll use a demonstration set of data.

## Create basic Azure Monitor log queries to extract information from log data

Let's use the **Azure Log Analytics** web site to practice writing queries against sample data. This site is provided for demonstration with pre-populated sample data. The user interface is similar to the Azure portal and you can use the Kusto language.

1. In your browser, go to the URL https://portal.loganalytics.io/demo#/discover/query/main

    > [!NOTE]
    > You can also run queries in your own subscription under Monitor -> Logs. The results depend on the resources that are in use in your subscription

    Enter a basic query in the *Type your query here...* box. The example query retrieves the details of the most recent 10 security events.

    ```kusto
    SecurityEvent
        | take 10
    ```

1. Click **Run** to execute the query and see the results. You can drill into each row in the results to obtain further information.

1. Sort the data by time, by running the following query.

    ```kusto
    SecurityEvent
        | top 10 by TimeGenerated
    ```

1. Enter a query using a filter clause and a time. This query fetches records that are more than 30 minutes old and that have a Level of 10 or more.

    ```kusto
        SecurityEvent
        | where TimeGenerated < ago(30m)
        | where toint(Level) >= 10
    ```

1. Run the following example. This example searches the `Events` table for records from the `Application` event log for the last `24` hours.

    ```kusto
    Event
    | where EventLog == "Application"
    | where TimeGenerated > ago(24h)
    ```

1. Run the following query. This query displays the number of different computers that generated heartbeat events each week, for the last three weeks. The results are displayed as a bar chart.

    ```kusto
    Heartbeat
        | where TimeGenerated >= startofweek(ago(21d))
        | summarize dcount(Computer) by endofweek(TimeGenerated) | render barchart kind=default
    ```

You can see from the Kusto queries you used here that it's easy to target a query to a specific time window, event level, or event log type. The security team can easily examine heartbeats to identify when servers are unavailable, which might indicate a denial-of-service attack. If they spot the time when a server was unavailable, they can query for events in the security log around that time to diagnose whether the interruption was caused by an attack.