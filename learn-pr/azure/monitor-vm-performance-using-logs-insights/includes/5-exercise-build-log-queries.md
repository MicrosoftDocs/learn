
In the previous units, recall that you need to explore Azure native monitoring tools for workloads being deployed in Azure, along with figuring out a way to track the data being reported for each deployed Azure resource. To further your knowledge, you'll need to know how to use, adjust, and create log queries.

In this unit, you'll:

1. Take an existing query, load the query into the editor, and run the query to see results.
1. Adjust the existing query and analyze the results.

## Build a query using the query pane

1. Data collecting in a Log Analytics workspace from Azure resources may take some time to populate. You can either use the Log Analytics workspace you provisioned earlier in the module or open up browser and go to Microsoft's Log Analytics demo workspace (https://portal.loganalytics.io/demo) to run queries (note the unit focuses on using the demo Log Analytics workspace).

1. If you are reusing queries or storing them in source control, you will want to let an engineer or administrator know how to use the query. Commenting out helpful descriptors is done by using // before guiding someone on how to use the query.

    :::image type="content" source="../media/5-commenting-on-query.png" alt-text="Showcasing how to comment out text that helps guide engineers or administrators who may reuse the query.":::

1. The idea behind query writing is to never start from scratch. By using examples within Log Analytics workspaces, you will be able to achieve the results you are looking for to properly track and monitor your Azure resources over time.

1. Select **Queries** from the upper left of the **Logs** resource, which displays an overlay pane of information about all pre-populated queries any engineer or admin could run. Additionally, there are two links at the top: the community GitHub repo and a link to Microsoft's documentation.

    :::image type="content" source="../media/5-queries-pane.png" alt-text="Screen shot of the queries pane that showcases where both the GitHub repo and documentation links exist.":::

1. Ensure you remove the **Log Analytics workspaces** filter at the top and focus on Virtual Machines on the far left, underneath **All Queries**.

1. Focus on the **Virtual Machine free disk space** query.

1. When you hover over **Run**, another box to the left of Run displays, stating you could **Load to the editor**.

1. The basic difference is **Run** will run the query as is and **Load to the editor** will load the query into the editor for additional tweaks.

1. Select **Load to the editor**.

1. Examine the query in the editor, take note of the comments that indicate what the query displays, and then select **Run**.

    :::image type="content" source="../media/5-initial-free-disk-query.png" alt-text="Screen shot of the free disk query plus the comments on what it will display.":::

1. Based upon the results within the Log Analytics demo, you should see a number of records displayed, each record highlighting: TimeGenerated [UTC], InstanceName, CounterValue, Computer, and ResourceId.

1. This query takes data from the Perf (short for performance) table and shows you a list of virtual machines reporting to the Log Analytics workspace, plus specific metadata about each resource like name, resource ID, the counter value, the instance name of the disks on each machine, and so on.

1. Accumulating this information regularly may make sense if you are trying to build a report of your environment over time related to disk space consumed.

## Adjust existing query and analyze results

1. As with a lot of query languages, there are a number of ways to represent your data inside a Log Analytics workspace.

1. Let's take the existing query we used from the query pane and edit a few pieces to obtain a better query for creating an alert.

1. Let's change the CounterName to **"% Free Space"**.

1. From there, change the query string that starts with **summarize arg_max** to be **summarize FreeSpace = min(CounterValue) by Computer, InstanceName**.

1. Afterward, make a carriage return in the editor and type in the following: **| where FreeSpace < 10**.

1. The last piece to type in surrounds using the sort feature. Type in **| sort by FreeSpace asc**, which sorts this in ascending order based upon the FreeSpace counter.

1. The query should look like what is shown within the next screen shot. Note, you may not see any data over a 24 hour period within the Log Analytics demo environment.

    :::image type="content" source="../media/5-adjusted-disk-space-query.png" alt-text="Adjusting disk space query to create an alert.":::

1. In order to create an alert rule, you would select **+ New alert rule** at the top of the query editor, to the right of **Run**.

1. You could also create a meaningful dashboard for a team to analyze by selecting **Pin to dashboard** as well.

1. This adjusted query takes data from the Perf table, analyzes the percentage of free space available, and reports back any servers that have less than 10% free space.