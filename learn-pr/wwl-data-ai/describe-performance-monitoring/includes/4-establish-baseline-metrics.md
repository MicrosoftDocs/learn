A baseline is a collection of data measurements that helps you understand the normal state of your application or server’s performance. Having the data collected over time allows you to identify changes from the normal state. Baselines can be as simple as a chart of CPU utilization over time, or complex aggregations of metrics to offer granular level performance data from specific application calls. The granularity of your baseline depends on the criticality of performance of your database and application.

With any type of application workload, it's imperative to establish a working baseline. A baseline helps you identify if an ongoing issue should be considered within normal parameters or has exceeded given thresholds. Without a baseline, every issue encountered could be considered normal and therefore not require any extra intervention.

## Correlating SQL Server and operating system performance

When deploying SQL Server on an Azure virtual machine, it’s critical to correlate the performance of SQL Server with the performance of the underlying operating system. If you're using Linux as the operating system, you need to install *InfluxDB*, *Collectd*, and *Grafana* to capture data similar to Windows Performance Monitor. These services collect data from SQL Server and provide a graphical interface to review the data. Utilizing these tools on Linux or Performance Monitor on Windows can be used in conjunction looking at SQL Server-specific data such as SQL Server wait statistics. Using these tools together allow you to identify bottlenecks in hardware or code. The following Performance Monitor counters are a sampling of useful Windows metrics, and can allow you to capture a good baseline for a SQL Server workload:

**Processor(_Total)\% Processor Time** - This counter measures the CPU utilization of all of the processors on the server. It's a good indication of the overall workload, and when used with other counters, this counter can identify problems with query performance.

**Paging File(_Total)\% Usage** - In a properly configured SQL Server, memory shouldn't page to the paging file on disk. However, in some configurations you may have other services running that consume system memory and lead to the operating system paging memory to disk resulting in performance degradation.

**PhysicalDisk(_Total)\Avg. Disk sec/Read and Avg. Disk sec/Write** - This counter provides a good metric for how the storage subsystem is working. Your latency values in most cases shouldn't be above 20 ms, and with Premium Storage you should see values less than 10 ms.

**System\Processor Queue Length** - This number indicates the number of threads that are waiting for the time on the processor. If it's greater than zero, it indicates CPU pressure, indicating your workload could benefit from more CPUs.

**SQLServer:Buffer Manager\Page life expectancy** - Page life expectancy indicates how long SQL Server expects a page to live in memory. There's no proper value for this setting. Older documentation refers to 300 seconds as proper, but that was written in a 32-bit era when servers had far less RAM. You should monitor this value over time, and evaluate sudden drops. Such drops in the counter's value could indicate poor query patterns, external memory pressure (for example, the server running a large SSIS package) or could just be normal system processing like running a consistency check on a large database.

**SQLServer:SQL Statistics\Batch Requests/sec** - This counter is good for evaluating how consistently busy a SQL Server is over time. Once again there's no good or bad value, but you can use this counter with % Processor time to better understand your workload and baselines.

**SQLServer:SQL Statistics\SQL Compilations/sec and SQL Re-Compilations/sec** - These counters are updated when SQL Server has to compile or recompile an execution plan for a query because there's no existing plan in the plan cache, or because a plan was invalidated because of a change. Recompiles can indicate T-SQL with recompile query hints, or be indicative of memory pressure on the plan cache caused by either many ad-hoc queries or simple memory pressure.

These counters are just a sample of the available performance monitor counters that are available to you. While these counters provide a good baseline of performance, you may need to examine more counters to identify specific performance problems.

## Wait statistics

When a thread is being executed and is forced to wait on an unavailable resource, SQL Server keeps track of these metrics. This information is easily identifiable via the dynamic management view (DMV) `sys.dm_os_wait_stats`. This information is important to understanding the baseline performance of your database, and can help you identify specific performance issues both with query execution and hardware limitations. Identifying the appropriate wait type and corresponding resolution is critical for resolving performance issues. Wait statistics are available across the Azure SQL platform.
