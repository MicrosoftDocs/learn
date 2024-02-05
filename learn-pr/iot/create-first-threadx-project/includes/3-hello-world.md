## Introduction

There are three purposes for this example:

- Introduce you to the basics of ThreadX system development
- Identify the essential components needed to implement that system by using a simple but realistic scenario
- Understand the fundamentals needed to design a ThreadX real-time solution

## Scenario

A message center has two types of messages that it processes: Urgent and Routine. The Processor can handle only one message at a time. If two messages arrive at the same time, the Processor handles the Urgent message first because it has a higher priority. However, if the Processor is already handling a Routine message and an Urgent message arrives, then the Urgent message must wait until the Routine message finishes. Here are some other details:

- Urgent messages have a higher priority than Routine messages
- There's only one Processor
- The Processor runs 24 hours per day

<a name="hello-world-scenario"></a>

The following diagram illustrates the Hello World scenario and how we can model the activities of the Urgent thread and the Routine thread.

:::image type="content" source="../media/model-thread-activities.svg" alt-text="Illustration of the Hello World scenario." border="false":::

For convenience, we specify exact values for preparation and processing times. In reality, we would have sensors that would determine the actual times for the preparation and processing activities. For example, the length and nature of each message would determine the amount of time required for the preparation and the processing activities.

> [!NOTE]
> Activities 2 and 4 are labeled as Critical Sections. For example, when the Processor is handling a Routine message, it cannot at the same time handle an Urgent message. This means that only one thread can be in a critical section at any point in time. We'll use a mutex to enforce this property.

A significant advantage of using ThreadX is that it handles the scheduling of all activities and the management of the one message processor.
