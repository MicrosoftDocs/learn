Businesses that want to build and deploy cloud-native apps on Azure have several options for hosting their apps.

The following sections examine the host platforms for cloud-native apps on Azure. The service descriptions enable you to compare Azure Container Apps with the other container options on Azure.

## Azure Container Apps

Azure Container Apps enables you to build serverless microservices and jobs based on containers. Distinctive features of Container Apps include:

- Container Apps is optimized for running general purpose containers, especially for applications that span many microservices deployed in containers.
- Container Apps is powered by Kubernetes and open-source technologies like Dapr, KEDA, and envoy.
- Container Apps supports Kubernetes-style apps and microservices with features like service discovery and traffic splitting.
- Container Apps enables event-driven application architectures by supporting scale based on traffic and pulling from event sources like queues, including scale to zero.
- Container Apps supports running on demand, scheduled, and event-driven jobs.

Azure Container Apps doesn't provide direct access to the underlying Kubernetes APIs. If you require access to the Kubernetes APIs and control plane, you should use Azure Kubernetes Service. However, if you would like to build Kubernetes-style applications and don't require direct access to all the native Kubernetes APIs and cluster management, Container Apps provides a fully managed experience based on best-practices. For these reasons, many teams prefer to start building container microservices with Azure Container Apps.

## Azure App Service

Azure App Service provides fully managed hosting for web applications including websites and web APIs. You can deploy these web applications using code or containers. Azure App Service is optimized for web applications. Azure App Service is integrated with other Azure services including Azure Container Apps or Azure Functions. When you're building web apps, Azure App Service is an ideal option.

## Azure Container Instances

Azure Container Instances (ACI) provides a single pod of Hyper-V isolated containers on demand. It's a simpler and more flexible option than Container Apps. Concepts like scale, load balancing, and certificates aren't provided with ACI containers. For example, to scale to five container instances, you create five distinct container instances. Azure Container Apps provides many application-specific concepts on top of containers, including certificates, revisions, scale, and environments. Users often interact with Azure Container Instances through other services. For example, Azure Kubernetes Service can layer orchestration and scale on top of ACI through virtual nodes. If you need a less "opinionated" building block that doesn't align with the scenarios Azure Container Apps is optimizing for, Azure Container Instances is an ideal option.

## Azure Kubernetes Service

Azure Kubernetes Service (AKS) provides a fully managed Kubernetes option in Azure. It supports direct access to the Kubernetes API and runs any Kubernetes workload. The full cluster resides in your subscription, with the cluster configurations and operations within your control and responsibility. Teams looking for a fully managed version of Kubernetes in Azure, Azure Kubernetes Service is an ideal option.

## Azure Functions

Azure Functions is a serverless Functions-as-a-Service (FaaS) solution. It's optimized for running event-driven applications using the functions programming model. It shares many characteristics with Azure Container Apps around scale and integration with events, but optimized for ephemeral functions deployed as either code or containers. The Azure Functions programming model enhances team productivity by enabling the triggering of functions based on events and establishing bindings to different data sources. When you're building FaaS-style functions, Azure Functions is the ideal option. The Azure Functions programming model is available as a base container image, making it portable to other container based compute platforms allowing teams to reuse code as environment requirements change.

## Azure Spring Apps

Azure Spring Apps is a fully managed service for Java developers using the Spring Framework. If you want to run Spring Boot, Spring Cloud or any other Spring applications on Azure, Azure Spring Apps is an ideal option. The service manages the infrastructure of Spring applications so developers can focus on their code. Azure Spring Apps provides lifecycle management using comprehensive monitoring and diagnostics, configuration management, service discovery, CI/CD integration, blue-green deployments, and more.

## Azure Red Hat OpenShift

Azure Red Hat OpenShift is a joint project between Red Hat and Microsoft. The goal is to provide an integrated product and support experience for running Kubernetes-powered OpenShift. With Azure Red Hat OpenShift, teams can choose their own registry, networking, storage, and CI/CD solutions. Teams can also use the built-in solutions for automated source code management, container and application builds, deployments, scaling, health management, and more from OpenShift. If your team or organization is using OpenShift, Azure Red Hat OpenShift is an ideal option.
