In this module, you created a Service Bus namespace, a queue, and a topic in your subscription by using the Azure portal, and you sent and received messages through the queue and the topic.

Service Bus queues and topics are excellent tools that you can use to increase the resilience of communications within a distributed application. By acting as a temporary storage location, they remove the requirement for direct communication between components and handle peaks in demand smoothly. Consider using them whenever you have a component that can communicate with another component in a loosely coupled configuration.

[!include[](../../../includes/azure-sandbox-cleanup.md)]