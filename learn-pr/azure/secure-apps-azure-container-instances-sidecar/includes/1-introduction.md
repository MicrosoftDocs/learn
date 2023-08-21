In this module, you use Azure Container Instances to launch APIs in single containers inside of virtual networks for security. You learn to use advanced tools like sidecar containers, initialization containers, and Azure Private Link to address sophisticated networking and security requirements.

Suppose you're a developer at a network provider that creates and deploys Application Programmable Interfaces (APIs) for its customers as a for-charge premium service. These APIs must fulfill the following requirements:

- Once a customer starts an API, they're responsible for its lifecycle.
- Customers can launch and stop their APIs on demand.
- APIs aren't exposed to the public internet.
- A specific customer can access only their own APIs.

The company chose Container Instances as the ideal platform to meet the requirements, because it offers:

- Quick startup times.
- Granular sizing.
- Per-second billing.
- On-demand infrastructure.
- Windows and Linux support.

You need to implement several improvements in a customer API to better meet their advanced security and networking requirements.

## Learning objectives

In this module, you implement the following Container Instances capabilities:

- Deploy Container Instances in Azure Virtual Networks by using Azure CLI.
- Learn to define containers with YAML, for greater flexibility and similarity to Kubernetes YAML manifests.
- Enhance an existing application with a sidecar container, to add functionality without having to modify the original application code.
- Use Azure Private Link to connect to Azure platform-as-a-service (PaaS) resources with private IP addressing.
- Do initialization tasks with initialization containers, such as notifying other systems of a container's IP address by modifying the Domain Name System (DNS).

## Prerequisites

- Access to an Azure subscription with permission to create resources and assign roles. If you use an existing Azure subscription, you might incur charges. If you don't already have an Azure subscription, you can [create a free account](https://azure.microsoft.com/free/).
