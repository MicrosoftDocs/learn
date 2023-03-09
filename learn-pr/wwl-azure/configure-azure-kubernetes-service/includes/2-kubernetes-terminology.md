Azure Kubernetes Service (AKS) provides a simplified approach for deploying a managed Kubernetes cluster in Azure. Azure operates as a hosted Kubernetes service and performs critical functions like health monitoring and maintenance. AKS employs components like nodes, pods, and pools to help you deploy and manage your container applications in Kubernetes clusters.

The following illustration shows the relationships in a Kubernetes pool between nodes, pods, and containers.

:::image type="content" source="../media/kubernetes-terms-ee59aa6e.png" alt-text="Illustration of a Kubernetes pool with nodes, nodes with pods, and pods with containers." border="false":::

### Things to know about AKS concepts

Before you begin using Kubernetes and Azure Kubernetes Service to deploy and manage containerized applications, it's helpful to be familiar with the terminology and concepts.

- **Pools**: A pool is a group of nodes that have an identical configuration.

- **Nodes**: A node is an individual virtual machine that runs containerized applications.

- **Pods**: A pod is a single instance of an application. A pod can contain multiple containers.

- **Container**: A container is a lightweight and portable executable image that contains software and all of its dependencies.

- **Deployment**: A deployment has one or more identical pods managed by Kubernetes.

- **Manifest**: The manifest is the YAML file that describes a deployment.