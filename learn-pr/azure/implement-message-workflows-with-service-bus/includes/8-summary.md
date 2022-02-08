In this module, you created a Service Bus namespace, a queue, a topic, and a subscription to the topic in your Azure subscription. Then, you sent and received messages through the queue and the topic by using C# code.

Service Bus queues and topics are excellent tools you can use to increase the resilience of communications within a distributed application. By acting as temporary storage locations, Service Bus queues and topics remove the requirement for direct communication between components, and they smoothly handle peaks in demand. Consider using Service Bus queues and topics when you have a component that can communicate with another component in a loosely coupled configuration.

[!include [Azure sandbox cleanup](../../../includes/azure-sandbox-cleanup.md)]
