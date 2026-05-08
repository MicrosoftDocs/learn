The visual query editor in Microsoft Fabric provides an intuitive, graphical, no-code interface for building queries.

To open the visual query editor, select the dropdown arrow on **New SQL query** in the ribbon, then select **New visual query**.

- **Graphical interface**: Drag and drop tables onto a canvas to visually design your queries. The editor shows the relationships between tables, making the query structure easy to understand at a glance.

- **Automatic query generation**: As you design your query, the corresponding T-SQL is generated automatically, so you can focus on the logic rather than the syntax.

## Build your query visually

To build a query, drag tables from the **Explorer** onto the canvas.

:::image type="content" border="false" source="../media/4-new-visual-query.png" alt-text="Screenshot showing the New visual query option selected in the dropdown menu, with red arrows indicating how to drag the Date and Trip tables from the Explorer onto the blank canvas.":::

Once your tables are on the canvas, you can join them by right-clicking a table and selecting **Merge queries**.

:::image type="content" border="false" source="../media/4-merge-queries.png" alt-text="Screenshot of the visual query editor canvas with two tables and the Merge queries option highlighted in the context menu.":::

In the Merge dialog, select the common key column in each table and choose a join type, then select **OK**.

:::image type="content" border="false" source="../media/4-merge-dialog.png" alt-text="Screenshot of the Merge dialog in the visual query editor showing column selection and join type options.":::

After configuring your query, select **Run** to see results in the pane below the canvas.

:::image type="content" border="false" source="../media/4-visual-canvas.png" alt-text="Screenshot of the visual query editor showing two tables joined on the canvas with query results displayed in the pane below, including Save as table, Download Excel file, and Visualize results options.":::

Like the SQL query editor, the visual query editor also provides **Save as table** and **Save as view** in the results toolbar. You can also select **Download Excel file** to export results, or **Visualize results** to create a chart.

## View the generated SQL

As you build your visual query, the corresponding T-SQL is generated automatically. Select **View SQL** in the ribbon to inspect it, or **Edit SQL script** to open it in the SQL query editor for further editing.

To learn more about the visual query editor, see [Query using the visual query editor](/fabric/data-warehouse/visual-query-editor?azure-portal=true).
