Azure Storage resource logs capture each operation performed in your storage account, as well as the outcome of these operations. These logs provide details about each request made rather than providing the minute-by-minute summary of operations that the metrics show. Using the logging information, you can examine the nature of requests made to a storage account and determine whether these requests are successful.

In this unit, you'll learn about Azure Storage resource logs in Azure Monitor. You'll see the different types of information captured in logs, and how you might use this information to detect problems that might occur when an application uses Azure Storage.

## Resource Logs in Azure Monitor

Sometimes you want to see more detail about storage transactions than performance-related metrics. Metrics are useful for tracking overall trends in performance or demand, but monitoring the transaction metrics can't reveal the requested URLs. Also, none of the available storage metrics can give error messages that relate to a specific request.

Resource logs in Azure Monitor capture this kind of detailed information, and they're useful for examining the detail behind specific requests. For example, you can use these logs if you want to know how many requests for a specific resource are authenticated or anonymous, or successful, or failed.

To collect resource logs, you must create a diagnostic setting. Resource logs list successful and failed requests for a storage account. Requests are recorded as read, write, or delete operations against the specific storage service: Azure Blob Storage, Table Storage, or Queue Storage. By using a diagnostic setting, you can route logs to Log Analytics, a storage account, or stream them to an event hub or to a partner solution.

You can use resource logs to review different types and frequency of requests, or to troubleshoot failed requests. Logs are generated only when transactions occur, and only for the specific service endpoint. Therefore, if you're using storage in the Blob Storage and Queue Storage endpoints, but only the Blob Storage endpoint has requests or transactions, then the system will create logs only for Blob Storage.

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

Resource logs are automatically generated for your storage account, but those logs aren't available to view unless you send them to a destination. You can specify where to send them by using a diagnostic setting.

When you create a diagnostic setting, you choose the type of storage for which you're interested in routing logs (for example: Blob Storage or File Storage). Then, you'll choose which types of operations you want to appear in logs (for example: read, write, or delete operations). Finally, you'll choose where you would like logs to be sent. You can send log to any of these locations:

* Log Analytics

* Storage account

* Event hub

* A partner solution

You can access logs sent to a Log Analytics workspace by using Azure Monitor log queries.

If you route logs to a storage account, those logs appear as blobs stored to a container. Data is collected and stored inside a single blob as a line-delimited JSON payload. The name of the blob follows this naming convention:

`https://<destination-storage-account>.blob.core.windows.net/insights-logs-<storage-operation>/resourceId=/subscriptions/<subscription-ID>/resourceGroups/<resource-group-name>/providers/Microsoft.Storage/storageAccounts/<source-storage-account>/blobServices/default/y=<year>/m=<month>/d=<day>/h=<hour>/m=<minute>/PT1H.json`

Logs sent to an event hub aren't stored as a file, but you can verify that the event hub received the log information by opening your event hub in the Azure portal and examining the incoming messages count.

You can also send platform metrics and logs to certain Azure Monitor partners. You must first install a partner integration into your subscription. Configuration options vary by partner.

You can't set a retention policy for log data. If you send logs to Log Analytics, you can manage the data retention period at the workspace level or even specify different retention settings by data type. If you archive logs to a storage account, you can manage a log container's retention policy by defining a lifecycle management policy.
