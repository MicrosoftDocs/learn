There are times when you must guarantee that multiple operations execute together. For example, in your instant messaging application, users can send an individual picture, an individual text message, or a picture and text message together. When the user chooses to send a picture and text message together, you must ensure that other members of the group receive them at the same time. This is important because if a picture and text message are not received together, it’s possible that a separate message could be sent in between the picture and text message. That could make the overall conversation confusing.

Here, we'll look at how to create a transaction in Azure Cache for Redis to guarantee that multiple operations are executed together.

## Creating and running transactions

Transactions in Redis work by queueing multiple commands to be executed as a group. When a transaction is executed, the commands queued inside of it are guaranteed to execute without any other commands from other clients interleaved between them.

To begin a transaction block, enter the `MULTI` command. Further commands will be queued and not executed immediately. Running the `EXEC` command will execute all of the queued commands as a transactional unit. If you decide you want to abort an open transaction while queuing commands, running the `DISCARD` command will close the transaction block without running _any_ of the queued commands.

Redis transactions do not support the concept of rollback. If you queue a command with incorrect syntax into a transaction block, the block will remain open, but will automatically be discarded if you attempt to execute it with `EXEC`. Commands in a transaction that fail _during_ execution (after `EXEC` is called) do not cause a transaction to be aborted or rolled back &mdash; Redis will still run all of the commands and consider the transaction to have completed successfully.

## Redis transactions with ServiceStack.Redis

**ServiceStack.Redis** is a C# client library for interacting with Azure Cache for Redis.

Transactions in ServiceStack.Redis are created by calling `IRedisClient.CreateTransaction()`. The `IRedisTransaction` object that is returned can have multiple commands queued into it with `QueueCommand()`. Calling `Commit()` on the transaction object will execute it.

`IRedisTransaction` objects are disposable, and will automatically issue a `DISCARD` command if disposed before calling `Commit()`. This feature works well with C#'s `using` blocks: if you don't commit a transaction for any reason, you can trust that the transaction will automatically be discarded so that the Redis connection can continue to be used.

## Create a transaction using C# and the ServiceStack.Redis client

Here's an example of using ServiceStack.Redis to create a transaction that can send a message that includes a picture URL and the contents of a text message.

```csharp
public bool SendPictureAndText(string groupChatID, string text, string pictureURL)
{
    bool transactionResult = false;

    using (RedisClient redisClient = new RedisClient(redisConnectionString))
    using (var transaction = redisClient.CreateTransaction())
    {
        //Add multiple operations to the transaction
        transaction.QueueCommand(c => c.PublishMessage(groupChatID, pictureURL));
        transaction.QueueCommand(c => c.PublishMessage(groupChatID, text));

        //Commit and get result of transaction
        transactionResult = transaction.Commit();
    }

    return transactionResult;
}
```

Transactions ensure that multiple operations are executed together without operations from other clients in between them. You create a transaction using the `MULTI` command. With ServiceStack.Redis, you use the `CreateTransaction()` method.