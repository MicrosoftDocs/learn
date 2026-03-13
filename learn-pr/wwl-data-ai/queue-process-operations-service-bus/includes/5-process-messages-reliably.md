Reliable message processing ensures that your AI pipeline handles every inference request exactly as intended, even when processors crash, models return errors, or payloads contain unexpected data. Azure Service Bus provides receive modes, message settlement operations, dead-letter queues, and lock management features that give developers fine-grained control over delivery guarantees. This unit covers how to receive and process messages with the appropriate reliability level for AI workloads.

## Choose a receive mode

Service Bus offers two receive modes that control how the broker handles message delivery acknowledgment. The choice between them determines whether your system prioritizes throughput or delivery guarantees.

### Receive-and-delete mode

In receive-and-delete mode, Service Bus removes the message from the queue immediately when it delivers the message to the consumer. If the processor crashes after receiving the message but before completing inference, the system loses the message. This mode provides the highest throughput because it eliminates the lock management and settlement round trip. It suits scenarios where occasional message loss is acceptable and processing speed is the priority, such as real-time telemetry ingestion or noncritical logging where missing a few data points doesn't affect overall system correctness.

### Peek-lock mode

Peek-lock mode is the default and the recommended mode for AI workloads. Service Bus locks the message for a configurable duration and delivers it to the consumer without removing it from the queue. The consumer must explicitly settle the message (complete, abandon, dead-letter, or defer) within the lock duration. If the lock expires before settlement, Service Bus releases the lock and makes the message available for another consumer to receive. This two-phase approach provides at-least-once delivery, which is essential for AI workloads where losing an inference request is unacceptable.

The trade-off with peek-lock is slightly lower throughput compared to receive-and-delete, because each message requires a settlement call. For most AI workloads, this overhead is negligible compared to the time spent on inference processing, and the delivery guarantee far outweighs the minor throughput difference.

## Settle messages after processing

After receiving a message in peek-lock mode, the processor calls one of four settlement operations to report the processing outcome to Service Bus. Each operation signals a different outcome and instructs the broker to handle the message accordingly.

### Complete a message

The `complete_message()` method marks the message as successfully processed and removes it from the queue permanently. You can call this method after the processor finishes inference and writes the result to the results store. Completing a message is the normal success path in the processing loop.

### Abandon a message

The `abandon_message()` method releases the lock without removing the message from the queue, making it immediately available for redelivery. You can use this method when the processor encounters a transient error that might succeed on a retry, such as a model service timeout or a temporary network failure. Service Bus increments the message's delivery count each time it's abandoned, so the message eventually moves to the dead-letter queue if transient errors persist beyond the maximum delivery count.

### Dead-letter a message

The `dead_letter_message()` method moves the message to the dead-letter subqueue with a reason string and an error description. You can use this method when the processor can never successfully handle the message, such as when it contains a malformed JSON payload, references an unsupported model, or fails validation checks that won't pass on retry. Dead-lettering immediately removes the message from normal processing and preserves it for investigation without consuming further retry attempts.

### Defer a message

The `defer_message()` method keeps the message in the queue but removes it from regular delivery. You can only retrieve the message later by its sequence number using `receive_deferred_messages()`. This suits scenarios where the processor can't handle the message right now but expects to handle it later, such as when a required dependency isn't available yet or when messages need processing in a specific order but arrive out of sequence.

The following example shows the peek-lock receive pattern with complete and dead-letter settlements in an AI processing loop.

```python
# Code fragment - focus on peek-lock receive with settlement
import json
from azure.servicebus import ServiceBusClient, ServiceBusReceiveMode
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()

with ServiceBusClient(
    fully_qualified_namespace="<namespace>.servicebus.windows.net",
    credential=credential
) as client:
    with client.get_queue_receiver(
        queue_name="inference-requests",
        receive_mode=ServiceBusReceiveMode.PEEK_LOCK,
        max_wait_time=30
    ) as receiver:
        for msg in receiver:
            try:
                payload = json.loads(str(msg))
                result = run_inference(payload)
                save_result(result, payload.get("document_id"))
                receiver.complete_message(msg)
            except json.JSONDecodeError:
                receiver.dead_letter_message(
                    msg,
                    reason="MalformedPayload",
                    error_description="Message body is not valid JSON"
                )
            except ModelNotFoundError:
                receiver.dead_letter_message(
                    msg,
                    reason="UnsupportedModel",
                    error_description=f"Model {payload.get('model')} is not available"
                )
            except TransientServiceError:
                receiver.abandon_message(msg)
```

> [!NOTE]
> Code examples in this module are patterns to adapt to your specific requirements. They illustrate the SDK's API surface and aren't intended for direct copy-paste into production applications.

## Handle poison messages with max delivery count

Service Bus tracks how many times it delivers each message. When the delivery count exceeds the queue's `max_delivery_count` (the default is 10), Service Bus automatically moves the message to the dead-letter queue with the reason `MaxDeliveryCountExceeded`. This mechanism prevents a consistently failing message from blocking the queue indefinitely. Without max delivery count, a message that always causes an error would cycle through delivery and abandonment in an infinite loop, consuming processing resources without making progress.

For AI workloads, you can adjust `max_delivery_count` based on your retry strategy. A lower count (such as three to five) moves poison messages to the dead-letter queue faster, freeing processing capacity for healthy messages. A higher count gives transient errors more opportunities to resolve, which is useful when model services experience intermittent availability issues. Consider the nature of the errors your pipeline encounters: if failures are typically transient (network timeouts, temporary resource constraints), a higher count provides better recovery. If failures are typically permanent (malformed data, unsupported parameters), a lower count reduces wasted processing.

## Monitor and process the dead-letter queue

The dead-letter queue (DLQ) is a subqueue attached to every queue and subscription. It holds messages that expire, exceed the max delivery count, or that application code explicitly dead-letters. The DLQ exists automatically, and you don't need to create or manage it separately. Messages in the DLQ persist until you explicitly receive and complete them.

Each dead-lettered message carries `dead_letter_reason` and `dead_letter_error_description` properties that explain why Service Bus moved it. For messages that exceed the max delivery count, the reason is `MaxDeliveryCountExceeded`. For messages that application code dead-letters, the reason and description are whatever strings you pass to `dead_letter_message()`. These properties provide the diagnostic context needed to understand systemic issues in your AI pipeline.

Monitoring the DLQ is critical for AI applications because it reveals patterns of failure. A sudden increase in dead-lettered messages might indicate that a model deployment isn't working, that the processor doesn't handle a new input format, or that an upstream service is sending malformed requests. You can set Azure Monitor alerts on the dead-letter message count metric to detect these issues early.

```python
# Code fragment - focus on receiving and inspecting dead-letter messages
from azure.servicebus import ServiceBusClient, ServiceBusSubQueue
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()

with ServiceBusClient(
    fully_qualified_namespace="<namespace>.servicebus.windows.net",
    credential=credential
) as client:
    with client.get_queue_receiver(
        queue_name="inference-requests",
        sub_queue=ServiceBusSubQueue.DEAD_LETTER,
        max_wait_time=10
    ) as dlq_receiver:
        for msg in dlq_receiver:
            print(f"Dead-letter reason: {msg.dead_letter_reason}")
            print(f"Error description: {msg.dead_letter_error_description}")
            print(f"Correlation ID: {msg.correlation_id}")
            print(f"Delivery count: {msg.delivery_count}")
            print(f"Body: {str(msg)}")
            # Inspect and decide whether to resubmit or discard
            dlq_receiver.complete_message(msg)
```

You access the DLQ using the `sub_queue=ServiceBusSubQueue.DEAD_LETTER` parameter on the receiver. Use this approach instead of constructing the path manually (such as `<queue_name>/$deadletterqueue`), because the SDK handles the path formatting internally from the `ServiceBusSubQueue` enum.

## Reprocess dead-lettered messages

After fixing the root cause of failures, such as updating the model, correcting input validation, or expanding payload handling, you can resubmit dead-lettered messages to the original queue. The reprocessing pattern involves reading each message from the DLQ, creating a new message with the same body and properties, sending the new message to the original queue, and completing the dead-letter message to remove it from the DLQ.

```python
# Code fragment - focus on resubmitting dead-lettered messages
with client.get_queue_receiver(
    queue_name="inference-requests",
    sub_queue=ServiceBusSubQueue.DEAD_LETTER,
    max_wait_time=10
) as dlq_receiver:
    with client.get_queue_sender("inference-requests") as sender:
        for msg in dlq_receiver:
            # Create a new message with the original body and properties
            new_message = ServiceBusMessage(
                body=msg.body,
                content_type=msg.content_type,
                correlation_id=msg.correlation_id,
                application_properties=msg.application_properties
            )
            sender.send_messages(new_message)
            dlq_receiver.complete_message(msg)
```

Automated reprocessing scripts can handle bulk resubmission when a systemic fix resolves multiple failures at once. Before resubmitting, confirm that your fix genuinely resolves the root cause. Otherwise, the messages cycle back through processing and land in the DLQ again, wasting resources and obscuring the real failure count.

## Manage lock duration for long-running AI operations

Some AI operations, such as processing a long document or running a complex model pipeline, take longer than the default lock duration. Service Bus queue lock duration is configurable up to a maximum of five minutes, with a default of one minute. If the lock expires before the processor settles the message, Service Bus makes the message available for another consumer, which leads to duplicate processing.

For operations that might exceed the lock duration, you have two options. You can extend the lock by calling `receiver.renew_message_lock()` periodically during processing. Alternatively, you can use the `AutoLockRenewer` class, which automatically renews the lock in the background until the specified maximum renewal duration elapses. The `AutoLockRenewer` is the simpler option for long-running AI operations because it handles the renewal timing without requiring manual calls in your processing loop.

```python
# Code fragment - focus on automatic lock renewal for long-running processing
from azure.servicebus import ServiceBusClient, AutoLockRenewer
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()

with ServiceBusClient(
    fully_qualified_namespace="<namespace>.servicebus.windows.net",
    credential=credential
) as client:
    renewer = AutoLockRenewer()
    with client.get_queue_receiver(
        queue_name="inference-requests",
        max_wait_time=30
    ) as receiver:
        for msg in receiver.receive_messages():
            # Renew the lock for up to 10 minutes
            renewer.register(receiver, msg, max_lock_renewal_duration=600)
            result = run_long_inference(msg)
            receiver.complete_message(msg)
    renewer.close()
```

For long operations that consistently exceed even the extended renewal period, consider a two-phase processing approach. In the first phase, the processor receives the message, records the request in a tracking store, and completes the message quickly. In the second phase, a separate process picks up work from the tracking store and performs the long-running inference. This approach avoids lock management entirely for the long-running portion and uses the queue solely for reliable initial delivery.

## Additional resources

- [Settling receive operations](/azure/service-bus-messaging/message-transfers-locks-settlement#settling-receive-operations)
- [Overview of Service Bus dead-letter queues](/azure/service-bus-messaging/service-bus-dead-letter-queues)
- [Service Bus message sessions](/azure/service-bus-messaging/message-sessions)
