

## Multiple Choice
What is a key consideration when choosing to use Service Bus queues over Storage queues?
(x) Your solution requires the queue to provide a guaranteed first-in-first-out (FIFO) ordered delivery. {{Correct. Service Bus queues provide a guaranteed first-in-first-out (FIFO) ordered delivery.}}
( ) Your application must store over 80 gigabytes of messages in a queue. {{Incorrect. This is a feature of Storage queues, not Service Bus queues.}}
( ) You require server side logs of all of the transactions executed against your queues. {{Incorrect. This is also a feature of Storage queues, not Service Bus queues.}}

## Multiple Choice
What is the main difference between Service Bus queues and topics with subscriptions?
(x) Queues allow processing of a message by a single consumer, while topics with subscriptions provide a one-to-many form of communication. {{Correct. A queue allows processing of a message by a single consumer. In contrast, topics and subscriptions provide a one-to-many form of communication.}}
( ) Queues allow processing of a message by multiple consumers, while topics with subscriptions provide a one-to-one form of communication. {{Incorrect. Queues offer First In, First Out (FIFO) message delivery to one or more competing consumers, but only one consumer processes each message.}}
( ) Topics with subscriptions allow processing of a message by a single consumer, while queues provide a one-to-many form of communication. {{Incorrect. Topics and subscriptions provide a one-to-many form of communication in a publish and subscribe pattern, scaling to large numbers of recipients.}}

## Multiple Choice
What is the role of the `ContentType` property in Service Bus message payloads?
( ) It encrypts the payload for secure transmission. {{Incorrect. The `ContentType` property doesn't encrypt the payload.}}
( ) It determines the size of the payload. {{Incorrect. The `ContentType` property doesn't determine the size of the payload.}}
(x) It enables applications to describe the payload, with the suggested format for the property values being a MIME content-type description. {{Correct. The `ContentType` property describes the payload, suggesting a MIME content-type format.}}

## Multiple Choice
What is the purpose of the 'QueueClient' class in Azure Queue Storage when using .NET?
( ) It manages the configuration files for client applications. {{Incorrect. The 'QueueClient' class is not used for managing configuration files, but for interacting with queues in Azure Queue Storage.}}
(x) It retrieves and manipulates queues stored in Azure Queue Storage. {{Correct. The 'QueueClient' class is used to interact with queues in Azure Queue Storage, including creating, retrieving, and deleting queues.}}
( ) It creates and manage messages within a specific queue. {{Incorrect. While 'QueueClient' does interact with messages, it is primarily used to retrieve and manipulate queues, not individual messages.}}