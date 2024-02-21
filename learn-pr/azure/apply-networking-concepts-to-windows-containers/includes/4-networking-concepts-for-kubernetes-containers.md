Kubernetes is a portable, extensible open-source platform for automating the deployment, scaling, and management of your containerized workloads. As an orchestration platform, Kubernetes provides ease of use and flexibility like Platform as a Service (PaaS) and Infrastructure as a Service (IaaS) offerings.

> [!IMPORTANT]
> You need to understand concepts such as virtual networks, load balancers, and reverse proxies to configure Kubernetes networking.

## Clusters and nodes

Kubernetes is based on clusters. Instead of having a single virtual machine, it uses several virtual machines called nodes that work together as one. Kubernetes uses a cluster architecture that consists of a primary node and one or more worker nodes. The primary node runs the control plane components, such as the API server, the scheduler, and the controller manager. The worker nodes run the data plane components, such as the **kubelet**, the **kube-proxy**, and the container runtime.

:::image type="content" source="../media/kubernetes-cluster.jpg" alt-text="Diagram showing how Kubernetes uses a cluster architecture that consists of a primary node and one or more worker nodes." border="false":::

The kube-proxy component is responsible for local cluster networking and runs on each node. It ensures that each node has a unique IP address. It also implements rules to handle routing and load balancing of traffic by using IP tables and an IP virtual server. This proxy doesn't provide DNS services by itself. A DNS cluster add-on based on CoreDNS is recommended and installed by default.

## Pods

A Kubernetes pod groups containers and applications into a logical structure. These pods have no intelligence and are composed of one or more application containers. Each one has an IP address, network rules, and exposed ports.

:::image type="content" source="../media/kubernetes-pod.jpg" alt-text="Diagram showing how a Kubernetes pod groups containers and applications into a logical structure." border="false":::

A Kubernetes deployment is an evolution of pods. A deployment wraps the pods into an intelligent object that allows them to scale out. You can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

## Abstraction layer resources

To allow access to your applications or between application components, Kubernetes provides an abstraction layer to virtual networking. Kubernetes nodes connect to a virtual network, which provides inbound and outbound connectivity for pods. The kube-proxy component runs on each node to provide these network features.

In Kubernetes:

- *Services* logically group pods to allow for direct access to a specific port via an IP address or DNS name.
- *ServiceTypes* allow you to specify what kind of Service you want.
- You can distribute traffic by using a load balancer.
- Layer 7 routing of application traffic can also be achieved with ingress controllers.
- You can control outbound (egress) traffic for cluster nodes.
- Security and filtering of the network traffic for pods is possible with network policies.

## Networks in Kubernetes

Kubernetes has specific requirements for how you implement networking for a cluster. Your configuration choices affect your options for how to expose your apps on the cluster network and how to store data. To simplify communication, Kubernetes expects you to configure networking in such a way that:

- Pods can communicate with one another across nodes without Network Address Translation (NAT).
- Nodes and pods can communicate with each other without NAT.
- Agents on a node can communicate with all nodes and pods.

A container's configuration and the data in it isn't persistent between executions. After you delete a container, all information is gone unless it's configured to use a volume. The same applies to the container's network configuration and any IP addresses assigned to it.

A deployment is a logical grouping of pods. It isn't considered a physical workload and isn't assigned an IP address. Each pod is automatically assigned an IP address, which is lost when the pod is destroyed. This behavior makes a manual network configuration strategy complex.

## Kubernetes networking options for Windows containers

When you deploy Kubernetes with Windows containers, you have two networking options: **Services** and **Ingress controllers**. To use these options, Windows depends on Container Network Interface (CNI) plugins.

To simplify the network configuration for application workloads, Kubernetes uses services to logically group a set of pods together and provide network connectivity. The service functions as an entry point for the group of pods and provides a static IP address. Traffic arrives at the service for the group and is distributed in a round-robin pattern to the pods. As the IP addresses for the pods change over time, the service tracks the changes to ensure correct flow of network traffic to the pods.

Containerized applications that run on Kubernetes need to send and receive data over the internet. Kubernetes supports this communication through ingress and egress components. The ingress controller specifies which traffic and sources can connect to your services. The egress controller lets you connect your apps to outside entities through an internet gateway.

CNI plugins enable Kubernetes to use different network interfaces for container networking. The plugins connect your pods to the network and allocate the pod IP addresses. They interact with the Windows Host Networking Service (HNS) and the Host Compute Service (HCS) to create and manage network resources for Windows containers. Some examples of plugins include Calico, Flannel, and Azure CNI.

## Kubernetes ServiceTypes

To configure your desired service, you can specify one of the following Kubernetes **ServiceTypes**:

- **ClusterIP** creates an internal IP address for use within the cluster. This service is good for internal-only applications that support other workloads within the cluster. This is the default that's used if you don't explicitly specify a type for a service.

:::image type="content" source="../media/cluster-ip.jpg" alt-text="Diagram showing how ClusterIP creates an internal IP address for use within the cluster." border="false":::

- **NodePort** creates a port mapping on the underlying node that allows the application to be accessed directly with the node IP address and port.

:::image type="content" source="../media/node-port.jpg" alt-text="Diagram showing how NodePort creates a port mapping on the underlying node that allows the application to be accessed directly with the node IP address and port." border="false":::

- **LoadBalancer** creates a load balancer resource, configures an external IP address, and connects the requested pods to the load balancer backend pool. To allow customers' traffic to reach the application, load balancing rules are created on the desired ports.

:::image type="content" source="../media/load-balancer.jpg" alt-text="Diagram showing how LoadBalancer creates a load balancer resource, configures an external IP address, and connects the requested pods to the load balancer backend pool." border="false":::

For HTTP/S load balancing of inbound traffic, another option is to use an ingress controller.

- ExternalName creates a specific DNS entry for easier application access.

## Kubernetes ingress

The Kubernetes ingress component exposes routes for HTTP and HTTPS traffic from outside a cluster to services inside the cluster. You define ingress routes by using ingress rules. A Kubernetes cluster rejects all incoming traffic without these routes defined.

:::image type="content" source="../media/kubernetes-ingress.jpg" alt-text="Diagram showing how the Kubernetes ingress component exposes routes for HTTP and HTTPS traffic from outside a cluster to services inside the cluster." border="false":::

## Ingress controller

An ingress controller is a piece of software that provides configurable traffic routing for Kubernetes services. Kubernetes ingress resources are used to configure the ingress rules and routes for individual Kubernetes services. By using an ingress controller and ingress rules, you can use a single IP address to route traffic to multiple services in a Kubernetes cluster. After deploying the controller in your environment, you can then create and deploy the ingress manifest. Kubernetes uses ingress controllers to manage ingress configuration in a cluster and provides several features.

## Ingress rules

Ingress rules define where traffic is coming from and where to direct it within a cluster. You define ingress rules in an ingress deployment manifest file. These rules are defined in the rules key of the manifest file. Each rule is a set of values that describes the rule.

## Ingress annotations

An annotation allows you to attach nonidentifying metadata, such as ingress configurations, for workloads. You can think of the annotation as an internal label that defines specific configurations for resources. For example, you might want to use a specific ingress controller that supports name rewriting or payload limiting.

## Network policies

Kubernetes provides the **Network policy** feature to control traffic flow between pods. You can allow or deny traffic based on your settings for assigned labels, the namespace, and the traffic port. Network policies offer a cloud-native approach that’s ideal for controlling traffic across Kubernetes pods. 
