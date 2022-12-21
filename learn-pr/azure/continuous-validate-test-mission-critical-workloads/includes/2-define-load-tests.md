In this unit, you'll learn about user and system flows, why they're important, and how to design load tests based on these flows.

## User and system flows

A flow is the sum of activities and decisions a user or system will take in an application to complete a task. A **user flow** lets you determine how users interact with your application when they do things like sign-in or edit a profile. Although most applications have multiple flows, not all flows require the same components, have the same requirements regarding performance, or availability. A component can appear in more than one flow. Therefore, if a component fails, it's important to understand which flows are impacted, and which aren't, so that you can design meaningful load tests.

As an example user flow, we're using the checkout process in Contoso Shoes. This user flow requires the backend inventory management to be available, and doesn't require a search component. In this example, the page needs to load fast due to the expected large number of concurrent users.

A **system flow** is typically not user facing while an outage might still have an impact on the end user experience. An example system flow can be an asynchronous activity that picks up orders from a database and generates shipping labels.

## Define a load test and its threshold values

To design a load test based on a user flow requires knowledge of the application. You should answer the following questions:

- Which API calls need to be made?
- What's the sequence of API calls?
- What test data should be used with the API calls?

Follow these steps to design a load test, based on our checkout example:

1. Starting planning by identifying key scenarios, dependencies, expected usage, availability, performance, and scalability targets.

1. Define a set of measurable threshold values to quantify the expected performance of the key scenarios. The expected number of user logins, requests per second of a given API, operations per second of a background process, are applicable examples for threshold values.

1. Use the threshold values to define a load test that generates realistic traffic for testing application performance, validating expected scale operations, and so on. Use these same threshold values to develop a health model for the application for both testing and production.

It is highly recommended that the load test reflects every relevant user and system flow.

## Implement load test validation

Microsoft Azure provides [Azure Load Testing](/azure/load-testing/overview-what-is-azure-load-testing) as a managed service for you to implement load testing.

Although you can configure and deploy Azure Load Testing through the Azure portal, it's preferable to use APIs to deploy, configure and execute the tests in a programmatic and automated way.
