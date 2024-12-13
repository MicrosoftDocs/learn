The SQL query editor in Microsoft Fabric is a versatile tool that supports Transact-SQL (T-SQL), allowing you to create and run scripts to query your data warehouse. It also provides features such as IntelliSense and debugging to aid in the development process.

T-SQL allows users, analysts and developers to manipulate the data stored in a warehouse.

## Launch a SQL query editor

The SQL query editor isn't just about querying; it’s about managing your data effectively. Whether you’re creating a new table, inserting rows into a table, granting objects permission or executing complex queries, the SQL query editor is designed to make these tasks seamless.

To launch the SQL query editor, you need to select your warehouse asset from **My workspace**. This step connects to your data warehouse automatically, without you having to prompt any connection information.  

From the warehouse **Explorer**, there are a few ways to create a SQL query editor.

:::image type="content" border="false" source="../media/2-sql-editor.png" alt-text="Screenshot showing how to invoke a new SQL editor for a data warehouse in Microsoft Fabric.":::

1. **Home** menu: Select **New SQL query** or select any of the templates available.
2. **Queries** node: Select **...** in **My queries**, then select **New SQL Query**.
3. **Query** tab: This option opens a new query editor.

No matter how you initiate a new query editor, a new query item is automatically created in **My queries** folder in the **Explorer**.

Any new query item updated is automatically saved.

## Run queries and view results

To run a query, type it into a new query editor and select **Run** at the top of the editor.

:::image type="content" border="false" source="../media/2-query-editor.gif" alt-text="Animated GIF showing how to run a query for a data warehouse in Microsoft Fabric.":::

The **Results** section shows a preview, limited to 10,000 rows if exceeded.

## Export results

Your query results can be exported as an Excel file. To export it, select **Download Excel file**. 

:::image type="content" border="false" source="../media/2-export-query.gif" alt-text="Animated GIF showing how to export query results for a data warehouse in Microsoft Fabric.":::

You need to select the text of one `SELECT` statement in your query to export results to Excel.

Similarly, the query editor offers the ability to save your highlighted query as either a view or a table, each with distinct features:

- **Save as view**: Allows you to create a view in the warehouse using the SELECT statement highlighted in the query editor.
- **Save as table**: Creates a new table with your query results. 

For both options, you must provide the schema and the name before confirming the creation.

To learn more about SQL query editor, see [Query using the SQL query editor](/fabric/data-warehouse/sql-query-editor?azure-portal=true).

