
In the previous units, recall that you need to explore Azure native monitoring tools for workloads being deployed in Azure, along with figuring out a way to track the data being reported for each deployed Azure resource. To further your knowledge, you'll need to know how to use, adjust, and create log queries.

In this unit, you'll:

1. Take an existing query, load the query into the editor, and run the query to see results.
1. Adjust an existing query and analyze the results.
1. Take a simple query, add a tabular operator, and showcase how to display filtered results.

## Build a query using the query pane

1. Data collecting in a Log Analytics workspace from Azure resources may take some time to populate. You can either use the Log Analytics workspace you provisioned earlier in the module or open up browser and go to Microsoft's Log Analytics demo workspace: https://portal.loganalytics.io/demo to run queries (note the unit focuses on using the demo Log Analytics workspace).

1. If you are reusing queries or storing them in source control, you will want to let an engineer or administrator know how to use the query. Commenting out helpful descriptors is done by using // before guiding someone on how to use the query.

    :::image type="icon" source="../media/5-commenting-on-query.png" border="false" alt-text="Showcasing how to comment out text that helps guide engineers or administrators who may reuse the query.":::

1. The idea behind query writing is to never start from scratch. By using examples within Log Analytics workspaces, you will be able to achieve the results you are looking for to properly track and monitor your Azure resources over time.

1. Select **Queries** from the upper left of the **Logs** resource, which displays an overlay pane of information about all pre-populated queries any engineer or admin could run. Additionally, there are two links at the top: the community GitHub repo and a link to Microsoft's documentation.

    :::image type="icon" source="../media/5-queries-pane.png" border="false" alt-text="Screen shot of the queries pane that showcases where both the GitHub repo and documentation links exist.":::

1. Ensure you remove the **Log Analytics workspaces** filter at the top and focus on Virtual Machines on the far left, underneath **All Queries**.

1. Focus on the **Virtual Machine free disk space** query.

1. When you hover over **Run**, another box to the left of Run displays, stating you could **Load to the editor**.

1. The basic difference is **Run** will run the query as is and Load to the editor** will load the query into the editor for additional tweaks.

1. Select **Load to the editor**.

1. Examine the query in the editor, take note of the comments that indicate what the query displays and how to create an alert, and then select **Run**.

    :::image type="icon" source="../media/5-initial-free-disk-query.png" border="false" alt-text="Screen shot of the free disk query plus the comments on what it will display.":::

1. Based upon the results within the Log Analytics demo, you should see a number of records displayed, each record highlighting: TimeGenerated [UTC], InstanceName, CounterValue, Computer, and ResourceId.

## Adjust existing query and analyze results

1. Focus on all primary operators the learner will predominantly use to find information: search, where, take, count, summarize, extend, project, distinct, and top.

1. Build queries off of Heartbeat and Insights tables for Azure IaaS VMs reporting to demo workspace.

