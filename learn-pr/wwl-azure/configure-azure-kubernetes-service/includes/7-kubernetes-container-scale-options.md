Kubernetes has built-in components to scale your replicas (pods) and nodes. If your application needs to scale rapidly, the horizontal pod autoscaler might schedule more pods than can be provided by the existing compute resources in the node pool. As a result, the cluster autoscaler is triggered to deploy more nodes in the node pool. This scenario can take a few minutes for the nodes to successfully provision.

To resolve this situation, you can rapidly scale your Azure Kubernetes Service cluster by integrating with Azure Container Instances. The following illustration shows an AKS cluster with rapid burst scaling of virtual nodes in AKS to pods in Container Instances.

:::image type="content" source="../media/kubernetes-burst-686ee747.png" alt-text="Illustration that shows an Azure Kubernetes Service cluster with rapid burst scaling of virtual nodes in AKS to pods in Azure Container Instances." border="false":::

### Things to know about rapid burst scaling

Review the following characteristics of an AKS cluster that uses Azure Container Instances for rapid burst scaling.

- Azure Container Instances lets you quickly deploy your container instance without extra infrastructure overhead. When you connect with AKS, your container instance becomes a secured, logical extension of your AKS cluster.

- The Virtual Kubelet component is installed in your AKS cluster. The component presents your container instance as a virtual Kubernetes node.

- Kubernetes schedules pods to run as container instances through virtual nodes, rather than pods on virtual machine nodes directly in your AKS cluster.

- Your application requires no modification to use virtual nodes.

- Deployments can scale across AKS and Container Instances. There's no delay when the cluster autoscaler deploys new nodes in your AKS cluster.

- Virtual nodes are deployed to another subnet in the same virtual network as your AKS cluster. This virtual network configuration allows the traffic between Container Instances and AKS to be secured. Like an AKS cluster, a container instance is a secure, logical compute resource that's isolated from other users.