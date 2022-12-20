
In this exercise, we are going to take things one step further.
Instead of just having graphs or other visualizations that show data from various data sources, we are going to add visuals that combine metrics.

We are going to monitor your system by creating graphs that combine metrics from the web application and the database to show the number of requests, CPU time, and request unit consumption in the web app and in the Cosmos DB.

We are going to combine data using queries that get data from these sources:

- the Web app
- the CosmosDB
- the Log Analytics workspace

Then we will add a metric that blah blah blah.


## Generate some data for this exercise

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. On the **Home** page, select **Resource groups**, or search for "Resource groups" in the search bar at the top of the page.
1. Select the "learn" resource group created when the sandbox was activated.
1. Look through the list of resources and select the App Service.

    :::image type="content" source="../media/6-portal-select-app-service.png" alt-text="Screenshot of selecting the App Service from the resource group.":::

1. On the top toolbar, select **Browse**.

    :::image type="content" source="../media/6-portal-browse-app-service.png" alt-text="Screenshot of the browser button from the App Service page.":::

1. Populate the app service with some activities to generate some data for our example. On the **List of To-Do Items** page, create some items, edit them, or mark some as complete.

    :::image type="content" source="../media/6-app-service-tasks.png" alt-text="Screenshot that shows tasks for the app service for workbooks learn module.":::

## Add a graph that shows the number of requests sent to the Cosmos DB

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

     :::image type="content" source="../media/6-web-app-parameter.png" alt-text="Screenshot that shows the web app parameter in a workbook.":::

    - Select **Save**.
1. In the same **Add parameter** section, select **Add parameter** again.

    :::image type="content" source="../media/6-add-additional-parameter.png" alt-text="Screenshot that shows adding a second parameter to an existing parameter control in Azure workbooks.":::

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
1. Select **Done editing**.

    Your workbook now has a parameter control with four parameters. When you select the first parameter, the list in each consecutive drop down is populated based on your selection.

    :::image type="content" source="../media/6-multiple-parameters.png" alt-text="Screenshot that shows multiple parameters in one control in Azure workbooks.":::
