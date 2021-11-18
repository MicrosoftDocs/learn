The **TransactionalBatchResponse** class contains multiple members to interrogate the results of the batch operation. The **StatusCode** property, specifically, is of type **HttpStatusCode** and will return an HTTP status code giving easy to identify error message for common transaction failures.

```csharp
response.StatusCode
```

The **IsSuccessStatusCode** property is a boolean property that you can use directly in your application code before extracting results.

```csharp
if (batchResponse.IsSuccessStatusCode)
{
}
```

The **GetOperationResultAtIndex\<\>** generic method returns the individual deserialized item at the index you specify.

```csharp
TransactionalBatchOperationResult<Product> result = response.GetOperationResultAtIndex<Product>(0);
Product firstProductResult = result.Resource;

TransactionalBatchOperationResult<Product> result = response.GetOperationResultAtIndex<Product>(1);
Product secondProductResult = result.Resource;
```
