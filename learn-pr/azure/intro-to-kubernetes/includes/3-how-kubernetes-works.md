A successfully configured Kubernetes installation depends on a good understanding of the Kubernetes system architecture. Here you'll look at all the components that make up a Kubernetes installation.

### What is a computer cluster?

:::image type="content" source="../media/3-diagram-cluster.svg" alt-text="Diagram of a computer cluster." border="false":::

A cluster is a set of computers that you configure to work together and view as a single system. The computers configured in the cluster will typically do the same kinds of tasks. For example, they'll all host websites, host APIs, or run compute-intensive work.

A cluster uses centralized software that's responsible for scheduling and controlling these tasks. The computers in a cluster that run the tasks are called nodes, and the computers that run the scheduling software are called masters or control planes.

## Kubernetes architecture

Recall from earlier, an orchestrator is a system that deploys and manages applications. You also learned a cluster is a set of computers that work together and are viewed as a single system. You use Kubernetes as the orchestration and cluster software to deploy your apps and respond to changes in compute resource needs.

:::image type="content" source="../media/3-cluster-arch-components.svg" alt-text="Diagram of a Kubernetes cluster architecture that shows the components installed on the control plane and the worker nodes." border="false":::

A Kubernetes cluster contains at least one master and one or more nodes. Both the master and node instances can be physical devices, virtual machines, or instances in the cloud. The default host operating system in Kubernetes is Linux, with default support for Linux-based workloads. 

It's also possible to run Microsoft workloads by using Windows Server 2019 or later on cluster nodes. For example, assume that the data processing service in the drone tracking application is written as a .NET 4.5 application that makes use of specific Windows OS API calls. This service can run only on nodes that run a Windows Server OS.

Let's look at both the master and worker nodes, and the software that runs on each, in more detail. Understanding the role of each component and where each component runs in the cluster helps you when it comes to installing Kubernetes.

### The Kubernetes master

The Kubernetes master node, also known as the control plane in a Kubernetes cluster, runs a collection of services that manages the orchestration functionality in Kubernetes. All of the Kubernetes services can run in a single master node configuration. From a learning perspective, it makes sense to use a single master in your test environment as you explore Kubernetes functionality. However, in production and cloud deployments such as Azure Kubernetes Service (AKS), you'll find that the preferred configuration is a multi-master high-availability deployment with three to five replicated masters.

The fact that a master node runs specific software to maintain the state of the cluster doesn't exclude the master node from running other compute workloads. However, you usually want to make sure to exclude the master from running noncritical and user application workloads.

### The Kubernetes node

A node in a Kubernetes cluster is where your compute workloads run. Each node communicates with the control plane via the API server to inform it about state changes on the node.

## Services that run in a control plane

:::image type="content" source="../media/3-cluster-arch-master.svg" alt-text="Diagram of a Kubernetes cluster architecture that shows the components installed on the control plane." border="false":::

The following services make up the control plane in a Kubernetes cluster:

- API server
- Backing store
- Scheduler
- Controller manager
- Cloud controller manager

### What is the API server?

You can think of the API server as the front end to the control plane in your Kubernetes cluster. All the communication between the components in Kubernetes is done through this API. For example, as a user, you use a command-line application called `kubectl` that allows you to run commands against your Kubernetes cluster's API server. The component that provides this API is called `kube-apiserver`, and you can deploy several instances of this component to support scaling in your cluster.

This API exposes a RESTful API that allows you to post commands or YAML-based configuration files. YAML is a human-readable data serialization standard for programming languages. You use YAML files to define the intended state of all the objects within a Kubernetes cluster.

For example, assume that you want to increase the number of instances of your application in the cluster. You'll define the new state by using a YAML-based file and submit this file to the API server. The API server will validate the configuration, save the configuration to the cluster, and finally enact the configured increase in application deployments.

### What is the backing store?

The backing store is a persistence store that your Kubernetes cluster uses to store the complete configuration of a Kubernetes cluster. Kubernetes uses a high-availability distributed reliable key-value store called `etcd`. This key-value store stores the current state as well as the desired state of all objects within your cluster.

Keep in mind that `etcd` isn't responsible for data backup. It's your responsibility to ensure that an effective backup plan is in place to back up the `etcd` data.

In a production Kubernetes cluster, the official Kubernetes guidance is to have three to five replicated instances of the `etcd` database for high availability.

### What is the scheduler?

The scheduler is the component that's responsible for the assignment of workloads across all nodes. The scheduler monitors the cluster for newly created containers and assigns them to nodes.

### What is the controller manager?

The controller manager is responsible for launching and monitoring the controllers configured for a cluster through the API server.

Kubernetes makes use of controllers to track the state of objects in the cluster. Each controller runs in a non-terminating loop while watching and responding to events in the cluster. For example, there are controllers to monitor nodes, containers, and endpoints.

The controller communicates with the API server to determine the state of the object. If the current state is different from the wanted state of the object, then the controller will take action to ensure the wanted state.

Let's assume that one of three containers running in your cluster stops responding and has died. In this case, a controller decides whether it's required to launch new containers to ensure that your applications are always available. If the wanted state is to run three containers at any time, then a new container is scheduled to run.

#### What is the cloud controller manager?

The cloud controller manager integrates with the underlying cloud technologies in your cluster when the cluster is running in a cloud environment. These services can be load balancers, queues, and storage, for example.


## Services that run in a node

:::image type="content" source="../media/3-cluster-arch-node.svg" alt-text="Diagram of a Kubernetes cluster architecture that shows the components installed on the control plane." border="false":::

The following services make up a node in a Kubernetes cluster:

- Kubelet
- Kube-proxy
- Container runtime

### What is kubelet?

Kubelet is the agent that runs on each node in the cluster and monitors work requests from the API server. It makes sure that the requested unit of work is running and healthy.

Kubelet monitors the nodes and makes sure that the containers scheduled on each node run as expected. Kubelet manages only containers created by Kubernetes. It isn't responsible for rescheduling work to run on other nodes if the current node can't run the work.

### What is kube-proxy?

Kube-proxy is responsible for local cluster networking and runs on each node. It makes sure that each node has a unique IP address. Kube-proxy also implements rules to handle routing and load balancing of traffic by using iptables and IPVS. 

Kube-proxy doesn't provide DNS services by itself. A DNS cluster add-on based on CoreDNS is recommended and installed by default.

### What is the container runtime?

The container runtime is the underlying software that runs containers on a Kubernetes cluster. The runtime is responsible for fetching, starting, and stopping container images. Kubernetes supports several container runtimes, including but not limited to Docker, rkt, CRI-O, containerd, and frakti. The support for many container runtime types is based on the Container Runtime Interface (CRI). The CRI is a plug-in design that  allows kubelet to communicate with the available container runtime.

The default container runtime in Azure Kubernetes Service is Docker. However, you can also use Kata Containers and containerd. Keep in mind that the Windows support for containerd is experimental.

## How to interact with a Kubernetes cluster

Kubernetes provides a command-line tool called `kubectl` that you use to manage your cluster. You use `kubectl` to send commands to the cluster's control plane or fetch information about all Kubernetes objects via the API server.

`kubectl` uses a configuration file that includes configuration information:

- Use the **Cluster** configuration to specify a cluster name, certificate information, and the service API endpoint associated with the cluster. This definition enables you to connect from a single workstation to multiple clusters.
- Use the **User** configuration to specify the users and their permission levels when they're accessing the configured clusters.
- Use the **Context** configuration to group clusters and users by using a friendly name. For example, you might have a "dev-cluster" and a "prod-cluster" to identify your development and production clusters.

You can configure `kubectl` to connect to multiple clusters by providing the correct context as part of the command-line syntax.

## Kubernetes pods

The workloads that you run on Kubernetes are containerized applications. However, unlike in a Docker environment, you can't run containers directly on Kubernetes. You package the container into a Kubernetes object. This object is called a pod and is the smallest object that you can create in Kubernetes.

A pod represents a single instance of an application. A single pod can also hold a group of one or more containers. However, a pod typically doesn't contain multiples of the same application.

A pod includes information about the shared storage and network configuration, and a specification on how to run its packaged containers. You use pod templates to define the information about the pods that run in your cluster. Pod templates are YAML coded files that you reuse and include in other objects to manage pod deployments.

For example, assume that you want to deploy a pod that contains a website to a Kubernetes cluster. You create the pod definition file that specifies the application's container images and configuration. Then you deploy the pod definition file to Kubernetes.

:::image type="content" source="../media/3-diagram-pod-with-website.svg" alt-text="Diagram of a pod with a website as the primary container." border="false":::

It's unlikely that a web application has a website as the only component in the solution. A web application typically has some kind of datastore and other supporting elements. Kubernetes pods can also contain more than one container.

:::image type="content" source="../media/3-diagram-pod-with-website-database.svg" alt-text="Diagram of pod with a website as the primary container and a supporting container. The node has both an assigned IP address and a localhost host address." border="false":::

Assume that your site uses a database. The website is packaged in the main container, and the database is packaged in the supporting container. For these two containers to function and communicate with each other, you expect them to run in an environment that provides a host OS, a network stack, kernel namespaces, shared memory, and volumes to persist data. The pod is the sandbox environment that provides all of these services to your application. The pod also allows the containers to share its assigned IP address.

Because you can potentially create many pods that are running on many nodes, it can be hard to identify them. You recognize and group pods by using string labels that you specify when you define a pod.

### The life cycle of a Kubernetes pod

Kubernetes pods have a distinct life cycle that affects the way you deploy, run, and update pods.

You start by submitting the pod YAML manifest to the cluster. After the manifest file is submitted and persisted to the cluster, it defines the wanted state of the pod. The scheduler schedules the pod to a healthy node that has enough resources to run the pod.

:::image type="content" source="../media/3-pod-lifecycle.svg" alt-text="Diagram that shows the life cycle of a pod." border="false":::

Let's look at the phases in a pod's life cycle.

|||
|---|---|
| Pending | After the pod run is scheduled, the container runtime downloads container images and starts all containers for the pod. |
| Running | The pod transitions to a running state after all of the resources within the pod are ready. |
| Succeeded | The pod transitions to a succeeded state after the pod completes its intended task and runs successfully. |
| Failed | Pods can fail for various reasons. A container in the pod might have failed, leading to the termination of all other containers. Or maybe an image wasn't found during preparation of the pod containers. In these types of cases, the pod can go to a failed state. Pods can transition to a failed state from either a pending state or a running state. A specific failure can also place a pod back in the pending state. |
| Unknown | If the state of the pod can't be determined, the pod is an unknown state. |

Pods are kept on a cluster until a controller, the control plane, or a user explicitly removes them. When a pod is deleted and is replaced by a new pod, the new pod is an entirely new instance of the pod based on the pod manifest. 

The cluster doesn't save the pod's state or dynamically assigned configuration. For example, it doesn't save the pod's ID or IP address. This aspect affects how you deploy pods and how you design your apps. For example, you can't rely on preassigned IP addresses for your pods.

### Container states

Keep in mind that the phases are a summary of where the pod is in its life cycle. When you inspect pods, there are three states that the cluster uses to track your containers inside the pod.

|||
|---|---|
| Waiting | The default state of a container and the state that the container is in when it's not running or terminated.|
| Running | The container is running as expected without any problems. |
| Terminated | The container is no longer running. The reason is that either all tasks finished or the container failed for some reason. A reason and exit code are available for debugging both cases. |
