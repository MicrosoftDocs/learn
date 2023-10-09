Here, you'll retrieve and transform data from the `Perf` table, using KQL queries, to analyze the free space of the machines logging data to your Log Analytics workspace. 

## 1. Set goals

Recall that your IT team has noticed recurring issues related to insufficient free space on virtual machines. 

To analyze free space usage of machines running in your IT environment, you need information about:

- Total free space available on each machine.
- Percentage of space used on each machine.

## 2. Assess logs

As we saw the previous exercise, the `Perf` table provides information about the performance of hardware components, operating systems, and applications.
 
We noted that the `Perf` table's `ObjectName` column lists the names of all of the objects being monitored and the `CounterName` column holds the names of the various performance counters that Azure Monitor collects. We also saw that both of these columns hold lots of values, many of which appear multiple times. 

Let's run a query on the `Perf` table to list distinct `ObjectName` values:

<a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAwtILUpT0NdXCMlIVShJTMpJVajML33UMLMoVaGwNLWoMjMvnatGISWzuCQzL7lEwT8pKzW5xC8xNxWkyQcoXIxVsiwxpzS1GAB8NbsmXQAAAA%253D%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

```kusto
Perf // The table you’re querying
| distinct ObjectName // Lists distinct ObjectName values
```

The result set of this query includes all `ObjectName` values currently in the table:

:::image type="content" source="../media/kql-log-analytics-perf-table-distinct-objectname.png" alt-text="Screenshot that shows the results of the Distinct Object Name query on the Perf table with the Logical Disk values highlighted." lightbox="../media/kql-log-analytics-perf-table-distinct-objectname.png":::

In our scenario, we're interested in analyzing virtual machines, so the objects we want to look at are `LogicalDisk` and `Logical Disk` (to monitor the memory in a physical machine, you'd look at the `memory` object). The reason there are two similarly named objects is that `LogicalDisk` is the object name in Windows records while `Logical Disk` is used in Linux records.

To list the distinct names of the counters Azure Monitor collects for the `LogicalDisk` and `Logical Disk` objects, run:

<a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA33MMQ6CQBCF4d5TvHABTkClJVELE%252BuFHWEUd%252BPMrkhC4TW8nidxxWhFbN%252F8821JDshz7FpCMFVHGHx83h9CuESSgV0DLEb0LaVpUx2pDmtzJhQFstI3XJtuxXrK4OXr%252BKmCe2dRyYId9uys7xVCtReri3kJH%252BqPU7KLt58ywrIGdqla%252BugCySSm%252FzLtOn%252B9mi6SvgDYtn9E%252BQAAAA%253D%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

```kusto
Perf // The table you’re querying  
| where ObjectName == "LogicalDisk" or // The object name used in Windows records
ObjectName == "Logical Disk" // The object name used in Linux records
| distinct CounterName // Lists distinct CounterName values
```

The result set of this query includes all performance counters collected for the `LogicalDisk` and `Logical Disk` objects:

:::image type="content" source="../media/kql-log-analytics-perf-table-countername.png" alt-text="Screenshot that shows the results of a query that lists the distinct names of the counters Azure Monitor collects for the LogicalDisk (written as one word) and Logical Disk (written as two words) objects." lightbox="../media/kql-log-analytics-perf-table-countername.png":::

The performance counters that provide information about used and free space are `% Used Space`, `% Free Space`, and `Free Megabytes`. We have two similar counters - `% Free Space` and `% Used Space` - collected from Windows and Linux records, respectively. 

Let's assess how we can use this data and which KQL operations can help extract and transform the data:

| Column | Description | Analysis goal | Related KQL operations |
| --- | --- | --- | --- |
| `TimeGenerated` | Indicates when the virtual machine generated each log. | Define the time scope of the analysis. | `where TimeGenerated > ago(1d)` <br/>For more information, see [ago()](/azure/data-explorer/kusto/query/agofunction), [where operator](/azure/data-explorer/kusto/query/whereoperator), and [Numerical operators](/azure/data-explorer/kusto/query/numoperators). |
| `Computer` | Computer from which the event was collected. | Associate CPU usage with a specific computer. | `summarize... by Computer` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator).|
| `ObjectName` | Holds the names of all of objects for which the table holds performance data. For your analysis, you're interested in the `LogicalDisk` and `Logical Disk` objects. | Monitor the logical disks in virtual machines. | `where ObjectName == "LogicalDisk" or ObjectName == "Logical Disk"`<br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `CounterName` | Holds the names of all performance counters in the table. | <ul><li>Monitor counters related to free space.</li><li>Rename `% Used Space` to `% Free Space` (in parallel, convert the related `CounterValue`)</li></ul>. | `where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"`<br/>To simplify the results and facilitate further analysis:<ul><li>Change `% Used Space` to `% Free Space` (`CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName)`).</li><li> Change `Free Megabytes` to `OverallFreeSpaceInGB` (`CounterName= iff(CounterName=="Free Megabytes", "OverallFreeSpaceInGB", CounterName)`)</li></ul>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `InstanceName` | Lists the monitored instances of the monitored object. | Monitor all drives on the virtual machine. | `InstanceName == "_Total"` <br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator). |
| `CounterValue` | The measurement collected for the counter.  | Retrieve performance measurements for the `% Used Space`, `% Free Space`, and `Free Megabytes` performance counters.  | <ul><li>`CounterValue = iff(CounterName=="% Used Space", 100-CounterValue, CounterValue)`</li><li>`CounterValue = iff(CounterName=="Free Megabytes", (CounterValue)*0.001, CounterValue)`</li></ul>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
      
## 3. Write your query

1. Retrieve all logs generated in the past day that reported the `% Used Space`, `% Free Space`, and `Free Megabytes` performance counters for the `LogicalDisk` and `Logical Disk` objects:

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA32R3UoDMRCF7%252FsUhwVBoVB8gHqjVIT6g1a8lOlmuo1mkzKZbRV8eJNUlxaWXp9vvzl78sSyGv1gt2ZhLGzLt%252BxZSNngCtSE80tz0eePyw%252Bu9YFaxnSKah4aW5O7sfGzQhBMJlisGaFQ8BnrYhJZjzfrTdhFCNdBTBwNm7BXnfDMre%252B%252Best%252Fr%252BvQeWXpdTNhxj03tPxWjqXbMVKdoTAvG6p5IEcCXvPJPyA1mlmX8ohVgjW126ThgrTka0a9%252Fzji%252BPAYh2fGIG9w6B109D9156PmpK%252F0vghKrkJu88wqlrccYUgpDeLKk2ko3TSDaTNquPQl52DEZjx4ELZWtEuESXP%252FAsyG8IcBAgAA" target="_blank">Click to run query in Log Analytics demo environment</a>    

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to free space for all drives on a virtual machine  
    ```

    The result set of this query likely includes multiple records for each machine from which you collect performance counters related to free space.

    :::image type="content" source="../media/kql-log-analytics-perf-free-space.png" alt-text="Screenshot that shows the results of a query for logs generated in the past day that report on virtual machine free space." lightbox="../media/kql-log-analytics-perf-free-space.png":::

1. Filter for the last counter value collected for every counter reported by each virtual machine: 

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA32S3UoDMRCF732KQ0FoYaH4APVGqQj1B616Waab6Taan5Jkt6348E62dulC8XLnnJz5crLPHFYXP9iuOTDm2vIdOw6UWOEaVPnhlRp1%252BtPyk8v0SJYxmWAw85Uuydzq%252BDWADxiPMV8zfOuCy7Y6SpB2%252BNBO%252BW1E4NIHFS%252FOJ%252BEQ9U%252FOTLt616UcuW587RKHLm4amPHAFS33iWPL1rcMLtF6XjdU8hkdYnjLK%252F8MQjTVRvSIlZiT0G2kOB8suZJRHg5H9BcXOF1TgJzCae7ZjO5S9y6mrHRIi7lPZAbINC%252BcguaGIxQlkkJM%252B2TJt2wpG6UzqrjlJWOggs5270BodEi1OJTUDcjGWFtLQX8zKFQLS7th71cojvW8k6l5hOVeBnZTy6ToNdcjyySGYjpeDU0%252BLV%252FGyLsKbUZjKtedoR00HPYdoRVZO%252F4FivrG3KYCAAA%253D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to free space for all drives on a virtual disk  
    | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName // Retrieves the last counter value collected for each counter for every virtual machine
    ```

    You now have the last reported counter value for every free space-related counter of every machine.

    :::image type="content" source="../media/kql-log-analytics-perf-free-space-summarize.png" alt-text="Screenshot that shows the results of a query that filters for the last counter value collected for each counter every virtual machine." lightbox="../media/kql-log-analytics-perf-free-space-summarize.png":::

1. To facilitate analysis:

    1. Convert the `% Used Space` counter value to `% Free Space` (by subtracting the `% Used Space` value from 100%) and change the name of the `% Used Space` column to `% Free Space`: 

        <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA42R0U6DMBSG7%252FcUJyQmzKCDB8CLaVyWTGci6uVS4MDqoF3a4pjx4S0lI5Rturum5%252Bt3%252FnP6giIb%252FcBujQIhoiXOkKEgClO4A5JzN0jHXX0Zf2KinkmJEIbgLHhOE1I8ULlxgAuYTCBaI3BDAWuwSmoRZfBBWcp3EgQmXKRydNoEreoPz4Kyqu4sh1z3vGIKRad7FIjwhDmJ9wqlyWYjzhUY5nVLEjxRBw28NS1boGs0Z1IRlmCHrSKuSNEAsipLIug3AhH5qiS1a23TO3R4J0WFY4j3%252BqLcVvrG6zfXJqwVstTiIQSaZW6PMzP0InoQ%252BP5N%252F82g45G4neF%252Fr70rK%252Byx9HzawZ944Frxrv1b3w8uyXyR3Fl%252B6b0XRVMwwedsNj0bXgMbPXFoDn31IM8vQBDU1y0DAAA%253D" target="_blank">Click to run query in Log Analytics demo environment</a>
    
        ```kusto
        Perf
        | where TimeGenerated > ago(1d)
        | where ObjectName == "LogicalDisk" or // The object name used in Windows records
        ObjectName == "Logical Disk" // The object name used in Linux records
        | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
        | where InstanceName == "_Total"  // Retrieves data related to free space for all drives on a virtual disk  
        | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName // Retrieves the last counter value collected for each counter for every virtual machine
        | extend CounterValue = iff(CounterName=="% Used Space", 100-CounterValue, CounterValue) // Converts % Used Space to % Free Space
        | extend CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName) // Changes the column name from % Used Space to % Free Space
        ```

        The result set of this query presents the percentage of free space on Windows and Linux machines in the same way, which makes further analysis clearer and easier. 

        :::image type="content" source="../media/kql-log-analytics-perf-free-space-extend.png" alt-text="Screenshot that shows the results of a query that converts the Percentage Used Space counter value to Percentage Free Space." lightbox="../media/kql-log-analytics-perf-free-space-extend.png":::

    1. Convert `Free Megabytes` to Gigabytes (`Free Megabytes` value * 0.001 = Free Gigabytes) and relabel `Free Megabytes` to `OverallFreeSpaceInGB`:

        <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA42RXU%252BDMBSG7%252FcrTkhMmEEHPwAvpnFZMp2JqJdLgQOr0nbph2PGH29hGaFs6m57nj7v29MnlMXoG7ZrlAgJZThDjpJozOEGSCn8KB9382X6jpl%252BJAwhjsFbiJJmpLqj6sMDIWEygWSNIFoKeIMZZUWUwxvludgqkJgJmavRaRPsVX94FpSburMcet0KwzXKTncvEeEBS5LuNKq2m4t4F9AyzxuS4Yk5WOClidwDXdCcK014hh22SoQmVQMowxiR9AuByHLFSO072wwOCa%252BkMjiGdGcP2MbYk6Afbk1Ya%252BS5w0MMtCj8Hte%252BoVcxgCgMr%252Fp3BolH4v0b%252Fve6u3LKHkt%252Fbzv4kwB8p95leB2G0Tmdz5J7y0%252B796pqBm3xOZ9NB%252BV%252FADMcqLH7AgAA" target="_blank">Click to run query in Log Analytics demo environment</a>

        ```kusto
        Perf
        | where TimeGenerated > ago(1d)
        | where ObjectName == "LogicalDisk" or // The object name used in Windows records
        ObjectName == "Logical Disk" // The object name used in Linux records
        | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
        | where InstanceName == "_Total"  // Retrieves data related to free space for all drives on a virtual disk  
        | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName // Retrieves the last counter value collected for each counter for every virtual machine
        | extend CounterValue = iff(CounterName=="% Used Space", 100-CounterValue, CounterValue) // Converts % Used Space to % Free Space
        | extend CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName) // Changes the column name from % Used Space to % Free Space
        | extend CounterValue = iff(CounterName=="Free Megabytes", (CounterValue)*0.001, CounterValue) // Converts megabytes to gigabytes
        | extend CounterName= iff(CounterName=="Free Megabytes", "OverallFreeSpaceInGB", CounterName) // Changes the column name fromFree Megabytes to OverallFreeSpaceInGB
        ```

        You can now get a clear picture of the total free space on each machine in gigabytes and as a percentage of the machine's total memory.

        :::image type="content" source="../media/kql-log-analytics-perf-free-space-extend-free-megabytes.png" alt-text="Screenshot that shows the results of a query that converts the Free Megabytes column to Overall Free Space In Gigabytes." lightbox="../media/kql-log-analytics-perf-free-space-extend-free-megabytes.png":::

## Challenge: Bundle together free space statistics for each computer

The result set of our query so far includes two lines for each computer - one line shows the overall free space in Gigabytes and the other shows the percentage of free space available.

Can you create a dictionary that bundles these two free space statistics together for each virtual machine?

**Hint:** 

- Use the [bag_pack() function](/azure/data-explorer/kusto/query/packfunction) to create key-value pairs for each of the two performance counters.
- Use the [make_bag() aggregation function](/azure/data-explorer/kusto/query/make-bag-aggfunction) to bundle both key-value values for each computer.

**Solution:**

1. Group together `CounterName, CounterValue` key-value pairs:

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA42R0U6DMBSG7%252FcUJyQmzKCDB8CLaVyWTGci6uVS4MDqoF3a4pjx4S0lI5Rturum5%252Bt3%252FnP6giIb%252FcBujQIhoiXOkKEgClO4A5JzN0jHXX0Zf2KinkmJEIbgLHhOE1I8ULlxgAuYTCBaI3BDAWuwSmoRZfBBWcp3EgQmXKRydNoEreoPz4Kyqu4sh1z3vGIKRad7FIjwhDmJ9wqlyWYjzhUY5nVLEjxRBw28NS1boGs0Z1IRlmCHrSKuSNEAsipLIug3AhH5qiS1a23TO3R4J0WFY4j3%252BqLcVvrG6zfXJqwVstTiIQSaZW6PMzP0InoQ%252BP5N%252F82g45G4neF%252Fr70rK%252Byx9HzawZ944Frxrv1b3w8uyXyR3Fl%252B6b0XRVMwwedsNj0bXgMbPXFoDn31IM8vQBDU1y0DAAA%253D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to free space for all drives on a virtual disk  
    | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName // Retrieves the last counter value collected for each counter for every virtual machine
    | extend CounterValue = iff(CounterName=="% Used Space", 100-CounterValue, CounterValue) // Converts % Used Space to % Free Space
    | extend CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName) // Changes the column name from % Used Space to % Free Space
    | extend CounterValue = iff(CounterName=="Free Megabytes", (CounterValue)*0.001, CounterValue) // Converts megabytes to gigabytes
    | extend CounterName= iff(CounterName=="Free Megabytes", "OverallFreeSpaceInGB", CounterName) // Changes the column name fromFree Megabytes to OverallFreeSpaceInGB
    | extend packed = pack(CounterName, CounterValue) // Groups together CounterName-CounterValue key-value pairs
    ```

    Grouping together `CounterName, CounterValue` key-value pairs lets you create a dictionary of free space statistics for each computer in the next step. 

    :::image type="content" source="../media/kql-log-analytics-perf-free-space-extend-pack.png" alt-text="Screenshot that shows the results of a query that groups together Counter Name and Counter Value key-value pairs." lightbox="../media/kql-log-analytics-perf-free-space-extend-pack.png":::

1. Create a property-bag (dictionary), called SpaceStats, of all free space statistics collected for each machine, summarize by computer, and filter for machines with less than 50% free space:
    
    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA42SQU%252FCQBCF7%252FyKSROTYiqUgzfrQY2EBMUE1IMxZNoOZaXdJbtbAeOPd9uG0gVUbs3Om%252B%252B9mekTyVnrG1ZzkgQTllGfOEnUFMM1YCLcXtyu66PwgyL9iBlBEIAzFAmLML1jauGAkNDtwmROIEoV8EKWKwNiHF4Zj8VKgaRIyFi1jpOgQv3BGTKer2vKNtetyLkmWePuJRE8UILhRpMqs9kS5wxKzXiJER2pgxE8F5aVoDYacKWRR1TLphOhMS0EKs8ylOyLAGUyzXDtWtv0tg4vmObUhnBjHrJlbl68prkh0VoTjy09BMBmM7ehK2doRPSg5%252FsXzZ49xwNwNcP%252FXHtXVthD6O9p927igWvFO%252Fc7vt87JfNJcGf0afaepkWhDD7g%252FZtfwxvBwkwclB9N9GGe3ZlL7FijVqYxwwVNQ0zcCmXdt%252F57dh2dN3ur71cBXPo%252FdE%252FvKYwDAAA%253D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to free space for all drives on a virtual disk  
    | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName // Retrieves the last counter value collected for each counter for every virtual machine
    | extend CounterValue = iff(CounterName=="% Used Space", 100-CounterValue, CounterValue) // Converts % Used Space to % Free Space
    | extend CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName) // Changes the column name from % Used Space to % Free Space
    | extend CounterValue = iff(CounterName=="Free Megabytes", (CounterValue)*0.001, CounterValue) // Converts megabytes to gigabytes
    | extend CounterName= iff(CounterName=="Free Megabytes", "OverallFreeSpaceInGB", CounterName) // Changes the column name fromFree Megabytes to OverallFreeSpaceInGB
    | extend packed = pack(CounterName, CounterValue) // Groups together CounterName-CounterValue key-value pairs
    | summarize SpaceStats = make_bag(packed) by Computer // Summarizes free space statstics by computer
    | where SpaceStats.["% Free Space"]<= 50
    ```

    The result set of this query summarizes free space statistics by machine, which was the goal of your free space analysis!

    The last line of the query filters for machines with less that 50% free space. You might want to monitor or analyze more closely, or reconfigure them to ensure they don't run out of space.

    :::image type="content" source="../media/kql-log-analytics-perf-free-space-make-bag.png" alt-text="Screenshot that shows the results of a query that summarizes free space statistics by machine." lightbox="../media/kql-log-analytics-perf-free-space-make-bag.png":::
