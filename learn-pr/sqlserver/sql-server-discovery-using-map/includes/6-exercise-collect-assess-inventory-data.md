As a new database administrator, you're planning an audit of all the SQL Server instances for your large law firm that has multiple branch offices. You want to familiarize yourself with the steps required to do an audit using the **Microsoft Assessment and Planning (MAP)** toolkit. Then explore the data returned by the audit created by the MAP tooling.

In this exercise, you'll add a new SQL Server to the database of servers that exist in the inventory database, scan the database landscape, and then assess the resulting audit data.

## Start the lab

Start by logging into the server:

1. Sign into the VM with a Microsoft account, or create a new account.
1. Click **Commands**, and then click **CTRL+ALT+DEL**, and login with the Administrator password: **Pa55w.rd**.

## Collect inventory data

Begin your analysis by using MAP to collect inventory data. Follow these steps:

1. Click **Start**, and then click **Microsoft Assessment and Planning Toolkit**
1. From the list of tabs on the left, click **Database**.
1. Click **Collect inventory data**.
1. In the Inventory and Assessment Wizard, in the **Inventory Scenarios** tab, under **Choose your scenario**, select **Windows Computers**, **SQL Server**, and **SQL Server with Database Details**, and then click **Next**.
1. In the **Discovery Methods** tab, clear the **Use Active Directory Domain Services (AD DS)** check, then select **Manually enter computer names and credentials**, and click **Next**.
1. In the **All Computers Credentials** tab, click **Create**.
1. In the **Account Entry** dialog box, in the **Account name** field, type `Administrator`. Enter the password `Pa55w.rd` into the **Password**, and **Confirm Password** fields.
1. Clear the **Validate credentials with the Domain Controller** check box, and in the Warning dialog box, click **OK**.
1. In the **Applies to** list, make sure **WMI**, **SQL Windows**, and **SQL Native** are selected.
1. Click **Save** to return to the Wizard, and then click **Next**.
1. In the **Credentials Order** tab, in the **Technology** list, click on each item to ensure it has a value in the **Credential** field, and then click **Next**.
1. In the **Enter Computers Manually** tab, click **Create**.
1. In the **Specify Computers and Credentials** dialog box, in the **Computer Name** field, type in the name `MIA-SQL`, and click **Add**.
1. Click **Use All Computers credential list**, and then click **Save** to return to the wizard.
1. Click **Next**.
1. In the **Summary** tab, click **Finish**.
1. The **Data Collection** window appears and gives a live count of machines inventoried, and count of collections remaining; after a few moments, the **Total machines discovered** count will show **1**.
1. The collection process may take 5-10 minutes to complete; when collection has finished, the **Assessment** process starts, and shows as **Running**.
1. When the **Assessment** shows as **Completed**, click **Close**.

<!-- TODO this is a painful thing to wait for over 10 minutes, is there a chance we could have a video here? https://channel9.msdn.com/Shows/Edge/Edge-Show-99-Assess-VM-Migration-to-Azure-with-MAP?ocid=player -->

## Assess SQL Server versions and editions

Now that data has been collected, you can use MAP to assess this inventory. To find out about the versions and editions of SQL Server in your organization, follow these steps:

1. In the **Database** tab, under **Scenarios**, click anywhere in the **SQL Server Discovery** box. This box is showing the count of servers for each edition.
1. In the **SQL Server Discovery** tab, under **SQL Server Versions**, hold your mouse over the pink section of the pie charts to see the pop-up details. The pop-up shows that 53 SQL Server 2012 instances were discovered, accounting for 23% of the total.

    > [!NOTE]
    > The server versions are represented in the pie chart in chronological order. This shows that less than 25% of the total 230 servers are SQL Server 2012 or above. If the organization you work for wants SQL Server 2012 as a minimum version for its servers, a lot of work is required to upgrade the versions below 2012.

    > [!IMPORTANT]
    > If the pie charts aren't showing scroll the window to refresh the diagrams.

1. Look at the **Developer and Free Editions** section at the bottom of the tab (you may need to scroll down). There are 107 instances that aren't production servers, so when planning your upgrades, you can optionally return to the Express and Desktop editions at a later date, and potentially ignore the Evaluation editions. Conversely you may want to upgrade certain development databases before upgrading the production version, to test your upgrade procedures.

## Assess SQL Server components

Next, examine which SQL Server services are present in your organization:

1. Look at the **SQL Server Components** chart. Instantly you can see that **Database Engine Services** is the dominant service, as you would expect to find in most setups. Notice that there's only one SQL Server R Services component in use. If this was your organization, it would suggest that data science hasn't yet been widely adopted across the business.
1. In the **Options** box in the top right-hand corner of the tab, click **Generate SQL Server Assessment Report**. The **Report Generation Status** dialog opens. When the report has been created, click **Close**.
1. Again, in the **Options** box in the top right-hand corner of the tab, click **Generate SQL Server Database Details Report**. The **Report Generation Status** dialog opens. When the report has been created, click **Close**.
1. A **File Explorer** window should open automatically to display the two new files. If not, click **Start**, and type **File Explorer**, and navigate to **C:\Users\Administrator\Documents\MAP\MapTrainingDatabase**.
1. Double-click on **SqlServerAssessment-MM-DD-YYYY-HHh-MMm-SSs.xls**; the file will be date and time stamped from when you generated it; leave the File Explorer window open.
1. When the file opens in Excel, take a look at the list of components in the **Summary** tab. Again, you'll see the single instance of SQL Server R Services listed.

## Drill into the Excel file

You can use Excel's filtering functionality to examine the data in more detail. Follow these steps:

1. Click the **DatabaseInstances** tab. On the **SQL Server Product Name** column header, click the filter, and unselect **Microsoft SQL Server 2012**, **Microsoft SQL Server 2014**, **Microsoft SQL Server 2016**, and **Microsoft SQL Server 2017**.
1. Click **OK**.
1. On the **SQL Server Edition** column header, click the filter, and unselect **Desktop Engine**, **Enterprise Evaluation**, and **Express**. Click **OK**. A list of production servers requiring an upgrade will be shown.
1. Click the **Components** tab. On the **SQL Server Component Name** column header, click the filter. Click **(Select All)**, to unselect all items, then click **SQL Server R Services**.
1. On the **File** menu, select **File**, click **Close**, then click **Don't Save** when asked if you want to save the file.

## Use Excel to assess SQL Server database inventory data

Finally, use Excel to investigate further database details, such as sizes and connection status:

1. In File Explorer, double-click **SqlServerDatabaseDetails-MM-DD-YYYY-HHh-MMm-SSs.xls**.
1. If a **Microsoft Office Activation** dialog box pops up, click **Close**.
1. On the **Overview** tab, notice the counts of database engines across the different versions. Look at the **Total SQL Server Databases that were Connected to Successfully** column, and see that the **SQL Server 2008** and **SQL Server 2008 R2** instances have the highest number of operational databases.
1. On the **SQLServerSummary** tab, on the **SQL Server Product Name** column header, click the filter, clear the **(Select All)** check box (to clear all items), select the **Microsoft SQL Server 2008**, and **Microsoft SQL Server 2008 R2** check boxes, and then click **OK**.
1. On the **DatabaseSummary** tab, on the **Database Size (MB)** column header, click on the filter, and then click **Sort Z to A** to order by the largest to smallest databases.
1. On the **DBInstanceSummary** tab, scroll to the right to see the data collected in this category.
1. On the **SQL Connection Status** column header, click the filter, clear the **Success** check box, and then click **OK**, to show only servers that the toolkit failed to connect to.
1. On the **DBInstanceProperties** tab, on the **clr enabled** column header, click on the filter, clear the **(Select All)** check box, select the **1** check box, and then click **OK** to return only instances that have the Common Language Runtime (CLR) enabled.
1. On the **SQL Server Database Engine Instance Name** column header, click on the filter, clear the **MAPS**, and **MICROSOFTSCM** check boxes, and then click **OK**.
1. On the **DBUserDetails** tab, scroll to the right and notice the data gathered in this category.
1. On the **File** menu, click **Close**.
1. In the **Microsoft Excel** dialog box, click **Don't Save**.

## Summary

The MAP Toolkit automatically collects a vast array of data on the servers and databases in your landscape, and presents it in an easy to read format. The in-depth details of the inventory collection can be exported to Excel and filtered to enable you to find the servers or databases you want to upgrade. The granularity of data available in these assessment reports enables you to prioritize the order in which you upgrade your instances or databases.