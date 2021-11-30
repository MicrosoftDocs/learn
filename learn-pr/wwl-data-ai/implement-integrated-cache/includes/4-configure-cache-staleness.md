By default, the cache will keep data for five minutes. This staleness window can be configured using the **MaxIntegratedCacheStaleness** property in the SDK.

For point read operations, set the **DedicatedGatewayRequestOptions** property of the **ItemRequestOptions** class to a new instance of the **DedicatedGatewayRequestOptions** class with the **MaxIntegratedCacheStaleness** property set to an appropriate timespan for your application. In this example, the staleness is configured to **15 minutes**.

```csharp
ItemRequestOptions operationOptions = new()
{
    ConsistencyLevel = ConsistencyLevel.Eventual,
    DedicatedGatewayRequestOptions = new() 
    { 
        MaxIntegratedCacheStaleness = TimeSpan.FromMinutes(15) 
    }
};
```

For query operations, perform the same configuration tasks in the **QueryRequestOptions** class instead. In this example, the cache staleness is only set to **120 seconds** or **2 minutes**.

```csharp
QueryRequestOptions queryOptions = new()
{
    ConsistencyLevel = ConsistencyLevel.Eventual,
    DedicatedGatewayRequestOptions = new() 
    { 
        MaxIntegratedCacheStaleness = TimeSpan.FromSeconds(120) 
    }
};
```
