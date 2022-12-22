Kubernetes provides an abstraction layer for virtual networking to allow access to your applications, or for application components to communicate with each other. Kubernetes uses pods to run an instance of your application, and provides different services to logically group pods. This arrangement allows for direct access via an IP address or domain name system (DNS) name and on a specific port. Azure Kubernetes Service expands on the Kubernetes features to simplify the process to support networking.

### Things to know about Kubernetes virtual networking

Let's review how virtual networking is supported in Kubernetes.

- Kubernetes nodes are connected to a virtual network, which provides inbound and outbound connectivity for pods.

- The kube-proxy component runs on each node to provide the network features.

- Network policies configure security and filtering of the network traffic for pods.

- Network traffic can be distributed by using a load balancer.

- Complex routing of application traffic can be achieved with Ingress Controllers.

#### Azure Kubernetes Service

The Azure platform helps to simplify virtual networking for Azure Kubernetes Service clusters.

When you create a Kubernetes load balancer, the underlying Azure Load Balancer resource is created and configured. As you open network ports to pods, the corresponding Azure network security group rules are configured. For HTTP application routing, Azure can configure an external DNS as new ingress routes are configured.

### Things to know about Kubernetes service types

To simplify the network configuration for application workloads, Kubernetes uses services to logically group a set of pods together and provide network connectivity. There are four service types available for creating network configurations.

| Service type | Description | Scenario |
| --- | --- | --- |
| **Cluster IP** | Create an internal IP address for use within an Azure Kubernetes Service cluster. | _Implement internal-only applications that support other workloads within the cluster_ |
| **NodePort** | Create a port mapping on the underlying node. | _Allow direct access to the application with the node IP address and port_ |
| **LoadBalancer** | Create an Azure Load Balancer resource, configure an external IP address, and connect the requested pods to the load balancer back-end pool. | _Allow customer traffic to reach the application by creating load-balancing rules on the desired ports_ |
| **ExternalName** | Create a specific DNS entry. | _Support easier application access_ |

Here are some details about these network configuration options:

- You can create internal and external load balancers.

- The IP address for load balancers and services can be dynamically assigned, or you can specify an existing static IP address.

- Internal load balancers are only assigned a private IP address, so can't be accessed from the internet.

- Both internal and external static IP addresses can be assigned. The existing static IP address is often tied to a DNS entry.

### Things to know about Kubernetes pods

Kubernetes uses pods to run an instance of your application, where a pod represents a single instance of your application. 

Let's examine how Kubernetes uses pods and containers to support networking.

- Pods typically have a 1:1 mapping with a container, although there are advanced scenarios where a pod might contain multiple containers.

- Multi-container pods are scheduled together on the same node, and allow containers to share related resources.

- When you create a pod, you can define resource limits to request a certain amount of CPU or memory resources. The Kubernetes Scheduler attempts to schedule the pods to run on a node with available resources to meet the request.

- You can specify maximum resource limits that prevent a given pod from consuming too much compute resource from the underlying node.

   > [!NOTE]
   > A best practice is to include resource limits for all pods to help the Kubernetes Scheduler recognize what resources are needed and permitted.

- A pod is a logical resource, but a container is where the application workloads run.

   Pods are typically ephemeral, disposable resources. Individually scheduled pods miss some of the high availability and redundancy features Kubernetes provides. Instead, pods are commonly deployed and managed by Kubernetes controllers, such as the Deployment controller.