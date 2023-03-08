In this unit we'll discuss how you can decide whether Azure Functions is the right choice for your IoT solutions. We'll list some criteria that indicate whether Azure functions will meet your deployment goals for IoT solutions. 

Using the serverless computing approach, you can focus on the core logic of your solutions. You avoid the need to manage the underlying infrastructure that runs your solution. In the serverless application model, the cloud service provider automatically provisions, scales, and manages the underlying infrastructure required to run the code. The serverless model has two aspects: **function as a service** and **backend as a service.**

Developers write the application as functions. Typically, these functions are stateless and short-lived. Azure functions enable you to chain your functions to create the complete solution. Hence, as a developer, you're concerned with writing functions that interact with each other to solve the business problem. On the other hand, the cloud service provider manages these deployed functions from the perspective of resources like processors, storage, and bandwidth (backend as a service). The resources are provided on an ‘as-needed’ basis and scaled as required. You (the developer) are charged for the function only when the function is actually running (function as service). IoT applications suit many of these characteristics. In the case of IoT applications, you can create a larger application by amalgamating/chaining many functions and scaling them dynamically as needed.

## Business considerations

The key business considerations for using Azure function for IoT are to create scalable applications where you're charged only for the resources you use. Your solution can scale up or down dynamically depending on the business requirements. You don't have to manage the infrastructure or allocate the resources in advance. Other business advantages include faster time to market and the flexibility to use multiple programming languages.  

## Considerations for IoT

Internet of Things (IoT) solutions are typically event driven. That is, you need to define a specific trigger that causes the function to run. If your IoT solution could potentially scale from a small number of devices to millions of devices – you should consider Azure Functions. Similarly, if your solution could see spikes of events to millions of events, you should consider Azure functions.

## Best practice guidelines for Azure Functions

- **Avoid long running functions**: Large, long-running functions can cause unexpected timeout issues.

- **Write functions to be stateless:** Functions should be stateless and idempotent if possible. Idempotence is the property of certain operations in mathematics and computer science whereby they can be applied multiple times without changing the result beyond the initial application. For example, the number 1 is idempotent with respect to the multiplication operation because 1 x 1 = 1. Associate any required state information with your data. It's possible to achieve cross function communication using Durable Functions and Azure Logic Apps that manage state transitions and communication between multiple functions.

- **Write defensive functions:** Design your functions with the ability to continue from a previous fail point during the next execution.

- **Scalability best practices:** Share and manage connections, avoid sharing storage accounts, manage function memory usage.
