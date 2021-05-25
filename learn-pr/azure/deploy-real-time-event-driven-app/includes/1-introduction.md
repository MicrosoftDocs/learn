Application stacks, which describe the real-world scenario the best, tend to be the most efficient and reliable. Many workloads are event driven in their nature. In this module, we're going to learn what event driven means and how we can represent a real-world scenario on Azure.

## Learning objectives

By the end of this module, you'll be able to:

- Explain event-driven and real-time workloads by example.
- Create a scenario with simulated telemetric data.
- Send the telemetric data with an Azure function to an event hub.
- Connect another function with this event hub to trigger the storage in Azure Cosmos DB.
- Have a look at the metrics in Application Insights to measure the performance and identify potential bottlenecks.

## Prerequisites

As a Java developer, you're already familiar with NoSQL databases and how to connect them with functions. As you complete the exercises in this module, you'll use a personal Azure account. Make sure that you have the following resources:
  
- An Azure subscription
- Local installations of Java JDK (1.8 or later), Maven (3.0 or later), and the Azure CLI (2.12 or later)
- Azure Functions Core Tools (2.6.66 or later)
