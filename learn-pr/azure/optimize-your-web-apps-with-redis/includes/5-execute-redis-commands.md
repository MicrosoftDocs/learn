::: zone pivot="csharp"

As mentioned earlier, Redis is an in-memory NoSQL database, which can be replicated across multiple servers. It's often used as a cache, but can be used as a formal database or even as a message-broker.

Redis can store various data types and structures. It supports various commands you can issue to retrieve cached data or to query information about the cache itself. The data you work with is always stored as key/value pairs.

## Execute commands on the Redis cache

Typically, a client application will use a *client library* to form requests and execute commands on a Redis cache. You can get a list of client libraries directly from the [Redis clients page](https://redis.io/clients). A popular high-performance Redis client for the .NET platform is **StackExchange.Redis**. The package is available through NuGet, and you can add it to your .NET code using the command line or IDE.

### Connect to your Redis cache with StackExchange.Redis

Recall that we use the host address, port number, and an access key to connect to a Redis server. Azure also offers a *connection string* for some Redis clients, which bundles this data together into a single string.

### What is a connection string?

A connection string is a single line of text that includes all the required pieces of information to connect and authenticate to a Redis cache in Azure. It will look something like the following (with the **cache-name** and **password-here** fields filled in with real values):

```json
[cache-name].redis.cache.windows.net:6380,password=[password-here],ssl=True,abortConnect=False
```

> [!TIP]
> The connection string should be protected in your application. If the application is hosted on Azure, consider using an Azure Key Vault to store the value.

You can pass this string to **StackExchange.Redis** to create a connection to the server.

Notice that there are two more parameters at the end:

- **ssl**: ensures that communication is encrypted
- **abortConnection**: allows a connection to be created even if the server is unavailable at that moment

There are several other [optional parameters](https://github.com/StackExchange/StackExchange.Redis/blob/master/docs/Configuration.md#configuration-options) you can append to the string to configure the client library.

### Create a connection

The main connection object in **StackExchange.Redis** is the `StackExchange.Redis.ConnectionMultiplexer` class. This object abstracts the process of connecting to a Redis server (or group of servers). It's optimized to manage connections efficiently and intended to be kept around while you need access to the cache.

You create a `ConnectionMultiplexer` instance using the static `ConnectionMultiplexer.Connect` or `ConnectionMultiplexer.ConnectAsync` method, passing in either a connection string or a `ConfigurationOptions` object.

Here's a simple example:

```csharp
using StackExchange.Redis;
...
var connectionString = "[cache-name].redis.cache.windows.net:6380,password=[password-here],ssl=True,abortConnect=False";
var redisConnection = ConnectionMultiplexer.Connect(connectionString);
    // ^^^ store and re-use this!!!
```

Once you have a `ConnectionMultiplexer`, there are three primary things you might want to do:

1. Access a Redis Database (the focus of this module).
2. Make use of the publisher/subscript features of Redis (outside the scope of this module).
3. Access an individual server for maintenance or monitoring purposes.

### Access a Redis database

The Redis database is represented by the `IDatabase` type. You can retrieve one using the `GetDatabase()` method:

```csharp
IDatabase db = redisConnection.GetDatabase();
```

> [!TIP]
> The object returned from `GetDatabase` is a lightweight object and doesn't need to be stored. Only the `ConnectionMultiplexer` needs to be kept alive.

Once you have a `IDatabase` object, you can execute methods to interact with the cache. All methods have synchronous and asynchronous versions, which return `Task` objects to make them compatible with the `async` and `await` keywords.

Here's an example of storing a key/value in the cache:

```csharp
bool wasSet = db.StringSet("favorite:flavor", "i-love-rocky-road");
```

The `StringSet` method returns a `bool` indicating whether the value was set (`true`) or not (`false`). We can then retrieve the value with the `StringGet` method:

```csharp
string value = db.StringGet("favorite:flavor");
Console.WriteLine(value); // displays: ""i-love-rocky-road""
```

#### Get and Set binary values

Recall that Redis keys and values are *binary safe*. You can use these same methods to store binary data. There are implicit conversion operators to work with `byte[]` types so you can work with the data naturally:

```csharp
byte[] key = ...;
byte[] value = ...;

db.StringSet(key, value);
```

```csharp
byte[] key = ...;
byte[] value = db.StringGet(key);
```

> [!TIP]
> **StackExchange.Redis** represents keys using the `RedisKey` type. This class has implicit conversions to and from both `string` and `byte[]`, allowing both text and binary keys to be used without any complication. Values are represented by the `RedisValue` type. As with `RedisKey`, there are implicit conversions in place to allow you to pass `string` or `byte[]`.

#### Other common operations

The `IDatabase` interface includes several other methods to work with the Redis cache. There are methods to work with hashes, lists, sets, and ordered sets.

Here are some of the more common operations that work with single keys; you can [read the source code](https://github.com/StackExchange/StackExchange.Redis/blob/master/src/StackExchange.Redis/Interfaces/IDatabase.cs) for the interface to see the full list.

| Method | Description |
|--------|-------------|
| `CreateBatch` | Creates a *group of operations* that will be sent to the server as a single unit, but not necessarily processed as a unit. |
| `CreateTransaction` | Creates a group of operations that will be sent to the server as a single unit *and* processed on the server as a single unit. |
| `KeyDelete` | Deletes the key/value. |
| `KeyExists` | Returns whether the given key exists in cache. |
| `KeyExpire` | Sets a time-to-live (TTL) expiration on a key. |
| `KeyRename` | Renames a key. |
| `KeyTimeToLive` | Returns the TTL for a key. |
| `KeyType` | Returns the string representation of the type of the value stored at key. The different types that can be returned are: string, list, set, zset, and hash. |

### Execute other commands

The `IDatabase` object has an `Execute` and `ExecuteAsync` method, which can be used to pass textual commands to the Redis server. For example:

```csharp
var result = db.Execute("ping");
Console.WriteLine(result.ToString()); // displays: "PONG"
```

The `Execute` and `ExecuteAsync` methods return a `RedisResult` object, which is a data holder that includes two properties:

- `Type`, which returns a `string` indicating the type of the result - "STRING", "INTEGER", etc.
- `IsNull`, a true/false value to detect when the result is `null`.

You can then use `ToString()` on the `RedisResult` to get the actual return value.

You can use `Execute` to perform any supported commands. For example, we can get all the clients connected to the cache ("CLIENT LIST"):

```csharp
var result = await db.ExecuteAsync("client", "list");
Console.WriteLine($"Type = {result.Type}\r\nResult = {result}");
```

The preceding commands output all the connected clients:

```output
Type = BulkString
Result = id=9469 addr=16.183.122.154:54961 fd=18 name=DESKTOP-AAAAAA age=0 idle=0 flags=N db=0 sub=1 psub=0 multi=-1 qbuf=0 qbuf-free=0 obl=0 oll=0 omem=0 ow=0 owmem=0 events=r cmd=subscribe numops=5
id=9470 addr=16.183.122.155:54967 fd=13 name=DESKTOP-BBBBBB age=0 idle=0 flags=N db=0 sub=0 psub=0 multi=-1 qbuf=0 qbuf-free=32768 obl=0 oll=0 omem=0 ow=0 owmem=0 events=r cmd=client numops=17
```

### Store more complex values

Redis is oriented around binary safe strings, but you can cache off object graphs by serializing them to a textual format; typically XML or JSON. For example, perhaps for our statistics, we have a `GameStat` object, which looks like:

```csharp
public class GameStat
{
    public string Id { get; set; }
    public string Sport { get; set; }
    public DateTimeOffset DatePlayed { get; set; }
    public string Game { get; set; }
    public IReadOnlyList<string> Teams { get; set; }
    public IReadOnlyList<(string team, int score)> Results { get; set; }

    public GameStat(string sport, DateTimeOffset datePlayed, string game, string[] teams, IEnumerable<(string team, int score)> results)
    {
        Id = Guid.NewGuid().ToString();
        Sport = sport;
        DatePlayed = datePlayed;
        Game = game;
        Teams = teams.ToList();
        Results = results.ToList();
    }

    public override string ToString()
    {
        return $"{Sport} {Game} played on {DatePlayed.Date.ToShortDateString()} - " +
               $"{String.Join(',', Teams)}\r\n\t" + 
               $"{String.Join('\t', Results.Select(r => $"{r.team } - {r.score}\r\n"))}";
    }
}
```

We could use the **Newtonsoft.Json** library to turn an instance of this object into a string:

```csharp
var stat = new GameStat("Soccer", new DateTime(1950, 7, 16), "FIFA World Cup", 
                new[] { "Uruguay", "Brazil" },
                new[] { ("Uruguay", 2), ("Brazil", 1) });

string serializedValue = Newtonsoft.Json.JsonConvert.SerializeObject(stat);
bool added = db.StringSet("event:1950-world-cup", serializedValue);
```

We could retrieve it and turn it back into an object using the reverse process:

```csharp
var result = db.StringGet("event:1950-world-cup");
var stat = Newtonsoft.Json.JsonConvert.DeserializeObject<GameStat>(result.ToString());
Console.WriteLine(stat.Sport); // displays "Soccer"
```

## Clean up the connection

Once you're done with the Redis connection, you can **Dispose** the `ConnectionMultiplexer`. This command closes all connections and shuts down the communication to the server:

```csharp
redisConnection.Dispose();
redisConnection = null;
```

Let's create an application and do some work with our Redis cache.

::: zone-end

::: zone pivot="javascript"

As mentioned earlier, Redis is an in-memory NoSQL database, which can be replicated across multiple servers. It's often used as a cache, but can be used as a formal database or even message-broker.

Redis can store various data types and structures. It supports various commands you can issue to retrieve cached data or query information about the cache itself. The data you work with is always stored as key/value pairs.

## Execute commands on the Redis cache

Typically, a client application will use a *client library* to form requests and execute commands on a Redis cache. You can get a list of client libraries directly from the [Redis clients page](https://redis.io/clients). A popular Redis client for JavaScript is the **redis** package, which you can add to a project with `npm install redis`.

### Connect to your Redis cache with the redis package

Interaction with a Redis cache is achieved with the `RedisClient` class. In most scenarios, the following boilerplate code is the best way to create a `RedisClient` that connects to a Redis cache in Azure:

```javascript
const client = redis.createClient(
  port,  // the port number, 6380 by default
  hostname,  // <resourceName>.redis.cache.windows.net
  {
    password: accessKey,  // the primary or secondary access key
    tls: { servername: hostname }
  }
);
```

In most cases, you should avoid creating multiple `RedisClient`s. A single instance of `RedisClient` can be passed around and used everywhere in your code where Redis is needed.

### Work with a Redis database

Redis commands are represented as methods on `RedisClient` with the names as the commands themselves. Here's an example of storing a new value in the cache:

```javascript
client.set("myKey", "myValue"); // executes "set myKey myValue" on the cache
```

All of the command methods on `RedisClient` are asynchronous and support an optional callback argument that provides the result. The `redis` package doesn't support Promises (and thus `async`/`await` or chaining with `.then()`) out of the box. The easiest way to use `async`/`await` or `.then()` with `RedisClient` is to add Promise support to the entire client at once with the `bluebird` package's `promisifyAll` function:

```javascript
var redis = require("redis");
var Promise = require("bluebird");

Promise.promsifyAll(redis);
```

The `promisifyAll` function will add `XXXAsync` versions of all command methods to `RedisClient` instances, allowing you to use async methods as in the following example:

```javascript
var result = await client.setAsync("myKey", "myValue");
```

### Execute commands dynamically

You can send commands dynamically by using `sendCommand()` (or `sendCommandAsync()` with bluebird) to send any string as a command to the cache. For example, your app could present a prompt to send commands directly to the cache, or Redis could introduce new commands that the `redis` package doesn't support. Command arguments must be sent as an array.

```javascript
// Add a key/value pair
var result = await client.sendCommandAsync("set", ["myKey", "myValue"]);
```

## Clean up the connection

Once you're done with the Redis connection, you should close it with `quit()` (or `quitAsync()` when using bluebird):

```javascript
await client.quitAsync();
```

Let's create an application and do some work with our Redis cache.

::: zone-end
