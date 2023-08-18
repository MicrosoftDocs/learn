
Azure provides a wide range of services that help you work with containers.

Here are the essential services that are involved:

[Azure Container Instances (ACI)](https://azure.microsoft.com/services/container-instances/)

Running your workloads in Azure Container Instances (ACI) allows you to create your applications rather than provisioning and managing the infrastructure that will run the applications.

ACIs are simple and fast to deploy, and when you're using them, you gain the security of hypervisor isolation for each container group. It ensures that your containers aren't sharing an operating system kernel with other containers.

[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/services/kubernetes-service/)

Kubernetes has quickly become the de-facto standard for container orchestration. This service lets you quickly deploy and manage Kubernetes, to scale and run applications while maintaining overall solid security.

This service started life as Azure Container Services (ACS) and supported Docker Swarm and Mesos/Mesosphere DC/OS at release to manage orchestrations. These original ACS workloads are still supported in Azure, but Kubernetes support was added.

It quickly became so popular that Microsoft changed the acronym for Azure Container Services to AKS and later changed the name of the service to Azure Kubernetes Service (also AKS).

[Azure Container Registry (ACR)](https://azure.microsoft.com/services/container-registry/)

This service lets you store and manage container images in a central registry. It provides you with a Docker private registry as a first-class Azure resource.

All container deployments, including DC/OS, Docker Swarm, and Kubernetes, are supported. The registry is integrated with other Azure services such as the App Service, Batch, Service Fabric, and others.

Importantly, it allows your DevOps team to manage the configuration of apps without being tied to the configuration of the target-hosting environment.

[Azure Container Apps](https://azure.microsoft.com/services/container-apps/)

Azure Container Apps allows you to build and deploy modern apps and microservices using serverless containers. It deploys containerized apps without managing complex infrastructure.

You can write code using your preferred programming language or framework and build microservices with full support for [Distributed Application Runtime (Dapr)](https://dapr.io/). Scale dynamically based on HTTP traffic or events powered by [Kubernetes Event-Driven Autoscaling (KEDA)](https://keda.sh/).

[Azure App Service](https://azure.microsoft.com/services/app-service/)

Azure Web Apps provides a managed service for both Windows and Linux-based web applications and provides the ability to deploy and run containerized applications for both platforms. It provides autoscaling and load balancing options and is easy to integrate with Azure DevOps.
