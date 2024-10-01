There are many options for teams to build and deploy cloud native and containerized applications on Azure. Let's understand which scenarios and use cases are best suited for Azure Container Apps and how it compares to other container options on Azure.

### Things to know about Azure Container Apps

Azure Container Apps is a serverless platform that allows you to maintain less infrastructure and save costs while running containerized applications. Instead of worrying about server configuration, container orchestration, and deployment details, Container Apps provides all the up-to-date server resources required to keep your applications stable and secure.

Common uses of Azure Container Apps include:

- Deploying API endpoints
- Hosting background processing jobs
- Handling event-driven processing
- Running microservices

Additionally, applications built on Azure Container Apps can dynamically scale based on the following characteristics:

- HTTP traffic
- Event-driven processing
- CPU or memory load
- Any KEDA-supported scaler

### Things to consider when using Azure Container Apps 

Azure Container Apps enables you to build serverless microservices and jobs based on containers. Distinctive features of Container Apps include:

- Optimized for running general purpose containers, especially for applications that span many microservices deployed in containers.
- Powered by Kubernetes and open-source technologies like Dapr, KEDA, and envoy.
- Supports Kubernetes-style apps and microservices with features like service discovery and traffic splitting.
- Enables event-driven application architectures by supporting scale based on traffic and pulling from event sources like queues, including scale to zero.
- Supports running on demand, scheduled, and event-driven jobs.

Azure Container Apps doesn't provide direct access to the underlying Kubernetes APIs. If you would like to build Kubernetes-style applications and don't require direct access to all the native Kubernetes APIs and cluster management, Container Apps provides a fully managed experience based on best-practices. For these reasons, many teams may prefer to start building container microservices with Azure Container Apps.

#### Compare container management solutions

Azure Container Instances (ACI) can be managed in several ways. Azure Container Apps (ACA) is one way, and Azure Kubernetes Service (AKS) is another. Here’s a comparison table for when to use ACA and AKS. 

| Feature | Azure Container Apps (ACA) | Azure Kubernetes Service (AKS) |
| --- | --- | --- |
| Overview | ACA is a serverless container platform that simplifies the deployment and management of microservices-based applications by abstracting away the underlying infrastructure. | AKS simplifies deploying a managed Kubernetes cluster in Azure by offloading the operational overhead to Azure. It’s suitable for complex applications that require orchestration. |
| Deployment | ACA provides a PaaS experience with quick deployment and management capabilities. | AKS offers more control and customization options for Kubernetes environments, making it suitable for complex applications and microservices. |
| Management | ACA builds upon AKS and offers a simplified PaaS experience for running containers, with additional features, like Dapr for microservices. | AKS provides a more granular control over the Kubernetes environment, suitable for teams with Kubernetes expertise. |
| Scalability | ACA supports both HTTP-based autoscaling and event-driven scaling, making it ideal for applications that need to respond quickly to changes in demand. | AKS offers horizontal pod autoscaling and cluster autoscaling, providing robust scalability options for containerized applications. |
| Use Cases | ACA is designed for microservices and serverless applications that benefit from rapid scaling and simplified management. | AKS is best for complex, long-running applications that require full Kubernetes features and tight integration with other Azure services. |
| Integration | ACA integrates with Azure Logic Apps, Functions, and Event Grid for event-driven architectures. | AKS provides features like Azure Policy for Kubernetes, Azure Monitor for containers, and Azure Defender for Kubernetes for comprehensive security and governance. |