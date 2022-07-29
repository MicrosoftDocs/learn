While it's often necessary to view specific query text and query plans, it's also useful to view a visual overview of your database performance.

To view Query Store data in a graphical format in Azure Database fo PostgreSQL single server, you can use the **Query Performance Insight** view in the Azure portal.

> [!NOTE]
> Query Performance Insight is not available in Azure Database for PostgreSQL flexible server and you must deploy Azure Database for PostgreSQL single server to use Query Performance Insight.

:::image type="content" source="../media/4-query-performance-insight.png" alt-text="Screenshot of Query Performance Insight." lightbox="../media/4-query-performance-insight.png":::

Query Performance Insight has a display for **Long running queries** and a display for **Wait Statistics**. The displays graphically show which queries have the longest duration or longest wait and provide the **QUERY ID** of each query to enable you to find more information in the **azure_sys** database.

To enable Query Performance Insight, follow these steps:

1. Navigate to the Azure portal and sign in.
1. Select your Azure Database for PostgreSQL server.
1. In **Settings**, select **Server parameters**.
1. Scroll down to **pg_qs.query_capture_mode** and in **pg_qs.query_capture_mode** select **ALL**.
1. Select **Save**.

For more information on the Query Performance Insight, see [Query Performance Insight](/azure/postgresql/concepts-query-performance-insight).
