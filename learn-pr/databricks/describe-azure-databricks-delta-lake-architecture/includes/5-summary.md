If you're looking for a data-management system that's fast, reliable, and able to handle large volumes of data in different raw formats, Databricks Delta is the solution. Databricks Delta provides the best of data lake, data warehousing, and streaming data-ingestion systems.

During this module, you explored combining streaming and batch processing with a single pipeline. Now you should know how to:

- Ingest streaming JSON data from disk and write it to a bronze Delta Lake Table.
- Perform a Stream-Static Join on the streamed data to add additional geographic data.
- Transform and load the data, saving it out to a silver Delta Lake Table.
- Summarize the data through aggregation into a gold Delta Lake Table.
- Materialize views of the gold table through streaming plots and static queries.
- Write batches of data back to the bronze table to trigger the same logic on newly loaded data and propagate your changes automatically.

## Clean up

If you plan on completing other Azure Databricks modules, don't delete your Azure Databricks instance yet. You can use the same environment for the other modules.

### Delete the Azure Databricks instance

1. Navigate to the Azure portal.
1. Navigate to the resource group that contains your Azure Databricks instance.
1. Select **Delete resource group**.
1. Type the name of the resource group in the confirmation text box.
1. Select **Delete**.
