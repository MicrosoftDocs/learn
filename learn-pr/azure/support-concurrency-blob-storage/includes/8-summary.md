In this module you've learned about three different concurrency strategies to address issues with multiple people trying to update data in blob storage:

1. Last writer wins
1. Optimistic with ETags
1. Pessimistic with leases

Both optimistic and pessimistic approaches to concurrency are declared in the code used to update content in Blob storage. If concurrency isn't addressed the last person to write to the file wins.

In this lesson, we've gone over code examples for each of the three approaches.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## Additional resources

The documentation provides more information on the APIs, along with tutorials and samples. Here are a few useful links to explore further:

- [Managing Concurrency in Microsoft Azure Storage](/azure/storage/common/storage-concurrency)
- [Specifying Conditional Headers for Blob Service Operations](/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations)
- [Lease Blob](/rest/api/storageservices/lease-blob)