<!-- Original file: C:\Users\Mark\Desktop\CMU\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m05_streaming_and_mq\x-oli-workbook_page\_u05_m05_8_summary.xml -->
##  Message Queues, Stream Processing and Real-time architectures
Message queues are communication mechanisms used to enable indirect, asynchronous communications by partitioning and storing messages on brokers. This allows easy horizontal scaling of the messaging layer.

Kafka is a multi-subscriber message queue developed at LinkedIn. Consumers of this queue can choose to subscribe to topic(s), and is guaranteed to receive messages in the order sent.

Stream processing systems operate on an infinitely-long, often fast-moving set of input records, for e.g. the output of a message queue. To reduce latency, there are a set of simple rules that it could follow.

Stream processing jobs could be stateless (simply applying pre-defined rules to an input) or stateful (applying continuously changing rules based on past data and current status).

Samza is a stream processing framework developed at LinkedIn. By default, Samza is configured runs cgroups containers scheduled over YARN, reads from a Kafka stream, allowing programmers to use a custom API to define streaming tasks. When local state is needed, an embedded RocksDB instance is used.

Lambda and Kappa architectures are two methods of working with data pipelines with different latency requirements.

##  Quiz 12: GraphLab, Message Queues and Stream Processing