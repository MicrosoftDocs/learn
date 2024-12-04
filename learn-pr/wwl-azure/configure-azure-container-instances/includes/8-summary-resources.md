In this module, you learned how to identify when to use Azure Container Instances versus Azure virtual machines. You explored the features and usage cases of Azure Container Instances. You discovered how to implement Azure container groups.

The main takeaways from this module are:

- Containers provide lightweight isolation and use fewer system resources compared to virtual machines.
- Containers can be deployed individually using Docker or with an orchestrator like Azure Container Apps. 
- Containers use Azure Disks or Azure Files for storage.
- A container group is a collection of containers that get scheduled on the same host machine. 
- Containers can be rapidly recreated on another cluster node if a node fails. 
 
## Learn more

- [Containers versus virtual machines](/virtualization/windowscontainers/about/containers-vs-vm). This article reviews the key similarities and differences between containers and virtual machines (VMs), and when you might want to use each. 

- [Quickstart: Deploy a container instance in Azure using the Azure portal](/azure/container-instances/container-instances-quickstart-portal). In this quickstart, you use the Azure portal to deploy an isolated Docker container and make its application available with a fully qualified domain name (FQDN). After configuring a few settings and deploying the container, you can browse to the running application:

- [Container groups in Azure Container Instances](/azure/container-instances/container-instances-container-groups). This article describes what container groups are and the types of scenarios they enable.

## Learn more with self-paced training

- [Run container images in Azure Container Instances](/training/modules/create-run-container-images-azure-container-instances/). Learn how Azure Container Instances can help you quickly deploy containers, how to set environment variables, and specify container restart policies.

- [Implement Azure Container Apps](/training/modules/implement-azure-container-apps/). Learn how Azure Container Apps can help you deploy and manage microservices and containerized apps on a serverless platform that runs on top of Azure Kubernetes Service.

- [Introduction to Docker containers](/training/modules/intro-to-docker-containers/). Learn the benefits of using Docker containers as a containerization platform. Discuss the infrastructure provided by the Docker platform.