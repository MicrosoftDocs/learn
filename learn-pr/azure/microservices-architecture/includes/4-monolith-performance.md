There are many reasons that you might choose to change the architecture of a system. Operational agility, cost, scalability, and performance are just some of the factors that play a role in determining the architecture of a system. In our example, we'll take a closer look at how performance becomes a factor for the drone shipping system.

As their drone shipping business grows, system load increases. The current architecture is straining under the load and they would like to be able to provide better flexibility in scaling the application that isn't available in the current monolithic architecture. Improving the application's scalability is one of the drivers for Fabrikam to look at moving their application to a microservices architecture.

## Details on the organizational benefits and challenges of the monolith

- The package service has been identified as a critical part of the business and was originally part of the monolith
- Setting up a "tiger team" that is going to have full control over this piece of the business
- Because it's in the monolith, the team cannot operate autonomously, has to rely on shared data and data structures, and is unable to iterate as quickly as they need
- They want to move fast and break things
- Need independent scalability for their service to meet customer demands

## Scaling monolith vs scaling microservices

One of the primary benefits to a microservices architecture comes in the increased scaling capabilities. Because services are separated out, it's much easier to scale each service individually as load increases across them.

We can see this in the drone delivery system. In the monolithic architecture, all services are contained within a single instance of the application. They expose an API interface to customers to submit and manage delivery requests. As customer requests increase, load on the system increases, requiring more resources to be allocated to the system to avoid negatively impacting end user experience.

On a monolithic architecture, scaling this service individually would also require the resources for the other services, since they are contained within each application instance. This is inefficient, as load for the other services may be minimal, not requiring the additional resource utilization.

On a microservices architecture, since each service is separate, we could scale the API independently of the other services. This increases our efficiency, as we don't need to consume the resources of unnecessary services.

Let's take a look at the performance of the application in its current, monolithic state.
