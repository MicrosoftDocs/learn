As part of continuous validation, you need to design based on the application flows.

## What are application flows?

A flow is composed of interactions of a user or a component with an application to complete a task. 

- **User flow** 

   Lets you determine how users interact with your application when they do functional tasks. In the Contoso Shoes scenario, the checkout process for purchasing items is an example of a user flow. It includes interaction with backend components responsible for inventory management:
   
   - Front-end web application
   - Checkout logic in Azure Functions
   - Azure Cosmos DB
   
   From a mission-critical perspective, those components need to be highly available and resilient to failures. The front-end web page needs to load quickly because the organization expects a large number of concurrent users.

- **System flow** 

   These flows aren't typically user facing, but an outage or degradation of system flow components could have an impact on the user experience. For example, an asynchronous activity that picks up orders from a database and generates shipping labels.

Most applications have multiple flows. Each flow can touch various components of the architecture. Also a component can appear in more than one flow. It's important to understand which flows are affected when a component fails so that you can design meaningful load tests.

## Define a load test and its threshold values

A load test simulates real-world traffic to test your application's performance. However, the goal isn't to generate a large load  to break your system. That goal can be achieved through stress tests.

A load test can help identify the performance, performance limits, resource utilization, and optimal scaling behavior of a user flow's components. Your load tests reflect every relevant user flow and system flow. 

Designing a load test based on a user flow requires knowledge of the application. Begin by asking questions, such as:

- *Which API calls need to be made?*
- *What's the sequence of API calls?*
- *What test data should be used with the API calls?*

Let's design a load test on the checkout process flow:

1. Identify key scenarios, dependencies, expected usage, availability, performance, and scalability targets.

1. Define a set of measurable threshold values to quantify the expected performance of the key scenarios. For example, for an application component, you might consider threshold values for the expected number of user logins, requests per second of an API, and operations per second of a background process. 

   In the checkout process flow example, you could set threshold of the average page load duration of each checkout step to be less than 500 milliseconds with up to 100 concurrent users.

1. Use the threshold values to define a load test that generates realistic traffic for testing application performance, validating expected scale operations, and related activities. Use those threshold values to develop a health model for the application that covers both testing and production. 


## Implement load testing

Microsoft Azure provides [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) as a managed service for you to implement load testing.

Although you can configure and deploy Azure Load Testing through the Azure portal, a programmatic approach is highly recommended. Use APIs to deploy, configure, and run the tests in an automated way.
