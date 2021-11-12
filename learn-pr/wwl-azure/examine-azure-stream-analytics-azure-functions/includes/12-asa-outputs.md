Outputs let you store and save the results of the Stream Analytics job. By using the output data, you can do further business analytics and data warehousing of your data.

When you design your Stream Analytics query, refer to the name of the output by using the INTO clause. You can use a single output per job, or multiple outputs per streaming job (if you need them) by providing multiple INTO clauses in the query. To create, edit, and test Stream Analytics job outputs, you can use the Azure portal, Azure PowerShell, .NET API, REST API, and Visual Studio.

Some outputs types support partitioning. Output batch sizes vary to optimize throughput.

## Blob storage and Azure Data Lake Gen2<br>

Data Lake Storage Gen2 makes Azure Storage the foundation for building enterprise data lakes on Azure. Designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput, Data Lake Storage Gen2 allows you to easily manage massive amounts of data. A fundamental part of Data Lake Storage Gen2 is the addition of a hierarchical namespace to Blob storage.

Azure Blob storage offers a cost-effective and scalable solution for storing large amounts of unstructured data in the cloud. For an introduction on Blob storage and its usage, see "Upload, download, and list blobs with the Azure portal".

The following table lists the property names and their descriptions for creating a blob or ADLS Gen2 output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    A friendly name used in queries to direct the query output to this blob storage.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage account
  :::column-end:::
  :::column:::
    The name of the storage account where you are sending your output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage account key
  :::column-end:::
  :::column:::
    The secret key associated with the storage account.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage container
  :::column-end:::
  :::column:::
    A logical grouping for blobs stored in the Azure Blob service. When you upload a blob to the Blob service, you must specify a container for that blob.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Path pattern
  :::column-end:::
  :::column:::
    Optional. The file path pattern that is used to write your blobs within the specified container.

In the path pattern, you can choose to use one or more instances of the date and time variables to specify the frequency that blobs are written:
\{date\}, \{time\}

You can use custom blob partitioning to specify one custom \{field\} name from your event data to partition blobs. The field name is alphanumeric and can include spaces, hyphens, and underscores. Restrictions on custom fields include the following:

Field names are not case-sensitive. For example, the service cannot differentiate between column "ID" and column "id."
Nested fields are not permitted. Instead, use an alias in the job query to "flatten" the field.
Expressions cannot be used as a field name.

This feature enables the use of custom date/time format specifier configurations in the path. Custom date and time formats must be specified one at a time, enclosed by the \{datetime:&lt;specifier&gt;\} keyword. Allowable inputs for &lt;specifier&gt; are yyyy, MM, M, dd, d, HH, H, mm, m, ss, or s. The \{datetime:&lt;specifier&gt;\} keyword can be used multiple times in the path to form custom date/time configurations.

Examples:
Example 1: cluster1/logs/\{date\}/\{time\}
Example 2: cluster1/logs/\{date\}
Example 3: cluster1/\{client\_id\}/\{date\}/\{time\}
Example 4: cluster1/\{datetime:ss\}/\{myField\} where the query is: SELECT data.myField AS myField FROM Input;
Example 5: cluster1/year=\{datetime:yyyy\}/month=\{datetime:MM\}/day=\{datetime:dd\}

The time stamp of the created folder structure follows UTC and not local time.

File naming uses the following convention:

\{Path Prefix Pattern\}/schemaHashcode\_Guid\_Number.extension

Example output files:
Myoutput/20170901/00/45434\_gguid\_1.csv
Myoutput/20170901/01/45434\_gguid\_1.csv
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Date format
  :::column-end:::
  :::column:::
    Optional. If the date token is used in the prefix path, you can select the date format in which your files are organized. Example: YYYY/MM/DD
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time format
  :::column-end:::
  :::column:::
    Optional. If the time token is used in the prefix path, specify the time format in which your files are organized. Currently the only supported value is HH.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    Serialization format for output data. JSON, CSV, Avro, and Parquet are supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Minimum rows (Parquet only)
  :::column-end:::
  :::column:::
    The number of minimum rows per batch. For Parquet, every batch will create a new file. The current default value is 2,000 rows and the allowed maximum is 10,000 rows.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Maximum time (Parquet only)
  :::column-end:::
  :::column:::
    The maximum wait time per batch. After this time, the batch will be written to the output even if the minimum rows requirement is not met. The current default value is 1 minute and the allowed maximum is 2 hours. If your blob output has path pattern frequency, the wait time cannot be higher than the partition time range.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    If you are using CSV or JSON format, an encoding must be specified. UTF-8 is the only supported encoding format at this time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delimiter
  :::column-end:::
  :::column:::
    Applicable only for CSV serialization. Stream Analytics supports several common delimiters for serializing CSV data. Supported values are comma, semicolon, space, tab, and vertical bar.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Format
  :::column-end:::
  :::column:::
    Applicable only for JSON serialization. Line separated specifies that the output is formatted by having each JSON object separated by a new line. Array specifies that the output is formatted as an array of JSON objects. This array is closed only when the job stops or Stream Analytics has moved on to the next time window. In general, it is preferable to use line-separated JSON, because it does not require any special handling while the output file is still being written to.
  :::column-end:::
:::row-end:::


When you are using Blob storage as output, a new file is created in the blob in the following cases:

 -  If the file exceeds the maximum number of allowed blocks (currently 50,000). You might reach the maximum allowed number of blocks without reaching the maximum allowed blob size. For example, if the output rate is high, you can see more bytes per block, and the file size is larger. If the output rate is low, each block has less data, and the file size is smaller.
 -  If there is a schema change in the output, and the output format requires fixed schema (CSV and Avro).
 -  If a job is restarted, either externally by a user stopping it and starting it, or internally for system maintenance or error recovery.
 -  If the query is fully partitioned, and a new file is created for each output partition.
 -  If the user deletes a file or a container of the storage account.
 -  If the output is time partitioned by using the path prefix pattern, and a new blob is used when the query moves to the next hour.
 -  If the output is partitioned by a custom field, and a new blob is created per partition key if it does not exist.
 -  If the output is partitioned by a custom field where the partition key cardinality exceeds 8,000, and a new blob is created per partition key.

## Event Hubs

The Azure Event Hubs service is a highly scalable publish-subscribe event ingestor. It can collect millions of events per second. One use of an event hub as output is when the output of a Stream Analytics job becomes the input of another streaming job. For information about the maximum message size and batch size optimization, see the output batch size section.

You need a few parameters to configure data streams from event hubs as an output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    A friendly name used in queries to direct the query output to this event hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event hub namespace
  :::column-end:::
  :::column:::
    A container for a set of messaging entities. When you created a new event hub, you also created an event hub namespace.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event hub name
  :::column-end:::
  :::column:::
    The name of your event hub output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event hub policy name
  :::column-end:::
  :::column:::
    The shared access policy, which you can create on the event hub's Configure tab. Each shared access policy has a name, permissions that you set, and access keys.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event hub policy key
  :::column-end:::
  :::column:::
    The shared access key that is used to authenticate access to the event hub namespace.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Partition key column
  :::column-end:::
  :::column:::
    Optional. A column that contains the partition key for event hub output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    The serialization format for output data. JSON, CSV, and Avro are supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    For CSV and JSON, UTF-8 is the only supported encoding format at this time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delimiter
  :::column-end:::
  :::column:::
    Applicable only for CSV serialization. Stream Analytics supports several common delimiters for serializing data in CSV format. Supported values are comma, semicolon, space, tab, and vertical bar.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Format
  :::column-end:::
  :::column:::
    Applicable only for JSON serialization. Line separated specifies that the output is formatted by having each JSON object separated by a new line. Array specifies that the output is formatted as an array of JSON objects.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Property columns
  :::column-end:::
  :::column:::
    Optional. Comma-separated columns that need to be attached as user properties of the outgoing message instead of the payload. More information about this feature is in the section Custom metadata properties for output.
  :::column-end:::
:::row-end:::


## Power BI

You can use Power BI as an output for a Stream Analytics job to provide for a rich visualization experience of analysis results. You can use this capability for operational dashboards, report generation, and metric-driven reporting.

Power BI output from Stream Analytics is currently not available in the Azure China 21Vianet and Azure Germany (T-Systems International) regions.

The following table lists property names and their descriptions to configure your Power BI output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    Provide a friendly name that is used in queries to direct the query output to this Power BI output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Group workspace
  :::column-end:::
  :::column:::
    To enable sharing data with other Power BI users, you can select groups inside your Power BI account or choose My Workspace if you do not want to write to a group. Updating an existing group requires renewing the Power BI authentication.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Dataset name
  :::column-end:::
  :::column:::
    Provide a dataset name that you want the Power BI output to use.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Table name
  :::column-end:::
  :::column:::
    Provide a table name under the dataset of the Power BI output. Currently, Power BI output from Stream Analytics jobs can have only one table in a dataset.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authorize connection
  :::column-end:::
  :::column:::
    You need to authorize with Power BI to configure your output settings. Once you grant this output access to your Power BI dashboard, you can revoke access by changing the user account password, deleting the job output, or deleting the Stream Analytics job.
  :::column-end:::
:::row-end:::


For a walkthrough of configuring a Power BI output and dashboard, see the Azure Stream Analytics and Power BI tutorial.

**Note** Do not explicitly create the dataset and table in the Power BI dashboard. The dataset and table are automatically populated when the job is started and the job starts pumping output into Power BI. If the job query does not generate any results, the dataset and table are not created. If Power BI already had a dataset and table with the same name as the one provided in this Stream Analytics job, the existing data is overwritten.

### Create a schema

Azure Stream Analytics creates a Power BI dataset and table schema for the user if they do not already exist. In all other cases, the table is updated with new values. Currently, only one table can exist within a dataset.

Power BI uses the first-in, first-out (FIFO) retention policy. Data will collect in a table until it hits 200,000 rows.

### Convert a data type from Stream Analytics to Power BI

Azure Stream Analytics updates the data model dynamically at runtime if the output schema changes. Column name changes, column type changes, and the addition or removal of columns are all tracked.

This table covers the data type conversions from Stream Analytics data types to Power BI Entity Data Model (EDM) types, if a Power BI dataset and table do not exist.

:::row:::
  :::column:::
    **From Stream Analytics**
  :::column-end:::
  :::column:::
    **To Power BI**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    bigint
  :::column-end:::
  :::column:::
    Int64
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    nvarchar(max)
  :::column-end:::
  :::column:::
    String
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    datetime
  :::column-end:::
  :::column:::
    Datetime
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    float
  :::column-end:::
  :::column:::
    Double
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Record array
  :::column-end:::
  :::column:::
    String type, constant value "IRecord" or "IArray"
  :::column-end:::
:::row-end:::


### Update the schema

Stream Analytics infers the data model schema based on the first set of events in the output. Later, if necessary, the data model schema is updated to accommodate incoming events that might not fit into the original schema.

Avoid the SELECT \* query to prevent dynamic schema update across rows. In addition to potential performance implications, it might result in uncertainty of the time taken for the results. Select the exact fields that need to be shown on the Power BI dashboard. Additionally, the data values should be compliant with the chosen data type.

:::row:::
  :::column:::
    **Previous/current**
  :::column-end:::
  :::column:::
    **Int64**
  :::column-end:::
  :::column:::
    **String**
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **Datetime**
  :::column-end:::
  :::column:::
    **Double**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Int64
  :::column-end:::
  :::column:::
    Int64
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Double
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Double
  :::column-end:::
  :::column:::
    Double
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Double
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Datetime
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    Datetime
  :::column-end:::
  :::column:::
    String
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::


## Table storage

Azure Table storage offers highly available, massively scalable storage, so that an application can automatically scale to meet user demand. Table storage is Microsoft’s NoSQL key/attribute store, which you can use for structured data with fewer constraints on the schema. Azure Table storage can be used to store data for persistence and efficient retrieval.

The following table lists the property names and their descriptions for creating a table output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    A friendly name used in queries to direct the query output to this table storage.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage account
  :::column-end:::
  :::column:::
    The name of the storage account where you are sending your output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage account key
  :::column-end:::
  :::column:::
    The access key associated with the storage account.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Table name
  :::column-end:::
  :::column:::
    The name of the table. The table gets created if it does not exist.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Partition key
  :::column-end:::
  :::column:::
    The name of the output column that contains the partition key. The partition key is a unique identifier for the partition within a table that forms the first part of an entity's primary key. It is a string value that can be up to 1 KB in size.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Row key
  :::column-end:::
  :::column:::
    The name of the output column that contains the row key. The row key is a unique identifier for an entity within a partition. It forms the second part of an entity’s primary key. The row key is a string value that can be up to 1 KB in size.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Batch size
  :::column-end:::
  :::column:::
    The number of records for a batch operation. The default (100) is sufficient for most jobs. See the Table Batch Operation spec for more details on modifying this setting.
  :::column-end:::
:::row-end:::


## Service Bus queues

Service Bus queues offer a FIFO message delivery to one or more competing consumers. Typically, messages are received and processed by the receivers in the temporal order in which they were added to the queue. Each message is received and processed by only one message consumer.

The following table lists the property names and their descriptions for creating a queue output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    A friendly name used in queries to direct the query output to this Service Bus queue.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Service Bus namespace
  :::column-end:::
  :::column:::
    A container for a set of messaging entities.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Queue name
  :::column-end:::
  :::column:::
    The name of the Service Bus queue.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Queue policy name
  :::column-end:::
  :::column:::
    When you create a queue, you can also create shared access policies on the queue's Configure tab. Each shared access policy has a name, permissions that you set, and access keys.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Queue policy key
  :::column-end:::
  :::column:::
    The shared access key that is used to authenticate access to the Service Bus namespace.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    The serialization format for output data. JSON, CSV, and Avro are supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    For CSV and JSON, UTF-8 is the only supported encoding format at this time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delimiter
  :::column-end:::
  :::column:::
    Applicable only for CSV serialization. Stream Analytics supports several common delimiters for serializing data in CSV format. Supported values are comma, semicolon, space, tab, and vertical bar.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Format
  :::column-end:::
  :::column:::
    Applicable only for JSON type. Line separated specifies that the output is formatted by having each JSON object separated by a new line. Array specifies that the output is formatted as an array of JSON objects.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Property columns
  :::column-end:::
  :::column:::
    Optional. Comma-separated columns that need to be attached as user properties of the outgoing message instead of the payload. More information about this feature is in the section Custom metadata properties for output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    System Property columns
  :::column-end:::
  :::column:::
    Optional. Key value pairs of System Properties and corresponding column names that need to be attached to the outgoing message instead of the payload. More information about this feature is in the section System properties for Service Bus Queue and Topic outputs.
  :::column-end:::
:::row-end:::


The number of partitions is based on the Service Bus SKU and size. Partition key is a unique integer value for each partition.

## Service Bus topics

Service Bus queues provide a one-to-one communication method from sender to receiver. Service Bus topics provide a one-to-many form of communication.

The following table lists the property names and their descriptions for creating a Service Bus topic output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    A friendly name used in queries to direct the query output to this Service Bus topic.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Service Bus namespace
  :::column-end:::
  :::column:::
    A container for a set of messaging entities. When you created a new event hub, you also created a Service Bus namespace.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Topic name
  :::column-end:::
  :::column:::
    Topics are messaging entities, similar to event hubs and queues. They are designed to collect event streams from devices and services. When a topic is created, it is also given a specific name. The messages sent to a topic are not available unless a subscription is created, so ensure there is one or more subscriptions under the topic.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Topic policy name
  :::column-end:::
  :::column:::
    When you create a Service Bus topic, you can also create shared access policies on the topic's Configure tab. Each shared access policy has a name, permissions that you set, and access keys.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Topic policy key
  :::column-end:::
  :::column:::
    The shared access key that is used to authenticate access to the Service Bus namespace.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    The serialization format for output data. JSON, CSV, and Avro are supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    If you are using CSV or JSON format, an encoding must be specified. UTF-8 is the only supported encoding format at this time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delimiter
  :::column-end:::
  :::column:::
    Applicable only for CSV serialization. Stream Analytics supports several common delimiters for serializing data in CSV format. Supported values are comma, semicolon, space, tab, and vertical bar.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Property columns
  :::column-end:::
  :::column:::
    Optional. Comma-separated columns that need to be attached as user properties of the outgoing message instead of the payload. More information about this feature is in the section Custom metadata properties for output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    System Property columns
  :::column-end:::
  :::column:::
    Optional. Key value pairs of System Properties and corresponding column names that need to be attached to the outgoing message instead of the payload. More information about this feature is in the section System properties for Service Bus Queue and Topic outputs.
  :::column-end:::
:::row-end:::


The number of partitions is based on the Service Bus SKU and size. The partition key is a unique integer value for each partition.

## Azure Cosmos DB

Azure Cosmos DB is a globally distributed database service that offers limitless elastic scale around the globe, rich query, and automatic indexing over schema-agnostic data models. To learn about Azure Cosmos DB container options for Stream Analytics, see the "Stream Analytics with Azure Cosmos DB as output" article.

Azure Cosmos DB output from Stream Analytics is currently not available in the Azure China 21Vianet and Azure Germany (T-Systems International) regions.

**Note** At this time, Azure Stream Analytics only supports connection to Azure Cosmos DB by using the SQL API. Other Azure Cosmos DB APIs are not yet supported. If you point Azure Stream Analytics to the Azure Cosmos DB accounts created with other APIs, the data might not be properly stored.

Azure Stream Analytics can target Azure Cosmos DB for JSON output, enabling data archiving and low-latency queries on unstructured JSON data.

The following table describes the properties for creating an Azure Cosmos DB output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    An alias to refer this output in your Stream Analytics query.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Sink
  :::column-end:::
  :::column:::
    Azure Cosmos DB.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Import option
  :::column-end:::
  :::column:::
    Choose either Select Cosmos DB from your subscription or Provide Cosmos DB settings manually.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Account ID
  :::column-end:::
  :::column:::
    The name or endpoint URI of the Azure Cosmos DB account.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Account key
  :::column-end:::
  :::column:::
    The shared access key for the Azure Cosmos DB account.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Database
  :::column-end:::
  :::column:::
    The Azure Cosmos DB database name.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Container name
  :::column-end:::
  :::column:::
    The container name to be used, which must exist in Cosmos DB. Example:
MyContainer: A container named "MyContainer" must exist.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Document ID
  :::column-end:::
  :::column:::
    Optional. The name of the field in output events that is used to specify the primary key on which insert or update operations are based.
  :::column-end:::
:::row-end:::


## Azure Data Lake Storage Gen 1

Stream Analytics supports Azure Data Lake Storage Gen 1. Azure Data Lake Storage is an enterprise-wide, hyperscale repository for big data analytic workloads. You can use Data Lake Storage to store data of any size, type, and ingestion speed for operational and exploratory analytics. Stream Analytics must be authorized to access Data Lake Storage.

Azure Data Lake Storage output from Stream Analytics is currently not available in the Azure China 21Vianet and Azure Germany (T-Systems International) regions.

The following table lists property names and their descriptions to configure your Data Lake Storage Gen 1 output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    A friendly name used in queries to direct the query output to Data Lake Store.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subscription
  :::column-end:::
  :::column:::
    The subscription that contains your Azure Data Lake Storage account.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Account name
  :::column-end:::
  :::column:::
    The name of the Data Lake Store account where you are sending your output. You are presented with a drop-down list of Data Lake Store accounts that are available in your subscription.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Path prefix pattern
  :::column-end:::
  :::column:::
    The file path that is used to write your files within the specified Data Lake Store account. You can specify one or more instances of the \{date\} and \{time\} variables:
Example 1: folder1/logs/\{date\}/\{time\}
Example 2: folder1/logs/\{date\}

The time stamp of the created folder structure follows UTC and not local time.

If the file path pattern does not contain a trailing slash (/), the last pattern in the file path is treated as a file name prefix.

New files are created in these circumstances:
Change in output schema
External or internal restart of a job
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Date format
  :::column-end:::
  :::column:::
    Optional. If the date token is used in the prefix path, you can select the date format in which your files are organized. Example: YYYY/MM/DD
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time format
  :::column-end:::
  :::column:::
    Optional. If the time token is used in the prefix path, specify the time format in which your files are organized. Currently the only supported value is HH.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    The serialization format for output data. JSON, CSV, and Avro are supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    If you are using CSV or JSON format, an encoding must be specified. UTF-8 is the only supported encoding format at this time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delimiter
  :::column-end:::
  :::column:::
    Applicable only for CSV serialization. Stream Analytics supports several common delimiters for serializing CSV data. Supported values are comma, semicolon, space, tab, and vertical bar.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Format
  :::column-end:::
  :::column:::
    Applicable only for JSON serialization. Line separated specifies that the output is formatted by having each JSON object separated by a new line. Array specifies that the output is formatted as an array of JSON objects. This array is closed only when the job stops or Stream Analytics has moved on to the next time window. In general, it is preferable to use line-separated JSON, because it does not require any special handling while the output file is still being written to.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authentication mode
  :::column-end:::
  :::column:::
    You can authorize access to your Data Lake Storage account using Managed Identity or User token. Once you grant access, you can revoke access by changing the user account password, deleting the Data Lake Storage output for this job, or deleting the Stream Analytics job.
  :::column-end:::
:::row-end:::


## SQL Database

You can use Azure SQL Database as an output for data that is relational in nature or for applications that depend on content being hosted in a relational database. Stream Analytics jobs write to an existing table in SQL Database. The table schema must exactly match the fields and their types in your job's output. You can also specify Azure SQL Data Warehouse as an output via the SQL Database output option.

You can also use Azure SQL Database Managed Instance as an output. You have to configure public endpoint in Azure SQL Database Managed Instance and then manually configure the following settings in Azure Stream Analytics. Azure virtual machine running SQL Server with a database attached is also supported by manually configuring the settings below.

The following table lists the property names and their description for creating a SQL Database output.

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Output alias
  :::column-end:::
  :::column:::
    A friendly name used in queries to direct the query output to this database.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Database
  :::column-end:::
  :::column:::
    The name of the database where you are sending your output.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Server name
  :::column-end:::
  :::column:::
    The SQL Database server name. For Azure SQL Database Managed Instance, it is required to specify the port 3342. For example, sampleserver.public.database.windows.net,3342
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Username
  :::column-end:::
  :::column:::
    The username that has write access to the database. Stream Analytics supports only SQL authentication.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Password
  :::column-end:::
  :::column:::
    The password to connect to the database.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Table
  :::column-end:::
  :::column:::
    The table name where the output is written. The table name is case-sensitive. The schema of this table should exactly match the number of fields and their types that your job output generates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Inherit partition scheme
  :::column-end:::
  :::column:::
    An option for inheriting the partitioning scheme of your previous query step, to enable fully parallel topology with multiple writers to the table. For more information, see Azure Stream Analytics output to Azure SQL Database.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Max batch count
  :::column-end:::
  :::column:::
    The recommended upper limit on the number of records sent with every bulk insert transaction.


  :::column-end:::
:::row-end:::


## Azure Functions

Azure Functions is a serverless compute service that you can use to run code on-demand without having to explicitly provision or manage infrastructure. It lets you implement code that is triggered by events occurring in Azure or partner services. This ability of Azure Functions to respond to triggers makes it a natural output for Azure Stream Analytics. This output adapter enables users to connect Stream Analytics to Azure Functions, and run a script or piece of code in response to various events.

Azure Functions output from Stream Analytics is currently not available in the Azure China 21Vianet and Azure Germany (T-Systems International) regions.

Azure Stream Analytics invokes Azure Functions via HTTP triggers. The Azure Functions output adapter is available with the following configurable properties:

:::row:::
  :::column:::
    **Property name**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Function app
  :::column-end:::
  :::column:::
    The name of your Azure Functions app.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Function
  :::column-end:::
  :::column:::
    The name of the function in your Azure Functions app.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Key
  :::column-end:::
  :::column:::
    If you want to use an Azure Function from another subscription, you can do so by providing the key to access your function.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Max batch size
  :::column-end:::
  :::column:::
    A property that lets you set the maximum size for each output batch that is sent to your Azure function. The input unit is in bytes. By default, this value is 262,144 bytes (256 KB).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Max batch count
  :::column-end:::
  :::column:::
    A property that lets you specify the maximum number of events in each batch that is sent to Azure Functions. The default value is 100.
  :::column-end:::
:::row-end:::


When Azure Stream Analytics receives a 413 ("http Request Entity Too Large") exception from an Azure function, it reduces the size of the batches that it sends to Azure Functions. In your Azure function code, use this exception to make sure that Azure Stream Analytics does not send oversized batches. Also, make sure that the maximum batch count and size values used in the function are consistent with the values entered in the Stream Analytics portal.

**Note** During test connection, Stream Analytics sends an empty batch to Azure Functions to test if the connection between the two works. Make sure that your Functions app handles empty batch requests to make sure test connection passes.

Also, in a situation where there is no event landing in a time window, no output is generated. As a result, the computeResult function isn't called. This behavior is consistent with the built-in windowed aggregate functions.

## Custom metadata properties for output

You can attach query columns as user properties to your outgoing messages. These columns do not go into the payload. The properties are present in the form of a dictionary on the output message. Key is the column name and value is the column value in the properties dictionary. All Stream Analytics data types are supported except Record and Array. Supported outputs:

 -  Service Bus queue
 -  Service Bus topic
 -  Event hub

In the following example, we add the two fields DeviceId and DeviceStatus to the metadata.

 -  Query: `select *, DeviceId, DeviceStatus from iotHubInput`
 -  Output configuration: `DeviceId, DeviceStatus`

## System properties for Service Bus queue and topic outputs

You can attach query columns as system properties to your outgoing service bus Queue or Topic messages. These columns do not go into the payload instead the corresponding BrokeredMessage system property is populated with the query column values. These system properties are supported - `MessageId, ContentType, Label, PartitionKey, ReplyTo, SessionId, CorrelationId, To, ForcePersistence, TimeToLive, ScheduledEnqueueTimeUtc`. String values of these columns are parsed as corresponding system property value type and any parsing failures are treated as data errors. This field is provided as a JSON object format. Details about this format are as follows -

 -  Surrounded by curly braces \{\}.
 -  Written in key/value pairs.
 -  Keys and values must be strings.
 -  Key is the system property name and value is the query column name.
 -  Keys and values are separated by a colon.
 -  Each key/value pair is separated by a comma.

This shows how to use this property –

 -  Query: `select *, column1, column2 INTO queueOutput FROM iotHubInput`
 -  System Property Columns: `{ "MessageId": "column1", "PartitionKey": "column2"}`

This sets the `MessageId` on service bus queue messages with `column1`'s values and PartitionKey is set with `column2`'s values.

## Partitioning

The following table summarizes the partition support and the number of output writers for each output type:

:::row:::
  :::column:::
    **Output type**
  :::column-end:::
  :::column:::
    **Partitioning support**
  :::column-end:::
  :::column:::
    **Partition key**
  :::column-end:::
  :::column:::
    **Number of output writers**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Data Lake Store
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Use \{date\} and \{time\} tokens in the path prefix pattern. Choose the date format, such as YYYY/MM/DD, DD/MM/YYYY, or MM-DD-YYYY. HH is used for the time format.
  :::column-end:::
  :::column:::
    Follows the input partitioning for fully parallelizable queries.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure SQL Database
  :::column-end:::
  :::column:::
    Yes, needs to enabled.
  :::column-end:::
  :::column:::
    Based on the PARTITION BY clause in the query.
  :::column-end:::
  :::column:::
    When Inherit Partitioning option is enabled, follows the input partitioning for fully parallelizable queries. To learn more about achieving better write throughput performance when you are loading data into Azure SQL Database, see Azure Stream Analytics output to Azure SQL Database.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Blob storage
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Use \{date\} and \{time\} tokens from your event fields in the path pattern. Choose the date format, such as YYYY/MM/DD, DD/MM/YYYY, or MM-DD-YYYY. HH is used for the time format. Blob output can be partitioned by a single custom event attribute \{fieldname\} or \{datetime:&lt;specifier&gt;\}.
  :::column-end:::
  :::column:::
    Follows the input partitioning for fully parallelizable queries.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Event Hubs
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Varies depending on partition alignment.
When the partition key for event hub output is equally aligned with the upstream (previous) query step, the number of writers is the same as the number of partitions in event hub output. Each writer uses the EventHubSender class to send events to the specific partition.
When the partition key for event hub output is not aligned with the upstream (previous) query step, the number of writers is the same as the number of partitions in that prior step. Each writer
  :::column-end:::
  :::column:::
    Uses the SendBatchAsync class in EventHubClient to send events to all the output partitions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Power BI
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    None
  :::column-end:::
  :::column:::
    Not applicable.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Table storage
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Any output column.
  :::column-end:::
  :::column:::
    Follows the input partitioning for fully parallelized queries.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Service Bus topic
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Automatically chosen. The number of partitions is based on the Service Bus SKU and size. The partition key is a unique integer value for each partition.
  :::column-end:::
  :::column:::
    Same as the number of partitions in the output topic.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Service Bus queue
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Automatically chosen. The number of partitions is based on the Service Bus SKU and size. The partition key is a unique integer value for each partition.
  :::column-end:::
  :::column:::
    Same as the number of partitions in the output queue.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Cosmos DB
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Based on the PARTITION BY clause in the query.
  :::column-end:::
  :::column:::
    Follows the input partitioning for fully parallelized queries.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Functions
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Based on the PARTITION BY clause in the query.
  :::column-end:::
  :::column:::
    Follows the input partitioning for fully parallelized queries.
  :::column-end:::
:::row-end:::


The number of output writers can also be controlled using `INTO <partition count>` clause in your query, which can be helpful in achieving a desired job topology. If your output adapter is not partitioned, lack of data in one input partition will cause a delay up to the late arrival amount of time. In such cases, the output is merged to a single writer, which might cause bottlenecks in your pipeline.

## Output batch size

Azure Stream Analytics uses variable-size batches to process events and write to outputs. Typically the Stream Analytics engine does not write one message at a time, and uses batches for efficiency. When the rate of both the incoming and outgoing events is high, Stream Analytics uses larger batches. When the egress rate is low, it uses smaller batches to keep latency low.

The following table explains some of the considerations for output batching:

:::row:::
  :::column:::
    **Output type**
  :::column-end:::
  :::column:::
    **Max message size**
  :::column-end:::
  :::column:::
    **Batch size optimization**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Data Lake Store
  :::column-end:::
  :::column:::
    See Data Lake Storage limits: [https://docs.microsoft.com/azure/azure-subscription-service-limits\#data-lake-store-limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#data-lake-store-limits)
  :::column-end:::
  :::column:::
    Use up to 4 MB per write operation.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure SQL Database
  :::column-end:::
  :::column:::
    Configurable using Max batch count. 10,000 maximum and 100 minimum rows per single bulk insert by default.
  :::column-end:::
  :::column:::
    Every batch is initially bulk inserted with maximum batch count. Batch is split in half (until minimum batch count) based on retryable errors from SQL.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Blob storage
  :::column-end:::
  :::column:::
    See Azure Storage limits: [https://docs.microsoft.com/azure/azure-subscription-service-limits\#storage-limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#storage-limits)
  :::column-end:::
  :::column:::
    The maximum blob block size is 4 MB.
The maximum blob bock count is 50,000.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Event Hubs
  :::column-end:::
  :::column:::
    256 KB or 1 MB per message.
  :::column-end:::
  :::column:::
    When input/output partitioning isn't aligned, each event is packed individually in EventData and sent in a batch of up to the maximum message size. This also happens if custom metadata properties are used.

When input/output partitioning is aligned, multiple events are packed into a single EventData instance, up to the maximum message size, and sent.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Power BI
  :::column-end:::
  :::column:::
    See Power BI Rest API limits: [https://msdn.microsoft.com/library/dn950053.aspx](https://msdn.microsoft.com/library/dn950053.aspx)
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Table storage
  :::column-end:::
  :::column:::
    See Azure Storage limits: [https://docs.microsoft.com/azure/azure-subscription-service-limits\#storage-limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#storage-limits)
  :::column-end:::
  :::column:::
    The default is 100 entities per single transaction. You can configure it to a smaller value as needed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Service Bus queue
  :::column-end:::
  :::column:::
    256 KB per message for Standard tier, 1 MB for Premium tier.
  :::column-end:::
  :::column:::
    Use a single event per message.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Service Bus topic
  :::column-end:::
  :::column:::
    256 KB per message for Standard tier, 1 MB for Premium tier.
  :::column-end:::
  :::column:::
    Use a single event per message.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Cosmos DB
  :::column-end:::
  :::column:::
    See Azure Cosmos DB limits: [https://docs.microsoft.com/azure/azure-subscription-service-limits\#azure-cosmos-db-limits](https://docs.microsoft.com/azure/azure-subscription-service-limits#azure-cosmos-db-limits)
  :::column-end:::
  :::column:::
    Batch size and write frequency are adjusted dynamically based on Azure Cosmos DB responses.
There are no predetermined limitations from Stream Analytics.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Functions
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    The default batch size is 262,144 bytes (256 KB).
The default event count per batch is 100.
The batch size is configurable and can be increased or decreased in the Stream Analytics output options.
  :::column-end:::
:::row-end:::
