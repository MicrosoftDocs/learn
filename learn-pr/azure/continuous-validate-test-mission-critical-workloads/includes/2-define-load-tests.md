In this unit, you'll learn about user and system flows, why they're important, and how to design load tests based on these flows.

## User and system flows

A flow is the sum of activities and decisions that a user or system takes in an application to complete a task. 

A *user flow* lets you determine how users interact with your application when they do things like sign in or edit a profile. This module uses the checkout process for Contoso Shoes as an example of a user flow. This user flow requires the back-end inventory management to be available, and it doesn't require a search component. In this example, the page needs to load quickly because the company expects a large number of concurrent users.

A *system flow* is typically not user facing, but an outage or degradation of system flow components could have an impact on the user experience. For an example of system flow, consider an asynchronous activity that picks up orders from a database and generates shipping labels.

Most applications have multiple flows. Each flow consists of various components. Because a component can appear in more than one flow, it's important to understand which flows are affected when component failures happen so that you can design meaningful load tests.

## Define a load test and its threshold values

A load test simulates real-world traffic to test your application's performance. Its purpose, though, isn't to generate a large load or to break your system. A load test is not a stress test.

A load test can help identify the performance, performance limits, resource utilization, and optimal scaling behavior of a user flow's components. Designing a load test based on a user flow requires knowledge of the application. Answer the following questions:

- Which API calls need to be made?
- What's the sequence of API calls?
- What test data should be used with the API calls?

Follow these steps to design a load test, based on the checkout example:

1. Start planning by identifying key scenarios, dependencies, expected usage, availability, performance, and scalability targets.

1. Define a set of measurable threshold values to quantify the expected performance of the key scenarios. Applicable examples for threshold values include the expected number of user logins, requests per second of an API, and operations per second of a background process. 

   For example, in the checkout user flow, you could define that the average page load duration of each checkout step should be less than 500 milliseconds when up to 100 concurrent users are using the checkout at the same time.

1. Use the threshold values to define a load test that generates realistic traffic for testing application performance, validating expected scale operations, and related activities. Use these same threshold values to develop a health model for the application that covers both testing and production.

Ensure that your load tests reflect every relevant user flow and system flow.

## Implement load testing

Microsoft Azure provides [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) as a managed service for you to implement load testing.

Although you can configure and deploy Azure Load Testing through the Azure portal, it's preferable to use APIs to deploy, configure, and run the tests in a programmatic and automated way.
