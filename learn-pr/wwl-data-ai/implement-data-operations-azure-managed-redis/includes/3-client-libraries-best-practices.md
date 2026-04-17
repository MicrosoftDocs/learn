Azure Managed Redis supports client libraries for many programming languages. Each library maintains its own documentation and support through the developer community. Always use the latest version and upgrade regularly for improved reliability and performance. The following table lists some of the available clients.

| Client library | Language | GitHub repo |
|--|--|--|
| StackExchange.Redis | C#/.NET | [Link](https://github.com/StackExchange/StackExchange.Redis) |
| Lettuce | Java | [Link](https://github.com/lettuce-io/) |
| node_redis | Node.js | [Link](https://github.com/redis/node-redis) |
| redis-py | Python | [Link](https://github.com/redis/redis-py) |

## Choosing the right library based on your clustering policy

Azure Managed Redis supports two clustering policies: Enterprise clustering policy and OSS (Open Source Software) clustering policy. All client libraries work with instances using the Enterprise clustering policy. If you're using the OSS clustering policy, ensure your chosen client library supports connecting to clustered Redis instances.

### Blocked commands

Microsoft manages the configuration and management of Azure Managed Redis instances, which disables some commands by default. For more information on blocked commands, visit [Cluster management commands compatibility](https://redis.io/docs/latest/operate/rs/references/compatibility/commands/cluster/).

### Multi-key commands

Azure Managed Redis uses a clustered configuration, which can cause `CROSSSLOT` exceptions on multi-key commands. With OSS clustering, all keys must map to [the same hash slot](https://redis.io/docs/latest/operate/rs/databases/configure/oss-cluster-api/#multi-key-command-support). 

Enterprise clustering allows these commands across slots: `DEL`, `MSET`, `MGET`, `EXISTS`, `UNLINK`, and `TOUCH`. In Active-Active databases, only `MGET`, `EXISTS`, and `TOUCH` work across slots. For more information, see [Database clustering](https://redis.io/docs/latest/operate/rs/databases/durability-ha/clustering/#multikey-operations).

### Other blocked commands

The following commands are blocked for the Enterprise clustering policy:

- CLUSTER INFO
- CLUSTER HELP
- CLUSTER KEYSLOT
- CLUSTER NODES
- CLUSTER SLOTS

The following commands blocked for active geo-replication:

- FLUSHALL
- FLUSHDB

## Development best practices

When you develop applications with Azure Managed Redis, following best practices ensures optimal performance, reliability, and security. Consider these key recommendations for data design, network configuration, monitoring, and instance configuration.

### Data design and performance

- **Use smaller values**: Divide larger data chunks into multiple keys with smaller values
- **Handle large responses**: Optimize for many small values, increase virtual machine size for higher bandwidth, or use multiple connection objects with round-robin distribution
- **Use pipelining**: Choose clients that support [Redis pipelining](https://redis.io/topics/pipelining) for better network efficiency
- **Avoid expensive operations**: Don't use `KEYS` in production; use `SCAN` instead for iterating over keys

### Network and connectivity

- **Co-locate resources**: Place your Redis instance and application in the same Azure region
- **Use hostnames**: Rely on hostnames instead of public IP addresses, which can change during scale operations
- **Enable TLS encryption**: Azure Managed Redis requires TLS by default (versions 1.2 and 1.3 supported)

### Monitoring and scaling

Monitor these key metrics and scale when they consistently exceed 75%:

- Used Memory Percentage
- CPU usage
- Connected Clients
- Network bandwidth

### Configuration

- **Choose the right tier**: Select from Memory Optimized, Balanced, Compute Optimized, or Flash Optimized based on performance testing
- **Enable high availability**: Use high availability mode for production workloads; only disable for development/test environments
- **Implement data protection**: Enable data persistence for quick recovery or use import/export for periodic backups to your storage account

