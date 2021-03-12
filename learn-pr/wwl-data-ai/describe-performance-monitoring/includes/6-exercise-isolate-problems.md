You have been hired as a database administrator to identify performance related issues and provide viable solutions to resolve any issues found. You need to use the Azure portal to identify the performance issues and suggest methods to resolve them. 

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Review CPU utilization in Azure portal

1. From the Home screen, select the menu, and select **SQL databases**.

    :::image type="content" source="../media/sql-databases.png" alt-text="Screenshot showing selecting SQL databases.":::

1. Click on the **AdventureWorks** Azure SQL Database.

    :::image type="content" source="../media/adventureworks.png" alt-text="Screenshot showing selecting the Adventureworks database.":::

1. Select **Set server firewall**.

    :::image type="content" source="../media/firewall.png" alt-text="Screenshot showing selecting Set server firewall":::

1. Select **Add client IP** and select **Save**.

    :::image type="content" source="../media/client-ip.png" alt-text="Screenshot showing selecting Add client IP":::

1. Select **OK**.

1. In the navigation above **Firewall settings**, select the link that begins with **AdventureWorks**.

    :::image type="content" source="../media/firewall-adventureworks.png" alt-text="Screenshot showing selecting AdventureWorks.":::

1. In the left navigation, select **Query editor (preview)**.

    :::image type="content" source="../media/select-query-editor.png" alt-text="Screenshot showing selecting the query editor (preview) link.":::

    > [!NOTE]
    > Please note that this feature is in preview.

1. In **Password**, type **Pa55w.rd** and select **OK**.

1. In **Query 1**, type the following query and select **Run**:

    ```sql
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

    :::image type="content" source="../media/query-1.png" alt-text="Screenshot showing the Query.":::

    > [!NOTE]
    > If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Monitor Resources\exercise_steps.sql** file.

1. Wait for the query to complete.
1. Locate the **Metrics** icon on the **Monitoring** section of the blade for the AdventureWorks database.

    :::image type="content" source="../media/metrics.png" alt-text="Screenshot showing selecting the Metrics icon.":::

1. Change the **Metric** menu option to reflect **CPU Percentage**.

    :::image type="content" source="../media/cpu-percentage.png" alt-text="Screenshot showing CPU Percentage.":::

1. Select an **Aggregation** of **Avg**. This will display the average CPU Percentage for the given time frame.

    :::image type="content" source="../media/average-cpu-graph.png" alt-text="Screenshot showing average aggregation.":::

## Identify high CPU consuming queries

1. Locate the **Query Performance Insight** icon on the **Intelligent Performance** section of the blade for the AdventureWorks database.
1. Select **Reset settings**.

    :::image type="content" source="../media/reset-settings.png" alt-text="Reset settings":::

1. Click on the query in the grid below the graph. If you do not see a query, wait for 2 minutes and select **Refresh**.

Notice that you can find details of the performance metrics for each query.

:::image type="content" source="../media/intelligent-performance.png" alt-text="Intelligent Performance":::

For this query, you can see that the total duration was over 20 seconds and that it ran approximately 10,000 times.

To finish this exercise select **Done** below.
