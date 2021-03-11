The operations team doesn't currently have enough information about the behavior of its systems to diagnose and resolve problems effectively. To address this issue, the team has configured an Azure Monitor workspace with the company's Azure services. It will run Kusto queries to get the status of the system, and attempt to identify the causes of any problems that might occur.

In particular, the team is interested in monitoring security events to check for possible attempts to break into the system. An attacker might try to manipulate the applications running on the system, so the team also wants to gather application data for further analysis. An attacker might also try to halt the computers that compose the system, so the team wants to examine how and when machines are stopped and restarted.

In this exercise, you'll practice performing Azure Monitor log queries. You'll use a demonstration set of data.

## Create basic Azure Monitor log queries to extract information from log data

Let's use the **Azure Monitor Demo Logs pane** to practice writing queries against sample data. This site is provided for demonstration with pre-populated sample data. The user interface is similar to the Azure portal, and you can use the Kusto language.

1. In your browser, open the [Azure Monitor Demo Logs pane](https://portal.azure.com/learn.docs.microsoft.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade?azure-portal=true) in the Azure portal.

1. Enter a basic query in the **Type your query here** box. This example query retrieves the details of the ten most recent security events.

    ```kusto
    SecurityEvent
        | take 10
    ```

1. Select **Run** to execute the query, and see the results. You can view each row in the results for more information.

1. Sort the data by time by running the following query.

    ```kusto
    SecurityEvent
        | top 10 by TimeGenerated
    ```

1. Enter a query by using a filter clause and a time range. Run this query to fetch records that are more than 30 minutes old, and that have a level of 10 or more.

    ```kusto
        SecurityEvent
        | where TimeGenerated < ago(30m)
        | where toint(Level) >= 10
    ```

1. Run the following query to search the `Events` table for records from the `Application` event log for the last `24` hours.

    ```kusto
    Event
    | where EventLog == "Application"
    | where TimeGenerated > ago(24h)
    ```

1. Run the following query to display the number of different computers that generated heartbeat events each week for the last three weeks. The results appear as a bar chart.

    ```kusto
    Heartbeat
        | where TimeGenerated >= startofweek(ago(21d))
        | summarize dcount(Computer) by endofweek(TimeGenerated) | render barchart kind=default
    ```

In addition to writing queries from scratch, the operations team can also take advantage of predefined example queries in Azure Monitor Logs that answer common questions related to the health, availability, usage and performance of their resources. Use the **Time Range** parameter above the query editor to select **Last 24 hours** as the time period of concern. Navigate to the **Queries** tab in the left pane to view a list of the sample queries grouped by Category, Resource Type, Solution, or Topic.

1. Leave the Group by setting on **Resource Type**, expand **Virtual machines**, and run the query called **Distinct missing updates cross computers**. This query returns a list missing Windows updates from Virtual Machines sending logs into the workspace.

1. Change the Group by setting to **Category**, expand **Azure Monitor** and run the query called **Computers availability today**. This query shows a time series chart with the number of unique IP addresses sending logs into the workspace each hour for the last day.

1. Change the Group by setting to **Topic**, expand **Firewall Logs**, and run the query called **Network rule log data**. This query returns a list of firewall actions the details of the associated network flows.

You can see from the Kusto queries you used here that it's easy to target a query to a specific time window, event level, or event log type. The security team can easily examine heartbeats to identify when servers are unavailable, which might indicate a denial-of-service attack. If the team spots the time when a server was unavailable, it can query for events in the security log around that time to diagnose whether an attack caused the interruption. Additionally, pre-defined queries can also evaluate the availability of VMs, identify missing Windows updates, and review firewall logs to view denied network flows intended for the VMs of interest.
