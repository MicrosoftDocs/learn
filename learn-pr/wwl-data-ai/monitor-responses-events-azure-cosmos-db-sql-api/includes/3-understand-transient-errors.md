In this section, we'll diagnose and troubleshoot Azure Cosmos DB service unavailable exceptions. We usually can identify this exception when our request return status code 503. It means that the operations couldn't complete because the service was unavailable. There are several reasons why this exception could be raised. The status code could be returned because of network connectivity or service availability issues. In most cases, it's safe to retry the operation and the issue might have been resolved. If the issue persists, you will need to contact Azure support. Let's evaluate the three main cases when this status code would be returned.

## Required ports are blocked

Verify that the following ports are enabled for the SQL API.

| **Connection mode** | **Supported protocol** | **Supported SDKs** | **API/Service port** |
| :--- | :--- | :--- | :--- |
| Gateway | HTTPS | All SDKs | SQL (443) |
| Direct | TCP | .NET SDK, Java SDK | When using public/service endpoints: ports in the 10000 through 20000 range. When using private endpoints: ports in the 0 through 65535 range |

## Client-side transient connectivity issues

This exception can happen when there are transient connectivity problems that are causing timeouts. The stack trace related to this scenario will contain a `TransportException` error. This error could look like:

```C#
TransportException: A client transport error occurred: The request timed out while waiting for a server response. 
(Time: xxx, activity ID: xxx, error code: ReceiveTimeout [0x0010], base error: HRESULT 0x80131500
```
This error should be troubleshot like a [request timeout error][/azure/cosmos-db/sql/troubleshoot-dot-net-sdk-request-timeout] (status code 408).

## Service Outage

Check the [Azure status][/status] page to see if there's an ongoing issue.

[/azure/cosmos-db/sql/troubleshoot-dot-net-sdk-request-timeout]: https://docs.microsoft.com/azure/cosmos-db/sql/troubleshoot-dot-net-sdk-request-timeout#troubleshooting-steps
[/status]: https://status.azure.com/status


