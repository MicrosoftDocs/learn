We've seen the different options available to deploy a Java application on the cloud, and more specifically on Azure. But which option is the best, depending on your specific needs? Here's a guide to help you choose.

## Platform-as-a-Service vs Infrastructure control

The first question you should have, is whether you want full control of your application, or use a Platform-as-a-Service. It usually depends on your needs, and on the team you're working with.

Platform-as-a-Service offers are easier to use, and are favored as they offer a lower cost, better reliability and security. They'll be used for the following the reasons:

- If you want to go to production as fast as possible, with a limited ops team (maybe even no team at all!).
- If you have high availability, security or compliance requirements, as those features are provided out-of-the-box by a managed service.
- If you don't have the resources, or the will to maintain a production-grade infrastructure.

But some people will prefer to have a full control on their infrastructure, mostly for the two following reasons:

- If you're using some specific proprietary software, or some non-common Java features, a managed service might not be the right fit for you. For example, you might want to use network broadcasting to find your application nodes, and this feature won't be available on a managed service. Or you might want to use some specific native library, which also will not be able to run on a managed service.
- If you need to be multi-cloud, for example because you provide software to many heterogenous customers. Other clouds might not provide a Platform-as-a-Service solution, or will not offer the same level of support, making it challenging to run the same application on all of them.

## Choosing a Platform-as-a-Service solution on Azure

For running Java workloads on a Platform-as-a-Service solution, Azure provides three possible solutions:

- For simple event-driven workloads, that can scale extremely well, choose Azure Functions.
- For normal Web applications, or for running Jakarta EE workloads, Azure App Service will be the best option.
- For running Spring Boot applications, and more specifically Spring Cloud microservices, Azure Spring Cloud is an excellent service.

## Choosing infrastructure control on Azure

For full control on what you are deploying, Azure provides the following two main options:

- If you want to run Docker images, choose Azure Kubernetes Service. You will also benefit from Kubernetes's rich ecosystem.
- If you want to run any kind of workload, or if you want to "lift and shift" from an existing on-premise infrastructure without rearchitecting your applications, choose Azure Virtual Machines.

## Final words to help you decide

Choosing a destination is only a first step, don't forget that once you're using a specific service:

- You will have a maintenance burden that will vastly vary on the type of service you choose, and on the skills of your own ops team.
- Your developers will use that platform daily, and thus will be more productive if that service provides a great developer experience.

For both of these points, it all depends on the team you have, so you also need to choose a destination that matches your team's expertise and preferences.
