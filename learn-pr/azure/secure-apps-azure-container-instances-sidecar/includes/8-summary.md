In this learning module, you evolved the architecture of an application deployed in Azure Container Instances.

1. You created an Azure container instance that's only accessible from within an Azure virtual network. Using an Azure virtual machine as a jump host, you verified the correct operation of the container and the connectivity from the container to an Azure SQL database.

1. You exported the properties of an existing container instance to YAML format. You modified the YAML file to change some of its attributes, and deployed a new container instance with updated properties.

1. You included an NGINX sidecar container next to the application container in the Container Instances group. The sidecar container enhanced the application container with SSL functionality without having to modify the application code.

1. You configured access from the application container to the Azure SQL database by using its private address. You connected Azure SQL Database to the virtual network by using Azure Private Link, and you used a private DNS zone to make sure that the container instance reaches the Azure SQL database over its private endpoint.

1. You used an init container inside of a Container Instances group to update a private DNS zone so other applications can find the application container by using its DNS name instead of its IP address.

## Learn more

- [Terraform azurerm_container_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group)
- [ACI Secure Values](/azure/container-instances/container-instances-environment-variables#secure-values)
- [Understanding Kubernetes Objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/)
- [ACI YAML Reference](/azure/container-instances/container-instances-reference-yaml)
- [Sidecar Pattern](/azure/architecture/patterns/sidecar) 
- [Container groups in Azure Container Instances](/azure/container-instances/container-instances-container-groups)
- [Pods in Kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/)
- [Kubernetes Init Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
