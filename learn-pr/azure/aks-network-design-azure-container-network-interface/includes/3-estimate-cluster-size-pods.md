We've learned that nodes, pods, and services all need IP addresses. So, how many IP addresses are we going to need? To determine the number of addresses, we have to understand the characteristics of our application. We can start by finding how many pods we need. Then we can look at what size nodes we require and how many nodes we want to run.

## How many pods do you need?

A pod is the place where your application runs. Your application could be simple, running entirely in a single pod. Or, it could be more complex, such as a microservices architecture application that consists of multiple separate services, each running in their own pods, distributed across multiple nodes.

You need to fully understand the architecture of your application. From there, you can work out how many pods the application needs. You can then review how many replicas of each pod you want to run. You might know your application has fairly predictable usage patterns and through testing you've determined it runs best with a fixed number of pods. Or your application may experience periods of higher or lower demand that requires the number of pods to change in response to that. Even in a scenario with unpredictable usage patterns, you should still set limits on the maximum number of pods that your application can scale up to. If you plan to use autoscaling features, your cluster could scale up to a large number of nodes. If left unchecked, it could become expensive to run!

It's often a good idea to set up a load testing environment. You can use a load tester to simulate typical or peak demand scenarios. The data from load tests help you understand how your application works in different situations. This information is useful when determining the number of pods needed to make sure your application remains responsive in all situations.

## How many pods should you run?

Let's review the scenario outlined in the Introduction unit. We're going to deploy a new online web store that's made up of multiple services. You approach the developers working on the new store and ask for information about the services that are being built. The following table shows how many replicas of each service are needed.

Service | Min Replicas | Max Replicas
--- | --- | ---
Website Front End | 3 | 10
Identity API | 3 | 5
Catalog API | 3 | 10
Orders API | 3 | 5
Orders Helper | 3 | 5
Basket API | 3 | 10
Marketing API | 3 | 10
Locations API | 3 | 5
**Total replicas for all services** | **24** | **60**

It's been agreed that all services should deploy a minimum of three replicas. This configuration ensures a baseline level of performance and availability can be provided. Each development team has provided the maximum number of replicas they need to cope with demand, including any seasonal peaks.

Using the numbers in the table we can easily calculate the minimum and maximum number of pod replicas that our cluster should run.

- The minimum number of pods is **24** - there are 8 services, all of which run a minimum of 3 replicas each.
- The maximum number of replicas is **60** pods.

We've made a good start and know the numbers of pods needed. Now we can think about the Azure Virtual Machines where these pods run.
