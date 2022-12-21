In this exercise, we're going to take things one step further. Instead of just having visualizations that show data from some data sources, we're going to add visuals that combine data from these sources to let you correlate the data and analyze your system.

We're going to create graphs to show the requests, CPU time, and request unit consumption in the web app and the Cosmos DB. The graph uses combined metrics from the web application and the database.

We're going to combine data using Log Analytics queries that get data from these sources:

- the Web app
- the Cosmos DB
- the Log Analytics workspace

Then we'll add a metric that monitors the application.

## Generate some data for this exercise

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. On the **Home** page, select **Resource groups**, or search for "Resource groups" in the search bar at the top of the page.
1. Select the "learn" resource group created when the sandbox was activated.
1. Look through the list of resources and select the App Service.

    :::image type="content" source="../media/7-portal-select-app-service.png" alt-text="Screenshot of selecting the App Service from the resource group.":::

1. On the top toolbar, select **Browse**.

    :::image type="content" source="../media/7-portal-browse-app-service.png" alt-text="Screenshot of the browser button from the App Service page.":::

1. Populate the app service with some activities to generate some data for our example. On the **List of To-Do Items** page, create some items, edit them, or mark some as complete.

    :::image type="content" source="../media/7-app-service-tasks.png" alt-text="Screenshot that shows tasks for the app service for workbooks learn module.":::

## Add graphs to compare the volume of requests

We're going to generate two graphs to place side by side to compare the number of requests sent to the web app and to the Cosmos DB.

In your workbook, select **Edit** from the top toolbar.

1. Select **Add**, and then select **Add parameters**.
1. Select **Add parameter** to add a new parameter.

    - In the **Parameter name** field, enter **WebApps**.
    - In the **Parameter type** field, select **Resource picker**.
    - Select the **Required** checkbox.
    - In the **Get data from** section, select **Query**.
    - In the **Subscriptions Log query** section:

        - In the **Data source** field, select **Azure resource graph**.
        - In the **Resource type** field, select **Subscription**.
        - In the **Subscriptions** field, select the **Subscription** resource parameter.
        - Enter the following query, and then select **Run Query**.

            ```azurecli
            resources 
            | where type == "microsoft.web/sites" 
            | project id
            ```

     :::image type="content" source="../media/7-web-app-parameter.png" alt-text="Screenshot that shows the web app parameter in a workbook.":::

    - Select **Save**.
1. In the same **Add parameter** section, select **Add parameter** again.

    :::image type="content" source="../media/7-add-additional-parameter.png" alt-text="Screenshot that shows adding a second parameter to an existing parameter control in Azure workbooks.":::

    - In the **Parameter name** field, enter **CosmosDB**.
    - In the **Parameter type** field, select **Resource picker**.
    - Select the **Required** checkbox.
    - In the **Get data from** section, select **Query**.
    - In the **Subscriptions Log query** section:

        - In the **Data source** field, select **Azure resource graph**.
        - In the **Resource type** field, select **Subscription**.
        - In the **Subscriptions** field, select the **Subscription** resource parameter.
        - Enter the following query, and then select **Run Query**.

            ```azurecli
            resources 
            | where type == "microsoft.documentdb/databaseaccounts" 
            | project id
            ```

    - Select **Save**.

1. In the same **Add parameter** section, select **Add parameter** again.

    - In the **Parameter name** field, enter **LogAnalytics**.
    - In the **Parameter type** field, select **Resource picker**.
    - Select the **Required** checkbox.
    - In the **Get data from** section, select **Query**.
    - In the **Subscriptions Log query** section:

        - In the **Data source** field, select **Azure resource graph**.
        - In the **Resource type** field, select **Subscription**.
        - In the **Subscriptions** field, select the **Subscription** resource parameter.
        - Enter the following query, and then select **Run Query**.

            ```azurecli
            resources 
            | where type == "microsoft.operationalinsights/workspaces"
            | project id
            ```

    - Select **Save**.
1. In the same **Add parameter** section, select **Add parameter** again.

    - In the **Parameter name** field, enter **TimeRange**.
    - In the **Parameter type** field, select **Time range picker**.
    - Select the **Required** checkbox.
    - In the **Available time ranges** field, make sure all the values are selected.
    - Select **Save**.
1. Select **Done editing**. Your workbook now has a parameter control with four parameters. When you select the first parameter, the list in each consecutive drop down is populated based on your selection.

    :::image type="content" source="../media/7-multiple-parameters.png" alt-text="Screenshot that shows multiple parameters in one control in Azure workbooks.":::

1. Select **Edit** next to the parameter control we just added, and then select **Add** and **Add metric**.
1. Enter these settings for the metric:

    - In the **Resource Type** field, select **App Service**.
    - In the **App Service** field, select the **WebApp** parameter.
    - In the **Time Range** field, select the **TimeRange** parameter.

        :::image type="content" source="../media/7-web-app-metric-settings.png" alt-text="Screenshot that shows the metric settings for a web app in Azure Workbooks.":::

1. Select **Add metric**, and enter these settings:

    - In the Namespace field, select **App Service standard metrics**.
    - In the Metrics field, select **Requests**.
    - In the Aggregation field, select **Count**.
    - Select **Save**.

        :::image type="content" source="../media/7-web-app-request-metric.png" alt-text="Screenshot that shows the metric settings for the number of requests made to a web app in Azure Workbooks.":::

1. To make sure that the graphs display side by side, select **Style** on the top of the window, and then select the **Make this item a custom width** checkbox. Make sure that the **Percent width** is set to 50%.
1. Select **Advanced settings**, and enter a name for the chart in the **Chart title** field, such as "Web app number of requests".
1. Select **Done editing**. You now have a graph displaying the number of requests sent to your web app.

    :::image type="content" source="../media/7-one-chart-requests.png" alt-text="Screenshot that shows one graph in an Azure Workbook.":::

1. Select **Add** and **Add metric**.
1. Enter these settings for the metric:

    - In the **Resource Type** field, select **Azure Cosmos DB account**.
    - In the **App Service** field, select the **CosmosDB** parameter.
    - In the **Time Range** field, select the **TimeRange** parameter.
1. Select **Add metric**, and enter these settings:

    - In the Namespace field, select **Azure Cosmos DB account standard metrics**.
    - In the Metrics field, select **Total Requests**.
    - In the Aggregation field, select **Count**.
    - Select **Save**.
1. To make sure that the graphs display side by side, select **Style** on the top of the window, and then select the **Make this item a custom width** checkbox. Make sure that the **Percent width** is set to 50%.
1. Select **Advanced settings**, and enter a name for the chart in the **Chart title** field, such as "Cosmos DB total requests".
1. Select **Done editing**. You now have two side by side graphs displaying the number of requests sent to your web app and your database.

    :::image type="content" source="../media/7-two-charts-requests.png" alt-text="Screenshot that shows two graphs in an Azure Workbook.":::

## Add graphs to compare the volume of operations

We're going to use Log Analytics queries to generate two graphs that we'll place side by side to compare the number and types of requests sent to the web app and to the Cosmos DB.

In your workbook, select **Edit** from the top toolbar.

1. Add a query for the number of requests per operation. Select **Add**, and then select **Add query**.

    - In the **Data source** field, select **Logs**.
    - In the **Resource type** field, select **Log Analytics**.
    - In the **Log Analytics workspace** field, select the **Log Analytics** parameter.
    - In the **Time Range** field, select the **TimeRange** parameter.
    - Enter this Log query:

        ```azurecli
          AppRequests
        | summarize RequestsCount=sum(ItemCount) by OperationName, _ResourceId
        | order by RequestsCount desc
        ```

        :::image type="content" source="../media/7-operations-request-query.png" alt-text="Screenshot that shows a query in an Azure Workbooks.":::

1. We're going to use the rendering settings to make the chart easy to understand visually.
1. Select **Column settings**, and then in the **Columns** section on the left, select **Operation Name**, and then enter these settings.

    - In the **Column name** field, enter (or leave the default name) "OperationName".
    - In the **Column renderer** field, select **Thresholds**.
    - In the **Thresholds** section, select **Colors**, and then add these thresholds:

        |Operator  |Value  | Color | Text|
        |---------|---------|---------|---------|
        |contains    |  Create     | Orange | {0}{1}|
        |contains    |  Delete     | Red (Bright) | {0}{1}|
        |contains    |  Edit     | Blue (Light) | {0}{1}|
        |Default    |       | Green | {0}{1}|

        :::image type="content" source="../media/7-column-color-settings.png" alt-text="Screenshot that shows setting the colors in a grid in Azure Workbooks.":::

1. In the **Columns** section on the left, select **_ResourceId**, and then in the **Column renderer** field, select **Hidden**.
1. In the **Columns** section on the left, select **ResourceCount**, and then enter these settings:

    - In the **Column name** field, enter (or leave the default name) "RequestCount".
    - In the **Column renderer** field, select **Bar**.
    - In the **Color palette** section, select **Blue**.**
    - Select **Save and Close**.
1. To make sure that the graphs display side by side, select **Style** on the top of the window, and then select the **Make this item a custom width** checkbox. Make sure that the **Percent width** is set to 50%.
1. Select **Advanced settings**, and enter a name for the chart in the **Chart title** field, such as "Web App Operations".
1. Select **Done editing**. Your workbook now has a color-coded graph showing the types of operations sent to your web app and the number of each type of request.

    :::image type="content" source="../media/7-web-app-operations-chart.png" alt-text="Screenshot that shows a bar chart with the number of requests per operation for a web app.":::

1. Now we're going to add a visualization for the number of requests for the Cosmos DB. 
1. Select **Edit** next to the parameter control we just added, and then select **Add** and **Add metric**.
1. Enter these settings for the metric:

    - In the **Resource Type** field, select **Azure Cosmos DB account**.
    - In the **App Service** field, select the **CosmosDB** parameter.
    - In the **Time Range** field, select the **TimeRange** parameter.
    - In the **Visualization** field, select **Grid**.
1. Select **Add metric**, and enter these settings:

    - In the Namespace field, select **Azure Cosmos DB account standard metrics**.
    - In the Metrics field, select **Total Requests**.
    - In the Aggregation field, select **Count**.
    - In the **Split** field, select **None**.
    - Select **Save**.

        :::image type="content" source="../media/7-cosmos-db-metric-grid-settings1.png" alt-text="Screenshot that shows a query in an Azure Workbooks.":::

1. Add another metric. Select **Add** and **Add metric**, and enter these settings:

    - In the Namespace field, select **Azure Cosmos DB account standard metrics**.
    - In the Metrics field, select **Total Requests**.
    - In the Aggregation field, select **Count**.
    - In the **Split by** field, select **OperationType**.
    - In the **Sort by** field, select **Descending**.
    - In the **Number of splits** field, select **5**.
    - In the **Display Name** field, enter "Operations".
    - Select **Save**.

        :::image type="content" source="../media/7-cosmos-db-metric-grid-settings2.png" alt-text="Screenshot that shows a query in an Azure Workbooks.":::

1. We're going to use the rendering settings to make the chart easy to understand visually.
1. Select **Column settings**, and then in the **Columns** section on the left, select **microsoft.documentsdb/databaseaccounts-Requests-TotalRequests**, and then enter these settings.

    - In the **Column renderer** field, select **Heatmap**.
    - In the **Color palette** field, select **Blue**.
    - Select **Custom formatting**.
        - In the **Units** field, select **Count**.
        - In the **Style** field, select **Decimal**.

        :::image type="content" source="../media/7-cosmos-db-heatmap-settings.png" alt-text="Screenshot that shows setting the colors in a grid in Azure Workbooks.":::

1. In the **Columns** section on the left, select **microsoft.documentsdb/databaseaccounts-Requests-TotalRequests Timeline (Hidden)**, and then enter these settings:

    - In the **Column Label** field, enter (or leave the default name) "Total Requests (Count)".
    - In the **Column renderer** field, select **Heatmap**.
    - In the **Color palette** field, select **Blue**.

1. In the **Columns** section on the left, select ***/Operations$ (Text)**, and then enter these settings:

    - In the **Column Label** field, enter (or leave the default name) "Total Requests (Count)".
    - In the **Column renderer** field, select **Heatmap**.
    - In the **Color palette** field, select **Blue**.
    - Select **Custom formatting**.
        - In the **Units** field, select **Count**.
        - In the **Style** field, select **Decimal**.
    - Select **Save and Close**.

1. To make sure that the graphs display side by side, select **Style** on the top of the window, and then select the **Make this item a custom width** checkbox. Make sure that the **Percent width** is set to 50%.
1. Select **Advanced settings**, and enter a name for the chart in the **Chart title** field, such as "Cosmos DB Operations".
1. Select **Done editing**. Your workbook now has two color coded graphs showing the numbers and types of requests sent to your web app and your Cosmos DB.

    :::image type="content" source="../media/7-final-workbook-grids.png" alt-text="Screenshot that shows two side by side grids in Azure Workbooks.":::
