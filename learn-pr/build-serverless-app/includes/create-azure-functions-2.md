## Overview of Azure Functions

Azure Functions makes it easy for you to run small pieces of code, or "functions," in the cloud. You can write only the code you need for the problem at hand, without worrying about a whole application or the infrastructure to run it. Functions can make you more productive during your development time, and let you use your development language of choice, such as C#, F#, Node.js, Java, or PHP. Azure automatically scales when your code runs, and you pay only for the time you're actually consuming resources.

## What can I do with Functions?
Functions is a great solution for processing data, integrating systems, working with the Internet of Things (IoT), and building simple APIs and microservices. Consider Functions for tasks such as image or order processing, file maintenance, or for any tasks that you want to run on a schedule. 

Functions provides templates to get you started with key scenarios, including the following:

* **HTTPTrigger**: Trigger the execution of your code by using an HTTP request.
* **TimerTrigger**: Execute cleanup or other batch tasks on a predefined schedule.
* **GitHub webhook**: Respond to events that occur in your GitHub repositories.
* **Generic webhook**: Process webhook HTTP requests from any service that supports webhooks.
* **CosmosDBTrigger**: Process Azure Cosmos DB documents when they are added or updated in collections in a NoSQL database.
* **BlobTrigger**: Process Azure Storage blobs when they are added to containers. You might use this function for image resizing.
* **QueueTrigger**: Respond to messages as they arrive in an Azure Storage queue.
* **EventHubTrigger**: Respond to events delivered to an Azure event hub. This action is particularly useful in application instrumentation, user experience or workflow processing, and IoT scenarios.
* **ServiceBusQueueTrigger**: Connect your code to other Azure services or on-premises services by listening to message queues.
* **ServiceBusTopicTrigger**: Connect your code to other Azure services or on-premises services by subscribing to topics.

Let's get started creating some Azure functions to process our incoming pictures and re-upload them.
