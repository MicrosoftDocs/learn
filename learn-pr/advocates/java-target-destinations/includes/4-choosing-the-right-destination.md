We discussed the available options for deploying a Java application in the cloud, and more specifically on Azure. But which option best addresses your specific needs? Here's a guide to help you choose.

## Platform as a service or infrastructure control?

The first question to ask is whether you want a managed platform service or you need more control over the infrastructure. Your answer usually depends on the needs of the team with which you're working.

Managed platform services, including PaaS and serverless options, are easier to use. Many teams prefer them because they can offer lower cost, better reliability, and greater security.

Teams choose managed platform services for the following reasons:

- They need to go to production quickly, and they have only a limited operations team or no ops team at all.
- They have certain high availability, security, or compliance requirements, and they can meet these needs with out-of-box features that a managed service provides.
- They might not have the resources or the willingness to maintain a production-grade infrastructure.

But some teams prefer to have more control over their infrastructure, mostly for the following reasons:

- If you're using specific proprietary software or uncommon Java features, a managed service might not be the right fit for you. For example, you might want to use network broadcasting to find your application nodes, and this feature isn't available on a managed service.
- You use a specific native library that doesn't run on a managed service.

## Choose a managed platform service on Azure

For running Java workloads on managed platform services, Azure provides these common options:

- **Azure Container Apps**: Best for containerized Java applications and microservices when you want serverless container hosting without managing Kubernetes.
- **Azure Functions**: Best for simple, event-driven workloads that can scale extremely well.
- **Azure App Service**: Best for rapid prototyping and hosting Java web applications on supported built-in runtime stacks or custom containers.

## Choose infrastructure control on Azure

If you need more control over the infrastructure or orchestration layer, Azure provides these main options:

- **Azure Kubernetes Service (AKS)**: Best for more complex container-based Java applications when you want managed Kubernetes and access to the rich Kubernetes ecosystem.
- **Azure virtual machines**: Best for running workloads that need OS-level control, custom middleware, or a "lift and shift" move from an existing on-premises infrastructure without rearchitecting your applications.

## Final words to help you decide

Deciding on a destination is only a first step. As you're choosing your service, keep in mind the following points:

- Your maintenance tasks vary greatly, depending on both the type of service you choose and the skill set of your own operations team.
- Your developers use the platform daily, and they can be more productive if the service provides a great developer experience.

For both of these points, your choice depends on the team you have. The best practice is to choose a destination that matches your team's expertise and preferences.
