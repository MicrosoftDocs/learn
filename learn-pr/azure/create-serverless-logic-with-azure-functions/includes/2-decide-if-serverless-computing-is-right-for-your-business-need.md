## Motivation

In preparation for creating your temperature data service, you need to be sure that serverless compute is the best solution for the job. Using Azure Functions may seem like a fit, but there are certain cases where firing up a VM and maintaining a server would end up being more cost effective.

## What is serverless compute?

Let's first explain a little bit about what serverless compute actually is. Serverless compute can be thought of as a function as a service (FaaS), or a microservice that is hosted on a cloud platform. This function contains business logic code that can be executed without the need to provision or scale infrastructure.  The hosting platform is completely abstracted, there are no servers to access and scaling to estimate. The billing model for these functions is based on the resources used, namely the number of executions, execution time, and memory consumption.

## What are Azure functions?

Azure functions is Azure's serverless application platform implementation. It allows developers to host business logic that can be executed without needing to provision costly infrastructure. Azure functions provide intrinsic scalability and bills only for the resources used.  Azure Functions can be implemented in a variety of languages including C#, F#, and JavaScript. It also provides support for NuGet and NPM, so you can use many popular libraries in your code.

## When do you use serverless compute?

Serverless compute is a very tempting option for hosting business logic code in the cloud. It has automatic scaling, no servers to manage, sub-second billing, and provides a choice of multiple programming languages for implementation. Here are some additional characteristics that are well served with serverless compute.

### Avoiding over-allocation of infrastructure

Suppose you have provisioned VM servers and configured them with enough resources to handle your peak load times. This means that all the time your load is not at peak, you are overpaying for your infrastructure. Serverless compute solves the over-allocation problem by handling and abstracting all provisioning, managing and scaling of infrastructure to keep up with the current load, and scales up or down automatically as required. You are only billed for the resources that are used while your function is actively running.

### Stateless logic

Stateless functions are great candidates for serverless compute, this is because instances are built up and torn down based on current load - there is no such thing as a sticky session. Granted, if you needed some type of state in your functions, it makes sense to store it with the data. The function you will be creating is both stateless and idempotent, making it a perfect candidate. Your function will receive data, check the temperature property and assign it a status based on pre-defined thresholds.

### Event driven

Azure Functions are event driven. This means that they run only in response to an event happening, such as receiving an HTTP request or a message being added to a queue. Azure function configuration greatly simplifies your codebase by allowing you to declare where the data comes from (trigger/input binding) and where it goes (output binding). This means that you don't have to write code to watch queues, blobs, hubs,etc. - you can focus strictly on the business logic.

## When do you not use serverless compute?

Serverless compute will not always be the appropriate solution to hosting your business logic. Here are a few characteristics of Azure functions that may affect your decision to host your services in serverless compute.

### Execution time

The first characteristic is execution time. By default, Azure functions have a timeout of 5 minutes, this is further configurable to a maximum of 10 minutes. If your function requires more than 10 minutes to execute, you will need to host it on a VM. Furthermore, if your service is initiated through an Http request and you expect that value as an Http response, the timeout is further restricted to 2.5 minutes, while the function will continue to execute - nothing will be returned on the Http pipe.

### Execution frequency

The second characteristic is execution frequency. If you expect your function to be executed continuously by multiple clients, it would be prudent to estimate the usage and calculate the cost of using Azure functions accordingly. It could very well be cheaper to host your service on a VM.

While scaling, only one function app instance can be created every 10 seconds, for up to 200 total instances. Keep in mind, each instance has the ability to service multiple concurrent executions, so there is no set limit on how much traffic a single instance can handle. Different types of triggers have different scaling requirements, so research your choice of trigger and investigate its limits.

### Processing power

Lastly, if your function requires a large amount of memory to run, and is run often; it would make sense to do a cost feasibility estimation when it comes to memory as well.

## Summary

In this unit, you've learned about serverless compute and Azure's implementation - Azure functions. You learned about characteristics of functions that make good and bad serverless candidates and determined that the temperature service is a prime candidate for a serverless implementation.

In the next unit you will learn about a component of the Azure serverless platform, the Function App.

## Resources

* [Azure Functions Pricing Details](https://azure.microsoft.com/en-us/pricing/details/functions/)
* [Introduction to Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-overview)
* [Azure Functions Scaling](https://docs.microsoft.com/en-us/azure/azure-functions/functions-scale)
* [Event Hub Trigger Scaling](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs#trigger---scaling)
