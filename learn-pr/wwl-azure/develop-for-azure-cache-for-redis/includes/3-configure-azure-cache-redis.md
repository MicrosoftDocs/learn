You can create a Redis cache using the Azure portal, the Azure CLI, or Azure PowerShell. 

## Create and configure an Azure Cache for Redis instance

There are several parameters you need to decide in order to configure the cache properly for your purposes.

### Name

The Redis cache needs a globally unique name. The name has to be unique within Azure because it's used to generate a public-facing URL to connect and communicate with the service.

The name must be between 1 and 63 characters, composed of numbers, letters, and the '-' character. The cache name can't start or end with the '-' character, and consecutive '-' characters aren't valid.

### Location

You should always place your cache instance and your application in the same region. Connecting to a cache in a different region can significantly increase latency and reduce reliability. If you're connecting to the cache outside of Azure, then select a location close to where the application consuming the data is running.

### Cache type

The tier determines the size, performance, and features that are available for the cache. For more information, visit [Azure Cache for Redis pricing](https://azure.microsoft.com/pricing/details/cache/).

> [!TIP]
> Microsoft recommends you always use Standard tier or higher for production systems. The Basic tier is a single node system with no data replication and no SLA. 

### Clustering support

With the Premium, Enterprise, and Enterprise Flash tiers you can implement clustering to automatically split your dataset among multiple nodes. To implement clustering, you specify the number of shards to a maximum of 10. The cost incurred is the cost of the original node, multiplied by the number of shards.

## Accessing the Redis instance

Redis has a command-line tool for interacting with an Azure Cache for Redis as a client. The tool is available for Windows platforms by downloading the [Redis command-line tools for Windows](https://github.com/MSOpenTech/redis/releases/). If you want to run the command-line tool on another platform, download Azure Cache for Redis from https://redis.io/download.

Redis supports a set of known commands. A command is typically issued as `COMMAND parameter1 parameter2 parameter3`.

Here are some common commands you can use:

| Command | Description |
|--|--|
| `ping` | Ping the server. Returns `PONG`. |
| `set [key] [value]` | Sets a key/value in the cache. Returns "OK" on success. |
| `get [key]` | Gets a value from the cache. |
| `exists [key]` | Returns '1' if the **key** exists in the cache, '0' if it doesn't. |
| `type [key]` | Returns the type associated to the value for the given **key**. |
| `incr [key]` | Increment the given value associated with **key** by '1'. The value must be an integer or double value. This returns the new value. |
| `incrby [key] [amount]` | Increment the given value associated with **key** by the specified amount. The value must be an integer or double value. Returns the new value. |
| `del [key]` | Deletes the value associated with the **key**. |
| `flushdb` | Delete *all* keys and values in the database. |

Following is an example of a command:

```
> set somekey somevalue
OK
> get somekey
"somevalue"
> exists somekey
(string) 1
> del somekey
(string) 1
> exists somekey
(string) 0
```

### Adding an expiration time to values

Caching is important because it allows us to store commonly used values in memory. However, we also need a way to expire values when they're stale. In Redis expiring values is done by applying a time to live (TTL) to a key.

When the TTL elapses, the key is automatically deleted, exactly as if the DEL command were issued. Here are some notes on TTL expirations.

* Expirations can be set using seconds or milliseconds precision.
* The expire time resolution is always 1 millisecond.
* Information about expires are replicated and persisted on disk, the time virtually passes when your Redis server remains stopped (this means that Redis saves the date when a key expires).

Here's an example of an expiration:

```
> set counter 100
OK
> expire counter 5
(integer) 1
> get counter
100
... wait ...
> get counter
(nil)
```

## Accessing a Redis cache from a client

To connect to an Azure Cache for Redis instance, you need several pieces of information. Clients need the host name, port, and an access key for the cache. You can retrieve this information in the Azure portal through the **Settings > Access Keys** page.

* The host name is the public Internet address of your cache, which was created using the name of the cache. For example, `sportsresults.redis.cache.windows.net`.

* The access key acts as a password for your cache. There are two keys created: primary and secondary. You can use either key. Two are provided in case you need to change the primary key. You can switch all of your clients to the secondary key, and regenerate the primary key. This would block any applications using the original primary key. Microsoft recommends periodically regenerating the keys - much like you would your personal passwords.

> [!WARNING]
> Your access keys should be considered confidential information, treat them like you would a password. Anyone who has an access key can perform any operation on your cache!
