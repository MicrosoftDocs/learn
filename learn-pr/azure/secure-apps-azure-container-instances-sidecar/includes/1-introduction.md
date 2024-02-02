In this module, you use Azure Container Instances to launch APIs in single containers inside of virtual networks for flexibility and security. You learn to use advanced tools like sidecar containers, initialization containers, and Azure Private Link to address more sophisticated networking and security requirements.

Suppose you're a developer at a network provider that creates and deploys Application Programmable Interfaces (APIs) for its customers as a for-charge premium service. These APIs must fulfill the following requirements:

- Once a customer starts an API, they're responsible for its lifecycle.
- Customers can launch and stop their APIs on demand.
- APIs aren't exposed to the public internet.
- A specific customer can access only their own APIs.

Your company chose Container Instances as the ideal platform to meet the requirements, because it offers the following benefits:

- Quick startup times.
- Granular sizing.
- Per-second billing.
- On-demand infrastructure.
- Windows and Linux support.

You now need to make several improvements in a customer's containerized API to better meet the customer's advanced security and networking needs.

## Learning objectives

In this module, you implement the following Container Instances capabilities:

- Deploy Container Instances in Azure Virtual Networks by using Azure CLI.
- Learn to define containers with YAML, for greater flexibility and similarity to Kubernetes YAML manifests.
- Enhance an existing application with a sidecar container, to add functionality without having to modify the original application code.
- Use Azure Private Link to connect to Azure platform-as-a-service (PaaS) resources with private IP addressing.
- Use an initialization container to do the initialization task of updating the Domain Name System (DNS) entry for the container group.

## Prerequisite

Access to an Azure subscription with permission to create resources and assign roles. If you don't already have an Azure subscription, you can [create a free account](https://azure.microsoft.com/free/).

- If you use an existing Azure subscription, you might incur charges.
- To create the service principal in Unit 6, you must have at least **User Access Administrator** role in the Azure subscription. Subscription ownership includes this role.
