## Nodes

It's common to see Kubernetes referred to as a *cluster*. At a high level, clusters are a group of computers that work together and share resources to help improve performance and availability. If any computers in the cluster fail, the services running on the cluster can continue running on the remaining functioning computers.

In Microsoft Azure, those computers are known as *virtual machines (VMs)*. In Kubernetes, those VMs are known as *nodes*.

Nodes need network connectivity so they can communicate with one another and effectively route network traffic. Nodes also need to communicate with the Kubernetes *control plane*, which provides the core Kubernetes services and orchestration of application workloads, so they can run your application workload resources.

:::image type="content" source="../media/2-overview-of-kubernetes-networking-nodes.svg" alt-text="Diagram that shows the Kubernetes cluster nodes and control plane." border="false":::

## Pods

In Kubernetes, application workload resources include pods, deployments, and sets. Pods are the smallest deployable unit in a Kubernetes cluster. They're distributed across your nodes in a way that enables the best use of the available processor and memory resources on the nodes. Pods typically represent a single instance or subcomponent of your application. A pod might run a shopping cart component that manages the items in a customer's cart or a shipping component that handles the processing of completed orders.

You can run multiple copies, or *replicas*, of the same pod. Replicas distribute multiple pods across nodes to provide high availability. With multiple replicas of the pods, our application can continue to work if a component running in a pod fails.

:::image type="content" source="../media/2-overview-of-kubernetes-networking-pods.svg" alt-text="Diagram that shows multiple pod replicas running across several Kubernetes cluster nodes." border="false":::

With the scaling features in Kubernetes, you can add or remove pods in response to the level of demand on the cluster. The self-healing abilities in Kubernetes can replace any pod that fails, and the built-in support for rolling updates automates the deployment of new versions of an application without any downtime.

Pods are assigned a new IP address during their initial deployment. This IP address is used for all network communication with the pod. There are many scenarios where a pod is assigned a new IP address. When cluster demand is high and scaling occurs, new pods are deployed. When you update an application, new pods are deployed to replace the old pods. If a pod fails, a new pod automatically replaces it. All of these scenarios result in new pod IP addresses.

If pod IP addresses experience frequent changes, how does Kubernetes know where to send network traffic to reach our application? The answer is *services*.

## Services

A Kubernetes *service* sits in front of a group of pods and provides a static IP address. When traffic arrives at a service, the service distributes it in a round-robin manner to a set of backend pods. The service tracks changes in the IP addresses of the pods to ensure network traffic is sent to the correct pods.

:::image type="content" source="../media/2-overview-of-kubernetes-networking-services.svg" alt-text="Diagram that shows multiple pod replicas being served network traffic via a Kubernetes service." border="false":::
