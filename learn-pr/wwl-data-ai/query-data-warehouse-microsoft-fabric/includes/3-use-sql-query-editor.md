The SQL query editor in Microsoft Fabric lets you write and run T-SQL scripts directly against your data warehouse, with built-in IntelliSense and debugging support.

## Launch a SQL query editor

The SQL query editor supports a full range of T-SQL operations — from querying data to creating tables, inserting rows, granting permissions, and executing complex scripts.

To launch the SQL query editor, select your warehouse from the workspace where it's located. It connects automatically, without requiring any connection information.  

From the warehouse **Explorer**, you can create a new SQL query in the following ways.

:::image type="content" border="false" source="../media/3-sql-editor.png" alt-text="Screenshot showing ways to create a new SQL query in a data warehouse in Microsoft Fabric.":::

1. **Home** menu: Select **New SQL query** or select any of the templates available.
2. **Queries** node: Select **...** to the right of **My queries**, then select **New SQL Query**.

Either way, a new query item is created automatically in the **My queries** folder in the **Explorer** and saved as you work.

## Run queries and view results

To run a query, type it into a new query editor and select **Run** at the top of the editor.

:::image type="content" border="false" source="../media/3-run.png" alt-text="Screenshot of the SQL query editor in Microsoft Fabric showing a query and the Run button.":::

The **Results** section shows a preview, limited to 10,000 rows if exceeded.

## Work with query results

The results toolbar gives you several ways to explore and export your data after running a query. To access most options, highlight a `SELECT` statement in the editor first.

:::image type="content" border="false" source="../media/3-results-toolbar.png" alt-text="Screenshot of the SQL query editor results toolbar showing Open in Excel, Explore this data, Visualize results, and Copy buttons.":::

- **Open in Excel**: Opens the query as a live connection in Microsoft Excel (not a static file download). After the file downloads, open it in Excel, select **Enable Editing**, then **Enable Content**, approve the Native Database Query dialog, and authenticate with your Microsoft account. Your data loads as a connected query that you can refresh.
- **Explore this data (preview)**: Opens a side-by-side matrix and visual view of results for ad hoc exploration — useful for spotting trends before building a full Power BI report.
- **Visualize results**: Creates a Power BI visual directly from your query results inside the editor. Note: doesn't support queries with an `ORDER BY` clause.
- **Copy**: Use the **Copy** dropdown to copy results with column names, results only, or column names only.
- **Multiple result sets**: When running multiple queries, use the **Results** dropdown to navigate between individual result sets.

The query editor also offers the ability to save your highlighted query as either a view or a table, each with distinct features:

- **Save as view**: Allows you to create a view in the warehouse using the SELECT statement highlighted in the query editor.
- **Save as table**: Creates a new table with your query results. 

For both options, you must provide the schema and the name before confirming the creation.

## Copilot in the SQL query editor

If Copilot is enabled in your tenant, you'll see **Fix query errors** and **Explain query** quick action buttons in the SQL query editor ribbon, near the **Run** button.

:::image type="content" border="false" source="../media/3-copilot-quick-actions.png" alt-text="Screenshot of the SQL query editor ribbon showing the Explain query and Fix query errors Copilot quick action buttons, and the Copilot chat pane.":::

- **Explain query**: Adds natural language comments to your query describing what each part does.
- **Fix query errors**: Detects and fixes syntax or logic errors in your highlighted query. This button is grayed out when no errors are detected — it activates automatically when the editor identifies a problem.

You can also open the Copilot chat pane by selecting **Copilot** in the toolbar, to generate T-SQL from natural language questions.

> [!NOTE]
> Copilot in Data Warehouse requires an F2 or P1 capacity or higher. It isn't available on trial SKUs.

For a full introduction to Copilot capabilities in Data Warehouse, see [Get started with Copilot in Microsoft Fabric for Data Warehouse](/training/modules/get-started-copilot-fabric-data-warehouse/).

To learn more about SQL query editor, see [Query using the SQL query editor](/fabric/data-warehouse/sql-query-editor?azure-portal=true).

