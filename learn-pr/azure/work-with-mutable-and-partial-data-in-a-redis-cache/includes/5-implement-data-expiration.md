Here, you'll add an expiration time to our data in the Azure Cache for Redis.

## Add an expiration time

In the last exercise, we left off with the following code in **Program.cs**.

```csharp
bool transactionResult = false;

using (RedisClient redisClient = new RedisClient(redisConnectionString))
using (var transaction = redisClient.CreateTransaction())
{
    //Add multiple operations to the transaction
    transaction.QueueCommand(c => c.Set("MyKey1", "MyValue1"));
    transaction.QueueCommand(c => c.Set("MyKey2", "MyValue2"));

    //Commit and get result of transaction
    transactionResult = transaction.Commit();
}

if(transactionResult)
{
    Console.WriteLine("Transaction committed");
}
else
{
    Console.WriteLine("Transaction failed to commit");
}
```

Let’s add an expiration of 15 seconds to both **MyKey1** and **MyKey2**.

Add the following code before you commit the transaction:

```csharp
//Add an expiration time
transaction.QueueCommand(c => ((RedisNativeClient)c).Expire("MyKey1", 15));
transaction.QueueCommand(c => ((RedisNativeClient)c).Expire("MyKey2", 15));
```

In this code, the **Expire** method is a part of the **RedisNativeClient**. To access the method, we must first cast our object.

## Verify the expiration

Now that we added the code to expire our data, let's run the program and check that the data is removed from Azure Cache for Redis.

1. Run the program.

    ```bash
    dotnet run
    ```

1. Switch back to the Azure Cache for Redis console in the Azure portal.

1. To verify that the data is still there, issue the following command:

    ```console
    get MyKey1
    ```

1. After 15 seconds, issue the command again. You should see that the data is no longer there.

    ![Screenshot of the Azure Cache for Redis console showing the value of MyKey1 being nil](../media/6-redis-console-data-expiration.png)