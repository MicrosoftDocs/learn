As a new database administrator, you're planning an audit of all the SQL Server instances for your large law firm that has multiple branch offices. You want to familiarize yourself with the steps required to do an audit using the **Microsoft Assessment and Planning (MAP)** toolkit. You'll then explore the data returned by the audit that MAP tooling creates.

In this exercise, you'll add a new SQL Server to the database of servers that exist in the inventory database. You'll then scan the database landscape, and assess the resulting audit data.

## Enter the collect inventory data settings

Begin your analysis by using MAP to collect inventory data. Follow these steps:

1. From the list of tabs on the left, select **Database**.
1. Select **Collect inventory data**.
1. In the **Inventory and Assessment Wizard**, in the **Inventory Scenarios** tab, under **Choose your scenario**, select **Windows Computers**, **SQL Server**, and **SQL Server with Database Details**, then select **Next**.
1. In the **Discovery Methods** tab, clear the **Use Active Directory Domain Services (AD DS)** check box, then select **Manually enter computer names and credentials**, and select **Next**.
1. In the **All Computers Credentials** tab, select **Create**.
1. In the **Account Entry** dialog box, in the **Account name** field, type `azureadmin`. Enter the password you saved earlier into the **Password**, and **Confirm Password** fields.
1. Clear the **Validate credentials with the Domain Controller** check box, and in the **Warning** dialog box, select **OK**.
1. In the **Applies to** list, make sure **WMI**, **SQL Windows**, and **SQL Native** are selected.
1. Select **Save** to return to the wizard, then select **Next**.
1. In the **Credentials Order** tab, in the **Technology** list, select each item to ensure it has a value in the **Credentials** field, then select **Next**.
1. In the **Enter Computers Manually** tab, select **Create**.
1. In the **Specify Computers and Credentials** dialog box, in the **Computer Name** field, type the name `ReportingServer`, and select **Add**.
1. Select **Use All Computers credential list**, then select **Save** to return to the wizard.
1. Select **Next**.
1. In the **Summary** tab, select **Finish**.

## Watch the assessment run

1. The **Data Collection** window appears and gives a live count of machines inventoried, and count of collections remaining. After a few moments, the **Total machines discovered** count will show **1**.
1. Expand the **Details** under **Assessment**. The section shows the details of the assessment. You can watch the details being completed as the assessment runs.
1. The collection process might take five minutes to complete. When collection has finished, the **Assessment** process starts, and shows as **Running**.
1. When the **Assessment** shows as **Completed**, select **Close**.

## Assess SQL Server versions and editions

Now that data has been collected, you can use MAP to assess this inventory. To find out about the versions and editions of SQL Server in your organization, follow these steps:

1. In the **Database** tab, under **Scenarios**, click anywhere in the **SQL Server Discovery** box. This box shows the count of servers for each edition.
1. In the **SQL Server Discovery** tab, under **SQL Server Versions**, hold your mouse over the pink section of the pie charts to see the pop-up details. The pop-up shows that 53 SQL Server 2012 instances were discovered, accounting for 22% of the total.

    > [!NOTE]
    > The server versions are represented in the pie chart in chronological order. This shows that less than 25% of the total 230 servers are SQL Server 2012 or above. If the organization for which you work wants SQL Server 2012 as a minimum version for its servers, a lot of work is required to upgrade the versions below 2012.

    > [!IMPORTANT]
    > If the pie charts aren't showing, scroll the window to refresh the diagrams.

1. Look at the **Developer and Free Editions** section at the bottom of the tab (you might need to scroll down). Of the instances, 110 aren't production servers, so when you're planning upgrades, you can optionally return to the Express and Desktop editions later and potentially ignore the Evaluation edition. Or, you might want to upgrade certain development databases before upgrading the production version to test your procedures.

## Assess SQL Server components

Next, examine which SQL Server services are present in your organization:

1. Look at the **SQL Server Components** chart. You'll instantly see that **Database Engine Services** is the dominant service, as you'd expect to find in most setups. Notice that there's six SQL Server R Services components in use. If this was your organization's chart, that suggests that data science hasn't yet been widely adopted across the business.
1. In the **Options** box in the top-right corner of the tab, select **Generate SQL Server Assessment Report**. The **Report Generation Status** dialog opens. When the report has been created, select **Close**.
1. Again, in the **Options** box in the top-right corner of the tab, select **Generate SQL Server Database Details Report**. The **Report Generation Status** dialog opens. When the report has been created, select **Close**.
1. A **File Explorer** window should open automatically to display the two new files. If not, select **Start**, type **File Explorer**, and go to **C:\Users\azureadmin\Documents\MAP\MapTrainingDatabase**.
1. Double-click **SqlServerAssessment-MM-DD-YYYY-HHh-MMm-SSs.xls**. The file will be date and time stamped from when you generated it. Leave the File Explorer window open.
1. When the file opens in Excel, look at the list of components in the **Summary** tab. Again, you'll see the six instances of SQL Server R Services listed.

## Drill into the Excel file

If you have an Office account, use Excel's filtering functionality to examine the data in more detail. You can browse the data, or sign in with your credentials and follow these steps:

1. Select the **DatabaseInstances** tab. On the **SQL Server Product Name** column header, select the filter, and clear **Microsoft SQL Server 2012**, **Microsoft SQL Server 2014**, **Microsoft SQL Server 2016**, and **Microsoft SQL Server 2017**.
1. Select **OK**.
1. On the **SQL Server Edition** column header, select the filter and clear **Desktop Engine**, **Enterprise Evaluation**, and **Express**. Select **OK**. A list of production servers requiring an upgrade will be shown.
1. Select the **Components** tab. On the **SQL Server Component Name** column header, select the filter. Select **(Select All)** to clear all items, then select **SQL Server R Services**.
1. On the **File** menu, select **File**, select **Close**, then select **Don't Save** when asked if you want to save the file.

## Use Excel to assess SQL Server database inventory data

Finally, use Excel to investigate further database details, such as sizes and connection status:

1. In File Explorer, double-click **SqlServerDatabaseDetails-MM-DD-YYYY-HHh-MMm-SSs.xls**.
1. On the **Overview** tab, notice the counts of database engines across the different versions. Look at the **Total SQL Server Databases that were Connected to Successfully** column. You'll notice that the **SQL Server 2008** and **SQL Server 2008 R2** instances have the highest number of operational databases.
1. On the **SQLServerSummary** tab, on the **SQL Server Product Name** column header, select the filter, clear the **(Select All)** check box (to clear all items), select the **Microsoft SQL Server 2008**, and **Microsoft SQL Server 2008 R2** check boxes, then select **OK**.
1. On the **DatabaseSummary** tab, on the **Database Size (MB)** column header, select the filter, then select **Sort Z to A** to order by the largest to smallest databases.
1. On the **DBInstanceSummary** tab, scroll to the right to see the data collected in this category.
1. On the **SQL Connection Status** column header, select the filter, clear the **Success** check box, then select **OK** to show only servers to which the toolkit failed to connect.
1. On the **DBInstanceProperties** tab, on the **clr enabled** column header, select the filter, clear the **(Select All)** check box, select the **1** check box, then select **OK** to return only instances that have the Common Language Runtime (CLR) enabled.
1. On the **SQL Server Database Engine Instance Name** column header, select the filter, clear the **MAPS**, and **MICROSOFTSCM** check boxes, then select **OK**.
1. On the **DBUserDetails** tab, scroll to the right and notice the data gathered in this category.
1. On the **File** menu, select **Close**.
1. In the **Microsoft Excel** dialog box, select **Don't Save**.

The MAP toolkit automatically collects a vast array of data on the servers and databases in your landscape, and presents it in an easy to read format. The in-depth details of the inventory collection can be exported to Excel and filtered, so you'll find the servers or databases you want to upgrade. The granularity of data available in these assessment reports enables you to prioritize the order in which you upgrade your instances or databases.
