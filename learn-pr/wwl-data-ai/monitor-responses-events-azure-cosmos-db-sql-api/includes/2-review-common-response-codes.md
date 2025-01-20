Most common request operations using the Azure Cosmos DB for NoSQL, are to create, query, or manage container documents. Each request returns an HTTP status code on the status of the operation. This code might let us know if the operation was successful. Or the code let's us know the request was unsuccessful and provide us with some possible insight of what went wrong. In this section we review some of the most common HTTP status codes returned by the following types of requests:

- Create a Document
- List Documents
- Get a Document
- Replace a Document
- Patch a Document
- Delete a Document
- Query Documents

## Common Status codes for all types of operations

While some status codes like 400, 403, and 404 are shared among different operation types, their descriptions vary slightly and aren't listed in this table.

| **Status Code** | **Name** | **Operation Type** | **Description** |
| :--- | :--- | :--- | :--- |
| **200** | OK | List, Get, Replace, Patch, Query | The operation was successful. |

## Create a Document

The *Create Document operation* creates a new document in a collection. Its status codes are:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **201** | Created | The operation was successful. |
| **400** | Bad Request | The JSON body is invalid. |
| **403** | Forbidden | The operation couldn't be completed because the storage limit of the partition was reached. |
| **409** | Conflict | The `parition key` and `id` provided for the new document has been taken by an existing document. |
| **413** | Entity Too Large | The document size in the request exceeded the allowable document size. |

## List documents under the collection using ReadFeed

ReadFeed can be used to retrieve all documents, or just the incremental changes to documents within the collection. Its status codes are:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **400** | Bad Request | The override set in x-ms-consistency-level is stronger than the one set during account creation. For example, if the consistency level is Session, the override can't be Strong or Bounded.|

## Get a Document

The *Get Document operation* retrieves a document by its partition key and document key. Its status codes are:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **304** | Not Modified |The document requested wasn't modified since the specified eTag value in the If-Match header. The service returns an empty response body. |
| **400** | Bad Request |The override set in the x-ms-consistency-level header is stronger than the one set during account creation. For example, if the consistency level is Session, the override can't be Strong or Bounded. |
| **404** | Not Found | The document no longer exists, that is, the document was deleted. |

## Replace a Document

The *Replace Document operation* replaces the entire contents of a document. Its status codes are:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **400** | Bad Request | The JSON body is invalid. Check for missing curly brackets or quotes. |
| **404** | Not Found | The document no longer exists, that is, the document was deleted. |
| **409** | Conflict | The `parition key` and `id` provided for the new document has been taken by an existing document. |
| **413** | Entity Too Large | The document size in the request exceeded the allowable document size. |

## Patch a Document

The* Patch Document operation* does path-level updates to specific files/properties in a single document. Its status codes are:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **400** | Bad Request | The JSON body is invalid. |
| **412** | Precondition Failed | The specified precondition isn't met. |

## Delete Document

The *Delete Document operation* deletes an existing document in a collection. Its status codes are:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **204** | No Content |The delete operation was successful. |
| **404** | Not Found | The document isn't found. |

## Query Documents

You can query the collection documents using Azure Cosmos DB for NoSQL queries. Its status codes are:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **400** | Bad Request | The request was specified with an incorrect SQL syntax or was missing required headers. |

## Other important status codes Azure Cosmos DB request could return

Some failed status codes are also references to **exceptions**. We'll discuss a couple of these status codes in more detail in the next sections, but here are a few more common status codes to review:

| **Status Code** | **Operation Type** | **Description** |
| :--- | :--- |  :--- |
| **408** | Request timeout | The operation didn't complete within the allotted amount of time. This code is returned when a stored procedure, trigger, or UDF (User Defined Function) within a query doesn't complete execution within the maximum execution time. |
| **429** | Too many requests | The collection exceeded the provisioned throughput limit. Retry the request after the server specified retry after duration. For more information, see request units. |
| **500** | Internal Server Error | The operation failed because of an unexpected service error. Contact support.  |
| **503** | Service Unavailable | The operation couldn't be completed because the service was unavailable. This situation could happen because of network connectivity or service availability issues. It's safe to retry the operation. If the issue persists, contact support.|
