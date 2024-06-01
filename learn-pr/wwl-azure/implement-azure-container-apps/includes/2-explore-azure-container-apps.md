


Azure Container Apps enables you to run microservices and containerized applications on a serverless platform that runs on top of Azure Kubernetes Service. Common uses of Azure Container Apps include:

* Deploying API endpoints
* Hosting background processing applications
* Handling event-driven processing
* Running microservices

Applications built on Azure Container Apps can dynamically scale based on: HTTP traffic, event-driven processing, CPU or memory load, and any [KEDA-supported scaler](https://keda.sh/docs/scalers/).

With Azure Container Apps, you can:

* Run multiple container revisions and manage the container app's application lifecycle.
* Autoscale your apps based on any KEDA-supported scale trigger. Most applications can scale to zero. (Applications that scale on CPU or memory load can't scale to zero.)
* Enable HTTPS ingress without having to manage other Azure infrastructure.
* Split traffic across multiple versions of an application for Blue/Green deployments and A/B testing scenarios.
* Use internal ingress and service discovery for secure internal-only endpoints with built-in DNS-based service discovery.
* Build microservices with [Dapr](https://docs.dapr.io/concepts/overview/) and access its rich set of APIs.
* Run containers from any registry, public or private, including Docker Hub and Azure Container Registry (ACR).
* Use the Azure CLI extension, Azure portal or ARM templates to manage your applications.
* Provide an existing virtual network when creating an environment for your container apps.
* Securely manage secrets directly in your application.
* Monitor logs using Azure Log Analytics.

## Azure Container Apps environments

Individual container apps are deployed to a single Container Apps environment, which acts as a secure boundary around groups of container apps. Container Apps in the same environment are deployed in the same virtual network and write logs to the same Log Analytics workspace. You may provide an existing virtual network when you create an environment.

Reasons to deploy container apps to the same environment include situations when you need to:

* Manage related services
* Deploy different applications to the same virtual network
* Instrument [Dapr](https://docs.dapr.io/concepts/overview/) applications that communicate via the Dapr service invocation API
* Have applications to share the same Dapr configuration
* Have applications share the same log analytics workspace

Reasons to deploy container apps to different environments include situations when you want to ensure:

* Two applications never share the same compute resources
* Two Dapr applications can't communicate via the Dapr service invocation API

## Microservices with Azure Container Apps

Microservice architectures allow you to independently develop, upgrade, version, and scale core areas of functionality in an overall system. Azure Container Apps provides the foundation for deploying microservices featuring:

* Independent scaling, versioning, and upgrades
* Service discovery
* Native [Dapr](https://docs.dapr.io/concepts/overview/) integration

## Dapr integration

When you implement a system composed of microservices, function calls are spread across the network. To support the distributed nature of microservices, you need to account for failures, retries, and timeouts. While Container Apps features the building blocks for running microservices, use of Dapr provides an even richer microservices programming model. Dapr includes features like observability, pub/sub, and service-to-service invocation with mutual TLS, retries, and more.
