Data is not always permanent, and there are times you would like to delete it at a specific time. For example, in your instant messaging application, users can set the display name of the group chat. However, you want the name to reset after one hour. You could accomplish this by writing your own server-side logic that set an hour timer and deleted the name. However, Azure Cache for Redis supports data expiration, which is a feature that does this automatically without writing additional logic.

Here, you'll learn about the common Redis commands to implement data expiration.

## What is data expiration?

Data expiration is a feature that can automatically delete a key and value in the cache after a set amount of time.

## Why use data expiration?

Data expiration is commonly used in situations where the data you're storing is short-lived.  This is important because Azure Cache for Redis is an in-memory database and you don't have as much memory available to use as you would if you were storing on disk. Since you have limited storage with Azure Cache for Redis, you want to make sure you're only storing data that is important. If the data doesn't need to be around for a long time, make sure you set an expiration.

## How to use data expiration in Azure Cache for Redis

There are different commands to implement and manage data expiration in Azure Cache for Redis:

- `EXPIRE`: Sets the timeout of a key in seconds
- `PEXPIRE`: Sets the timeout of a key in milliseconds
- `EXPIREAT`: Sets the timeout of a key using an absolute Unix timestamp in seconds
- `PEXPIREAT`: Sets the timeout of a key using an absolute Unix timestamp in milliseconds
- `TTL`: Returns the remaining time a key has to live in seconds
- `PTTL`: Returns the remaining time a key has to live in milliseconds
- `PERSIST`: Makes a key never expire

The most common command is `EXPIRE`, and we'll use it throughout this module.

### Example of data expiration using C# and ServiceStack.Redis

Remember, when using a client library like **ServiceStack.Redis**, we don't have to worry about remembering the low-level Azure Cache for Redis commands. Instead, we can use simple C# methods.

```csharp
public static void SetGroupChatName(string groupChatID, string chatName)
{
    using (RedisClient redisClient = new RedisClient(redisConnectionString))
    {
        //Create a key for group chat display names
        string key = groupChatID + "displayName";

        //Set the group chat display name
        redisClient.SetValue(key, chatName);

        //Set the expiration for one hour
        redisClient.Expire(key, 3600);
    }
}
```

Azure Cache for Redis allows you to delete data automatically after a set amount of time using data expiration. This is important because Azure Cache for Redis is an in-memory database, and you don't have as much memory available as you would with storing data on disk. If the data you're storing doesn't need to be around for a long time, make sure you set an expiration.