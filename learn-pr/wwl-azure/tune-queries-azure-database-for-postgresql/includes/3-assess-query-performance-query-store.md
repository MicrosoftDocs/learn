The Query Store feature is often a more effective method than pg_stat_statements for monitoring query performance and is recommended as the primary method to monitor query performance.

## Enable the Query Store

Query Store isn't enabled by default, but can be turned on globally or on a per-database basis. You should also enable wait statistics. To enable Query Store and wait statistics, perform the following steps:

1. Go to the Azure portal and select your Azure Database for PostgreSQL server.
1. Select **Server parameters** and navigate to the **pg_qs.query_capture_mode** setting.
1. Select **TOP**.

    :::image type="content" source="../media/3-settings-turn-query-store-on.png" alt-text="Screenshot of settings to turn on the Query Store." lightbox="../media/3-settings-turn-query-store-on.png":::

1. Navigate to **pgms_wait_sampling.query_capture_mode**, select **ALL**, and select **Save**.

    :::image type="content" source="../media/3-query-capture-mode.png" alt-text="Screenshot of settings to turn on pgms_wait_sampling.query_capture_mode." lightbox="../media/3-query-capture-mode.png":::

## Access information in the Query Store

To access the data in the Query Store, you should query system views in the **azure_sys** database. The following system views are available:

- **query_store.qs_view** returns query information including blocks, runtime, and query text.
- **query_store.pgms_wait_sampling_view** returns wait times for queries.
- **query_store.query_texts_view** returns the query text of queries.
- **query_store.runtime_stats_view** returns runtime statistics information.

## Resetting the Query Store

If you want to clear all the data in the Query Store, you can call the **qs_reset** function. Alternatively you can truncate the tables in the **azure_sys** database, in the **query_store** schema.

For more information on the Query Store, see [Monitor performance with the Query Store](/azure/postgresql/concepts-query-store).
