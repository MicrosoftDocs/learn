
You can create a Redis cache using the Azure portal, the Azure CLI, or Azure PowerShell. 

## Create and configure an Azure Cache for Redis instance

There are several parameters you will need to decide in order to configure the cache properly for your purposes.

### Name

The Redis cache will need a globally unique name. The name has to be unique within Azure because it is used to generate a public-facing URL to connect and communicate with the service.

The name must be between 1 and 63 characters, composed of numbers, letters, and the '-' character. The cache name can't start or end with the '-' character, and consecutive '-' characters aren't valid.

### Location

You will need to decide where the Redis cache will be physically located by selecting an Azure region. You should always place your cache instance and your application in the same region. Connecting to a cache in a different region can significantly increase latency and reduce reliability. If you are connecting to the cache outside of Azure, then select a location close to where the application consuming the data is running.

> [!IMPORTANT]
> Put the Redis cache as close to the data consumer as you can.

### Pricing tier

As mentioned in the last unit, there are three pricing tiers available for an Azure Cache for Redis.

* **Basic:** Basic cache ideal for development/testing. Is limited to a single server, 53 GB of memory, and 20,000 connections. There is no SLA for this service tier.
* **Standard:** Production cache which supports replication and includes an SLA. It supports two servers, and has the same memory/connection limits as the Basic tier.
* **Premium:** Enterprise tier which builds on the Standard tier and includes persistence, clustering, and scale-out cache support. This is the highest performing tier with up to 530 GB of memory and 40,000 simultaneous connections.

You can control the amount of cache memory available on each tier - this is selected by choosing a cache level from C0-C6 for Basic/Standard and P0-P4 for Premium. Check the [pricing page](https://azure.microsoft.com/pricing/details/cache/) for full details.

> [!TIP]
> Microsoft recommends you always use Standard or Premium Tier for production systems. The Basic Tier is a single node system with no data replication and no SLA. 

The Premium tier allows you to persist data in two ways to provide disaster recovery:

* RDB persistence takes a periodic snapshot and can rebuild the cache using the snapshot in case of failure.

* AOF persistence saves every write operation to a log that is saved at least once per second. This creates bigger files than RDB but has less data loss.

There are several other settings which are only available to the **Premium** tier.

### Virtual Network support

If you create a premium tier Redis cache, you can deploy it to a virtual network in the cloud. Your cache will be available to only other virtual machines and applications in the same virtual network. This provides a higher level of security when your service and cache are both hosted in Azure, or are connected through an Azure virtual network VPN.

### Clustering support

With a premium tier Redis cache, you can implement clustering to automatically split your dataset among multiple nodes. To implement clustering, you specify the number of shards to a maximum of 10. The cost incurred is the cost of the original node, multiplied by the number of shards.

## Accessing the Redis instance

Redis has a command-line tool for interacting with an Azure Cache for Redis as a client. The tool is available for Windows platforms by downloading the [Redis command-line tools for Windows](https://github.com/MSOpenTech/redis/releases/). If you want to run the command-line tool on another platform, download Azure Cache for Redis from https://redis.io/download.

Redis supports a set of known commands. A command is typically issued as `COMMAND parameter1 parameter2 parameter3`.

Here are some common commands you can use:

| Command | Description |
|--|--|
| `ping` | Ping the server. Returns "PONG". |
| `set [key] [value]` | Sets a key/value in the cache. Returns "OK" on success. |
| `get [key]` | Gets a value from the cache. |
| `exists [key]` | Returns '1' if the **key** exists in the cache, '0' if it doesn't. |
| `type [key]` | Returns the type associated to the value for the given **key**. |
| `incr [key]` | Increment the given value associated with **key** by '1'. The value must be an integer or double value. This returns the new value. |
| `incrby [key] [amount]` | Increment the given value associated with **key** by the specified amount. The value must be an integer or double value. This returns the new value. |
| `del [key]` | Deletes the value associated with the **key**. |
| `flushdb` | Delete *all* keys and values in the database. |

Below is an example of a command:

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

Caching is important because it allows us to store commonly used values in memory. However, we also need a way to expire values when they are stale. In Redis this is done by applying a time to live (TTL) to a key.

When the TTL elapses, the key is automatically deleted, exactly as if the DEL command were issued. Here are some notes on TTL expirations.

* Expirations can be set using seconds or milliseconds precision.
* The expire time resolution is always 1 millisecond.
* Information about expires are replicated and persisted on disk, the time virtually passes when your Redis server remains stopped (this means that Redis saves the date at which a key will expire).

Here is an example of an expiration:

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

To connect to an Azure Cache for Redis instance, you'll need several pieces of information. Clients need the host name, port, and an access key for the cache. You can retrieve this information in the Azure portal through the **Settings > Access Keys** page.

* The host name is the public Internet address of your cache, which was created using the name of the cache. For example `sportsresults.redis.cache.windows.net`.

* The access key acts as a password for your cache. There are two keys created: primary and secondary. You can use either key, two are provided in case you need to change the primary key. You can switch all of your clients to the secondary key, and regenerate the primary key. This would block any applications using the original primary key. Microsoft recommends periodically regenerating the keys - much like you would your personal passwords.

> [!WARNING]
> Your access keys should be considered confidential information, treat them like you would a password. Anyone who has an access key can perform any operation on your cache!
