:::image type="content" source="../media/select-azure-functions.png" alt-text="Flowchart for selecting Azure function solutions.":::



### What are Azure Functions?

[Azure Functions](/azure/azure-functions/functions-overview) is a serverless application platform. Functions are used when you want to run a small piece of code in the cloud, without worrying about the infrastructure. Functions provide intrinsic scalability, and you’re charged only for the resources used. You can write your function code in the language of your choice. Functions provide “compute on demand” in two significant ways. 

- First, Azure Functions allows you to implement your system's logic into readily available blocks of code. These code blocks (functions) can run anytime you need to respond to critical events.

- Second, as requests increase, Azure Functions meets the demand with as many resources and function instances as necessary. As requests complete, any extra resources and application instances drop off automatically.

### Scenarios for Azure Functions

Azure Functions are best when handling specific definable actions triggered by an event. For example, a function could process an API call and then store the processed data in Cosmos DB. Once the data transfer happens, another function could trigger a notification. 

:::image type="content" source="../media/azure-functions-events.png" alt-text="Azure functions handle API calls and output data to notifications hubs.":::



> [!TIP]
> You can get some other ideas on how to use Azure Functions by visiting the [code samples](/samples/browse/?expanded=azure&languages=csharp&products=azure-functions) page. 

### Best practices and tips for using Azure Functions

- **Avoid long running functions.** Large, long-running functions can cause unexpected timeout issues. Whenever possible, refactor large functions into smaller function sets that work together and return responses faster. The default timeout is 300 seconds for Consumption Plan functions, 30 minutes for any other plan.

- **Know when to use durable functions**. [Durable functions](/azure/azure-functions/durable/durable-functions-overview?tabs=csharp) let you write stateful functions. So, behind the scenes, the function manages app state, checkpoints, and restarts. An example application pattern for durable functions is function chaining. Function chaining executes a sequence of functions in a specific order. The output of one function is applied to the input of another function. Do you understand how timeout issues can be overcome with durable functions and smaller function sets?

:::image type="content" source="../media/durable-functions.png" alt-text="Durable functions pass information.":::

 

- **Organize functions for performance and scaling.** Consider how you want to group functions with different load profiles. For example, let’s say you have two functions. One function processes many thousands of queued messages and has low memory requirements. The other function is only called occasionally but has high memory requirements. You might want to deploy separate function apps, so each function gets its own set of resources. Separate resources mean you can independently scale the functions.

- **Write defensive functions.** Design your functions assuming an exception could occur at any time. Downstream services, network outages, or memory limits could cause the function to fail. Plan out how you continue from a failure point. 

- **Avoid sharing storage accounts.** When you create a function app, you must associate it with a storage account. To maximize performance, use a separate storage account for each function app. This is important if your function generates a high volume of storage transactions.

> [!TIP]
> Take a few minutes to read about other [Azure Function best practices](/azure/azure-functions/functions-best-practices).

> [!NOTE]
> Relativity, an e-discovery company, is using Azure functions to identify and resolve performance issues. Take a few minutes to [read about their successes](https://customers.microsoft.com/story/relativity-partner-professional-services-azure). 
