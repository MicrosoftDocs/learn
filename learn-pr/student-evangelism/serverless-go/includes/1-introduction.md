Serverless architecture is a type of application development that allows you to run logic in the cloud without having to worry about building server infrastructure. Azure Functions implements a serverless architecture that runs your code on demand without requiring you to manually provision servers.

One of the biggest reasons to use Azure Functions is the low cost. With Azure Functions, you can run a function 1 million times before incurring a cost. After the first million executions, usage is calculated with a pay-for-what-you-use model.

> [!NOTE]
> Azure Application Insights has a separate billing model. It might generate charges if it's enabled in your Azure Functions application.

Using Azure Functions doesn't mean that you don't need to care about infrastructure. You just have fewer decisions to make about where your application runs. When you deploy a Functions app to Azure, server resources are provided on demand. As demand varies, the application automatically scales up and down.

Logic implemented in Azure Functions runs in response to events that happen in the cloud. Events that trigger a function include inserting database rows, provisioning new resources, and adding new queue messages.

To author Azure Functions in Go or Rust, for example, you use a feature called custom handlers. Custom handlers allow you to bring almost any language to Azure Functions.

## Learning objectives

After you complete this module, you'll be able to:

- Build a serverless functions app by using Go.
- Understand when to use custom handlers.
- Handle triggers like HTTP and queue.
