Azure Kubernetes Service (AKS) Hybrid is a feature that enables you to extend your AKS cluster to run on-premises or on other clouds. With AKS Hybrid, you can run Windows containers on any Kubernetes cluster. This approach gives you more flexibility and control over where you run your applications. You can use the same tools and commands that you use for AKS to manage and monitor your AKS Hybrid cluster. You can also use the same networking concepts and resources that you learned in this module.

## AKS Hybrid with Azure Arc

It can be easy to manage a few containers manually by using Docker and Windows, but applications often use five, ten, or even hundreds of containers. For larger or more complex configurations, Kubernetes orchestration is very helpful for container management. AKS simplifies on-premises Kubernetes deployment by providing wizards to help you set up Kubernetes and essential Azure add-ons and create Kubernetes clusters to host your workloads.

After you set up on-premises Kubernetes by using AKS Hybrid and create a Kubernetes cluster, you can manage and monitor your Kubernetes infrastructure in the Azure portal by using Azure Arc. Azure Arc is a service that helps you manage and govern your hybrid resources from the same location (or *single pane of glass*). You can manage your applications deployed on Kubernetes clusters across your cloud and on-premises environments. Azure Arc also enables you to manage your Kubernetes clusters with other Azure services including Azure Monitor, Azure Policy, and Role-Based Access Control.

## AKS Hybrid networking model

In AKS Hybrid, you can deploy a cluster by using the Flannel Overlay or Project Calico networking model. Both implementations use an **overlay** network configuration model. The overlay model provides an IP address assignment that's disconnected from the rest of the data center networking.

> [!IMPORTANT]
> Currently, Calico is the default selection in an overlay networking mode. You can configure your cluster to use the Flannel model with the New-AksHciCluster. PowerShell command. After you configure the overlay networking model and the cluster deploys, you can’t change the networking configuration.

In the **Flannel Overlay** model, network resources are usually created and configured when the cluster is deployed. This model is a virtual networking layer that’s designed specifically for containers. Flannel creates a flat network that overlays the host network. All containers and pods are assigned to a single IP address and communicate directly by connecting to each other's IP address.

The **Project Calico** model offers additional networking features, such as network policies and flow control. Calico is an open-source networking and network security solution for containers, virtual machines, and native host-based workloads. This model supports multiple data planes, including a Windows Host Networking Service (HNS) data plane.

## Kubernetes node networking

The primary consideration in the networking configuration for AKS Hybrid is choosing the network model that provides sufficient IP addresses. AKS Hybrid uses virtual networking to allocate IP addresses to the Kubernetes node resources.

There are two IP address assignment models.

- **Static IP networking**: This model is more predictable, but more effort is required for the initial configuration.
- **Dynamic Host Configuration Protocol (DHCP) networking**: This assignment uses dynamic allocation of IP addresses and requires less effort, but you need to be careful not to exhaust the available pool of IPs. You also need to manage reservations and exclusion ranges for virtual IP pools and certain cluster wide resources like the cloud agent service.

Both assignment models must plan IP addresses for the virtual IP pool and the Kubernetes node VM IP pool.

## IP address assignment

To simplify the network configuration for your application workloads, AKS Hybrid assigns IP addresses to certain objects in your deployment.

- **Kubernetes cluster API server**. The front end for the Kubernetes control plane, which exposes the Kubernetes API.
- **Kubernetes nodes** (*worker* **virtual machines**). These virtual machines are created as highly available virtual machines in AKS Hybrid.
- **Kubernetes services**. Services group pod IP addresses to enable direct access via a single IP address and distribute traffic by using a load balancer.
- **HAProxy load balancers**. A TCP/HTTP load balancer and proxy server that distributes incoming requests across multiple endpoints.
- **Microsoft On-premises Cloud Service**. The cloud provider that enables the creation and management of the virtualized environment hosting Kubernetes on an on-premises AKS Hybrid cluster. The networking model implemented in your AKS Hybrid cluster determines the IP address allocation method used by the Microsoft On-premises Cloud Service.

## Load balancing in AKS Hybrid

For a small deployment, you can use the built-in load balancer. This option is deployed as a Linux virtual machine with HAProxy and KeepAlive. It sends traffic to application services deployed as a part of the AKS cluster. You can also use a custom load balancer to manage traffic to your services. This option provides added flexibility to your deployment and ensures that AKS Hybrid works alongside existing deployments, such as Software Defined Network (SDN) deployments that use load balancers.
