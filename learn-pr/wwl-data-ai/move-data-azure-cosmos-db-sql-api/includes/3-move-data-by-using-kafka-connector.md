**Apache Kafka** is an open-source platform used to stream events in a distributed manner. Many companies use Kafka for large-scale high-performance data integration scenarios. **Kafka Connect** is a tool within their suite to stream data between Kafka and other data systems. Understandably, this can include Azure Cosmos DB as a source of data or a target (sink) of data.

## Setup

The Kafka Connect connectors for Azure Cosmos DB is available as an open-source project on GitHub at [microsoft/kafka-connect-cosmosdb]. Instructions for downloading and installing the JAR file manually are available at the repository.

### Configuration

Four configuration properties should be set to properly configure connectivity to an Azure Cosmos DB SQL API account.

| **Property** | **Value** |
| :--- | :--- |
| **connect.cosmos.connection.endpoint** | Account endpoint URI |
| **connect.cosmos.master.key** | Account key |
| **connect.cosmos.databasename** | Name of the database resource |
| **connect.cosmos.containers.topicmap** | Using CSV format, a mapping of the Kafka topics to containers |

### Topics to containers map

Each container should be mapped to a topic. For example, suppose you would like the **products** container to be mapped to the **prodlistener** topic and the **customers** container to the **custlistener** topic. In that case, you should use the following CSV mapping string: ``prodlistener#products,custlistener#customers``.

## Write to Azure Cosmos DB

Let’s write data to Azure Cosmos DB by creating a topic. In Apache Kafka, all messages are sent via topics.

You can create a new topic using the **kafka-topics** command. This example will make a new topic named **prodlistener**.

```bash
kafka-topics --create \
    --zookeeper localhost:2181 \
    --topic prodlistener \
    --replication-factor 1 \
    --partitions 1
```

The following command will start a producer so you can write three records to the inventory topic.

```bash
kafka-console-producer \
    --broker-list localhost:9092 \
    --topic hotels
```

And in the console, you can then enter these three records to the topic. Once this is done, these records will be committed to the Azure Cosmos DB SQL API container mapped to the topic (**products**).

```json
{"id": "0ac8b014-c3f4-4db0-8a1f-434bab460938", "name": "handlebar", "categoryId": "78148556-4e84-44be-abae-9755dde9c9e3"}
{"id": "54ba00da-50cf-44d8-b122-1d18bd1db400", "name": "handlebar", "categoryId": "eb642a5e-0c6f-4c83-b96b-bb2903b85e59"}
{"id": "381dde84-e6c2-4583-b66c-e4a4116f7d6e", "name": "handlebar", "categoryId": "cf8ae707-6d74-4563-831a-06e15a70a0dc"}
```

## Read from Azure Cosmos DB

You can create a source connector in Kafka Connect using a JSON configuration object. In this sample configuration below, most of the properties should be left unchanged, but be sure to change the following values:

| **Property** | **Description** |
| :--- | :--- |
| **connect.cosmos.connection.endpoint** | Your actual account endpoint URI |
| **connect.cosmos.master.key** | Your actual account key |
| **connect.cosmos.databasename** | The name of your actual account database resource |
| **connect.cosmos.containers.topicmap** | Using CSV format, a mapping of your actual Kafka topics to containers |

```json
{
  "name": "cosmosdb-source-connector",
  "config": {
    "connector.class": "com.azure.cosmos.kafka.connect.source.CosmosDBSourceConnector",
    "tasks.max": "1",
    "key.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "connect.cosmos.task.poll.interval": "100",
    "connect.cosmos.connection.endpoint": "<cosmos-endpoint>",
    "connect.cosmos.master.key": "<cosmos-key>",
    "connect.cosmos.databasename": "<cosmos-database>",
    "connect.cosmos.containers.topicmap": "<kafka-topic>#<cosmos-container>",
    "connect.cosmos.offset.useLatest": false,
    "value.converter.schemas.enable": "false",
    "key.converter.schemas.enable": "false"
  }
}
```

As an illustrative example, using this example configuration table:

| **Property** | **Description** |
| :--- | :--- |
| **connect.cosmos.connection.endpoint** | ``https://dp420.documents.azure.com:443/`` |
| **connect.cosmos.master.key** | ``C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==`` |
| **connect.cosmos.databasename** | ``cosmicworks`` |
| **connect.cosmos.containers.topicmap** | ``prodlistener#products`` |

Here is an example configuration file:

```json
{
  "name": "cosmosdb-source-connector",
  "config": {
    "connector.class": "com.azure.cosmos.kafka.connect.source.CosmosDBSourceConnector",
    "tasks.max": "1",
    "key.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "connect.cosmos.task.poll.interval": "100",
    "connect.cosmos.connection.endpoint": "https://dp420.documents.azure.com:443/",
    "connect.cosmos.master.key": "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==",
    "connect.cosmos.databasename": "cosmicworks",
    "connect.cosmos.containers.topicmap": "prodlistener#products",
    "connect.cosmos.offset.useLatest": false,
    "value.converter.schemas.enable": "false",
    "key.converter.schemas.enable": "false"
  }
}
```

Once configured, data from the Azure Cosmos DB change feed will be published to a Kafka topic.

[microsoft/kafka-connect-cosmosdb]: https://github.com/microsoft/kafka-connect-cosmosdb
