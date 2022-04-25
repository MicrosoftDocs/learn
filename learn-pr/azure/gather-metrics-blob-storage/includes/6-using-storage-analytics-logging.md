You're now satisfied that metrics will provide enough statistical information about the use and performance of Azure Blob Storage for the company. 

But before you commit to the platform, you want to be sure that can troubleshoot any issues that might occur with files that are shared with the customer. For example, you want to be able to detect if files aren't downloaded successfully. You want to see what troubleshooting information Azure provides, and how to access the log files.

## Storage Analytics logging

Sometimes you want to see more detail about storage transactions than performance-related metrics. Metrics are useful for tracking overall trends in performance or demand, but monitoring the transaction metrics can't reveal the requested URLs. Also, none of the available storage metrics can give error messages that relate to a specific request.

Resource logs in Azure Monitor capture this kind of detailed information and they are useful for examining the detail behind specific requests. For example, you can use these logs if you want to know how many requests for a specific resource are authenticated or anonymous, or successful or failed.

To collect resource logs, you must create a diagnostic setting. Resource logs will list successful and failed requests for a storage account. Requests are recorded as read, write, or delete operations against the specific storage service: Azure Blob Storage, Table Storage, or Queue Storage. By using a diagnostic setting, you can route logs to Log Analytics, a storage account or stream them to an event hub.

You can use resource logs to review different types and frequency of requests, or to troubleshoot failed requests. Logs are generated only when transactions occur, and only for the specific service endpoint. So if you're using storage in the Blob Storage and Queue Storage endpoints, but only the Blob Storage endpoint has requests or transactions, then the system will create logs only for Blob Storage.

When you enable logging, these types of requests are logged:

* Authenticated requests
* Anonymous requests
* Successful requests
* Failed requests, such as timeouts, throttling, network errors, and authorization errors
* Server errors
* Requests that use a shared access signature, both failed and successful
* Timeout errors for client and server
* Requests to analytics data
* GET requests with error code 304 ("Not Modified")

## Storage of resource logs in Azure Monitor

When you create a diagnostic setting, you'll choose the type of storage that you want to enable logs for (For example: `blob` or `file`). Then, you'll choose the log categories (For example: read, write, or delete operations). Finally, you'll choose where you would like logs to be sent. You can send log to any of these locations:

- Log Analytics
- Storage account
- Event hub

You can't set a retention policy. However, you can manage the data retention period of Log Analytics at the workspace level or even specify different retention settings by data type.

You can access logs sent to a Log Analytics workspace by using Azure Monitor log queries.
If you route logs to a storage account, those logs appear as blobs stored to a container. Data is collected and stored inside a single blob as a line-delimited JSON payload. The name of the blob follows this naming convention:

`https://<destination-storage-account>.blob.core.windows.net/insights-logs-<storage-operation>/resourceId=/subscriptions/<subscription-ID>/resourceGroups/<resource-group-name>/providers/Microsoft.Storage/storageAccounts/<source-storage-account>/blobServices/default/y=<year>/m=<month>/d=<day>/h=<hour>/m=<minute>/PT1H.json`

Logs sent to an event hub aren't stored as a file, but you can verify that the event hub received the log information by opening your event hub in the Azure portal, and then examining the incoming messages count.

