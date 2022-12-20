In this exercise, we're going to take things one step further. Instead of just having visualizations that show data from some data sources, we're going to add visuals that combine data from these sources to let you correlate the data and analyze your system.

We're going to create graphs to show the requests, CPU time, and request unit consumption in the web app and the Cosmos DB. The graph uses combined metrics from the web application and the database.

We're going to combine data using queries that get data from these sources:

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

## Add two graphs that compare data

In this exercise, we are going to put two graphs side by side to compare the number of requests sent to the web app and to the Cosmos DB.

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

1. Select **Style** on the top of this window, and enter these settings:

    - Select the **Make this item a custom width** checkbox.
    - Leave the **Percent width** and **Maximum width** at their default values of 50 and 100.

1. Select **Advanced settings**, and enter a name for the chart in the **Chart title** field, such as "Web app number of requests" .
1. Select **Done editing**. You now have a graph displaying the number of requests sent to your web app.

    :::image type="content" source="../media/7-one-chart-requests.png" alt-text="Screenshot that shows one graph in an Azure Workbooks.":::

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
1. Select **Style** on the top of this window, and enter these settings:

    - Select the **Make this item a custom width** checkbox.
    - Leave the **Percent width** and **Maximum width** at their default values of 50 and 100.

1. Select **Advanced settings**, and enter a name for the chart in the **Chart title** field, such as "Cosmos DB total requests" .
1. Select **Done editing**. You now have two side by side graphs displaying the number of requests sent to your web app and your database.

    :::image type="content" source="../media/7-two-charts-requests.png" alt-text="Screenshot that shows two graphs in an Azure Workbooks.":::

