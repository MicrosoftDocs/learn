Power BI is a powerful tool dedicated to data modeling, data analysis, and data visualization. As a final exercise, let's take a look at how to connect to the ASDW database from Power BI, then query the database to generate a modern dashboard with a few clicks.

> [!NOTE]
> If you don't have the Power BI tools for Windows installed, please go to [Power BI](https://powerbi.microsoft.com/) to download and install.

1. Start the Power BI tool. Click the **Get data** button on the left.

    ![Screenshot of Getting Data in Power BI](../media/5-get-data.png)

1. In the Get Data dialog, select the **Database** category, then select the **SQL Server database**, then click the **Connect** button.

    ![Screenshot of Getting Data in Power BI](../media/5-connect-sql-server-db.png)

1. In the SQL Server database dialog, fill in the ASDW server name and the sample database name. Then expand the **Advanced options** node, input the last T-SQL query into the **SQL statement** textbox. Then click the **OK** button.

    ![Screenshot of Configuration in Power BI](../media/5-configure.png)

1. You will be asked for the ASDW username and password. After filling in, click the **Connect** button.

    ![Screenshot of Connecting to ASDW in Power BI](../media/5-connect-asdw.png)

    Since we are trying to connect the ASDW with a SQL query, once the connection is established, the SQL query will be executed immediately. Then, you will see the query result as below:

    ![Screenshot of Observing query result in Power BI](../media/5-observe-query-result.png)

1. Click **Load** button, the data of the query result will be loaded to the data model maintained by Power BI.

1. After the query result is loaded to the Power BI model, the Power BI data model is generated from the schema of the query result. To review the data model, click the **Data** button on the left side.

    ![Screenshot of Reviewing data model in Power BI](../media/5-review-data-model.png)

1. Click the **Report** button and switch back to the dashboard view. Click the pie chart icon of and vertical bar chart. This will insert two empty charts into the dashboard. Adjust the size and position of the empty charts until it looks good.

    ![Screenshot of Report in Power BI](../media/5-report.png)

1. Then, select each empty chart, and check ResellerName and Sales checkbox in the **FIELDS** panel for the chart.

    ![Screenshot of Chart Visualization in Power BI](../media/5-chart.png)

Congratulations! You now have a modern dashboard which is visualizing the query result from an Azure SQL Data Warehouse database!