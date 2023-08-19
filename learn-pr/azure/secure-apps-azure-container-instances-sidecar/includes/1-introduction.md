In this module, you learn to use Azure Container Instances to launch APIs in single containers. You deploy inside of virtual networks to increase security, and use advanced tools to address sophisticated networking and security requirements.

You manage Application Programmable Interface (API) development at a network provider that creates and deploys APIs for its customers as a for-charge premium service. These APIs must fulfill the following requirements:

- Once a customer starts an API, they're responsible for its lifecycle.
- Customers can launch and stop their APIs on demand.
- APIs aren't exposed to the public internet.
- A specific customer can access only their own APIs.

You choose Container Instances as the ideal platform to meet these requirements, because it offers:

- Quick startup times.
- Granular sizing.
- Per-second billing.
- On-demand infrastructure.
- Windows and Linux support.

## Learning objectives

In this module, you implement the following advanced Container Instances capabilities:

- Deploy Container Instances in Azure Virtual Networks.
- Provision Container Instances by using Azure CLI, or use YAML for greater flexibility and similarity to Kubernetes YAML manifests.
- Enhance existing applications with sidecar containers, to add functionality in a separate container without having to modify the original application code.
- Use Azure Private Link to connect to Azure platform-as-a-service (PaaS) resources by using private IP addressing.
- Do initialization tasks with initialization containers, such as notifying other systems of a container instance's IP address by modifying the Domain Name System (DNS).
