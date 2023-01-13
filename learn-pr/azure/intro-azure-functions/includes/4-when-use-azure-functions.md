As Azure Functions uses an event-based architecture, there are many interesting cases where such an architecture can be applied. Here’s a non-exhaustive list of scenarios suited for it:

- **Reminders and notifications**. Azure Functions has a trigger that can be instructed to run at certain intervals making it straight forward to implement such a scenario. You might have scenarios where getting a notification can be business critical.
- **Scheduled tasks**. Tasks that could use the same time-based triggers. In this case, there could be jobs that need to be done at certain intervals, for example, data cleaning or look for a piece of data.
- **Experimental APIs**. If you use the Consumption plan, with Functions, you can make millions of calls and pay very little. One thing to keep in mind is that any type of storage incurs a cost.

  An example is writing to a database with a function. This plan is ideal to use for prototyping or for Start-ups. In the latter case, if you have so many calls to your functions that most likely means you have paying customers. Hence, Azure Functions scales with your business. As your business grows, you might consider other hosting plans as well.

- **Irregular but important business flows**. Getting a new customer and onboarding that customer is an example where your code has a good reason to run. Such a flow likely consists of operations like interacting with a data store, sending out emails, and more.
- **Queue based**. You might have a ticket selling app and requests needs to be processed in a queue like fashion.
- **Processing data in real-time**. If combined with Azure SignalR, Azure Functions can be made to process data on demand.
- **Analyze IoT stream**. It’s possible to collect and process data from IoT devices.
- **Process file uploads**. Run code when a file is uploaded or changed in a blob storage.
- **Serverless workflow**. A series of functions can be chained together, and you can introduce state which makes it possible to devise complex long running workflows via Durable Functions. Another choice for workflows is Logic apps that can monitor external events, perform branching logic and invoke functions as a result.

There are numerous other scenarios where Azure Functions makes sense to use, the above serves as inspiration how you can innovate in the cloud when applying an event-based reasoning and architecture.
