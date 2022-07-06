In this learning module, you followed the evolution of the architecture of an application deployed by a telecommunications provider:

- Azure Container Instance was chosen as the platform for the API due to per-second billing and quick startup times
- Azure Container Instances can be deployed inside of Virtual Networks to increase security
- From within a Virtual Network, Azure Private Link technology can be used to connect to Azure PaaS services using private IP addressing
- Provisioning Azure Container Instances with YAML offers great flexibility and is similar to Kubernetes YAML manifests
- Sidecar containers can enhance an existing application by bringing additional functionality in a separate container in the same container group without having to modify the code of the original application
- Init containers can be used to perform initialization tasks, such as notify other systems of the IP address of an Azure Container Instance by modifying the Domain Name System (DNS)


## Learn more

- [Terraform azurerm_container_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group)
- [ACI Secure Values](/azure/container-instances/container-instances-environment-variables#secure-values)
- [Understanding Kubernetes Objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/)
- [ACI YAML Reference](/azure/container-instances/container-instances-reference-yaml)
- [Sidecar Pattern](/azure/architecture/patterns/sidecar) 
- [Container groups in Azure Container Instances](/azure/container-instances/container-instances-container-groups)
- [Pods in Kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/)
- [Kubernetes Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)