## Producer-consumer

The following image contains a description of the ProjectProducerConsumer activities.

:::image type="content" source="../media/producer-consumer-activities.svg" alt-text="Description of the ProjectProducerConsumer activities." border="false":::

The Producer thread has priority 5 and the Consumer thread has priority 15. The Producer continuously places instances on the storage facility. The Consumer takes instances from the storage facility. If no instances are available, the Consumer waits until an instance appears.
