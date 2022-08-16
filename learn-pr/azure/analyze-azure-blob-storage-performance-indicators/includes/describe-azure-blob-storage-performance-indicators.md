Premium Blob Storage represents a performance tier in Azure Blob Storage that provides block blobs and appends blob capabilities. The Premium Blob Storage tier complements the Hot, Cool, and Archive access tiers supported by general-purpose storage that offers standard performance. Premium Blob accounts use high-performance solid-state drives (SSDs) that are optimized for low latency, while the general-purpose storage accounts rely on hard-disk drives (HDD) as their underlying storage media.

To assess and compare storage performance, you should measure performance indicators. These indicators help you evaluate the speed of processing user requests, the amount of data that the storage account can process per request, the number of requests that it can process in a specific period of time, and the response time after submitting a request. These performance indicators are known as I/O operations per second (IOPS), throughput, and latency.

### IOPS

The IOPS indicator represents the number of requests that a storage resource is capable of processing in one second. An operation could be an individual read or write request, which can be either sequential, or random. This indicator is particularly important when working with Online Transaction Processing (OLTP) workloads, such as an online retail website, which needs to process multiple user requests simultaneously. 

### Throughput

Throughput is equivalent to bandwidth and represents the amount of data that a storage resource can process in a specified time interval. This indicator is particularly important when working with workloads that generate or consume large IO unit sizes. Among the most common workloads that belong to this category are data warehouse applications, which tend to access large portions of data at a time and typically perform bulk operations.

### Latency

Latency represents the time it takes for a storage resource to process a single request and return a response to its sender. In addition to IOPS and throughput, the latency indicator provides a critical measure of an application's performance. Azure Premium Blob Storage provides consistently low latencies.

>[!Note] 
>To evaluate the consistency of storage performance indicators, it's common to calculate performance data for the 99th percentile of storage operations.
>
