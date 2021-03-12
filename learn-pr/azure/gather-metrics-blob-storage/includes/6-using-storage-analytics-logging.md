You're now satisfied that metrics will provide enough statistical information about the use and performance of Azure Blob Storage for the company. 

But before you commit to the platform, you want to be sure that can troubleshoot any issues that might occur with files that are shared with the customer. For example, you want to be able to detect if files aren't downloaded successfully. You want to see what troubleshooting information Azure provides, and how to access the log files.

By the end of this unit, you'll be able to:

- Configure Azure Storage Analytics logging.
- Retrieve log file information to analyze storage transactions.

## Storage Analytics logging

Sometimes you want to see more detail about storage transactions than performance-related metrics. Metrics are useful for tracking overall trends in performance or demand, but monitoring the transaction metrics can't reveal the requested URLs. Also, none of the available storage metrics can give error messages that relate to a specific request. 

Storage Analytics logging captures this kind of detailed information and is useful for examining the detail behind specific requests. For example, you can use these logs if you want to know how many requests for a specific resource are authenticated or anonymous, or successful or failed.

Storage Analytics logging records successful and failed requests for a storage account. Requests are recorded as read, write, or delete operations against the specific storage service: Azure Blob Storage, Table Storage, or Queue Storage. These requests are then captured in a separate storage blob for later analysis.

You can use Storage Analytics logs to review different types and frequency of requests, or to troubleshoot failed requests. Logs are generated only when transactions occur, and only for the specific service endpoint. So if you're using storage in the Blob Storage and Queue Storage endpoints, but only the Blob Storage endpoint has requests or transactions, then the system will create logs only for Blob Storage.

> [!NOTE]
> At this time, Storage Analytics logging is available only for Blob Storage, Queue Storage, and Table Storage.

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

> [!NOTE]
> Storage Analytics doesn't log its own requests, such as requests to create or delete logs. 

## Storage of analytics logs

All analytics logs are stored in blobs, inside a container called `$logs`. Azure creates this container automatically when you create a storage account, and the container can't be deleted. However, the contents of the container can be deleted. Azure deletes log files automatically after seven days by default.

You can determine the current status of analytics logging for your storage account by using the `Get-AzStorageServiceLoggingProperty` PowerShell cmdlet. For example, to check the logging setting for Blob Storage on a storage account called *ContosoStorage1* in a resource group called *ContosoRG*, you would use the following two commands:

```powershell
Set-AzCurrentStorageAccount -Name ContosoStorage1 -ResourceGroupName ContosoRG
Get-AzStorageServiceLoggingProperty -ServiceType blob
```

You can also change the logging settings, including the log retention period and the events that are recorded, by using the `Set-AzStorageServiceLoggingProperty` cmdlet.

Logs are stored in the `$logs` folder of your storage account endpoint. They're then stored inside a folder structure that denotes the service type, year, month, day, and hour of the events. 

For example, the logs for files in Blob Storage between 4 PM and 5 PM on February 15, 2019, would use the following path: `https://<storageaccountname>.blob.core.windows.net/$logs/blob/2019/02/15/1600/`. The files are numbered starting from *000000.log* in each folder.

You can view or retrieve log files for analysis in various ways:

- You can download logs by using the AzCopy.exe command-line tool. AzCopy is available in Azure Cloud Shell, or you can download the latest version from the [Get started with AzCopy](https://docs.microsoft.com/azure/storage/common/storage-use-azcopy-v10) article.
- You can use [Azure Storage Explorer](https://azure.microsoft.com/features/storage-explorer/).
- You can download logs programmatically.
- You can view log data by using the Log Analytics tool in the Azure portal.

## Formatting of analytics logs

Storage Analytics logs are stored according to a standard format and version. There are two versions of log entries. Both versions conform to the following rules:

- All log fields, whether populated or empty, are separated by a semicolon (`;`).
- The last field of an entry does *not* end with a semicolon (`;`).
- Individual log entries end with a newline character (`\n`).
- The first field in a log entry specifies the log version number.

Version 1.0 log entries use the following format:

`<version-number>;<request-start-time>;<operation-type>;<request-status>;<http-status-code>;<end-to-end-latency-in-ms>;<server-latency-in-ms>;<authentication-type>;<requester-account-name>;<owner-account-name>;<service-type>;<request-url>;<requested-object-key>;<request-id-header>;<operation-count>;<requester-ip-address>;<request-version-header>;<request-header-size>;<request-packet-size>;<response-header-size>;<response-packet-size>;<request-content-length>;<request-md5>;<server-md5>;<etag-identifier>;<last-modified-time>;<conditions-used>;<user-agent-header>;<referrer-header>;<client-request-id>`

Version 2.0 log entries use the following format:

`<version-number>;<request-start-time>;<operation-type>;<request-status>;<http-status-code>;<end-to-end-latency-in-ms>;<server-latency-in-ms>;<authentication-type>;<requester-account-name>;<owner-account-name>;<service-type>;<request-url>;<requested-object-key>;<request-id-header>;<operation-count>;<requester-ip-address>;<request-version-header>;<request-header-size>;<request-packet-size>;<response-header-size>;<response-packet-size>;<request-content-length>;<request-md5>;<server-md5>;<etag-identifier>;<last-modified-time>;<conditions-used>;<user-agent-header>;<referrer-header>;<client-request-id>;<user-object-id>;<tenant-id>;<application-id>;<audience>;<issuer>;<user-principal-name>;<reserved-field>;<authorization-detail>`

Version 2.0 log entries include all version 1.0 fields. Version 2.0 entries add fields to record information about OAuth 2.0 token authorization.

Blob Storage and Queue Storage support log versions 1.0 and 2.0. Table Storage and Azure Files support only version 1.0.
