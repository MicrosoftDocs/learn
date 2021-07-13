Serverless architecture is a type of application development that allows you to run logic in the cloud without having to worry about building server infrastructure. Azure Functions implements a serverless architecture which runs your code on-demand and without you having to worry about manually provisioning servers.

One of the biggest reasons to use Azure Functions is due to the low cost. With Azure Functions, you can run a function one million times before incurring a cost. After the first million executions, usage is calculated with a pay-for-what-you-use model.

> [!NOTE]
> Azure Application Insights has a separate billing model and may generate charges if enabled in your Azure Functions application.

Using Azure Functions doesn't mean that you don't need to care about infrastructure, but that you have less decisions to make about where your application runs. When you deploy a functions app to Azure, server resources are provided on-demand. As demand varies, the application automatically scales up and down.

Logic implemented in Azure Functions runs in response to a variety of events that happen in the cloud. For example, some events that trigger a function include database row inserts, newly provisioned resources, and adding new queue messages.

To author Azure Functions in Go or Rust for example, you use a feature called custom handlers. Custom handlers allow you to bring almost any language to Azure Functions.

## Learning Objectives

After completing this module, you'll be able to:

- Build a serverless functions app using Go.
- Understand when to use custom handlers.
- Handle different triggers like HTTP and queue.
