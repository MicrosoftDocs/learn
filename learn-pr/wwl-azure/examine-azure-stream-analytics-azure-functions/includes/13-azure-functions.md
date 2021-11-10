Azure Functions is a solution for easily running small pieces of code, or "functions," in the cloud. You can write just the code you need for the problem at hand, without worrying about a whole application or the infrastructure to run it. Functions can make development even more productive, and you can use your development language of choice, such as C\#, Java, JavaScript, PowerShell, and Python. Pay only for the time your code runs and trust Azure to scale as needed. Azure Functions lets you develop serverless applications on Microsoft Azure.

## Features

Here are some key features of Functions:

 -  Choice of language - Write functions using your choice of C\#, Java, Javascript, Python, and other languages. See Supported languages for the complete list.
 -  Pay-per-use pricing model - Pay only for the time spent running your code. See the Consumption hosting plan option in the pricing section.
 -  Bring your own dependencies - Functions supports NuGet and NPM, so you can use your favorite libraries.
 -  Integrated security - Protect HTTP-triggered functions with OAuth providers such as Azure Active Directory, Facebook, Google, Twitter, and Microsoft Account.
 -  Simplified integration - Easily apply Azure services and software-as-a-service (SaaS) offerings. See the integrations section for some examples.
 -  Flexible development - Code your functions right in the portal or set up continuous integration and deploy your code through GitHub, Azure DevOps Services, and other supported development tools.
 -  Open-source - The Functions runtime is open-source and available on GitHub.

## What can I do with Azure Functions?

Azure Functions is a great solution for processing data, integrating systems, working with the internet-of-things (IoT), and building simple APIs and microservices. Consider Functions for tasks like image or order processing, file maintenance, or for any tasks that you want to run on a schedule.

Azure Functions provides templates to get you started with key scenarios, including the following:

 -  HTTPTrigger - Trigger the execution of your code by using an HTTP request. For an example, see Create your first function.
 -  TimerTrigger - Execute cleanup or other batch tasks on a predefined schedule. For an example, see Create a function triggered by a timer.
 -  CosmosDBTrigger - Process Azure Cosmos DB documents when they are added or updated in collections in a NoSQL database. For more information, see Azure Cosmos DB bindings.
 -  BlobTrigger - Process Azure Storage blobs when they are added to containers. You might use this function for image resizing. For more information, see Blob storage bindings.
 -  QueueTrigger - Respond to messages as they arrive in an Azure Storage queue. For more information, see Azure Queue storage bindings.
 -  EventGridTrigger - Respond to events delivered to a subscription in Azure Event Grid. Supports a subscription-based model for receiving events, which includes filtering. A good solution for building event-based architectures. For an example, see Automate resizing uploaded images using Event Grid.
 -  EventHubTrigger - Respond to events delivered to an Azure Event Hub. Useful in application instrumentation, user experience or workflow processing, and internet-of-things (IoT) scenarios. For more information, see Event Hubs bindings.
 -  ServiceBusQueueTrigger - Connect your code to other Azure services or on-premises services by listening to message queues. For more information, see Service Bus bindings.
 -  ServiceBusTopicTrigger - Connect your code to other Azure services or on-premises services by subscribing to topics. For more information, see Service Bus bindings.

Azure Functions supports triggers, which are ways to start execution of your code, and bindings, which are ways to simplify coding for input and output data. For a detailed description of the triggers and bindings that Azure Functions provides, see Azure Functions triggers and bindings developer reference.

## Integrations

Azure Functions integrates with various Azure and 3rd-party services. These services can trigger your function and start execution, or they can serve as input and output for your code. The following service integrations are supported by Azure Functions:

 -  Azure Cosmos DB
 -  Azure Event Hubs
 -  Azure Event Grid
 -  Azure Notification Hubs
 -  Azure Service Bus (queues and topics)
 -  Azure Storage (blob, queues, and tables)
 -  On-premises (using Service Bus)
 -  Twilio (SMS messages)

## How much does Azure Functions cost?

Azure Functions has two kinds of pricing plans. Choose the one that best fits your needs:

 -  Consumption plan - When your function runs, Azure provides all of the necessary computational resources. You don't have to worry about resource management, and you only pay for the time that your code runs.
 -  App Service plan - Run your functions just like your web apps. When you are already using App Service for your other applications, you can run your functions on the same plan at no extra cost.
