In this module, you learned about networking concepts and technologies for deploying Windows containers on Azure Kubernetes Service (AKS). In a networking configuration, Windows containers function like virtual machines. Each container has a virtual network adapter that’s connected to a virtual switch. The virtual switch type (NAT, Transparent, Overlay) sets the level of runtime network isolation. Networking for Windows containers on Kubernetes is exposed through container network interface (CNI) plugins such as Flannel and Calico. CNI plugins allocate IP addresses from a virtual network to container nodes and pods and attach them to the network.

When you deploy Kubernetes with Windows containers, networking is accomplished with services, ingress controllers, and network policies. The services group Kubernetes pods together and provides network connectivity. Ingress controllers help you manage HTTP(S) traffic flow for containerized applications. Windows containers with AKS offer management solutions for hosted Kubernetes environments. With AKS Hybrid, you can extend your Kubernetes cluster to run on-premises. These platforms make it simple to deploy and manage containerized applications in Azure with features like automated updates, self-healing, and quick scaling.

Learn more

- [Windows container networking](/virtualization/windowscontainers/container-networking/architecture)
- [Network isolation and security](/virtualization/windowscontainers/container-networking/network-isolation-security)
- [Windows container network drivers](/virtualization/windowscontainers/container-networking/network-drivers-topologies)
- [Network concepts for applications in AKS](/azure/aks/concepts-network)
- [Configure Azure CNI networking in AKS](/azure/aks/configure-azure-cni)
- [Container networking concepts in AKS Hybrid](/azure/aks/hybrid/concepts-container-networking)
- [Deploy an ingress controller in AKS Hybrid](/azure/aks/hybrid/create-ingress-controller)
- [Secure traffic between pods with network policies in AKS Hybrid](/azure/aks/hybrid/calico-networking-policy)
- [Advanced network options in Windows](/virtualization/windowscontainers/container-networking/advanced)
- [Best practices for network connectivity and security in AKS](/azure/aks/operator-best-practices-network)
