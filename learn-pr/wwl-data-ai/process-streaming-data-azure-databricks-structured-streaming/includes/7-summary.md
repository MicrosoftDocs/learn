Apache Spark Structured Streaming enables you to process streaming data and perform analytics in real time. You can use Azure Event Hubs together with Structured Streaming to process and analyze messages in real time.

Now that you have concluded this module, you should know:

- The key features and uses of Structured Streaming.
- How to stream data from a file and write it out to a distributed file system.
- How to list and stop active streams.
- How to use sliding windows to aggregate over chunks of data rather than all data.
- How to apply watermarking to throw away stale old data that you do not have space to keep.
- How to plot live graphs using `display`.
- How to connect to Event Hubs and write a stream to your event hub.
- How to read a stream from your event hub.
- How to define a schema for the JSON payload and parse the data do display it within a table.

## Clean up

If you plan on completing other Azure Databricks modules, don't delete your Azure Databricks instance yet. You can use the same environment for the other modules.

### Delete the Azure Databricks instance

1. Navigate to the Azure portal.
1. Navigate to the resource group that contains your Azure Databricks instance.
1. Select **Delete resource group**.
1. Type the name of the resource group in the confirmation text box.
1. Select **Delete**.
