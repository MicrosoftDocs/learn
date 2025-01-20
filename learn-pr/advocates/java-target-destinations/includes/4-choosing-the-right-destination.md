We discussed the available options for deploying a Java application in the cloud, and more specifically on Azure. But which option best addresses your specific needs? Here's a guide to help you choose.

## Platform as a service or infrastructure control?

The first question to ask is whether you want full control over your application or you want to use a platform as a service (PaaS) solution. Your answer usually depends on the needs of the team with which you're working.

PaaS solutions are easier to use. Many teams prefer them because they offer lower cost, better reliability, and greater security.

Teams choose PaaS solutions for the following reasons:

- They need to go to production quickly, and they have only a limited operations team or no ops team at all.
- They have certain high availability, security, or compliance requirements, and they can meet these needs with out-of-box features that a managed service provides.
- They might not have the resources or the willingness to maintain a production-grade infrastructure.

But some teams prefer to have a full control over their infrastructure, mostly for the following reasons:

- If you're using specific proprietary software or uncommon Java features, a managed service might not be the right fit for you. For example, you might want to use network broadcasting to find your application nodes, and this feature isn't available on a managed service.
- You use a specific native library that doesn't run on a managed service.

## Choose a PaaS solution on Azure

For running Java workloads on a platform as a service solution, Azure provides two possible options:

- **Azure Functions**: Best for simple, event-driven workloads that can scale extremely well.
- **Azure App Service**: Best for rapid prototyping monolithic Java web applications.

## Choose infrastructure control on Azure

For full control over your deployments, Azure provides the following three main options:

- **Azure Container Apps**: Has built-in Java supports for all types of Java on Azure, including monolithic apps and microservices.
- **Azure Kubernetes Service (AKS)**: Best for more complex container-based Java applications. You also benefit from the rich AKS ecosystem.
- **Azure virtual machines**: Best for running any kind of workload, or if you want to "lift and shift" from an existing on-premises infrastructure without rearchitecting your applications.

## Final words to help you decide

Deciding on a destination is only a first step. As you're choosing your service, keep in mind the following points:

- Your maintenance tasks vary greatly, depending on both the type of service you choose and the skill set of your own operations team.
- Your developers use the platform daily, and they can be more productive if the service provides a great developer experience.

For both of these points, your choice depends on the team you have. The best practice is to choose a destination that matches your team's expertise and preferences.
