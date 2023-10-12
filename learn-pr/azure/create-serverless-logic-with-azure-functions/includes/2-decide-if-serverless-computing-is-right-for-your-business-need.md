To help decide whether serverless computing is right for you, let's first learn what serverless is all about.

## What is serverless compute?

[Serverless compute](https://azure.microsoft.com/solutions/serverless/) can be thought of as a function as a service (FaaS), or a microservice that is hosted on a cloud platform. Your business logic runs as functions and you don't have to manually provision or scale infrastructure. The cloud provider manages infrastructure. Your app is automatically scaled out or down depending on load. Azure has several ways to build this sort of architecture. The two most common approaches are Azure Logic Apps and Azure Functions, which is the focus of this module.

## What is Azure Functions?

Azure Functions is a serverless application platform. It enables developers to host business logic that can be executed without provisioning infrastructure. Azure Functions provides intrinsic scalability and you're charged only for the resources used. You can write your function code in the language of your choice, including C#, Java, JavaScript, Python, and PowerShell. Support for package managers like NuGet and npm is also included, so you can use popular libraries in your business logic.

## Benefits of a serverless compute solution

Serverless compute is a great option for hosting business logic code in the cloud. With serverless offerings such as Azure Functions, you can write your business logic in the language of your choice. You get automatic scaling, you have no servers to manage, and you're charged based on what is used—not on reserved time. Here are some other characteristics of a serverless solution for you to consider.

### Avoids over-allocation of infrastructure

Suppose you've provisioned virtual machine (VM) servers and configured them with enough resources to handle your peak load times. When the load is light, you're potentially paying for infrastructure you're not using. Serverless computing helps solve the allocation problem by scaling up or down automatically, and you're only billed when your function is processing work.

### Stateless logic

Stateless functions are great candidates for serverless compute; function instances are created and destroyed on demand. If state is required, it can be stored in an associated storage service.

### Event driven

Functions are _event driven_. They run only in response to an event (called a "trigger"), such as receiving an HTTP request, or a message being added to a queue. You configure a trigger as part of the function definition. This approach simplifies your code by allowing you to declare where the data comes from (trigger/input binding) and where it goes (output binding). You don't need to write code to watch queues, blobs, hubs, and so on. You can focus purely on the business logic.

### Functions can be used in traditional compute environments

Functions are a key component of serverless computing, but they're also a general compute platform for executing any type of code. Should the needs of your app change, you can take your project and deploy it in a non serverless environment. That gives you the flexibility to manage scaling, run on virtual networks, and even completely isolate your functions.

## Drawbacks of a serverless compute solution

Serverless compute, as provided by Azure Functions in the Consumption plan, isn't always the appropriate solution to hosting your business logic. Here are a few characteristics of functions that may affect your decision to host your services in serverless compute.

### Execution time

By default, functions have a timeout of five (5) minutes. This timeout is configurable to a maximum of 10 minutes. If your function requires more than 10 minutes to execute, you can host it on a VM. Additionally, if your service is initiated through an HTTP request and you expect that value as an HTTP response, the timeout is further restricted to 2.5 minutes. However, there's also an option called [**Durable Functions**](/azure/azure-functions/durable) that lets you orchestrate the executions of multiple functions without any timeout.

### Execution frequency

Another characteristic is execution frequency. If you expect clients to execute your function continuously, it would be prudent to estimate the usage and calculate the cost of using functions accordingly. It might be cheaper to host your service on a VM.

When your function scales, only one function app instance can be created every 10 seconds, for up to 200 total instances. Keep in mind, each instance can service multiple concurrent executions, so there's no set limit about how much traffic a single instance can handle. Different types of triggers have different scaling requirements, so research your choice of trigger and investigate its limits.