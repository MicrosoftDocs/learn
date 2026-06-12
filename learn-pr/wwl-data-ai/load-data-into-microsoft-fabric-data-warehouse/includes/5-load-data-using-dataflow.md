A third approach for loading data into a Fabric warehouse is **Dataflow Gen2** — a visual Power Query interface where you connect to sources, apply transformations, and send the results to a destination, all without writing code.

## Create a dataflow

To create a new dataflow, navigate to your workspace and select **+ New item**. In the search box, type **Dataflow Gen2** and select it from the results.

:::image type="content" border="false" source="../media/5-load-using-dataflow.png" alt-text="Screenshot showing the workspace + New item search box with Dataflow Gen2 selected." lightbox="../media/5-load-using-dataflow.png":::

## Import data

Once Dataflow Gen2 opens, select **Get data** to choose your data source. You can connect to databases, cloud storage, files, and many other sources.

:::image type="content" border="false" source="../media/5-import-options.png" alt-text="Screenshot showing the data source import options in Dataflow Gen2." lightbox="../media/5-import-options.png":::

For file-based sources, you can upload directly from your local computer. For example, to load a CSV file, select **Import from a Text/CSV file** from the source list and browse to your file.

After you import data, you can clean, reshape, rename columns, and add calculated columns.

## Transform data with Copilot

Copilot can generate Power Query transformation steps from plain language instructions. To use it, activate Copilot within your dataflow and describe the transformation you want.

For example: *"Add a calculated column that multiplies Quantity by UnitPrice and name it TotalRevenue."*

:::image type="content" border="false" source="../media/5-copilot.png" alt-text="Screenshot showing how to use Copilot to apply transformation in a dataflow." lightbox="../media/5-copilot.png":::

Copilot adds the step automatically. You can inspect the generated formula, revert it, or continue building on it.

## Add a data destination

Once your data is transformed, add a destination to send it to storage. On the **Query settings** panel, select **+** next to **Data destination**.

:::image type="content" border="false" source="../media/5-add-destination.png" alt-text="Screenshot showing the option to add a data destination in a dataflow." lightbox="../media/5-add-destination.png":::

The following destinations are available:

- Azure SQL Database
- Azure Data Explorer (Kusto)
- Azure Data Lake Storage Gen2
- Fabric Lakehouse Tables
- Fabric Lakehouse Files
- Fabric Warehouse
- Fabric KQL database
- Fabric SQL database
- SharePoint Files
- Snowflake

When you select **Fabric Warehouse** as your destination, you choose between two update methods:

:::image type="content" border="false" source="../media/5-update-table-options.png" alt-text="Diagram showing the difference between append and replace update methods." lightbox="../media/5-update-table-options.png":::

- **Append**: Add new rows to an existing table. Use this for accumulating data over time, like daily transaction logs.
- **Replace**: Replace the entire table contents on each run. Use this for reference data that gets fully refreshed, like a product catalog.

> [!NOTE]
> Append is the only update method supported for KQL database and Azure Data Explorer destinations.

## Publish a dataflow

After you configure your destination, select **Publish** to save and activate your dataflow. Dataflow Gen2 automatically saves your work as a draft while you build, but changes only take effect when you publish. After publishing, you can run the dataflow manually or set it on a schedule.