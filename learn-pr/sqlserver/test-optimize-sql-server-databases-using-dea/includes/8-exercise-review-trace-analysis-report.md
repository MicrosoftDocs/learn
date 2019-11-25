You've completed the first phase of your staged upgrade of CRM databases to SQL Server 2017. Before going live, you need to check that the upgrade hasn't negatively affected on database performance.

In this exercise, you'll use the Microsoft Database Experimentation Assistant (DEA) to create a trace analysis report; you'll then review this report to identify any critical issues that must be addressed before the upgraded database can be deployed to a production environment.

## Start the lab

Start by logging into the database server:

1. Sign into the VM with a Microsoft account, or create a new account.
1. Click **Commands**, and then click **CTRL+ALT+DEL**, and login with the Administrator password: **Pa55w.rd**

## Generate the analysis report

Start by using DEA to analyze the trace performances against Target 1 and Target 2.

1. Click **Start**, and then type **Database Experimentation Assistant**.
1. When DEA has opened, click **Analyze traces**. Then in the **Server name** field type `localhost`, and leave **Authentication** selection as **Windows Authentication**. Click **Connect**.
1. Click **+ New analysis report**. This opens the **Report information** screen.
1. In the **Report name** field, type `AdventureWorksUpgrade` and then in the list **Storage location for Target 1 traces**, select **Local**.
1. In the **Trace for Target 1 SQL Server** field, click the **...**, and browse to **C:\\replay**. Select the last file prefixed **ReplayTarget1...**.
1. In the list **Storage location for Target 2 traces**, select **Local**.
1. In the **Trace for Target 2 SQL Server** field, click the **...**, and browse to **C:\\replay**. Select the last file prefixed **ReplayTarget2...**.
1. Click **Start**.

## View the analysis report

1. When the report is complete, it appears in the list.
1. Click **AdventureWorksUpgrade** to view the report.
1. Note the name of the Target 1 and Target 2 servers listed in the report, including the SQL Server version. View how the slices of the pie charts are categorized.
1. Select a new value from the **Threshold** list, and see if this changes the distribution of the slices.
1. Click on the slices of the pie chart to see the performance metrics for the category.
1. Select a couple of the queries to compare the statistics between Target 1 and Target 2, and then click the **Query Plan Information** tab to see the plans used.

## Summary

In this exercise, you generated an analysis report in the Database Migration Assistant to compare the result of your A/B test. You tested a number of queries to see how they performed on the Target 1 database. Target 1 was an exact copy of the source database and SQL Server 2008. Then you compared these results with the same queries run on the Target 2 database that had been upgraded to SQL Server 2017. You saw how to change the threshold to make the results more or less sensitive.