Nodes, pods, and services need IP addresses. But, how do you determine how many IP addresses you need? To determine the number of addresses, you must understand the characteristics of the application. First, you determine how many pods you need. Then, you can look at what size nodes are required and how many nodes you need to run.

## How many pods do you need?

Your application runs in a pod. A simple application might run entirely in a single pod. A more complex application, such as a microservices architecture application consisting of multiple separate services, might have each service running in its own pod, with the pods distributed across multiple nodes.

You need to fully understand the architecture of your application. From there, you can work out how many pods the application requires. You can then review how many replicas of each pod you want to run. You might know your application has fairly predictable usage patterns, and through testing, you determine it runs best with a fixed number of pods. Or, your application might experience periods of higher or lower demand that requires the number of pods to change in response to the fluctuating traffic. Even in scenarios with unpredictable usage patterns, you should still set limits on the maximum number of pods that your application can scale up to. This limit ensures that your application doesn't consume all the resources in your cluster.

It's a good idea to set up a load testing environment to gauge your needed resources. You can use a load tester to simulate typical or peak demand scenarios. The data from load tests helps you understand how your application works in different situations. This information is useful when determining the number of pods needed to make sure your application remains responsive in all situations.

## How many pods should you run?

You know your company wants to deploy a new online web store comprised of multiple services. You approach the developers working on the new store and ask for information about the services. The following table shows how many replicas of each service are needed.

Service | Min replicas | Max replicas
--- | --- | ---
Website front end | 3 | 10
Identity API | 3 | 5
Catalog API | 3 | 10
Orders API | 3 | 5
Orders helper | 3 | 5
Basket API | 3 | 10
Marketing API | 3 | 10
Locations API | 3 | 5
**Total replicas for all services** | **24** | **60**

Your team agreed that you should deploy a minimum of three replicas for each service. This configuration ensures that the application can provide a baseline level of performance and availability. Each development team provided the maximum number of replicas they need to cope with demand, including any seasonal peaks.

Using the numbers in the table, we can calculate the minimum and maximum number of pod replicas that the cluster should run:

- The minimum number of pods is **24** (eight services, all of which run a minimum of three replicas each).
- The maximum number of replicas is **60**.

Now that you have a plan for the pods, you need to think about the Azure VMs that are hosting them.
