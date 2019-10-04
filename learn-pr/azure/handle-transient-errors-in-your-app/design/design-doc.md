# Module Design

## Title

Build code that recovers from transient errors

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

N/A

## Prerequisites

- Entry-level developer knowledge in the covered language

## Summary

Customers building their very first cloud-based apps and who are not accustomed to the many kinds of transient faults that can occur (network connectivity, service unavailability, timeouts, etc.)

## Learning objectives

- Identify common strategies for handling transient errors
- Detect transient errors in code
- Perform appropriate task retry, delay and cancellation and logging in code

## Chunk your content into subtasks

Identify the subtasks of *Build code that recovers from transient errors*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
|  Define transient errors           |  Understand what transient errors are                                             |  Knowledge check |  1   |  Yes  |
|  Detect transient errors in code   |  Identify all the places the code currently handles transient errors              |  Exercise        |  2   |  Yes  |
|  Identify approaches to errors     |  Categorize strategies for handling errors                                        |  Exercise        |  3   |  Yes  |
|  Perform appropriate logging       |  Enhance the existing chat app if there are any missing errors not being handled  |  Exercise        |  3   |  Yes  |

## Outline the units

1. **Introduction**

    *Your company has been developing on-premise desktop applications. It has recently had a serious data incident where a large amount of data was lost. The CTO has been asked to improve the company’s entire suite of apps to use microservices and cloud-based data storage. Your team leader has given you time to examine your team's in-house chat app to help you get experience of how transient errors may impact your team's other apps.*

    *Talking the design through with your manager, you both agree that a good starting point is to identify all the places the code currently handles transient errors. You need to group these different approaches into categories, and define a common set of strategies that can be applied across all the companies applications. The existing chat app should be enhanced if it's missing any error handling.*

1. **Explore what transient errors are for cloud-based apps**

    List the content that will enable the learner to *Define transient errors*:

    - Video\Animation: Show how transient errors can bring down a service if an anti-pattern has been applied (for example, too many retries overloading a service)
    - Set the scene for the issues cloud-based applications can face:
        - Connectivity issues
        - Timeouts
        - Services unavailable
        - Throughput
    - Explain the challenges that need to be addressed:
        - Detection
        - Retry strategies
        - Don't make it worse - when to back-off
    - Define the difference between terminal, permanent and transient errors and the possible approaches for each type of error.

1. **Knowledge check**

    What types of questions will test *Identify common strategies for handling transient errors*?

    - Why would an app need to back-off from trying to read from a database?
    - Why is a *fast first retry* a good approach for cloud-based services?
    - What is the best approach when making a large number of retry attempts to an Azure-based service?

1. **Detect transient errors in code**

    List the content that will enable the learner to *Detect transient errors*:

    - Do the services being used have well-documented transient failure contracts?
    - Use examples for typical resources:
        - HTTP status codes (for example, 408, 449, 503, 504)
        - Azure connections WebExceptionStatus.ConnectionClosed, WebExceptionStatus.Timeout, WebExceptionStatus.RequestCanceled
        - Azure Cosmos DB `RequestRateTooLarge` error 429
        - Azure SQL Database Error Codes (for example, 40501: The service is currently busy. Retry the request after 10 seconds)
        - REST APIs may return status and time until next retry
    - Use the service's built-in retry logic. For example, reference CosmosDB *retryOptions*.

1. **Exercise - Detect transient errors in code**

    List the steps which apply the learning content from previous unit (separate out each language):

    1. Run a script in the Cloud Shell to create an Azure Cosmos DB account and database.
    1. Complete the steps to get the MongoDB connection string.
    1. git clone source code.
    1. Build the app in chosen language.
    1. Review existing detection code (each example app should have implemented one) - **(JohnS - "one" what?)**
    1. Add code to detect any transient errors.
    1. Test the code.

1. **Define an appropriate retry policy for cloud-based apps**

    List the content that will enable the learner to *Identify approaches to errors*:

    - You can take different approaches depending on the nature of the transient error. These include:
        - Fast first retry
        - Exponential back-off
        - Incremental intervals
        - Randomized back-off intervals
        - Customize when more information is available (for example, from HTTP response Retry-After header value)
        - Use a circuit breaker to stop retrying indefinitely
    - Expand on improving the apps resilience by having a central process that handles retries, including parameterizing retry counts and intervals.
    - Explain that there are libraries that can be used to help write fault tolerant code more efficiently. Polly, and Resilience4j, are two currently developed open-source projects.

1. **Exercise - Write a retry policy**

    List the steps which apply the learning content from previous unit (separate out each language):

    - C# and Java
        1. Add a class to handle retries.
        1. Add methods to implement fast retry, randomized incremental retires, and a circuit breaker.
        1. Include CosmosDB retryOptions.
        1. Use the class to handle retries when connecting to the database.

    - Node.JS
        1. Add code to the server.js to add functions to fast retry, randomized incremental retires, and a circuit breaker.
        1. Include CosmosDB retryOptions.
        1. Edit index.html to use these new functions when connecting to the database.

    1. Run the application.
    1. Using Azure CLI remove the firewall rule to allow connections to CosmosDB.
    1. Use the app and then add the firewall rule back to see the app recover.

1. **Log useful information related to errors faced by cloud-based apps**

    List the content that will enable the learner to *Perform appropriate logging*:

    - Explain how and why to log entries for all transient errors as warnings, and why.
    - Explain how and why to log time taken to recover from transient errors.
    - Explain how and why to log number of retries.

1. **Exercise - Add application logging**

    List the steps which apply the learning content from previous unit (separate out each language):

    1. Add logging to the console for each of the retry policies.
    1. Run the same test, blocking CosmosDB network access, and watch the logging in the console.

1. **Summary**

    *{How did you solve the problem in the initial scenario with the knowledge learned in the module?}*

    - Code was added to the chat app to handle more transient errors.
    - Code was added to log transient errors.
    - Several different approaches to transient errors have been defined.

## Notes
**This module is associated directly with an OD task and therefore is a high priority for coverage.** It is general developer knowledge and does not correspond to a particular Azure service or technology, although strategies discussed should mention specific services where applicable, specifically queuing.

This module should cover standard, simple detection and mitigation strategies in C#, JavaScript and Java code. Code should be idiomatic.

Module content should mention commonly-used libraries for handling transient errors, but should not be reliant on them. It should include code samples and strategies that require no external libraries.

Detection should focus on simple strategies for recognizing exceptions/errors such as timeouts and differentiating them (and their mitigation strategy) from non-transient errors.  

Resources:

https://docs.microsoft.com/azure/architecture/best-practices/transient-faults,  
https://docs.microsoft.com/aspnet/aspnet/overview/developing-apps-with-windows-azure/building-real-world-cloud-apps-with-windows-azure/transient-fault-handling 

Libraries:

- [Transient Fault Handling Application Block*](https://www.nuget.org/packages/EnterpriseLibrary.TransientFaultHandling/)
- [Polly .NET](http://www.thepollyproject.org/)
- [Polly.JS](https://www.npmjs.com/package/polly-js)
- [Resilience4j](https://github.com/resilience4j/resilience4j)

*no longer recommended

Comsos DB retry:

- [C#](https://docs.microsoft.com/dotnet/api/microsoft.azure.documents.client.connectionpolicy.retryoptions?redirectedfrom=MSDN&view=azure-dotnet#overloads)
- [Java](https://docs.microsoft.com/java/api/com.microsoft.azure.cosmosdb.retryoptions?view=azure-java-stable)
- [Node.JS](https://docs.microsoft.com/javascript/api/%40azure/cosmos/retryoptions?view=azure-node-latest)
- [MongoDB](https://docs.mongodb.com/manual/core/retryable-writes/#retryable-writes)

## Additional Comments
The learners will be presented with three chat apps written in C# .NET Core (console app), Node.JS (web app), and Java (console app). All of them can be run from the Cloud Shell. The chat app will read and write chat messages through a MongoDB API to a back-end Azure Cosmos DB. The module will be written generically, with the students able to switch to the language they're more familiar with.
