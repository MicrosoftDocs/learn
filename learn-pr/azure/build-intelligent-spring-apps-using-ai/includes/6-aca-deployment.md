In this module, you learn how to deploy our Spring Retrieval Augmented Generation (RAG) application to Azure Container Apps. This module covers the necessary concepts and steps to containerize your application, set up Azure Container Apps, and ensure secure and scalable deployment.

## Azure Container Apps Concepts

Azure Container Apps is a serverless platform that allows you to maintain less infrastructure and save costs while running containerized applications.

### Azure Container Apps environments

A Container Apps environment is a secure boundary around one or more container apps and jobs. The Container Apps runtime manages each environment by handling OS upgrades, scale operations, failover procedures, and resource balancing. Before we can deploy an Azure Container App, we need to create an Azure Container App environment.

There are two types of Container App environments:

1. **Workload profile.** Run serverless apps with support for scale-to-zero and pay only for resources your apps use with the consumption profile. You can also run apps with customized hardware and increased cost predictability using dedicated workload profiles.
1. **Consumption only.** Run serverless apps with support for scale-to-zero and pay only for resources your apps use.

### Deployment Types

There are three primary deployment types for Azure Container Apps:

1. **Deploy from Existing Image.** You can deploy a container app that uses an existing image in a public or private container registry.
1. **Deploy from Source Code.** Deploy your application directly from your local source code repository. The `az container up` command builds the container image, pushes it to a registry, and deploys the container app. It also creates the registry in Azure Container Registry if you don't provide one. This command can build the image with or without a Dockerfile. If building without a Dockerfile, the following languages are supported:

    * .NET
    * Node.js
    * PHP
    * Python

1. **Deploy from a GitHub Repository.** When you use the `az containerapp up` command to deploy from a GitHub repository, it generates a GitHub Actions workflow that builds the container image, pushes it to a registry, and deploys the container app. A Dockerfile is required to build the image.

### Ingress options

Azure Container Apps support multiple ingress options to control how your application is accessed:

1. **External Ingress.** This option exposes your container app to the internet, allowing external clients to access it. You can configure custom domains and SSL certificates for secure access.
2. **Internal Ingress.** This option restricts access to within the virtual network, making your container app accessible only to other resources within the same network. This option is useful for internal services that don't need to be exposed to the internet.
3. **No Ingress.** If you don't need any external or internal access, you can disable ingress. This option is useful for background jobs or services that don't require direct access.

### Scaling

Azure Container Apps provide flexible scaling options to ensure your application can handle varying loads efficiently. Here are the primary scaling options available:

1. **Manual Scaling.** You can manually set the number of replicas for your container app. This option gives you full control over the scaling process, allowing you to adjust the number of instances based on your specific needs.
1. **Automatic Scaling.** Azure Container Apps support automatic scaling based on various metrics. You can configure autoscaling rules to automatically adjust the number of replicas based on CPU usage, memory usage, or custom metrics including [`JVM` (Java Virtual Machine) metrics](/azure/container-apps/java-metrics-scale-with-keda) using KEDA (Kubernetes Event-driven Autoscaling). This capability ensures your application can handle increased traffic without manual intervention.
1. **Scale to Zero.** For serverless applications, you can configure your container app to scale down to zero instances when there's no traffic. This helps save costs by only using resources when needed.

To configure scaling, you can use the Azure CLI, Azure portal, or ARM templates. Here's an example of how to set up autoscaling using the Azure CLI:

```sh
az containerapp update \
  --name spring-ai-app \
  --resource-group spring-ai-demo \
  --min-replicas 1 \
  --max-replicas 10 \
  --scale-rule-name http-rule \
  --scale-rule-type http \
  --scale-rule-http-concurrency 15
```

In this example, the container app is configured to scale between 1 and 10 replicas based on HTTP concurrency. HTTP concurrency is set to 50, which means each replica handles up to 50 concurrent HTTP requests before more instances are created.

## Unit Summary

In this unit, we learned about the key concepts of Azure Container Apps, including environments, deployment types, ingress options, and scaling mechanisms. In the next exercise, we'll put these concepts into practice by deploying our Spring RAG application using Azure Container Apps.
