Now that you understand what dataflows are, it's time to explore how you use Power Query to transform data. The Power Query Online editor is where you connect to data sources, apply transformations, and configure output destinations.

## Create a dataflow

To create a dataflow, navigate to your Fabric workspace and select **+ New item**, then select **Dataflow Gen2**. You can now build your transformation logic in Power Query Online editor.

You start by connecting to a data source. Select **Get data** in the editor ribbon to browse available connectors. Fabric supports hundreds of data sources including cloud databases, on-premises databases (through gateways), flat files, web services, and other Fabric items like lakehouses and warehouses.

After you connect, a preview of your data appears in the editor. From here, you apply transformations visually, configure your output destination, and publish the dataflow.

## Navigate the Power Query editor

The Power Query Online editor has five main areas that you use during dataflow development:

- **Ribbon:** Contains commands organized by tabs (Home, Transform, Add Column, View). You access data source connectors, transformation operations, and destination settings from the ribbon.
- **Queries pane:** Lists all data source connections in your dataflow. Each connection is called a *query*, and queries become tables when loaded to a destination. You can duplicate, reference, or disable queries from this pane.
- **Diagram view:** Provides a visual representation of how queries connect to each other and what transformations apply to each one. You can toggle this view on or off from the View tab.
- **Data preview:** Shows a subset of the data so you can see the effect of each transformation. You can interact with the preview by right-clicking columns to filter, remove, or rename them.
- **Query settings:** Displays the *Applied Steps* for the selected query. Every transformation you apply is recorded as a step. You can reorder, rename, delete, or modify steps. The query settings pane also shows the configured data destination.

> [!TIP]
> Each applied step has a gear icon that lets you modify the step's settings. If a step doesn't have a gear icon, you must delete it and reapply the transformation with different settings.

## Apply common transformations

Power Query provides a wide range of transformations for cleaning and shaping data. The following table describes transformations frequently used when preparing analytical data:

| Transformation type | Purpose |
| --- | --- |
| **Filter rows** | Remove rows that don't meet criteria |
| **Select or remove columns** | Keep only the columns you need |
| **Change data types** | Set correct types for analysis |
| **Split columns** | Separate values in a column by delimiter or position |
| **Merge columns** | Combine values from multiple columns |
| **Pivot columns** | Convert row values into column headers |
| **Unpivot columns** | Convert column headers into row values |
| **Group by** | Aggregate data by one or more columns |
| **Add calculated columns** | Create new columns based on expressions |
| **Merge queries** | Join two queries on matching columns (like a SQL JOIN) |
| **Append queries** | Stack rows from two or more queries (like a SQL UNION) |

These transformations cover most data preparation needs. You apply them by selecting options from the ribbon or by right-clicking columns in the data preview.

## Clean and standardize data

Data quality transformations are essential for producing reliable analytical data. Common data quality operations in Power Query include:

- **Handle null values.** Filter out rows with nulls, or replace null values with defaults using Replace Values.
- **Remove duplicates.** Right-click a column and select Remove Duplicates to keep only unique rows based on that column.
- **Trim whitespace.** Use the Transform tab to trim leading and trailing spaces from text columns.
- **Standardize text.** Apply Capitalize Each Word, UPPERCASE, or lowercase transformations to ensure consistent formatting.
- **Handle errors.** Right-click a column and select Remove Errors to filter out rows where the transformation produced an error, or use Replace Errors to substitute a default value.

Consistent, clean data is especially important when the data supports downstream AI experiences. Copilot and data agents perform better when column values are standardized and free of noise.

## Work with the M language

Every transformation you apply through the Power Query interface generates M language code behind the scenes. M is a functional language that describes the complete transformation logic for a query. You can view and edit the full M script by selecting **Advanced Editor** from the View tab.

For most transformations, the visual interface is the fastest and least error-prone approach. However, writing M directly is useful in the following scenarios:

- **Custom functions.** Create reusable transformation logic that you can apply across multiple queries. For example, a function that standardizes date formats or applies business-specific cleaning rules.
- **Parameterized queries.** Use parameters to dynamically change connection strings, filter values, or other settings based on the environment.
- **Error handling.** Use `try...otherwise` expressions to handle errors gracefully and provide fallback values.
- **Advanced logic.** Implement iterative calculations, conditional branching, or complex business rules that the visual interface doesn't support directly.

The following example shows a simple custom function in M that standardizes a text column by trimming whitespace and converting to uppercase:

```powerquery-m
(inputText as text) as text =>
    Text.Upper(Text.Trim(inputText))
```

For example, calling this function with the input `" hello world "` returns `"HELLO WORLD"`.

You can then apply this function to any text column across your queries.

## Use Copilot for Dataflow Gen2

Copilot for Dataflow Gen2 lets you use natural language prompts to generate transformation logic, accelerating common shaping tasks and helping you discover the right Power Query patterns faster. Instead of navigating menus and selecting options, you describe what you want to accomplish and Copilot generates the appropriate transformation steps.

To open the Copilot chat, select the **Copilot** button on the Home tab.

Example prompts you can use:

- "Remove rows where Status is null"
- "Add a column that calculates profit as Revenue minus Cost"
- "Only keep rows where Category is Electronics or Clothing"
- "Count the total number of orders by customer"

Each action Copilot takes appears as a response card with corresponding steps in the Applied Steps list. You can review, modify, or undo any step Copilot creates.

Copilot also includes an **explainer skill** that helps you understand existing query logic without writing any code. To explain a full query, right-click the query in the Queries pane and select **Describe** or **Explain**. To explain a single applied step, right-click the step in the Applied Steps pane and select **Explain this step**. Copilot returns a plain-language summary of what the query or step does. This feature is useful when inheriting a dataflow from another team member or when debugging an unfamiliar transformation.

> [!NOTE]
> Copilot for Dataflow Gen2 requires a paid Fabric capacity of F2 or higher, or P1 or higher. Trial SKUs aren't supported. Check the [Copilot in Fabric documentation](/fabric/get-started/copilot-fabric-overview) for regional availability.

## Export query results for validation

You can export query results directly from the Power Query authoring experience to validate transformations, share samples with teammates, and debug data issues without leaving your authoring flow. This capability makes it easier to accelerate troubleshooting by exporting a shaped dataset and comparing results across steps. Or to improve collaboration by sharing a snapshot of outputs with business users or support teams.

To export query results, select the query in the Queries pane, then select **Export data** from the Home tab. You can export to formats like CSV or Excel depending on your needs.
