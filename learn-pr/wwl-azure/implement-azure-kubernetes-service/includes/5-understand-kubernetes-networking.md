Kubernetes pods have a limited lifespan and are replaced whenever new versions are deployed.

Settings such as the IP address change regularly, so interacting with pods using an IP address isn't advised.

Therefore, Kubernetes services exist. Kubernetes uses Services to logically group a set of pods and provide network connectivity to simplify the network configuration for application workloads.

**Kubernetes Service** is an abstraction that defines a logical set of pods, combined with a policy that describes how to access them.

Where pods have a shorter lifecycle, services are more stable and are not affected by container updates.

It means that you can safely configure applications to interact with pods by using services.

The service redirects incoming network traffic to its internal pods.

Services can offer more specific functionality based on the service type that you specify in the Kubernetes deployment file.

If you don't specify the service type, you'll get the default type, `ClusterIP`.

It means that your services and pods will receive virtual IP addresses only accessible from within the cluster.

Although it might be good practice for containerized back-end applications, it might not be what you want for applications that need to be accessible from the internet.

It would be best to determine how to configure your Kubernetes cluster to make those applications and pods accessible from the internet.

## Services

The following Service types are available:

 -  **ClusterIP** This service creates an internal IP address for use within the AKS cluster. However, it's suitable for internal-only applications that support other workloads within the cluster.
    
    :::image type="content" source="../media/clusterip-c2a72445.png" alt-text="A workflow graphic of internal traffic being routed over port 80 to a ClusterIP and then to three pods over port 80.":::
    

 -  **NodePort** This service creates a port mapping on the underlying node, enabling the application to be accessed directly with the node IP address and port.
    
    :::image type="content" source="../media/nodeport-5998cf88.png" alt-text="A workflow graphic of incoming traffic being routed over port 31000 to three AKS nodes, which are all routed to a single NodePort, and from there to three pods over port 80.":::
    

 -  **LoadBalancer** This service creates an Azure Load Balancer resource, configures an external IP address, and connects the requested pods to the load balancer backend pool. Load-balancing rules are created on the desired ports to allow customers' traffic to reach the application.
    
    :::image type="content" source="../media/loadbalancer-b2942699.png" alt-text="A workflow graphic of incoming traffic being routed through a load balancer to three AKS nodes, and then to two pods on port 80.":::
    
