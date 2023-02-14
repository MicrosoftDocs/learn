Load testing is an important part of continuous validation. To get started, you need to identify application flows. In this unit, you'll learn about user and system flows, why they're important, and the design criteria for the tests.

## What are application flows?

A flow is composed of application interactions required to complete a task. 

- **User flow** 

   These flows indicate how users interact with your application. In the Contoso Shoes scenario, the checkout process for purchasing items is an example of a user flow. It has these components that participate in inventory management:
   
   - Front-end web application
   - Checkout logic in Azure Functions
   - Backend database in Azure Cosmos DB
   
   From a mission-critical perspective, those components need to be highly available and resilient to failures. For example, the front-end web page needs to load quickly because the organization expects a large number of concurrent users.

- **System flow** 

   These flows aren't typically user facing, but an outage or degradation of system flow components can have an impact on the user experience. For example, an asynchronous activity that picks up orders from a database and generates shipping labels.

> [!NOTE]
> Most applications have multiple flows. Each flow can touch various components of the architecture. Also, a component can appear in more than one flow. It's important to understand which flows are affected when a component fails.

## Define a load test and its threshold values

A load test simulates real-world traffic to test your application's performance. However, the goal isn't to generate a large load to break your system. That goal can be achieved through stress tests.

A load test can help identify the performance, performance limits, resource utilization, and optimal scaling behavior of a user flow's components. Your load tests should reflect every relevant user flow and system flow. A good design requires knowledge of the application. Begin by asking questions, such as:

- *Which API calls need to be made?*
- *What's the sequence of API calls?*
- *What test data should be used with the API calls?*

Based on the answers:

1. Identify key scenarios, dependencies, expected usage, availability, performance, and scalability targets.

1. Define a set of measurable threshold values to quantify the expected performance of the key scenarios. For example, for an application component, you might consider threshold values for the expected number of user logins, requests per second of an API, and operations per second of a background process. 

1. Use the threshold values to define a load test that generates realistic traffic for testing application performance, validating expected scale operations, and related activities. Use those threshold values to develop a health model for the application that covers both testing and production. 

   In the checkout process flow example, you could set threshold of the average page load duration for each step to be less than 500 milliseconds and support up to 100 concurrent users.

With all the threshold values defined, you're now ready to implement load testing. This module uses [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing). 

Although you can configure and deploy Azure Load Testing through the Azure portal, a programmatic approach is highly recommended. Use APIs to deploy, configure, and run the tests in an automated way. That approach is discussed in the next unit.
