
In this learning module you followed the evolution of the architecture of an application deployed by a telecommunications provider:

- Azure Container Instance were chosen as the platform for the API due to per-second billing and quick startup times
- Azure Container Instances can be deployed inside of Virtual Networks to increase security
- From within a Virtual Network, Azure Private Link technology can be used to connect to Azure PaaS services using private IP addressing
- Provisioning Azure Container Instances with YAML brings a great flexibility, and is very similar to Kubernetes YAML manifests
- Sidecar containers can enhance an existing application by bringing additional functionality in a separate container in the same container group, without having to modify the code of the original application
- Init containers can be used to perform initialization tasks, such as notify other systems of the IP address of an Azure Container Instance by modifying the Domain Name System (DNS)