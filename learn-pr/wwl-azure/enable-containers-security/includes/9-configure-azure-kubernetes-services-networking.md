To allow access to your applications, or for application components to communicate with each other, Kubernetes provides an abstraction layer to virtual networking. Kubernetes nodes are connected to a virtual network, and can provide inbound and outbound connectivity for pods. The kube-proxy component runs on each node to provide these network features.

In Kubernetes, Services logically group pods to allow for direct access via an IP address or DNS name and on a specific port. You can also distribute traffic using a load balancer. More complex routing of application traffic can also be achieved with Ingress Controllers. Security and filtering of the network traffic for pods is possible with Kubernetes network policies.

The Azure platform also helps to simplify virtual networking for AKS clusters. When you create a Kubernetes load balancer, the underlying Azure load balancer resource is created and configured. As you open network ports to pods, the corresponding Azure network security group rules are configured. For HTTP application routing, Azure can also configure external DNS as new ingress routes are configured.

### Services

To simplify the network configuration for application workloads, Kubernetes uses Services to logically group a set of pods together and provide network connectivity. The following Service types are available:

 -  **Cluster IP** \- Creates an internal IP address for use within the AKS cluster. Good for internal-only applications that support other workloads within the cluster.
 -  **NodePort** \- Creates a port mapping on the underlying node that allows the application to be accessed directly with the node IP address and port.
 -  **LoadBalancer** \- Creates an Azure load balancer resource, configures an external IP address, and connects the requested pods to the load balancer backend pool. To allow customers' traffic to reach the application, load balancing rules are created on the desired ports.
 -  **ExternalName** \- Creates a specific DNS entry for easier application access.

:::image type="content" source="../media/az500-kubernetes-networking-a5178462.png" alt-text="Internal traffic uses Cluster IP to access the pod. Incoming direct traffic uses NodePort. Incoming non-direct traffic uses the load balancer.":::


When you run modern, microservices-based applications in Kubernetes, you often want to control which components can communicate with each other. The **principle of least privilege** should be applied to how traffic can flow between pods in an Azure Kubernetes Service (AKS) cluster. Let's say you likely want to block traffic directly to back-end applications. The *Network Policy* feature in Kubernetes lets you define rules for ingress and egress traffic between pods in a cluster.
