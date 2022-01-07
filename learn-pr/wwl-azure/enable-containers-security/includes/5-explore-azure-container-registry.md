A container registry is a service that stores and distributes container images. Docker Hub is a public container registry that supports the open source community and serves as a general catalog of images. Azure Container Registry provides users with direct control of their images, with integrated authentication, geo-replication supporting global distribution and reliability for network-close deployments, virtual network and firewall configuration, tag locking, and many other enhanced features.

In addition to Docker container images, Azure Container Registry supports related content artifacts including Open Container Initiative (OCI) image formats.

:::image type="content" source="../media/az500-azure-container-registry-8d915f7b.png" alt-text="Different registries including ACR are providing images to containers.":::


### Security and access

You log in to a registry using the Azure CLI or the standard docker login command. Azure Container Registry transfers container images over HTTPS, and supports TLS to secure client connections. Azure Container Registry requires all secure connections from servers and applications to use TLS 1.2. Enable TLS 1.2 by using any recent docker client (version 18.03.0 or later). You control access to a container registry using an Azure identity, an Azure Active Directory-backed service principal, or a provided admin account. Use role-based access control (RBAC) to assign users or systems fine-grained permissions to a registry.

Security features of the Premium SKU include content trust for image tag signing, and firewalls and virtual networks to restrict access to the registry. Microsoft Defender for Cloud optionally integrates with Azure Container Registry to scan images whenever an image is pushed to a registry.

## Repository

Container registries manage repositories, collections of container images or other artifacts with the same name, but different tags. For example, the following three images are in the "acr-helloworld" repository:

 -  acr-helloworld:latest
 -  acr-helloworld:v1
 -  acr-helloworld:v2

## Image

A container image or other artifact within a registry is associated with one or more tags, has one or more layers, and is identified by a manifest. Understanding how these components relate to each other can help you manage your registry effectively.

### Monitor container activity and user access

As with any IT environment, you should consistently monitor activity and user access to your container ecosystem to quickly identify any suspicious or malicious activity. The container monitoring solution in Log Analytics can help you view and manage your Docker and Windows container hosts in a single location.

By using Log Analytics, you can:

 -  View detailed audit information that shows commands used with containers.
 -  Troubleshoot containers by viewing and searching centralized logs without having to remotely view Docker or Windows hosts.
 -  Find containers that may be noisy and consuming excess resources on a host.
 -  View centralized CPU, memory, storage, and network usage and performance information for containers.

On computers running Windows, you can centralize and compare logs from Windows Server, Hyper-V, and Docker containers. The solution supports container orchestrators such as Docker Swarm, DC/OS, Kubernetes, Service Fabric, and Red Hat OpenShift.

Container technology is causing a structural change in the cloud-computing world. Containers make it possible to run multiple instances of an application on a single instance of an operating system, thereby using resources more efficiently. Containers give organizations consistency and flexibility. They enable continuous deployment because the application can be developed on a desktop, tested in a virtual machine, and then deployed for production in the cloud. Containers provide agility, streamlined operations, scalability, and reduced costs due to resource optimization.
