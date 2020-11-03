You have been hired as a database administrator to identify performance related issues and provide viable solutions to resolve any issues found. You need to use the Azure portal to identify the performance issues and suggest methods to resolve them. 

## Review CPU utilization in Azure Portal

1. When the VM lab environment opens, select the Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the password field.

1. From the Home screen, select the menu, and select **SQL databases**.

    :::image type="content" source="../media/sql-databases.png" alt-text="SQL databases":::

1. Click on the **AdventureWorks** Azure SQL Database.

    :::image type="content" source="../media/adventureworks.png" alt-text="Adventureworks":::

1. Select **Set server firewall**.

    :::image type="content" source="../media/firewall.png" alt-text="Set server firewall":::

1. Select **Add client IP** and select **Save**.

    :::image type="content" source="../media/clientip.png" alt-text="Add client IP":::

1. Select **OK**.
1. Select **AdventureWorks**.

    :::image type="content" source="../media/firewalladventureworks.png" alt-text="AdventureWorks":::

1. Select **Query editor**.
1. In **Password**, type **Pa55w.rd** and select **OK**.
1. In **Query 1**, type the following query and select **Run**:

   ```tsql
   DECLARE @Counter INT 
    SET @Counter=1
    WHILE ( @Counter <= 10000)
    BEGIN
        SELECT AVG(UnitPrice)
	    FROM SalesLT.SalesOrderDetail
	    GROUP BY ModifiedDate
        SET @Counter  = @Counter  + 1
    END
   ``` 

    :::image type="content" source="../media/query1.png" alt-text="Query":::

1. Wait for the query to complete.
1. Locate the **Metrics** icon on the **Monitoring** section of the blade for the AdventureWorks database.
    
    :::image type="content" source="../media/metrics.png" alt-text="Metrics icon":::

1. Change the **Metric** menu option to reflect **CPU Percentage**.

    :::image type="content" source="../media/cpu-percentage.png" alt-text="CPU Percentage":::

1. Select an **Aggregation** of **Avg**. This will display the average CPU Percentage for the given time frame.
1. Now adjust the **Aggregation** to **Max** to identify the maximum CPU Percentage used for the give time frame. Notice any difference from the average.

## Identify high CPU consuming queries

1. Locate the **Query Performance Insight** icon on the **Intelligent Performance** section of the blade for the AdventureWorks database.
1. Select **Reset settings**.

    :::image type="content" source="../media/resetsettings.png" alt-text="Reset settings":::

1. Click on the first query in grid below the graph.
1. Notice that you can find details of the performance metrics for each query.
 