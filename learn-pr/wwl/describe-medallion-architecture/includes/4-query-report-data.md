With data organized and refined across bronze, silver, and gold layers, the final step is making it accessible for querying and reporting. The gold layer is purpose-built for this — it's where data engineers have already done the modeling work so that analysts and business users can get answers without digging through raw data.

## Query data with the SQL analytics endpoint

The SQL analytics endpoint in Fabric gives any team member with SQL knowledge direct access to the gold layer. You can write T-SQL queries, save functions, generate views, and apply SQL security — all without moving data or building a separate query layer.

The SQL analytics endpoint operates in **read-only** mode over lakehouse Delta tables.

:::image type="content" source="../media/sql-endpoint-gold.png" alt-text="Screenshot of the SQL analytics endpoint in Fabric showing bronze, silver, and gold schemas in the left navigation, with a query running against a gold layer table." lightbox="../media/sql-endpoint-gold.png":::

## Serve data through a Power BI semantic model

For Power BI users, the gold layer is surfaced through a **semantic model**. To create one, select **New semantic model** from the lakehouse and choose which gold layer tables to include. Power BI reports connect to the semantic model, not directly to the raw Delta tables.

:::image type="content" source="../media/dataset-relationships.png" alt-text="Screenshot of a Power BI semantic model showing gold layer tables with relationships defined between a fact table and dimension tables." lightbox="../media/dataset-relationships.png":::

Semantic models connect to the gold layer using **Direct Lake** mode. Direct Lake reads directly from the Delta files in OneLake instead of importing a copy into Power BI. Reports always show current data without a separate refresh step.

