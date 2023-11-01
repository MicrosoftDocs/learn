



Azure supports two types of queue mechanisms: **Service Bus queues** and **Storage queues**.

Service Bus queues are part of a broader Azure messaging infrastructure that supports queuing, publish/subscribe, and more advanced integration patterns. They're designed to integrate applications or application components that may span multiple communication protocols, data contracts, trust domains, or network environments.

Storage queues are part of the Azure Storage infrastructure. They allow you to store large numbers of messages. You access messages from anywhere in the world via authenticated calls using HTTP or HTTPS. A queue message can be up to 64 KB in size. A queue may contain millions of messages, up to the total capacity limit of a storage account. Queues are commonly used to create a backlog of work to process asynchronously.

After completing this module, you'll be able to:

* Choose the appropriate queue mechanism for your solution.
* Explain how the messaging entities that form the core capabilities of Service Bus operate.
* Send and receive message from a Service Bus queue by using .NET.
* Identify the key components of Azure Queue Storage
* Create queues and manage messages in Azure Queue Storage by using .NET.

