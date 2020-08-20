First of all, the term "serverless computing" is a misnomer.  After all, there *is* a server (or a group of servers) that executes your code or desired functionality.  The key idea is that you are not responsible for setting up or maintaining that server.  You don't have to worry about scaling the server when there's an increased demand, and you don't have to worry about outages. The cloud vendor takes care of all of maintenance and scaling concerns for you.

Typically "serverless computing" is used to handle "backend" scenarios.  In other words, it's responsible for sending message from one system to another, or processing messages that were sent from other systems.  It's not used for end-user facing systems, but rather works in the background.

There are two Azure serverless computing services available: Azure Functions and Azure Logic Apps.

## Azure Functions

Azure Functions allows you to host a single method or function using a popular programming language in the cloud that runs in response to an event, like an HTTP request, a new message on a queue, or on a timer.  Due to their atomic nature, Azure Functions can serve many purposes in an application's design.  They can be written using many common programming languages like C#, Python, JavaScript, Typescript, Java, and PowerShell.

Azure Functions scale automatically, and charges accrue only when a function is triggered, so they're a solid choice when demand is variable. For example, you may be receiving messages from an IoT solution that monitors a fleet of delivery vehicles. You'll likely have more data arriving during business hours. Azure Functions can scale out to accommodate these busier times.

Furthermore, Azure Functions is a stateless environment; Functions behave as if they're restarted every time they respond to an event. This feature is ideal for processing incoming data. And if state is required, they can be connected to an Azure storage service.

Azure Functions can perform orchestration tasks using an extension called Azure Durable Functions, which allows developers to chain Functions together while maintaining state.

Azure Functions is ideal when you're only concerned with the code running your service and not the underlying platform or infrastructure. Azure Functions is commonly used when you need to perform work in response to an event, often via a REST request, timer, or message from another Azure service, and when that work can be completed quickly, within seconds or less.

## Azure Logic Apps

Logic Apps is a low-code/no-code development platform hosted as a cloud service that helps you automate and orchestrate tasks, business processes, and workflows when you need to integrate apps, data, systems, and services across enterprises or organizations. Logic Apps simplifies how you design and build scalable solutions, whether in the cloud, on premises, or both, for app integration, data integration, system integration, enterprise application integration (EAI), and business-to-business (B2B) integration.

Azure Logic Apps is designed in a web-based designer and can execute logic triggered by Azure services without writing any code.  You build an app by linking triggers to  actions with connectors.  A trigger is an event that causes your app to execute, like a timer, a new message sent to a queue, or an HTTP request. An action is a task or step that can execute.  There are logic actions like you would find in most programming languages like working with variables, decision statements and loops, as well as tasks to parse and modify data.

To build enterprise integration solutions with Azure Logic Apps, you can choose from a growing gallery of over 200 connectors. These include services such as Salesforce, SAP, Oracle DB, and file shares.

If you can't find the action or connector you need, you can build your own using custom code.

## What's the difference between these services?

You can call Azure Functions from Azure Logic Apps, and vice versa.  The primary difference is the intent of each service.  Azure Functions is a serverless compute service, while Azure Logic Apps is intended to be a serverless orchestration service.  While there's nothing stopping you from using Azure Functions to orchestrate a long running business process involving many different types of connections, this was not its primary use case when it was designed.  Furthermore, you can see a difference in how the two services are priced.  Azure Functions is priced based on the number of executions and the running-time of each execution while Logic Apps is priced by the number of executions and the type of connectors that are utilized.