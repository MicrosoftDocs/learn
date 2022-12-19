
In this exercise, we are going to combine metrics from the web application and the database to monitor your system by creating graphs that show the number of requests, CPU time, and request unit consumption in the web app and in the Cosmos DB.

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

## Add a graph that shows the number of requests sent to the Cosmos DB.
