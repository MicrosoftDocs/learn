You've completed the first phase of your staged upgrade of CRM databases to SQL Server 2019. Before going live, you need to check that the upgrade hasn't negatively affected database performance.

In this exercise, you'll use the Microsoft Database Experimentation Assistant (DEA) to create a trace analysis report. You'll then review this report to identify any critical issues that must be addressed before the upgraded database is deployed to a production environment.

## Generate the analysis report

Start by using DEA to analyze the trace performances against Target 1 and Target 2.

1. Select **Analysis Reports** on the left menu. Then in the **Server name** field, type `localhost`, and leave **Authentication** selection as **Windows Authentication**. Click **Connect**.
1. Click **+ New analysis report**. This action opens the **Report information** screen.
1. In the **Report name** field, type `AdventureWorksUpgrade`, and then in the **Storage location for Target 1 traces** list, select **Local**.
1. In the **Trace for Target 1 SQL Server** field, select the **...**, and browse to **C:\\replay**.
1. Change the file type from **SQL Trace Files (\*.trc) to** **Extended Event Files (\*.xel)**.
1. Select the last file prefixed **ReplayTarget1...**.
1. In the **Storage location for Target 2 traces** list, select **Local**.
1. In the **Trace for Target 2 SQL Server** field, select the **...**, and browse to **C:\\replay**.
1. Change the file type from **SQL Trace Files (\*.trc) to** **Extended Event Files (\*.xel)**.
1. Select the last file prefixed **ReplayTarget2...**.
1. Click **Start**.

## View the analysis report

1. When the report is complete, it appears in the list.
1. Click **AdventureWorksUpgrade** to view the report.
1. Note the name of the Target 1 and Target 2 servers listed in the report, including the SQL Server version. View how the slices of the pie charts are categorized.
1. Select a new value from the **Threshold** list, and see if this action changes the distribution of the slices.
1. Click the slices of the pie chart to see the performance metrics for the category.
1. Select a couple of the queries to compare the statistics between Target 1 and Target 2, then select the **Query Plan Information** tab to see the plans used.