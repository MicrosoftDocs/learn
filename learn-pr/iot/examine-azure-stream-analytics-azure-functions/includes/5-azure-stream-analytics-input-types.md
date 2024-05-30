Azure Stream Analytics jobs connect to one or more data inputs. Each input defines a connection to an existing data source. Stream Analytics accepts data incoming from several kinds of event sources including Event Hubs, IoT Hub, Azure Data Lake Storage Gen2, and Blob storage. The inputs are referenced by name in the streaming SQL query that you write for each job. In the query, you can join multiple inputs to blend data or compare streaming data with a lookup to reference data, and pass the results to outputs.

Input resources can live in the same Azure subscription as your Stream Analytics job, or they can come from a different subscription.

You can use the Azure portal, Azure PowerShell, .NET API, REST API, and Visual Studio to create, edit, and test Stream Analytics job inputs.

## Stream and reference inputs

As data is pushed to a data source, it's consumed by the Stream Analytics job and processed in real time. Inputs are divided into two types: data stream inputs and reference data inputs.

### Data stream input

A data stream is an unbounded sequence of events over time. Stream Analytics jobs must include at least one data stream input. Event Hub, IoT Hub, Azure Data Lake Gen2, and Blob storage are supported as data stream input sources. Event Hub is used to collect event streams from multiple devices and services. These streams might include social media activity feeds, stock trade information, or data from sensors. IoT Hubs are optimized to collect data from connected devices in Internet of Things (IoT) scenarios. Blob storage can be used as an input source for ingesting bulk data as a stream, such as log files.

### Reference data input

Stream Analytics also supports input known as reference data. Reference data is either static or changes slowly. It is typically used to perform correlation and lookups. For example, you might join data in the data stream input to data in the reference data, much as you would perform a SQL join to look up static values. Azure Blob storage, Azure Data Lake Storage Gen2, and Azure SQL Database are currently supported as input sources for reference data. Reference data source blobs have a limit of up to 300 MB in size, depending on the query complexity and allocated Streaming Units.
