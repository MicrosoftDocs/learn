A successfully configured Kubernetes installation depends on a good understanding of the Kubernetes system architecture. Here you'll look at all the components that make up a Kubernetes installation.

### What is a computer cluster?

:::image type="content" source="../media/3-diagram-cluster-tmp.png" alt-text="Diagram of computer cluster." border="false":::

A cluster is a set of computers that you configure to work together and view as a single system. The computers configured in the cluster will typically do the same kinds of tasks. For example, host websites, APIs, or run compute-intensive work.

A cluster uses centralized software that is responsible for scheduling and controlling these tasks. The computers in a cluster that run the tasks are called nodes, and the computers that run the scheduling software are called masters or control planes.

## Kubernetes architecture

Recall from earlier, that an orchestrator is a system that deploys and manages applications. You also learned that a cluster is a set of computers that work together and viewed as a single system. You use Kubernetes as the orchestration and cluster software to deploy your apps and respond to changes in compute resource needs.

:::image type="content" source="../media/3-cluster-arch-components-tmp.svg" alt-text="Diagram of a Kubernetes cluster architecture that shows the components installed on the control plane and the worker nodes." border="false":::

A Kubernetes cluster contains at least one master and one or more nodes. Both the master and node instances can be physical devices, virtual machines, or instances in the cloud. The default host operating system in Kubernetes is Linux, with default support for Linux-based workloads. It is, however, also possible to run Microsoft workloads using Windows Server 2019 or later on cluster nodes. For example, let's assume the data processing service in the drone tracking application is written as a .NET 4.5 application that makes use of specific Windows OS API calls. This service can only execute on nodes that run a Windows Server OS.

Let's look at both the master and worker nodes and the software that runs on each in more detail. Understanding the role of each component and where each component runs in the cluster helps you when it comes to installing Kubernetes.

### The Kubernetes master

The Kubernetes master node, also known as the control plane in a Kubernetes cluster, runs a collection of services that manages the orchestration functionality in Kubernetes. All of the Kubernetes services can run in a single master node configuration. From a learning perspective, it makes sense to use a single master in your test environment as you explore Kubernetes functionality. However, in production and cloud deployments such as Azure Kubernetes Service (AKS), you'll find that the preferred configuration is a multi-master high availability deployment with three to five replicated masters.

The fact that a master node runs specific software to maintain the state of the cluster doesn't exclude the master node from running other compute workloads. However, you usually want to make sure to exclude the master from running noncritical and user application workloads.

### Services that run in a control plane

The following services make up the control plane in a Kubernetes cluster.

- The API server
- The backing store
- The Scheduler
- The controller manager
- The cloud controller manager

#### What is the API server?

We can think of the API server as the front end to the control plane in your Kubernetes cluster. All the communication done between the components in Kubernetes is through this API. For example, as a user, you use a command-line application called `kubectl` that allows you to execute commands against your Kubernetes cluster's API server. The component that provides this API is called the `kube-apiserver`, and you can deploy several instances of this component to support scaling in your cluster.

This API exposes a RESTful API that allows you to post commands or YAML-based configuration files. YAML is a human-readable data serialization standard for programming languages. You use YAML files to define the intended state of all the objects within a Kubernetes cluster.

For example, assume you want to increase the number of instances of your application in the cluster. You'll define the new state using a YAML-based file and submit this file to the API server. The API server will validate the configuration, save the configuration to the cluster, and finally action the configured increase in application deployments.

#### What is the backing store?

The backing store is a persistence store your Kubernetes cluster uses to store the complete configuration of a Kubernetes cluster. Kubernetes uses a high-availability distributed reliable key-value store called, `etcd`. This key-value store stores the current state as well as the desired state of all objects within your cluster.

Keep in mind that `etcd` isn't responsible for data backup, and it's your responsibility to ensure an effective backup plan is in place to back up the `etcd` data.

In a production Kubernetes cluster, the official Kubernetes guidance is to have three to five replicated instances of the `etcd` database for high-availability.

#### What is the Scheduler?

The Scheduler is the component that is responsible for the assignment of workloads across all nodes. The Scheduler monitors the cluster for newly created containers and assigns them to nodes.

#### What is the controller manager?

The controller manager is responsible for launching the controllers configured for a cluster as well as monitoring them through the API server.

Kubernetes makes use of controllers to track the state of objects in the cluster. Each controller runs in a non-terminating loop while watching and responding to events in the cluster. For example, there are controllers to monitor nodes, containers, endpoints, and so on.

The controller communicates with the API server to determine the state of the object. If the current state is different from the desired state of the object, then the controller will take action to ensure the desired state.

Let's assume one of three containers running in your cluster stops responding and has died. In this case, a controller decides whether it's required to launch new containers to ensure that your applications are always available. If the desired state is to run three containers at any time, then a new container is scheduled to run.

#### What is the cloud controller manager?

The cloud controller manager's function is to integrate with the underlying cloud technologies in your cluster when the cluster is running in a cloud environment such as Azure or one of the other cloud providers. These services can be load-balancers, queues, storage, and so on.

### The Kubernetes node

A node in a Kubernetes cluster is where your compute workloads run. Each node communicates with the control plane via the API server to inform it about state changes on the node.

### Services that run in a node

The following services make up a node in a Kubernetes cluster.

- kubelet
- Container Runtime
- kube-proxy

#### What is kubelet?

kubelet is the agent that runs on each node in the cluster and monitors work requests from the API server and makes sure that the requested unit of work is running and healthy.

kubelet is responsible for monitoring the nodes and making sure that the containers scheduled on each node run as expected. kubelete only manages containers created by Kubernetes and isn't responsible for rescheduling work to run on other nodes if the current node can't run the work.

#### What is the Container runtime?

The Container Runtime is the underlying software that runs containers on a Kubernetes cluster. The runtime is responsible for fetching, starting, and stopping container images. Kubernetes supports several container runtimes, including but not limited to Docker, rkt, CRI-O, containerd, and frakti. The support for many container runtime types are based on the Container Runtime Interface (CRI). The CRI is a plugin design that provides a container runtime interface and allows Kubelet to communicate with the available container runtime.

The default container runtime in Azure Kubernetes Service (AKS) is Docker. However, you may also use kata-containers and containerd. Keep in mind that the Windows support for containerd is experimental.

#### What is kube-proxy?

Kube-proxy is responsible for local cluster networking and runs on each node. It's kube-proxy's responsibility to make sure that each node has a unique IP address. Kube-proxy also implements rules to handle routing and load-balancing of traffic using IPTABLES and IPVS. Kube-proxy does not provide DNS services by itself. A DNS cluster add-on based on coreDNS is recommended and installed by default.

## Kubernetes Pods

The workloads you run on Kubernetes are containerized applications. However, unlike in a docker environment, you can't run containers directly on Kubernetes. You have to package the container into a Kubernetes object. This object is called a Pod and is the smallest object that you can create in Kubernetes.

A pod represents a single instance of an application. A single pod can also group of one or more containers. However, a pod typically doesn't contain multiples of the same application.

A pod includes information about the shared storage and network configuration, and a specification on how to run its packaged containers. You use pod templates to define the information about the pods that run in your cluster. Pod templates are YAML coded files you reuse and include in other objects to manage pod deployments.

For example, assume you want to deploy a pod that contains a website to a Kubernetes cluster. You'll create the pod definition file that specifies the application container images and configuration. Then you deploy the pod definition file to Kubernetes.

:::image type="content" source="../media/3-diagram-pod-with-website-tmp.svg" alt-text="Diagram of pod with a website as the primary container." border="false":::

It's unlikely to see a web application that has a website as the only component in the solution. A web application typically has some kind of datastore and other supporting elements. Kubernetes Pods can also contain more than one container.

:::image type="content" source="../media/3-diagram-pod-with-website-database-tmp.svg" alt-text="Diagram of pod with a website as the primary container and a supporting container. The node has both an assigned IP address and a localhost host address." border="false":::

Assume your site uses a database. Here the website is packaged in the main container and the database in the supporting container. For these two containers to function and communicate with each other, you expect them to run in an environment that provides a host OS, a network stack, kernel namespaces, shared memory, and volumes to persist data. The pod is the sandbox environment that provides all of these services to your application and allows the containers to share the pod's assigned IP address.

Since you can potentially create many pods that are running on many nodes, it can hard to identify them. You recognize and group pods using string labels you specify when you define a pod.

### The lifecycle of a Kubernetes pod

Kubernetes pods have a distinct lifecycle that impacts the way you deploy, run, and update pods.

You start by submitting the pod YAML manifest to the cluster. Once submitted and persisted to the cluster, the manifest file defines the desired state of the pod. The Scheduler schedules the pod to a healthy node with enough resources to run the pod.

:::image type="content" source="../media/3-pod-lifecycle-tmp.png" alt-text="Diagram that shows the lifecycle of the pod." border="false":::

Let's look at the phases in a pod lifecycle.

|||
|---|---|
| Pending | Once scheduled, the container runtime downloads container images and starts all containers for the pod. |
| Running | The pod transitions to a running state once all of the resources within a pod are ready. |
| Succeeded | The pod transitions to a succeeded state when the pod completed its intended task and ran successfully. |
| Failed | Pods can fail for various reasons. For example, it could be that a container in the pod failed, and all other containers terminated, or an image wasn't found while preparing the pod containers. In these types of cases, the pod can go to a failed state. Pods can transition to a failed state from both pending and running. A specific failure can also place a pod back into the pending state. |
| Unknown | If the state of the pod can't be determined, the pod is an unknown state. |

Pods are kept on a cluster until a controller, the control plane, or a user explicitly removes them. When a pod is deleted and is replaced by a new pod, the new pod is an entirely new instance of the pod based on the pod manifest. The cluster doesn't save the pod's state or dynamically assigned configuration, for example, the pod ID or IP address. This aspect impacts how you deploy pods and how you design your apps. For example, you can't rely on preassigned IP addresses for your pods.

### Container states

Keep in mind that the phases are a summary of where the pod is in its lifecycle. When you inspect pods, there are three states the cluster uses to track your containers inside the Pod.

|||
|---|---|
| Waiting | The default state of a container and the state the container is in when it's not running or terminated.|
| Running | The container is executing as expected without any problems. |
| Terminated | The container is no longer running. This state can either be because all tasks complete or the container failed for some reason. A reason and exit code are available when debugging both cases. |
