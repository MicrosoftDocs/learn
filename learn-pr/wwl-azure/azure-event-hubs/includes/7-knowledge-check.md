

## Multiple Choice
Which of the following Event Hubs concepts represents an ordered sequence of events that is held in an Event Hubs?
( ) Consumer group {{Incorrect. A consumer group is a view of an entire Event hub.}}
(x) Partition {{Correct. A partition is an ordered sequence of events that is held in an Event Hub.}}
( ) Event Hubs producer {{Incorrect. An Event Hub producer is a type of client.}}

## Multiple Choice
Which of the following options represents when an event processor marks or commits the position of the last successfully processed event within a partition?
(x) Checkpointing {{Correct. Checkpointing is a process when an event processor marks, or commits, the position of the last successfully processed event within a partition.}}
( ) Scale {{Incorrect. Scale covers the number of consumers and taking ownership of reading partitions.}}
( ) Load balance {{Incorrect. Load balance increases or reduces the consumers dynamically.}}

## Multiple Choice
What is a key advantage of using Microsoft Entra ID with Azure Event Hubs?
( ) It allows storing credentials directly in the application code for easier access. {{Incorrect. Storing credentials in code is not recommended due to security risks.}}
( ) It eliminates the need for OAuth 2.0 tokens for authentication. {{Incorrect. OAuth 2.0 tokens are still required for authentication with Microsoft Entra ID.}}
(x) It removes the need to store credentials in the application code by using OAuth 2.0 tokens. {{Correct. Microsoft Entra ID enables secure authentication without storing credentials in the code.}}

## Multiple Choice
What is the purpose of the EventHubProducerClient in the Azure Event Hubs client library?
( ) To process events from an event hub using a consumer group. {{Incorrect. Processing events is the role of the EventHubConsumerClient or EventProcessorClient.}}
(x) To publish events to an event hub, either to specific partitions or using automatic routing. {{Correct. The EventHubProducerClient is responsible for publishing events to an Event Hub.}}
( ) To manage and monitor the partitions within an event hub. {{Incorrect. The EventHubProducerClient is not used for managing or monitoring partitions.}}

