Imagine you're building an instant messaging mobile application. Your application allows users to send messages to all members of a specific user-defined group. There's some data that needs to be stored about each user, like their username, email, and password. So you decide to use SQL Server to create a relational database for that information. However, the messages themselves need to be sent and accessed quickly and a relational database is too slow for that.

You decide to create an Azure Cache for Redis because of the number of benefits it provides. Recall from the **Optimize your web applications by caching read-only data with Redis** module that a Redis Cache is an in-memory data structure store that can be used as a database, cache or message broker.

With Azure Cache for Redis, you could use transactions to ensure a message with a picture and text are sent together. Use data expiration to reset the name of the group chat after an hour. Finally, use eviction policies to make sure the oldest messages are being deleted first when you're running low on memory.

## Learning objectives

In this module, you will:

- Group multiple operations into a transaction
- Set an expiration time on your data
- Manage out-of-memory conditions
- Use the cache-aside pattern
- Use the ServiceStack.Redis package in a .NET Core console application