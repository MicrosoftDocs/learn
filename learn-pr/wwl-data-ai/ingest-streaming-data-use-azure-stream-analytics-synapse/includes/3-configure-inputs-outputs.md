
All Azure Stream Analytics jobs include at least one input and output. In most cases, inputs reference sources of streaming data (though you can also define inputs for static reference data to augment the streamed event data). Outputs determine where the results of the stream processing query will be sent. In the case of data ingestion into Azure Synapse Analytics, the output usually references an Azure Data Lake Storage Gen2 container or a table in a dedicated SQL pool database.

## Streaming data inputs

Inputs for streaming data consumed by Azure Stream Analytics can include:

- Azure Event Hubs
- Azure IoT Hubs
- Azure Blob or Data Lake Gen 2 Storage

Depending on the specific input type, the data for each streamed event includes the event's data fields as well as input-specific metadata fields. For example, data consumed from an Azure Event Hubs input includes an **EventEnqueuedUtcTime** field indicating the time when the event was received in the event hub.

> [!NOTE]
> For more information about streaming inputs, see [Stream data as input into Stream Analytics](/azure/stream-analytics/stream-analytics-define-inputs?azure-portal=true) in the Azure Stream Analytics documentation.

## Azure Synapse Analytics outputs

If you need to load the results of your stream processing into a table in a dedicated SQL pool, use an **Azure Synapse Analytics** output. The output configuration includes the identity of the dedicated SQL pool in an Azure Synapse Analytics workspace, details of how the Azure Stream Analytics job should establish an authenticated connection to it, and the existing table into which the data should be loaded.

Authentication to Azure Synapse Analytics is usually accomplished through SQL Server authentication, which requires a username and password. Alternatively, you can use a managed identity to authenticate. When using an Azure Synapse Analytics output, your Azure Stream Analytics job configuration must include an Azure Storage account in which authentication metadata for the job is stored securely.

> [!NOTE]
> For more information about using an Azure Synapse Analytics output, see [Azure Synapse Analytics output from Azure Stream Analytics](/azure/stream-analytics/azure-synapse-analytics-output?azure-portal=true) in the Azure Stream Analytics documentation.

## Azure Data Lake Storage Gen2 outputs

If you need to write the results of stream processing to an Azure Data Lake Storage Gen2 container that hosts a data lake in an Azure Synapse Analytics workspace, use a **Blob storage/ADLS Gen2** output. The output configuration includes details of the storage account in which the container is defined, authentication settings to connect to it, and details of the files to be created. You can specify the file format, including CSV, JSON, Parquet, and Delta formats. You can also specify custom patterns to define the folder hierarchy in which the files are saved - for example using a pattern such as *YYYY/MM/DD* to generate a folder hierarchy based on the current year, month, and day.

You can specify minimum and maximum row counts for each batch, which determines the number of output files generated (each batch creates a new file). You can also configure the *write mode* to control when the data is written for a time window - appending each row as it arrives or writing all rows once (which ensures "exactly once" delivery).

> [!NOTE]
> For more information about using a Blob storage/ADLS Gen2 output, see [Blob storage and Azure Data Lake Gen2 output from Azure Stream Analytics](/azure/stream-analytics/blob-storage-azure-data-lake-gen2-output?azure-portal=true) in the Azure Stream Analytics documentation.
