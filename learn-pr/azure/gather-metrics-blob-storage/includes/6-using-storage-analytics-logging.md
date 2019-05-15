You are now satisfied that the metrics will provide enough statistical information about the use and performance of Azure Blob storage for the company. However, before you commit to the platform, you want to be sure that you will be able to troubleshoot any issues that might occur with files that are shared with clients; for example:you want to be able to detect if files are not successfully downloading.

You want to see what troubleshooting information is logged by Azure, and how to access the log files.

## Learning Objective

By the end of this unit, you will be able to configure Storage Analytics logging, and retrieve log file information to analyze storage transactions.

## Storage Analytics Logging

Sometimes you will want to see more detail about storage transactions than performance-related metrics. Metrics are useful for tracking overall trends in performance or demand, but monitoring the transaction metrics cannot reveal the requested URLs, and none of the available storage metrics can give error messages relating to a specific request. This kind of detailed information is captured by Storage Analytics logging, and is useful for examining the detail behind specific requests; for example: if you wanted to know how many requests for a specific resource are authenticated or anonymous, or successful or failed.

Storage Analytics logging records successful and failed requests for a storage account. Requests are recorded as read, write, or delete operations against the specific storage service - Blob, Table, or Queue - and captured into a separate storage blob for analysis later. You can use Storage Analytics logs to review different types and frequency of request, or to troubleshoot failed requests. Logs are only generated when transactions occur, and only for the specific service endpoint; so if you are using storage in the Blob and Queue endpoints, but only the Blob endpoint has requests or transactions, then the system will only create logs for the Blob service.

> [!NOTE]
> Note: Storage Analytics logging is only available for the Blob, Queue, and Table services at the time of writing.

The following list shows which types of requests are logged when logging is enabled:

* Authenticated requests that are logged
* Anonymous requests that are logged
* Successful requests
* Failed requests, such as timeouts, throttling, network, and authorization errors
* Server errors
* Requests using a Shared Access Signature (SAS), both failed and successful
* Timeout errors for client and server
* Requests to analytics data
* GET requests with error code 304 (Not Modified)

> [!NOTE]
> Note: Requests made by storage analytics, such as to create or delete logs, are not logged.
> 

## Analytics log storage

All analytics logs are stored in blobs, inside a container called `$logs`. Azure creates this container automatically when creating the storage account, and the container cannot be deleted. However the contents of the container can be deleted. Azure will delete log files automatically after seven days by default.

You can determine the current status of analytics logging for your storage account by using the `Get-AzStorageServiceLoggingProperty` PowerShell cmdlet. For example, to check the logging setting for blob storage on a storage account called *ContosoStorage1* in a resource group called *ContosoRG*, you would use the following two commands:

```powershell
Set-AzCurrentStorageAccount -Name ContosoStorage1 -ResourceGroupName ContosoRG
Get-AzStorageServiceLoggingProperty -ServiceType blob
```

You can also change the logging settings, including the log retention period and the events that are recorded by using the `Set-AzStorageServiceLoggingProperty` cmdlet.

Logs are stored in the `$logs` folder of your storage account endpoint, then inside a folder structure denoting the service type, year, month, day, and hour of the events. For example, the logs for files in blob storage between 4pm and 5pm on the 15 February 2019 would use the following path: https://<storageaccountname>.blob.core.windows.net/$logs/blob/2019/02/15/1600/ and the files are numbered starting from 000000.log in each folder.

Log files can be viewed or retrieved for analysis in a number of different ways:

- You can download logs using the AzCopy.exe command-line tool. AzCopy is available in the Cloud Shell, or you can download the latest version from http://aka.ms/AzCopy.
- You can use the Azure Storage Explorer. You can download Azure Storage Explorer from https://azure.microsoft.com/features/storage-explorer/.
- You can download logs programmatically.
- You can view log data with the Log Analytics tool in the Azure portal.

## Analytics Log Formatting

Storage Analytics logs are stored according to a standard format and version. There are two versions of log entries, both of which conform to the following rules:

- All log fields, whether populated or empty, are separated by a semicolon ";".
- The last field of an entry does *not* end with a semicolon ";".
- Individual log entries end with a newline character "\n".
- The first field in a log entry specifies the log version number.

Version 1.0 log entries use the following format:

`<version-number>;<request-start-time>;<operation-type>;<request-status>;<http-status-code>;<end-to-end-latency-in-ms>;<server-latency-in-ms>;<authentication-type>;<requester-account-name>;<owner-account-name>;<service-type>;<request-url>;<requested-object-key>;<request-id-header>;<operation-count>;<requester-ip-address>;<request-version-header>;<request-header-size>;<request-packet-size>;<response-header-size>;<response-packet-size>;<request-content-length>;<request-md5>;<server-md5>;<etag-identifier>;<last-modified-time>;<conditions-used>;<user-agent-header>;<referrer-header>;<client-request-id>`

Version 2.0 log entries use the following format:

`<version-number>;<request-start-time>;<operation-type>;<request-status>;<http-status-code>;<end-to-end-latency-in-ms>;<server-latency-in-ms>;<authentication-type>;<requester-account-name>;<owner-account-name>;<service-type>;<request-url>;<requested-object-key>;<request-id-header>;<operation-count>;<requester-ip-address>;<request-version-header>;<request-header-size>;<request-packet-size>;<response-header-size>;<response-packet-size>;<request-content-length>;<request-md5>;<server-md5>;<etag-identifier>;<last-modified-time>;<conditions-used>;<user-agent-header>;<referrer-header>;<client-request-id>;<user-object-id>;<tenant-id>;<application-id>;<audience>;<issuer>;<user-principal-name>;<reserved-field>;<authorization-detail>`

Version 2.0 log entries include all version 1.0 fields, version 2.0 entries add fields to record information about OAuth 2.0 token authorization.

The Blob and Queue services both support log versions 1.0 and 2.0, the Table and File services only support version 1.0.
