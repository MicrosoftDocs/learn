Reference data (also known as a lookup table) is a finite data set that is static or slowly changing in nature, used to perform a lookup or to augment your data streams. For example, in an IoT scenario, you could store metadata about sensors (which don’t change often) in reference data and join it with real-time IoT data streams. Azure Stream Analytics loads reference data in memory to achieve low latency stream processing. To make use of reference data in your Azure Stream Analytics job, you will generally use a Reference Data Join in your query.

Stream Analytics supports Azure Blob storage, Azure Data Lake Storage Gen2, and Azure SQL Database as the storage layer for Reference Data. You can also transform and/or copy reference data to Blob storage from Azure Data Factory to use any number of cloud-based and on-premises data stores.

## Static reference data

If your reference data is not expected to change, then support for static reference data is enabled by specifying a static path in the input configuration. Azure Stream Analytics picks up the blob from the specified path. `{date}` and `{time}` substitution tokens aren't required. Because reference data is immutable in Stream Analytics, overwriting a static reference data blob is not recommended.

## Generate reference data on a schedule

If your reference data is a slowly changing data set, then support for refreshing reference data is enabled by specifying a path pattern in the input configuration using the `{date}` and `{time}` substitution tokens. Stream Analytics picks up the updated reference data definitions based on this path pattern. For example, a pattern of `sample/{date}/{time}/products.csv` with a date format of "YYYY-MM-DD" and a time format of "HH-mm" instructs Stream Analytics to pick up the updated blob sample/2015-04-16/17-30/products.csv at 5:30 PM on April 16, 2015 UTC time zone.

Azure Stream Analytics automatically scans for refreshed reference data blobs at a one-minute interval.

> [!NOTE]
> You can find more information about reference data input here: [Use reference data for lookups in Stream Analytics](/azure/stream-analytics/stream-analytics-use-reference-data)
