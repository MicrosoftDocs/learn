
All Azure Stream Analytics jobs include at least one input and output. In most cases, inputs reference sources of streaming data (though you can also define inputs for static reference data to augment the streamed event data). Outputs determine where the results of the stream processing query will be sent. In the case of data ingestion into Azure Synapse Analytics, the output usually references an Azure Data Lake Storage Gen2 container or a table in a dedicated SQL pool database.

> [!NOTE]
> Azure Stream Analytics offers two authoring experiences: the traditional SQL query editor covered in this module, and a no-code drag-and-drop editor. The no-code editor lets you build complete jobs—including inputs, transformations, and Synapse outputs—visually without writing SQL. You can access it from the **Overview** page of a Stream Analytics job in the Azure portal, or from Azure Event Hubs via **Process Data**. For more information, see [No-code stream processing in Azure Stream Analytics](/azure/stream-analytics/no-code-stream-processing).

## Streaming data inputs

Inputs for streaming data consumed by Azure Stream Analytics can include:

- Azure Event Hubs
- Azure IoT Hubs
- Azure Blob or Data Lake Gen 2 Storage
- Apache Kafka

Depending on the specific input type, the data for each streamed event includes the event's data fields as well as input-specific metadata fields. For example, data consumed from an Azure Event Hubs input includes an **EventEnqueuedUtcTime** field indicating the time when the event was received in the event hub.

> [!NOTE]
> For more information about streaming inputs, see [Stream data as input into Stream Analytics](/azure/stream-analytics/stream-analytics-define-inputs?azure-portal=true) in the Azure Stream Analytics documentation.

## Azure SQL Database outputs

If you need to load the results of your stream processing into a relational table, use an **Azure SQL Database** output. The output configuration specifies the server name, database name, and the existing table into which data should be written. The table must already exist and its schema must exactly match the fields and their types produced by your query.

The recommended authentication method is **managed identity**, which eliminates password management overhead and avoids the 90-day token expiration that affects user-based authentication methods. Using managed identity also enables fully automated Stream Analytics deployments without embedded credentials. Alternatively, you can use SQL Server authentication with a username and password.

> [!NOTE]
> For more information about using an Azure SQL Database output, see [Azure SQL Database output from Azure Stream Analytics](/azure/stream-analytics/sql-database-output?azure-portal=true) in the Azure Stream Analytics documentation.

## Azure Data Lake Storage Gen2 outputs

If you need to write the results of stream processing to files in a data lake, use a **Blob storage/ADLS Gen2** output. The output configuration includes details of the storage account in which the container is defined, authentication settings to connect to it, and details of the files to be created. You can specify the file format, including CSV, JSON, Parquet, and Delta formats. You can also specify custom patterns to define the folder hierarchy in which the files are saved - for example using a pattern such as *YYYY/MM/DD* to generate a folder hierarchy based on the current year, month, and day.

You can specify minimum and maximum row counts for each batch, which determines the number of output files generated (each batch creates a new file). You can also configure the *write mode* to control when the data is written for a time window - appending each row as it arrives or writing all rows once (which ensures "exactly once" delivery).

> [!NOTE]
> For more information about using a Blob storage/ADLS Gen2 output, see [Blob storage and Azure Data Lake Gen2 output from Azure Stream Analytics](/azure/stream-analytics/blob-storage-azure-data-lake-gen2-output?azure-portal=true) in the Azure Stream Analytics documentation.

## Additional output types

Azure Stream Analytics supports a wide range of output destinations beyond data lakes and relational databases:

- **Azure Event Hubs** — forward filtered or enriched events to another event hub for downstream consumers or multi-stage pipelines.
- **Power BI** — write aggregated streaming metrics directly to a Power BI streaming dataset for near real-time visualization without a scheduled refresh.
- **Azure Cosmos DB** — write results to a globally distributed NoSQL database.
- **Azure Functions** — trigger serverless functions in response to stream events.

> [!NOTE]
> For the full list of supported output types, see [Understand outputs from Azure Stream Analytics](/azure/stream-analytics/stream-analytics-define-outputs?azure-portal=true) in the Azure Stream Analytics documentation.
