While most of your requests are fine, there are some scenarios where a request can fail for a temporary reason. In these scenarios, it's both normal and expected for you to retry your request after a reasonable amount of time.

## Built-in retry

A transient error is an error that has an underlying cause that soon resolves itself. Applications that connect to your database should be built to expect these transient errors. The Azure Cosmos DB SQL API SDK for .NET has built-in logic to handle common transient failures for read and query requests. The SDK does NOT automatically retry write requests as they are not idempotent.

> [!TIP]
> Try to always use the latest version of the SDK. The retry logic that is built-in is constantly being improved in newer releases.

If you are writing an application that experiences a write failure, it is up to your application code to implement retry logic is considered a best practice.

As an application developer, it's important to understand the HTTP status codes where retrying your request makes sense. These codes include, but are not limited to:

- **429**: Too many requests
- **449**: Concurrency error
- **500**: Unexpected service error
- **503**: Service unavailable

> [!TIP]
> If you experience 50x errors indicating issues with service availability, you can file an Azure support issue to receive technical support or report an issue.

There are HTTP error codes, such as **400 (bad request)**, **401 (not authorized)**, **403 (forbidden)**, and **404 (not found)** that indicate a failure client-side that should be fixed in application code and not retried.
