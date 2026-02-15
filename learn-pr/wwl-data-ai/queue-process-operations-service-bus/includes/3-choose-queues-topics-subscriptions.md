When you design a messaging layer for an AI workflow, the first architectural decision is whether to use a Service Bus queue or a topic with subscriptions. This choice determines how messages flow through your system, how many consumers can act on each message, and how easily you can add new consumers in the future. The right entity type depends on whether each message needs single-consumer processing or fan-out to multiple independent consumers.

## Use queues for single-consumer AI processing

A Service Bus queue delivers each message to exactly one competing consumer. When you have multiple worker instances reading from the same queue, Service Bus ensures that each message is processed by only one worker. This pattern suits AI workloads where a single processing step handles each request, such as an inference service that receives prompts, runs a model, and writes results to a database. You can scale processing horizontally by adding more workers without changing any code. Each worker independently connects to the queue, pulls messages, and processes them.

Queues support two receive modes that control how delivery acknowledgment works. In receive-and-delete mode, Service Bus removes the message from the queue immediately upon delivery. In peek-lock mode (the default), Service Bus locks the message for a configurable duration and waits for the consumer to explicitly complete, abandon, or dead-letter the message. Peek-lock is the recommended mode for AI workloads because it provides at-least-once delivery. If a worker crashes during processing, the lock expires and Service Bus makes the message available for another worker to pick up.

Queues also support sessions, which enable first-in-first-out (FIFO) processing guarantees and single-receiver semantics per session group. For AI workloads that need to process related messages in order, such as a multi-step document pipeline where extraction must precede classification, sessions allow you to group related messages using a session ID and ensure they're processed sequentially by a single consumer.

## Use topics and subscriptions for fan-out AI workflows

A Service Bus topic accepts messages from senders and distributes copies to each attached subscription. Each subscription acts like an independent virtual queue with its own consumer. This pattern fits scenarios where multiple downstream services need to react to the same event independently. For example, when a document analysis completes, a notification subscription sends an alert to the user, an audit subscription logs the result for compliance, and a metrics subscription updates a processing dashboard. Each subscription processes its copy of the message independently, so a failure in one subscription doesn't affect the others.

Topics decouple the sender from the receivers. The sender publishes to a single topic without knowing how many subscriptions exist or what each subscriber does with the message. You can add new subscriptions at any time without modifying the producer's code. This extensibility is valuable in AI architectures that evolve over time. You might start with a single inference pipeline that writes results to a database, then later add a subscription for a quality-assurance service that spot-checks model outputs, and another subscription for a retraining pipeline that collects input-output pairs for model improvement.

## Filter messages with subscription rules

Subscriptions support filter rules that select messages based on properties, allowing you to route messages selectively without writing filtering logic in each consumer. Service Bus evaluates filter rules at the broker level, so messages that don't match a subscription's filter are never delivered to that subscription's consumer. This reduces unnecessary message delivery and processing.

Three filter types are available. Boolean filters accept all messages (`TrueFilter`, the default) or reject all messages (`FalseFilter`). SQL filters use a SQL-like expression syntax that evaluates against application properties and system properties of the message. Correlation filters match against specific property values and are more efficient than SQL filters for exact-match scenarios.

For AI workloads, you can tag messages with application properties such as `model_name`, `priority`, or `document_type`, and each subscription receives only messages that match its filter. A high-priority subscription can filter on `priority = 'high'` to route urgent inference requests to a dedicated processor with reserved GPU capacity. A subscription for a specific model version can filter on `model_name = 'gpt-4o'` to process only requests targeting that model.

```python
# Code fragment - focus on creating a subscription rule with the management client
from azure.servicebus.management import ServiceBusAdministrationClient, SqlRuleFilter

admin_client = ServiceBusAdministrationClient(
    fully_qualified_namespace="<namespace>.servicebus.windows.net",
    credential=credential
)

admin_client.create_rule(
    topic_name="inference-results",
    subscription_name="high-priority",
    rule_name="filter-high-priority",
    filter=SqlRuleFilter("priority = 'high'")
)
```

> [!NOTE]
> Code examples in this module are patterns to adapt to your specific requirements. They illustrate the SDK's API surface and aren't intended for direct copy-paste into production applications.

## Decide between queues and topics

The following decision framework helps you match the right entity type to common AI messaging scenarios.

You can use a **queue** when:

- **A single processing pipeline handles each request.** A document extraction service receives a prompt, runs a model, and writes results. Only one consumer needs to act on each message.
- **You need competing consumers for horizontal scaling.** Multiple workers pull from the same queue. Service Bus ensures each message reaches only one worker.
- **No other service needs the same message.** The message represents a task that's complete once a single consumer processes it.

You can use a **topic with subscriptions** when:

- **Multiple independent services need to react to the same message.** A completed inference result needs to trigger notifications, auditing, and dashboard updates simultaneously.
- **You need content-based routing.** Different consumers should receive different subsets of messages based on properties like priority level, model name, or document type.
- **You want to add new consumers without modifying the producer.** New subscriptions can be created at any time, and the publisher's code doesn't change.

## Send messages with queue senders and topic senders

The Python `azure-servicebus` SDK uses the same `ServiceBusClient` class for both queues and topics. The difference is in how you create senders and receivers. You can call `get_queue_sender()` to send to a queue or `get_topic_sender()` to publish to a topic. On the receiving side, you can call `get_queue_receiver()` for queue consumers or `get_subscription_receiver()` for subscription consumers. This consistent API makes it straightforward to switch between patterns or use both patterns in the same application.

```python
# Code fragment - focus on sending to a queue versus a topic
from azure.servicebus import ServiceBusClient, ServiceBusMessage
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()

with ServiceBusClient(
    fully_qualified_namespace="<namespace>.servicebus.windows.net",
    credential=credential
) as client:
    # Send to a queue (point-to-point)
    with client.get_queue_sender("inference-requests") as queue_sender:
        queue_sender.send_messages(
            ServiceBusMessage("queue message body")
        )

    # Send to a topic (publish-subscribe)
    with client.get_topic_sender("inference-results") as topic_sender:
        topic_sender.send_messages(
            ServiceBusMessage("topic message body")
        )
```

On the receiving side, a subscription receiver connects to a specific subscription on a topic. Each subscription maintains its own copy of the messages, so consuming from one subscription doesn't affect the message availability in other subscriptions.

```python
# Code fragment - focus on receiving from a subscription
with client.get_subscription_receiver(
    topic_name="inference-results",
    subscription_name="notifications"
) as receiver:
    for msg in receiver:
        print(str(msg))
        receiver.complete_message(msg)
```

The `ServiceBusClient` uses context managers (`with` statements) to ensure connections are properly closed. You can also manage the client lifecycle manually by calling `client.close()`, but context managers are the recommended approach because they guarantee cleanup even when exceptions occur.

## Additional resources

- [Service Bus queues, topics, and subscriptions](/azure/service-bus-messaging/service-bus-queues-topics-subscriptions)
- [Topic filters and actions](/azure/service-bus-messaging/topic-filters)
