::: zone pivot="csharp"

The **TransactionalBatchResponse** class contains multiple members to interrogate the results of the batch operation. The **StatusCode** property, specifically, is of type **HttpStatusCode** and returns an HTTP status code giving easy to identify error message for common transaction failures.

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

::: zone-end

::: zone pivot="python"

The **CosmosList** object returned by the `execute_item_batch` method provides the means to examine the results of each operation in a batch request. Each operation's result can be accessed using zero-based indexing and provides details such as the HTTP status code and the operation's response body.

You can iterate through all operations in the batch to access the results:

```python
for result in batch_response:
    resource_body = result.get("resourceBody")
    print(f"Operation result: {resource_body}")
```

You can examine the status code, response body, and request charge of individual operations using the `get` method of the batch response objects.

```python
first_item_result = batch_response[0]
first_item_status_code = first_item_result.get("statusCode")
first_item_request_charge = first_item_result.get("requestCharge")
first_item_result = first_item_result.get("resourceBody")
print(f"First item status: {first_item_status_code}; request charge: {first_item_request_charge}; result: {first_item_result}")

second_item_result = batch_response[1]
second_item_status_code = second_item_result.get("statusCode")
second_item_request_charge = second_item_result.get("requestCharge")
second_item_result = second_item_result.get("resourceBody")
print(f"Second item status: {second_item_status_code}; request charge: {second_item_request_charge}; result: {second_item_result}")
```

When handling errors in batch operations, use the `CosmosBatchOperationError` exception to identify the failed operation and its index:

```python
try:
    batch_response = container.execute_item_batch(batch, partition_key=partition_key)
except exceptions.CosmosBatchOperationError as e:
    error_operation_index = e.error_index
    error_operation_response = e.operation_responses[error_operation_index]
    error_operation = batch[error_operation_index]
    print("\nError operation: {}, error operation response: {}\n".format(error_operation, error_operation_response))
```

::: zone-end

::: zone pivot="node"

The JavaScript SDK uses the `container.items.batch` method to execute batch operations. Each operation must include a type (`operationType`) and the data for the operation.

You can iterate through the results of the batch operation to inspect the status and output of each operation.

```javascript
response.result.forEach((operationResult, index) => {
    const { statusCode, requestCharge, resourceBody } = operationResult;
    console.log(`Operation ${index + 1}: Status code: ${statusCode}, Request charge: ${requestCharge}, Resource: ${JSON.stringify(resourceBody)}`);
});
```

You can examine the status code, response body, and request charge of individual operations using the `get` method of the batch response objects.

```javascript
// Retrieve the results of the first item in the batch:
const first_item_result = response.result[0];
const first_item_status_code = first_item_result.statusCode;
const first_item_request_charge = first_item_result.requestCharge;
const first_item_resource = first_item_result.resourceBody;
console.log(`Operation 1: Status code: ${first_item_status_code}, Request charge: ${first_item_request_charge}, Resource: ${JSON.stringify(first_item_resource)}`);

// Retrieve the results of the second item in the batch:
const second_item_result = response.result[1];
const second_item_status_code = second_item_result.statusCode;
const second_item_request_charge = second_item_result.requestCharge;
const second_item_resource = second_item_result.resourceBody;
console.log(`Operation 2: Status code: ${second_item_status_code}, Request charge: ${second_item_request_charge}, Resource: ${JSON.stringify(second_item_resource)}`);
```

::: zone-end
