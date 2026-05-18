At the highest level, Kubernetes is a cluster of machines—called nodes—that share compute, network, and storage resources. Each cluster has a control plane connected to one or more worker nodes. The worker nodes are responsible for running groups of containerized applications and workloads, known as pods, and the control plane manages which pods run on which worker nodes. In production, the control plane runs as a highly available, multi-replica service. In Azure Kubernetes Service (AKS), the control plane is fully managed by Azure. AKS node-pool nodes are Azure virtual machines, and AKS can also use virtual nodes backed by Azure Container Instances for specific scale-out scenarios.

:::image type="content" source="../media/overview-cluster-nodes-bad6d19a.png" alt-text="Diagram showing how nodes and pods make up a cluster.":::


Furthermore, a Kubernetes cluster is divided into two components:<br>

 -  **Control plane**: provides the core Kubernetes services and orchestration of application workloads.
 -  **Nodes**: run your application workloads.

:::image type="content" source="../media/cluster-architecture-control-plane-and-nodes-e496ba6d.png" alt-text="Diagram showing how Kubernetes control plane and node components work together.":::


A cluster is a set of computers that you configure to work together and view as a single system. A Kubernetes cluster contains at least one control plane and one or more nodes. In self-managed Kubernetes, the control plane and node instances can be physical devices, virtual machines, or instances in the cloud; in AKS, the control plane is a managed Azure service and node-pool nodes are Azure virtual machines. Linux is the default host OS, and the AKS system node pool must run Linux. AKS also supports Windows Server LTSC node pools for Windows container workloads. Supported Windows Server versions depend on the Kubernetes version: Windows Server 2022 isn't supported for node pools running Kubernetes 1.36 or later, and Windows Server 2025 LTSC is currently in preview where available.

A cluster uses centralized software that's responsible for scheduling and controlling these tasks. The computers in a cluster that run application workloads are called *nodes*, and the set of components that run the scheduling and orchestration software is called the *control plane*. In AKS, the control plane is a managed Azure service, and you don't manage the machines that host its components.

A node in a Kubernetes cluster is where your compute workloads run. Each node communicates with the control plane via the API server to inform it about state changes on the node.

For the control plane to communicate with the worker nodes—and for a person to communicate with the control plane—Kubernetes includes many components that make up the control plane.

Developers and operators interact with the cluster primarily by using kubectl, a command-line tool that installs on their local OS. Commands issued through kubectl are sent to the kube-apiserver, the component of the control plane that exposes the Kubernetes API. The kube-apiserver validates the request, creates or updates Kubernetes API objects, and stores API object data, including desired state in object specs, in etcd. The kube-controller-manager runs control loops that continuously watch the kube-apiserver for state changes and reconciles the cluster by issuing further API calls. The kubelet on each worker node also watches the kube-apiserver for pods assigned to its node and ensures that those containers are running.

:::image type="content" source="../media/kubernetes-control-plane-365035e5.png" alt-text="Diagram showing how the Kubernetes control plane and worker nodes interact.":::


The control plane stores cluster state and configuration in etcd, a distributed key-value store. To run pods with your containerized apps and workloads, you describe the desired state to the cluster in a YAML manifest. The manifest is submitted to the kube-apiserver, which creates or updates Kubernetes API objects from it and stores API object data and cluster state in etcd. Workload controllers in the kube-controller-manager (such as the Deployment controller) watch for new objects and create the underlying resources, such as ReplicaSets and Pods, by calling the kube-apiserver. The kube-scheduler independently watches for newly created pods that have no node assignment, selects an appropriate node based on resource requirements and policies, and writes the binding back through the kube-apiserver. The kubelet on the chosen node then pulls the container images and starts the pod's containers.

In a Kubernetes deployment, the desired state you describe is stored in object specs, while current state is reported in object status and actual cluster state. Controllers continuously reconcile the actual state toward the desired state. Kubernetes supports rollbacks, rolling updates, and pausing rollouts: Deployments retain a configurable revision history of their underlying ReplicaSets so you can roll back to a previous version. Deployments use ReplicaSets to ensure that the specified number of identically configured pods are running. If one or more pods fail, the ReplicaSet replaces them. In this way, Kubernetes is said to be self-healing.

:::image type="content" source="../media/master-node-controller-520be118.png" alt-text="Diagram showing how the kube-controller-manager and kube-scheduler work together.":::
