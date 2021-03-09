You've assessed all the development resources that are in the incorrect production resource group. You think they'll move without problems, but you'd like to test it first.

In this unit, you'll learn how to validate that a move would be successful. You'll also see how to use the Azure REST API `validate move` operation to test and validate your moves.

## Prepare to test your move

Before attempting to move a resource, you can test whether it will be successful by calling the `validate move` operation from the Azure REST API. This test is especially useful if you're trying to move resources by using, for example, Azure PowerShell or the Azure CLI. You can use these tools to script moves, with minimal human interaction. Testing a move doesn't affect your resources. The operation only tests whether your move operation would succeed, based on the options you provide.

If you're trying to move resources through the Azure portal, you don't need to validate the move before attempting it. The Azure portal does an automatic validation before allowing you to move resources.

A REST API is a programmatic interface that you can call by sending HTTP requests. Programmers often call REST APIs in their custom code from clients such as mobile apps. To call a specific Azure REST method, such as the `validate move` operation, you can use the Azure CLI:

``` bash
az rest --method post --uri <enter the correct REST operation URI here>
```

To formulate the correct REST URI to call, and to provide the other necessary details, you must obtain the following information:

- Your Azure subscription ID.
- The name of the resource group currently holding your resources.
- The [resource ID](https://docs.microsoft.com/powershell/module/azurerm.resources/get-azurermresource?view=azurermps-6.13.0) for each of the resources in your original resource group.
- The [resource ID](https://docs.microsoft.com/powershell/module/azurerm.resources/get-azurermresourcegroup?view=azurermps-6.13.0) for the destination resource group where you want to move your resources.
- Your account [access token](https://docs.microsoft.com/rest/api/azure/#acquire-an-access-token).

When you use the Azure CLI to call an Azure REST API operation, you don't have to provide a subscription ID or an access token. The CLI includes these values automatically.

## Test the validity of your move

Let's have a high-level look at the process for validating a move by using the REST API.

You can send a POST request with the following details:
``` http
POST https://management.azure.com/subscriptions/<your-subscription-id>/resourceGroups/<your-source-group>/validateMoveResources?api-version=2019-05-10
Authorization: Bearer <your-access-token>
Content-type: application/json
 ```

The body of your POST request must contain the following information:
``` json
{
 "resources": ["<your-resource-id-1>", "<your-resource-id-2>", "<your-resource-id-3>"],
 "targetResourceGroup": "/subscriptions/<your-subscription-id>/resourceGroups/<your-target-group>"
}
```

To submit this POST request with the correct body by using the Azure CLI, run this command:

``` bash
az rest --method post /
   --uri https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/<your-source-group>/validateMoveResources?api-version=2019-05-10 /
   --body "{\"resources\": [\"<your-resource-id-1>\", \"<your-resource-id-2>\", \"<your-resource-id-3>\"], \"targetResourceGroup\": \"/subscriptions/<your-subscription-id>/resourceGroups/<your-target-group>\"}" /
   --verbose
```

If your request is accepted, the API returns a status code of 202:

``` http
Response Code: 202
cache-control: no-cache
pragma: no-cache
expires: -1
location: https://management.azure.com/subscriptions/<your-subscription-id>/operationresults/<your-operation-id>?api-version=2018-02-01
retry-after: 15
```

At this stage, the API has only validated your request. It hasn't yet validated whether your move will be successful. This response gives you a location URL. You use this location URL to test your move. Wait for the amount of time shown in the `retry-after` value in the request validation, before attempting to test your validation. In this example, the value is 15 seconds.

You then send a GET request to the location URL:

``` http
GET <location-url>
Authorization: Bearer <your-access-token>
```

To submit this GET request by using the Azure CLI, run this command:

``` bash
az rest --method get --uri <location-url>
```

If your move validates as successful, you'll get a 204 status code. Otherwise, you'll receive the following error message, indicating that your move won't be successful:

``` json
{"error":{"code":"ResourceMoveProviderValidationFailed","message":"<message>"...}}
```
