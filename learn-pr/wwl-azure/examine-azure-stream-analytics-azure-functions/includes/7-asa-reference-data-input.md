Reference data (also known as a lookup table) is a finite data set that is static or slowly changing in nature, used to perform a lookup or to augment your data streams. For example, in an IoT scenario, you could store metadata about sensors (which don’t change often) in reference data and join it with real-time IoT data streams. Azure Stream Analytics loads reference data in memory to achieve low latency stream processing. To make use of reference data in your Azure Stream Analytics job, you will generally use a Reference Data Join in your query.

Stream Analytics supports Azure Blob storage and Azure SQL Database as the storage layer for Reference Data. You can also transform and/or copy reference data to Blob storage from Azure Data Factory to use any number of cloud-based and on-premises data stores.

## Azure Blob storage

Reference data is modeled as a sequence of blobs (defined in the input configuration) in ascending order of the date/time specified in the blob name. It only supports adding to the end of the sequence by using a date/time greater than the one specified by the last blob in the sequence.

### Configure blob reference data

To configure your reference data, you first need to create an input that is of type Reference Data. The table below explains each property that you will need to provide while creating the reference data input with its description:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Input Alias
  :::column-end:::
  :::column:::
    A friendly name that will be used in the job query to reference this input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage Account
  :::column-end:::
  :::column:::
    The name of the storage account where your blobs are located. If it’s in the same subscription as your Stream Analytics Job, you can select it from the drop-down.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage Account Key
  :::column-end:::
  :::column:::
    The secret key associated with the storage account. This gets automatically populated if the storage account is in the same subscription as your Stream Analytics job.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage Container
  :::column-end:::
  :::column:::
    Containers provide a logical grouping for blobs stored in the Microsoft Azure Blob service. When you upload a blob to the Blob service, you must specify a container for that blob.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Path Pattern
  :::column-end:::
  :::column:::
    The path used to locate your blobs within the specified container. Within the path, you may choose to specify one or more instances of the following two variables:
\{date\}, \{time\}
Example 1: products/\{date\}/\{time\}/product-list.csv
Example 2: products/\{date\}/product-list.csv
Example 3: product-list.csv

If the blob doesn't exist in the specified path, the Stream Analytics job will wait indefinitely for the blob to become available.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Date Format \[optional\]
  :::column-end:::
  :::column:::
    If you have used \{date\} within the Path Pattern that you specified, then you can select the date format in which your blobs are organized from the drop-down of supported formats.
Example: YYYY/MM/DD, MM/DD/YYYY, etc.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time Format \[optional\]
  :::column-end:::
  :::column:::
    If you have used \{time\} within the Path Pattern that you specified, then you can select the time format in which your blobs are organized from the drop-down of supported formats.
Example: HH, HH/mm, or HH-mm.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event Serialization Format
  :::column-end:::
  :::column:::
    To make sure your queries work the way you expect, Stream Analytics needs to know which serialization format you're using for incoming data streams. For Reference Data, the supported formats are CSV and JSON.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    UTF-8 is the only supported encoding format at this time.
  :::column-end:::
:::row-end:::


### Static reference data

If your reference data is not expected to change, then support for static reference data is enabled by specifying a static path in the input configuration. Azure Stream Analytics picks up the blob from the specified path. `{date}` and `{time}` substitution tokens aren't required. Because reference data is immutable in Stream Analytics, overwriting a static reference data blob is not recommended.

### Generate reference data on a schedule

If your reference data is a slowly changing data set, then support for refreshing reference data is enabled by specifying a path pattern in the input configuration using the `{date}` and `{time}` substitution tokens. Stream Analytics picks up the updated reference data definitions based on this path pattern. For example, a pattern of `sample/{date}/{time}/products.csv` with a date format of "YYYY-MM-DD" and a time format of "HH-mm" instructs Stream Analytics to pick up the updated blob sample/2015-04-16/17-30/products.csv at 5:30 PM on April 16, 2015 UTC time zone.

Azure Stream Analytics automatically scans for refreshed reference data blobs at a one-minute interval. If a blob with timestamp 10:30:00 is uploaded with a small delay (for example, 10:30:30), you will notice a small delay in Stream Analytics job referencing this blob. To avoid such scenarios, it is recommended to upload the blob earlier than the target effective time (10:30:00 in this example) to allow the Stream Analytics job enough time to discover and load it in memory and perform operations.

> [!NOTE]
> Currently Stream Analytics jobs look for the blob refresh only when the machine time advances to the time encoded in the blob name. For example, the job will look for sample/2015-04-16/17-30/products.csv as soon as possible but no earlier than 5:30 PM on April 16, 2015 UTC time zone. It will never look for a blob with an encoded time earlier than the last one that is discovered. For example, once the job finds the blob sample/2015-04-16/17-30/products.csv it will ignore any files with an encoded date earlier than 5:30 PM April 16, 2015 so if a late arriving sample/2015-04-16/17-25/products.csv blob gets created in the same container the job will not use it. Likewise if sample/2015-04-16/17-30/products.csv is only produced at 10:03 PM April 16, 2015 but no blob with an earlier date is present in the container, the job will use this file starting at 10:03 PM April 16, 2015 and use the previous reference data until then. An exception to this is when the job needs to reprocess data back in time or when the job is first started. At start time the job is looking for the most recent blob produced before the job start time specified. This is done to ensure that there is a non-empty reference data set when the job starts. If one cannot be found, the job displays the following diagnostic: Initializing input without a valid reference data blob for UTC time &lt;start time&gt;.

Azure Data Factory can be used to orchestrate the task of creating the updated blobs required by Stream Analytics to update reference data definitions. Data Factory is a cloud-based data integration service that orchestrates and automates the movement and transformation of data. Data Factory supports connecting to a large number of clouds based and on-premises data stores and moving data easily on a regular schedule that you specify.

### Tips on refreshing blob reference data

1.  Do not overwrite reference data blobs as they are immutable.
2.  The recommended way to refresh reference data is to:
    
     -  Use `{date}/{time}` in the path pattern.
     -  Add a new blob using the same container and path pattern defined in the job input.
     -  Use a date/time greater than the one specified by the last blob in the sequence.
3.  Reference data blobs are not ordered by the blob’s "Last Modified" time but only by the time and date specified in the blob name using the `{date}` and `{time}` substitutions.
4.  To avoid having to list large number of blobs, consider deleting very old blobs for which processing will no longer be done. Note that Azure Stream Analytics might have to reprocess a small amount in some scenarios like a restart.

## Azure SQL Database

Azure SQL Database reference data is retrieved by your Stream Analytics job and is stored as a snapshot in memory for processing. The snapshot of your reference data is also stored in a container in a storage account that you specify in the configuration settings. The container is autocreated when the job starts. If the job is stopped or enters a failed state, the autocreated containers are deleted when the job is restarted.

If your reference data is a slowly changing data set, you need to periodically refresh the snapshot that is used in your job. Stream Analytics allows you to set a refresh rate when you configure your Azure SQL Database input connection. The Stream Analytics runtime will query your Azure SQL Database at the interval specified by the refresh rate. The fastest refresh rate supported is once per minute. For each refresh, Stream Analytics stores a new snapshot in the storage account provided.

Stream Analytics provides two options for querying your Azure SQL Database. A snapshot query is mandatory and must be included in each job. Stream Analytics runs the snapshot query periodically based on your refresh interval and uses the result of the query (the snapshot) as the reference data set. The snapshot query should fit most scenarios, but if you run into performance issues with large data sets and fast refresh rates, you can use the delta query option. Queries that take more than 60 seconds to return reference data set will result in a timeout.

With the delta query option, Stream Analytics runs the snapshot query initially to get a baseline reference data set. After, Stream Analytics runs the delta query periodically based on your refresh interval to retrieve incremental changes. These incremental changes are continually applied to the reference data set to keep it updated. Using delta query may help reduce storage cost and network I/O operations.

### Configure SQL Database reference

To configure your SQL Database reference data, you first need to create Reference Data input. The table below explains each property that you will need to provide while creating the reference data input with its description. For more information, see Use reference data from a SQL Database for an Azure Stream Analytics job.

You can use Azure SQL Database Managed Instance as a reference data input. You have to configure public endpoint in Azure SQL Database Managed Instance and then manually configure the following settings in Azure Stream Analytics. Azure virtual machine running SQL Server with a database attached is also supported by manually configuring the settings below.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Input alias
  :::column-end:::
  :::column:::
    A friendly name that will be used in the job query to reference this input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subscription
  :::column-end:::
  :::column:::
    Choose your subscription.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Database
  :::column-end:::
  :::column:::
    The Azure SQL Database that contains your reference data. For Azure SQL Database Managed Instance, it is required to specify the port 3342. For example, sampleserver.public.database.windows.net,3342
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Username
  :::column-end:::
  :::column:::
    The username associated with your Azure SQL Database.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Password
  :::column-end:::
  :::column:::
    The password associated with your Azure SQL Database.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Refresh periodically
  :::column-end:::
  :::column:::
    This option allows you to choose a refresh rate. Choosing "On" will allow you to specify the refresh rate in DD:HH:MM.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Snapshot query
  :::column-end:::
  :::column:::
    This is the default query option that retrieves the reference data from your SQL Database.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Delta query
  :::column-end:::
  :::column:::
    For advanced scenarios with large data sets and a short refresh rate, choose to add a delta query.
  :::column-end:::
:::row-end:::


## Size limitation

Stream Analytics supports reference data with maximum size of 300 MB. The 300 MB limit of maximum size of reference data is achievable only with simple queries. As the complexity of query increases to include stateful processing, such as windowed aggregates, temporal joins and temporal analytic functions, it is expected that the maximum supported size of reference data decreases. If Azure Stream Analytics cannot load the reference data and perform complex operations, the job will run out of memory and fail. In such cases, SU % Utilization metric will reach 100%.

:::row:::
  :::column:::
    **Number of Streaming Units**
  :::column-end:::
  :::column:::
    **Approx. Max Size Supported (in MB)**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    50
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    3
  :::column-end:::
  :::column:::
    150
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    6 and beyond
  :::column-end:::
  :::column:::
    300
  :::column-end:::
:::row-end:::
