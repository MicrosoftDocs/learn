To determine the suitability of Kubernetes for orchestrating the Contoso containerized workloads, it's important for you to understand the Kubernetes architecture, terminology and definitions, in addition to how to manage storage and networking by using Kubernetes.

## Overview of Kubernetes

Kubernetes provides a means of operating and managing containerized applications deployed across multiple servers. It provides an open-source application programming interface (API) for controlling how and where your containers will run, and schedules containers to run on clustered VMs based on their available compute resources and the resource requirements of each container. Kubernetes focuses on application workloads, and not on the underlying infrastructure components.

Kubernetes can provide your container-based applications with benefits such as:

- Portability. Kubernetes' declarative approach to deployment is implemented by using lightweight YAML manifest files. For application updates you don't have to re-architect infrastructure.

- Scalability. You can schedule and deploy containers, scale them as needed and manage their life cycles.

- Extensibility. The Kubernetes open-source API allows you to build applications with your preferred programming language, operating system (OS), libraries, and messaging bus. You can also integrate your existing continuous integration and continuous delivery (CI/CD) tools.

### Kubernetes architecture

A Kubernetes cluster is divided into two core components:

- Nodes or *worker nodes* that run the application workloads (tasks) within a cluster. A cluster typically contains multiple nodes that are managed by the control plane. Sub-components of a node include the *kubelet*, *kube-proxy*, and *container runtime*.

- Control plane or *master node* that provides core Kubernetes services that are used for orchestrating your application workloads by scheduling and controlling the tasks within a cluster. Components that make up the control plane include *kube-api-server*, *controller*, and *kube-scheduler*.

> [!NOTE]
> Currently only the Linux OS is supported as the host OS for the Kubernetes *master node*.

:::image type="content" source="../media/m26-kubernetes-cluster.png" alt-text="A diagram to exemplify the components of a Kubernetes cluster with representations for master and worker node with the sub-components API server, kubelet, container runtime and container instances." border="false":::

Each Kubernetes cluster contains at least one control plane and one or more worker node instances. Worker node instances can be based either on the Linux OS or on Windows Server 2019. A typical Kubernetes workload is made up of several containers that are distributed over multiple worker nodes in a cluster.

### Terminology and definitions

The following table defines some important Kubernetes terms.

|Term|Definition|
|--|--|
|pod|The basic operational unit for Kubernetes. Containers are grouped into pods and the pods scale to your desired state. A *pod* provides a specification for running the containers within it. It also provides a specification for the storage and network resources that those containers use.|
|service|This is an abstracted, or logical, set of pods and a policy with which to access them. The policy defines how to access sets of pods, and specifies to which pods the policy applies. This pattern of combining a logical set of pods and a policy is sometimes referred to as a *micro-service*.|
|controller|Tracks changes to the state of a Kubernetes resource and helps bring the resource to its desired state. Types of workload controllers include ReplicaSet, Deployments, Job, CronJob, and more.|
|kubectl|A management tool that provides a command-line interface (CLI) for connecting to the control plane of a Kubernetes cluster.|
|kubeadm|A set of tools for creating a Kubernetes cluster quickly and with minimum features and addons.|
|kubelet|An agent that runs on each node in a cluster to process orchestration requests from the control plane and to schedule the running of requested containers.|
|kube-proxy|Manages virtual networking on each node by routing network traffic and managing IP addressing for services and pods.|
|container runtime|A node component that allows containerized applications to run and interact with additional resources such as the virtual network and storage.|
|kube-api-server|A control-plane component that exposes the underlying Kubernetes APIs to allow interaction with management tools, such as kubectl or the Kubernetes dashboard.|
|kube-scheduler|Determines what nodes can run the workload and starts them when an application is started or created.|

#### Containers, pods, and nodes

A *container* runs inside a *pod*, which in turn runs inside a *node*.

##### Containers

Containers should only be scheduled together in a single *pod* if they are closely related and need to share resources such as a disk.

##### Pods

A pod:

- Can hold one or more containers.
- Is used to represent a single instance of an application.
- Contains a specification for how to run the containers within the pod, such as network and storage details, that are shared by the containers within the pod.

You can use pod templates to define information about the pods such as which container image and ports to use.

##### Nodes

A node:

- Can hold multiple pods.
- Could be either a virtual machine or a physical machine, depending on the cluster.

Each node is managed by the control plane or *master node*. A master node manages the scheduling of the pods across the nodes in the cluster.

:::image type="content" source="../media/m26-kubernetes-nodes-vs-pods.png" alt-text="A diagram depicting containers, volumes running inside a pod, and in turn the pods running inside of a node." border="false":::

>[!TIP]
> You can assign a Kubernetes pod to a specific node by using *Node Affinity*. You can do this by using a combination of the `kubectl` command and the `.yaml` manifest file.

>[!NOTE]
> A *service* is effectively a collection of pods which have their own IP addresses.

### Storage and networking

Kubernetes also manages the networking and storage components that are associated with container-based applications.

#### Storage

For storage, Kubernetes uses *volumes*. A volume is essentially a directory that the containers in a pod can access for storing files. You can arrange Kubernetes storage volumes into two broad categories:

- *Persistent volumes*. Persistent volumes provide storage volumes as a Kubernetes resource. Both the volume and data are available after a container restarts.
- *Ephemeral volumes*. Ephemeral volumes provide temporary storage for read-only input data. When a container is restarted, the ephemeral volume and data are no longer available.

> [!NOTE]
> Kubernetes supports different types of volumes, including *azureDisk* for mounting a Microsoft Azure Data Disk into a pod, *azureFile* for mounting an Azure File volume into a pod, and *iSCSI*.

#### Networking

Kubernetes provides support for networking in the following areas:

- Container networking. Concerns networked communications between the containers within a pod.
- Cluster networking. Provides networked communications between the pods within a cluster.
- Services (external). Allows network access to the applications running in a pod from outside the cluster.
- Services (internal). Specifies which network services are permitted for use among the resources inside a cluster.

To achieve network communication in the previously-outlined scenarios, you need to be aware of how some core components are configured in Kubernetes, including:

- Containers:
  - Containers share pod network configuration, including IP address.
  - Containers have shared resources within the same pod and can communicate with other containers in the same pod.
  - All containers within a pod behave as if they are on the same host with regard to networking.
- Pods:
  - Every pod has its own unique IP address.
- Services:
  - Every service has its own virtual IP address.
- Clusters:
  - Every cluster node has its own IP address as it would in a normal cluster host.

Communicating from the cluster to a service involves routing from the service IP address to the pod IP address using the **kube-dns** and **kube-proxy** services.

To support communication directly between pods (such as pod-to-pod) and to allow the application of policies to that communication, you need to add a Container Network Interface (CNI) plug-in into the Kubernetes cluster. *CNI* is an industry specification for network plug-ins. There are many plug-ins available on Kubernetes that adhere to this specification.

>[!Note]
> CNI plug-ins create an abstraction of the physical network of the pods. The virtual nature of that abstracted network makes it easier to configure, manipulate, and automate pod networking. The physical network is known as the *underlay network*, and the virtual, abstracted network is known as the *overlay network*.
