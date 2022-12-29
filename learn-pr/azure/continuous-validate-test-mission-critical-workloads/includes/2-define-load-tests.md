In this unit, you'll learn about user and system flows, why they're important, and how to design load tests based on these flows.

## User and system flows

A flow is the sum of activities and decisions a user or system will take in an application to complete a task. A *user flow* lets you determine how users interact with your application when they do things like sign-in or edit a profile.

For an example user flow, we're using the checkout process in Contoso Shoes. This user flow requires the backend inventory management to be available, and doesn't require a search component. In this example, the page needs to load quickly due to the expected large number of concurrent users.

A *system flow* is typically not user-facing, but an outage or degradation of system flow components could have an impact on the end-user experience. For an example system flow, consider an asynchronous activity that picks up orders from a database and generates shipping labels.

Most applications have multiple flows, each composed of various components. Because a component can appear in more than one flow, it's important to understand which flows are impacted when component failures occur so that you can design meaningful load tests.

## Define a load test and its threshold values

A *load test* simulates real-world traffic to test your application's performance. Its purpose, though, isn't to generate a large load or to break your system. A load test is not a stress test.

A load test can help to identity the performance, performance limits, resource utilization, and the optimal scaling behavior of components that comprise a user flow. To design a load test based on a user flow requires knowledge of the application. Answer the following questions:

- Which API calls need to be made?
- What's the sequence of API calls?
- What test data should be used with the API calls?

Follow these steps to design a load test, based on our checkout example:

1. Starting planning by identifying key scenarios, dependencies, expected usage, availability, performance, and scalability targets.

1. Define a set of measurable threshold values to quantify the expected performance of the key scenarios. The expected number of user logins, requests per second of a given API, operations per second of a background process, are applicable examples for threshold values. For example, in the checkout user flow, you could define that the average page load duration of each checkout step should be less than 500 milliseconds when up to 100 concurrent users are using the checkout at the same time.

1. Use the threshold values to define a load test that generates realistic traffic for testing application performance, validating expected scale operations, and so on. Use these same threshold values to develop a health model for the application for both testing and production.

Ensure the load test reflects every relevant user and system flow.

## Implement load test validation

Microsoft Azure provides [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) as a managed service for you to implement load testing.

Although you can configure and deploy Azure Load Testing through the Azure portal, it's preferable to use APIs to deploy, configure and execute the tests in a programmatic and automated way.
