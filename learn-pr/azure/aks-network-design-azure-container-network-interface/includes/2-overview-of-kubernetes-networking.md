Before you begin designing a network for a Kubernetes cluster, it makes sense to understand how IP addresses are used by Kubernetes components. Let's dive into the details of some key Kubernetes components.

## Nodes

You may often see Kubernetes referred to as a cluster. Clusters are a group of computers that work together to share resources to help improve performance and provide high availability. Services running on the cluster can then continue running if one or more computers in the cluster should fail.

In Microsoft Azure, computers are virtual machines and in Kubernetes, these virtual machines are known as Nodes.

Nodes need network connectivity so that they can communicate with one another and to route network traffic to the correct place. Nodes also need to communicate with the Kubernetes control plane, which provides the overall state of what's happening within the cluster.

:::image type="content" source="../media/2-overview-of-kubernetes-networking-nodes.svg" alt-text="Diagram that shows Kubernetes cluster nodes and the Kubernetes Control Plane" border="false":::

## Pods

Pods are the smallest deployable unit in a Kubernetes cluster. Pods are distributed across your nodes in a manner that provides the best use of the available processor and memory resources available on the nodes.

Pods typically represent a single instance of your application or a subcomponent of your application. A pod could be running a shopping cart component that manages the items a customer has in their cart. Or maybe a shipping component that handles the processing of completed orders.

You can run multiple copies, known as replicas, of the same pod. Replicas distribute multiple pods across nodes to provide high availability. With multiple copies, our application can continue to work if a component running in a pod fails.

:::image type="content" source="../media/2-overview-of-kubernetes-networking-pods.svg" alt-text="Diagram that shows multiple pod replicas running across several Kubernetes cluster nodes." border="false":::

Kubernetes includes automatic scaling features. Pods can be added or removed in response to the level of demand on the cluster. Self-healing abilities can replace any pod that has failed. And built-in support for rolling updates automates the deployment of a new version of an application without any downtime.

There are many scenarios where a pod is assigned a new IP address. A new IP address is assigned when a new pod is deployed during an initial deployment. When demand on the cluster is high and scaling up takes place, further new pods are deployed. When an application is updated, new pods are deployed to take the place of old ones. Or if a pod fails, it's automatically replaced with a new pod. All of these events result in new pod IP addresses.

## Services

If the pod's IP addresses are forever changing, how does Kubernetes know where to send network traffic to reach our application? A Kubernetes Service is the answer! A Service sits in front of a group of pods and provides a static IP address. Traffic arriving at a service is distributed in a round-robin manner to a set of backend pods. As the pod's IP addresses change over time, the service tracks changes to make sure network traffic still gets sent to the correct pods.

:::image type="content" source="../media/2-overview-of-kubernetes-networking-services.svg" alt-text="Diagram that shows multiple pod replicas being served network traffic via a Kubernetes service." border="false":::

## Azure Container Network Interface (Azure CNI)

Kubernetes was designed to support plug-ins. You can add new features, replace, or enhance existing cluster behavior using plug-ins. The Container Network Interface is a specification that allows developers to create plug-ins to configure container networking. Kubernetes has adopted the CNI specification, so you can use CNI plug-ins with your cluster.

Azure CNI is a plug-in that allows containers to work with Azure Virtual Networks. In a Kubernetes cluster, using the Azure CNI allows a pod to be assigned an IP address from an Azure Virtual Network. The pod can then communicate on the Azure Virtual Network just like any other device. It can connect to other pods, to peered networks or on-premises networks using ExpressRoute or a VPN, or to other Azure services using Private Link.
