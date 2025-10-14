## Understanding Kusto Query Language (KQL)

**Kusto Query Language (KQL)** is the primary way to query Log Analytics and extract insights from your telemetry data. It provides both a **query language** for data analysis and a set of **control commands** for managing databases and tables.

### What makes KQL powerful?

**Design principles:**

- **Read-like flow:** Queries read left-to-right and top-to-bottom like natural language
- **Pipe operators:** Results flow through a pipeline of transformations (similar to Unix pipes)
- **Optimized for logs:** Designed specifically for time-series and log data analysis
- **Fast execution:** Columnar storage and query optimization enable sub-second queries over terabytes
- **Rich operators:** 100+ operators for filtering, aggregation, joins, time-series analysis, machine learning, and visualization

**KQL vs. SQL:**

- **Syntax:** Pipe-based (`|`) vs. nested SELECT statements
- **Optimization:** Designed for read-heavy analytics vs. transactional workloads
- **Time handling:** First-class support for time-series operations
- **Complexity:** Simpler for complex log analysis scenarios

### Where can you use KQL?

**Azure services supporting KQL:**

- **Log Analytics:** Query logs from Azure Monitor
- **Application Insights:** Analyze application telemetry
- **Azure Resource Graph:** Query Azure resource metadata
- **Microsoft Sentinel:** Security analytics and threat hunting
- **Azure Data Explorer:** Big data analytics platform

**Tools for writing KQL queries:**

**1. Azure Portal:**

- Integrated directly in Log Analytics workspace
- IntelliSense and syntax highlighting
- Query results displayed with visualization options
- Save and share queries across your organization

**2. Azure Data Explorer:**

- Kusto can be used directly within [Azure Data Explorer](https://dataexplorer.azure.com)
- Full-featured query environment with advanced capabilities
- Supports creating dashboards and parameterized queries
- Ideal for complex analysis and data exploration

**3. Azure Data Studio:**

- Azure Data Studio offers a **Kusto query experience** with extensions
- Supports the creation of **Jupyter-style notebooks** for Kusto queries
- Combine KQL queries with markdown documentation
- Create reproducible analysis workflows
- Share notebooks with team members

**4. Visual Studio Code:**

- Extensions available for KQL syntax highlighting
- Connect to Log Analytics workspaces
- Development environment for complex queries

**5. PowerShell and CLI:**

- Execute KQL queries programmatically
- Integrate query results into automation workflows
- Schedule recurring analysis tasks

### Getting started with KQL

For comprehensive documentation on KQL syntax, operators, and functions, see [Getting Started with Kusto Queries](/azure/data-explorer/kusto/concepts/).

**Learning path:**

1. **Basic filtering:** Learn `where`, `take`, `project` operators
2. **Aggregation:** Master `summarize`, `count`, `avg`, `max` functions
3. **Time operations:** Work with `ago()`, `bin()`, `startofday()`
4. **Visualization:** Create charts with `render` operator
5. **Advanced analysis:** Joins, unions, time-series functions, machine learning operators

## Hands-on walkthrough: Querying telemetry with KQL

**Note:** This walkthrough continues from the previous unit on Azure Log Analytics. Ensure you've completed the previous exercise where you created a workspace, connected VMs, configured performance counters, and generated test load with HeavyLoad.

### Prerequisites for this walkthrough

Before starting, verify:

- **Log Analytics workspace created:** From the previous exercise
- **VM connected:** Microsoft Monitoring Agent installed and sending data
- **Performance counters configured:** System, process, and SQL Server counters collecting
- **Test data generated:** HeavyLoad executed to create performance variations
- **Data latency elapsed:** Wait 10-15 minutes after generating load for data to appear

### Opening the Log Analytics query interface

**Step 1:** Log in to the [Azure portal](https://portal.azure.com) and navigate to the Log Analytics workspace created in the previous unit.

**Step 2:** From the left blade in the Log Analytics workspace, click **Logs**. This opens the Logs window with:

**Interface components:**

- **Query editor:** Top pane for writing KQL queries
- **Schema explorer:** Left pane showing available tables and columns
- **Results pane:** Bottom pane displaying query results
- **Toolbar:** Save, export, pin to dashboard, and visualization options

**Query editor features:**

- **IntelliSense:** Autocomplete for table names, columns, and operators
- **Syntax highlighting:** Color-coded query components
- **Query history:** Access previously run queries
- **Example queries:** Pre-built queries to learn from

You're now ready to start exploring all the data points captured into the workspace using KQL.

### Query 1: Listing connected machines with last heartbeat

**Objective:** Verify which machines are connected to the workspace and when they last reported.

Run the following query to list the **last heartbeat** of each machine connected to the Log Analytics workspace:

```kusto
// Last heartbeat of each computer
// Show the last heartbeat sent by each computer
Heartbeat
| summarize arg_max(TimeGenerated, *) by Computer
```

**Query explanation:**

**`Heartbeat` table:**

- Automatically populated by the Microsoft Monitoring Agent
- Agent sends heartbeat every minute to confirm connectivity
- Contains computer name, OS type, IP address, resource information

**`|` (pipe operator):**

- Passes results from one operator to the next
- Queries read left-to-right through pipe operations

**`summarize` operator:**

- Aggregates data by grouping rows
- Similar to SQL GROUP BY

**`arg_max(TimeGenerated, *)` function:**

- Finds the row with the maximum TimeGenerated value
- Returns all columns (`*`) from that row
- Effectively gets the most recent heartbeat

**`by Computer` clause:**

- Groups results by Computer name
- Creates one result row per unique computer

**Use cases for this query:**

- **Health check:** Identify machines that haven't reported recently
- **Inventory:** List all connected machines
- **Troubleshooting:** Verify agent connectivity
- **Alerting:** Create alert if heartbeat not received in X minutes

**Expected results:**

- One row per computer showing the most recent heartbeat timestamp
- Columns include Computer, TimeGenerated, OSType, Version, ComputerIP

### Query 2: Discovering collected performance counters

**Objective:** Understand what performance data is being collected from monitored machines.

Run the following query to show a list of all **distinct counters** being captured:

```kusto
// What data is being collected?
// List the collected performance counters and object types (Process, Memory, Processor.)
Perf
| summarize by ObjectName, CounterName
```

**Query explanation:**

**`Perf` table:**

- Stores all performance counter data from monitored machines
- Each row represents one performance counter sample
- Columns include Computer, ObjectName, CounterName, InstanceName, CounterValue, TimeGenerated

**`summarize by ObjectName, CounterName`:**

- Groups by both ObjectName (e.g., "Processor", "Memory") and CounterName (e.g., "% Processor Time")
- Returns only unique combinations
- No aggregation function means we just get distinct values
- Similar to SQL `SELECT DISTINCT ObjectName, CounterName`

**Understanding the results:**

**Object categories you'll see:**

- **Processor:** CPU-related metrics (% Processor Time, % Idle Time)
- **Memory:** Memory metrics (Available MBytes, Pages/sec)
- **LogicalDisk:** Disk I/O metrics (Disk Reads/sec, % Free Space)
- **Network Adapter:** Network metrics (Bytes Received/sec, Bytes Sent/sec)
- **Process:** Per-process metrics (% Processor Time by process)
- **SQL Server:** Database-specific counters (if SQL Server is installed)

**Why this query is useful:**

- **Configuration audit:** Verify that expected counters are being collected
- **Documentation:** Understand available metrics for alerting and analysis
- **Query building:** Identify correct ObjectName and CounterName for subsequent queries
- **Troubleshooting:** Confirm configuration changes are reflected in data collection

**Expected results:**

- Dozens to hundreds of rows depending on configuration
- Each row shows one ObjectName and CounterName combination
- Results sorted alphabetically by default

### Query 3: Measuring data collection volume

**Objective:** Understand the scale of data being collected and demonstrate query performance.

Run the following query to show a **count of data points** collected in the last 24 hours:

```kusto
Perf
| where TimeGenerated > ago(24h)
| count
```

**Query explanation:**

**`where TimeGenerated > ago(24h)`:**

- Filters data to last 24 hours
- `ago()` function calculates time relative to now
- `24h` means 24 hours (can also use `1d`, `7d`, `30m`, `60s`)
- Essential for performance: filtering by time first improves query speed

**`count` operator:**

- Returns the number of rows
- Simple aggregation showing total data points
- Similar to SQL `SELECT COUNT(*)`

**Interpreting the results:**

The result shows that we have **88 million data points** (your number will vary based on:

- Number of connected machines
- Number of performance counters configured
- Sampling interval (10 seconds vs. 60 seconds)
- Duration of data collection

**Performance implications:**

Despite having **88M data points**, we can **query them in near real-time** to analyze and correlate insights:

- Query execution time: Typically 1-3 seconds
- Columnar storage: Only relevant columns are scanned
- Distributed processing: Azure processes queries across multiple nodes
- Optimized indexing: TimeGenerated column is automatically indexed

:::image type="content" source="../media/count-data-points-collected-eb1adb35.png" alt-text="Screenshot of a count of the data points collected in the last 24 hours. The result shows that we have 88M data points.":::

**Data volume estimation:**

To estimate expected data volume:

- **Counters configured:** 50 counters (example)
- **Sampling interval:** 10 seconds = 6 samples per minute
- **Per hour:** 50 counters × 6 samples × 60 minutes = 18,000 data points
- **Per day per machine:** 18,000 × 24 hours = 432,000 data points
- **Multiple machines:** 432,000 × number of VMs

**Cost considerations:**

- More frequent sampling = more data points = higher ingestion costs
- Balance detail level against budget
- Use different sampling intervals for different counter types (critical counters: 10s, capacity planning: 5m)

### Query 4: Visualizing CPU utilization trends

**Objective:** Create a time-series visualization of CPU usage to identify performance patterns and anomalies.

Run the following query to generate the **max CPU utilization trend** over the last 24 hours, aggregated at a granularity of 1 minute:

```kusto
Perf
| where ObjectName == "Processor" and InstanceName == "_Total"
| summarize max(CounterValue) by Computer, bin(TimeGenerated, 1m)
| render timechart
```

**Query explanation:**

**`where ObjectName == "Processor" and InstanceName == "_Total"`:**

- **ObjectName == "Processor":** Filter to only CPU performance counters
- **InstanceName == "\_Total":** Get aggregate across all CPU cores (vs. per-core metrics)
- Multiple conditions combined with `and` operator

**`summarize max(CounterValue) by Computer, bin(TimeGenerated, 1m)`:**

- **max(CounterValue):** Get maximum CPU percentage in each time bucket
- **by Computer:** Create separate series for each machine
- **bin(TimeGenerated, 1m):** Group time into 1-minute buckets
  - Reduces 88M data points to manageable visualization
  - `bin()` function rounds timestamps to nearest interval
  - Can use `1s`, `5m`, `1h`, `1d` depending on zoom level needed

**`render timechart` operator:**

- Visualizes results as a time-series line chart
- X-axis: Time (TimeGenerated)
- Y-axis: Counter value (CPU percentage 0-100)
- Multiple lines: One per computer
- Interactive: Hover for exact values, zoom in/out

:::image type="content" source="../media/cpu-utilization-cd08686a.png" alt-text="Screenshot of a graph with max CPU Utilization trend over the last 24 hours, aggregated at a granularity of 1 min in a time chart.":::

**Analyzing the visualization:**

**Patterns to look for:**

- **Baseline utilization:** Normal CPU usage during typical operations (likely 10-30%)
- **Spikes:** Short bursts of high CPU (might be scheduled tasks, backups)
- **Sustained high load:** Prolonged periods above 80% (potential capacity issue)
- **Cyclic patterns:** Daily/weekly patterns (business hours vs. off-hours)
- **Test load impact:** Visible spike when HeavyLoad was running

**Advanced variations of this query:**

**Compare different time ranges:**

```kusto
Perf
| where ObjectName == "Processor" and InstanceName == "_Total"
| where TimeGenerated > ago(2h)  // Last 2 hours for detailed view
| summarize max(CounterValue) by Computer, bin(TimeGenerated, 10s)
| render timechart
```

**Show average instead of maximum:**

```kusto
Perf
| where ObjectName == "Processor" and InstanceName == "_Total"
| summarize avg(CounterValue) by Computer, bin(TimeGenerated, 5m)
| render timechart
```

**Add percentile lines (50th, 95th, 99th):**

```kusto
Perf
| where ObjectName == "Processor" and InstanceName == "_Total"
| summarize percentile(CounterValue, 50), percentile(CounterValue, 95), percentile(CounterValue, 99) by bin(TimeGenerated, 5m)
| render timechart
```

### Query 5: Identifying CPU-consuming processes

**Objective:** Drill down from total CPU utilization to identify which specific processes are consuming resources.

Run the following query to see all the **processes** running on the machine contributing to CPU utilization:

```kusto
Perf
| where ObjectName contains "process"
        and InstanceName !in ("_Total", "Idle")
        and CounterName == "% Processor Time"
| summarize avg(CounterValue) by InstanceName, CounterName, bin(TimeGenerated, 1m)
| render piechart
```

**Query explanation:**

**`where ObjectName contains "process"`:**

- **contains operator:** Case-insensitive substring match
- Matches "Process" object (per-process metrics)
- Less strict than `==` operator (exact match)

**`and InstanceName !in ("_Total", "Idle")`:**

- **!in operator:** "Not in" - excludes specified values
- **"\_Total":** Aggregate of all processes (redundant with individual processes)
- **"Idle":** System idle process (uninteresting for analysis)
- Result: Only individual named processes

**`and CounterName == "% Processor Time"`:**

- Filter to CPU utilization counter specifically
- Each process has many counters (memory, I/O, threads)
- We only want CPU percentage for this analysis

**`summarize avg(CounterValue) by InstanceName, CounterName, bin(TimeGenerated, 1m)`:**

- **avg(CounterValue):** Average CPU percentage across the time window
- **by InstanceName:** Separate result for each process name
- **bin(TimeGenerated, 1m):** Still bucketing by 1-minute intervals
- This creates multiple data points per process across time

**`render piechart` operator:**

- Visualizes results as a pie chart
- Each slice represents one process
- Slice size proportional to CPU consumption
- Labels show process name and percentage

:::image type="content" source="../media/run-processes-pie-chart-61e255a6.png" alt-text="Screenshot of all the processes running on that machine contributing to the CPU Utilization in a pie chart.":::

**Analyzing the pie chart:**

**What you'll typically see:**

- **HeavyLoad.exe:** Large slice if load test is running
- **sqlservr.exe:** Database process consuming CPU (if SQL Server installed)
- **w3wp.exe:** IIS worker process (if web server)
- **System:** Kernel-mode CPU time
- **Many small slices:** Background services and processes

**Use cases for this query:**

- **Performance troubleshooting:** Identify runaway processes
- **Capacity planning:** Understand typical process resource distribution
- **Security investigation:** Detect unusual processes consuming CPU
- **Application optimization:** Identify which application components need tuning

**Alternative visualizations:**

**Bar chart for easier comparison:**

```kusto
Perf
| where ObjectName contains "process"
        and InstanceName !in ("_Total", "Idle")
        and CounterName == "% Processor Time"
| summarize avg(CounterValue) by InstanceName
| top 10 by avg_CounterValue desc  // Top 10 processes only
| render barchart
```

**Table for detailed analysis:**

```kusto
Perf
| where ObjectName contains "process"
        and InstanceName !in ("_Total", "Idle")
        and CounterName == "% Processor Time"
| summarize AvgCPU=avg(CounterValue), MaxCPU=max(CounterValue), SampleCount=count() by InstanceName
| order by AvgCPU desc
```

**Time-series showing process CPU over time:**

```kusto
Perf
| where ObjectName contains "process"
        and InstanceName !in ("_Total", "Idle")
        and CounterName == "% Processor Time"
| where InstanceName in ("sqlservr", "w3wp", "HeavyLoad")  // Focus on specific processes
| summarize avg(CounterValue) by InstanceName, bin(TimeGenerated, 1m)
| render timechart
```

## Summary and key takeaways

This unit has introduced the **basic concepts of Kusto Query Language (KQL)** and how to get started with querying Log Analytics data. Through five practical queries, you've learned fundamental KQL patterns that apply to countless monitoring scenarios.

### What you've learned

**Query patterns covered:**

**1. Aggregation with arg_max:**

- Find the most recent record per entity
- Useful for status checks and health monitoring
- Pattern: `| summarize arg_max(timestamp, *) by grouping_column`

**2. Distinct value enumeration:**

- Discover available data without aggregation functions
- Pattern: `| summarize by column1, column2`
- Similar to SQL DISTINCT

**3. Simple counting:**

- Measure data volume and scale
- Pattern: `| where time_filter | count`
- Always filter by time first for performance

**4. Time-series aggregation and visualization:**

- Use `bin()` to create time buckets
- Aggregate metrics within buckets
- Visualize with `render timechart`
- Pattern: `| summarize agg_function by bin(TimeGenerated, interval)`

**5. Filtering and process analysis:**

- Combine multiple where conditions with `and`
- Use `contains` for substring matching
- Use `!in` to exclude specific values
- Visualize distributions with pie charts

### KQL operators you've used

| Operator    | Purpose                        | Example                           |
| ----------- | ------------------------------ | --------------------------------- | ------ |
| `where`     | Filter rows based on condition | `where ObjectName == "Processor"` |
| `summarize` | Aggregate data with grouping   | `summarize avg(CPU) by Computer`  |
| `bin()`     | Round timestamps to intervals  | `bin(TimeGenerated, 1m)`          |
| `ago()`     | Calculate relative time        | `ago(24h)`                        |
| `render`    | Create visualizations          | `render timechart`                |
| `contains`  | Substring match                | `where name contains "sql"`       |
| `!in`       | Exclusion filter               | `where process !in ("Idle")`      |
| `count`     | Count rows                     | `                                 | count` |

### Beyond the basics

We've only **scratched the surface** of what is possible with Log Analytics and KQL. The language includes 100+ operators for advanced scenarios:

**Advanced KQL capabilities not covered:**

**Joins and unions:**

- Combine data from multiple tables
- Correlate events across different sources
- Example: Join application logs with performance metrics

**Time-series functions:**

- `make-series`: Create full time-series including missing data points
- `series_decompose`: Separate trends, seasonality, and anomalies
- `series_fir`: Apply filters to smooth or emphasize patterns

**Machine learning operators:**

- `autocluster`: Automatically identify common patterns
- `basket`: Find frequently occurring attribute combinations
- `diffpatterns`: Compare two datasets to find differences

**Advanced visualizations:**

- Multi-dimensional charts
- Anomaly detection bands
- Geo-mapping
- Custom dashboards

**Performance optimization:**

- Materialized views for frequently accessed aggregations
- Query optimization techniques
- Partition strategies for large datasets

### Continuing your learning

We strongly encourage you to **explore the advanced tutorials** available for Log Analytics on [Microsoft Learn](/azure/azure-monitor/):

**Recommended learning paths:**

1. **Write your first Log Analytics query:** Introduction tutorial
2. **Advanced KQL for Azure Monitor:** Deep dive into complex queries
3. **Create visualizations with KQL:** Charts, dashboards, and reports
4. **Build alerts from queries:** Convert queries into monitoring alerts
5. **Optimize query performance:** Best practices for large-scale data

**Practice exercises:**

- Query Application Insights telemetry
- Analyze security logs in Microsoft Sentinel
- Create custom dashboards combining multiple data sources
- Build automated reports using Power BI integration

**Community resources:**

- KQL query samples in Azure Portal
- GitHub repositories with example queries
- Stack Overflow for troubleshooting
- Azure Monitor community forums

### Next steps

In the following units, you'll apply these KQL skills to:

- Analyze Application Insights telemetry
- Create custom metrics and dimensions
- Build alerts based on query conditions
- Design dashboards for stakeholders
- Implement comprehensive monitoring strategies

The queries you've learned here form the foundation for all these advanced scenarios.
