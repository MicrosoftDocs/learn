KQL is the language used to query the log data in the Log Analytics workspace. You can enter KQL queries in Microsoft Sentinel and Microsoft Defender. In Microsoft Sentinel onboarded to the Defender portal, you can access the query window from the Advanced hunting page or the Data lake exploration page. In Microsoft Sentinel, in the Azure portal, the Logs page provides access to the query window.

In the [Defender portal](https://security.microsoft.com/), select **Investigation & response** > **Hunting** > **Advanced hunting**, or to run ad-hoc interactive KQL queries on long-term data, select **Microsoft Sentinel** > **Data lake exploration** > **KQL queries**. In the [Azure portal](https://portal.azure.com), the **Search** page is listed under **General**.

### [Defender portal](#tab/defender-portal)

For Microsoft Sentinel in the Defender portal, you have several options for running KQL queries. In this unit we cover the two following options:

- Advanced hunting page: The query window allows you to run queries, save queries, run saved queries, create a new alert rule, and export. You can also link a result to an incident. The left side provides a list of tables and related table fields. To run a query, enter the query text and press the run button. Query results appear in the bottom section of the form.
- Data lake exploration page: To run ad-hoc interactive KQL queries on long-term data,

1. To use *Advanced hunting*, select **Investigation & response** > **Hunting** > **Advanced hunting**.

    :::image type="content" source="../media/advanced-hunting.png" alt-text="Screenshot of the Advanced hunting page in the Defender portal." lightbox="../media/advanced-hunting.png":::

1. To use *Data lake exploration*, select **Microsoft Sentinel** > **Data lake exploration** > **KQL queries**.

    :::image type="content" source="../media/data-lake-kql-queries.png" alt-text="Screenshot of the Data lake exploration page in the Defender portal." lightbox="../media/data-lake-kql-queries.png":::

1. Select the appropriate workspace from the workspace selector in the top menu.

    :::image type="content" source="../media/workspace-selector.png" alt-text="Screenshot of the workspace selector in the Azure portal." lightbox="../media/workspace-selector.png":::

### [Azure portal](#tab/azure-portal)

For Microsoft Sentinel in the Azure portal, you run KQL queries on the Logs page. The query window allows you to run queries, save queries, run saved queries, create a new alert rule, and export. The left side provides a list of tables and related table fields. To run a query, enter the query text and press the run button. Query results appear in the bottom section of the form.

1. In the navigation menu, expand the **General** section, and then select **Logs** to open the query window.

1. Unless you disabled it, the Queries hub page opens with a large selection of categorized sample queries.

   :::image type="content" source="../media/queries-hub.png" alt-text="Screenshot of Queries hub page in the Azure portal." lightbox="../media/queries-hub.png":::

    > [!NOTE]
    > You can prevent the Queries hub page from appearing by moving the **Always show Queries Hub** slider switch to the left or off.

1. Close the Queries hub by selecting the **X** in the upper right corner of the page.

1. The New query page opens in *Simple mode*. Use the dropdown menu in the upper right corner of the page to switch to *KQL mode*.

1. Enter your KQL query in the query editor and then select **Run** to execute the query.

   :::image type="content" source="../media/logs-page-query.png" alt-text="Screenshot of the Logs page in the Azure portal." lightbox="../media/logs-page-query.png":::

    > [!NOTE]
    > The screenshot shows the results with a specific set of columns selected. You can customize the columns shown in the results by selecting the **Columns** button to the right of the results pane. You could also modify the query to specify the columns you want to see in the results.

---
