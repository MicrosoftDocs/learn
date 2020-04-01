A successfully configured Kubernetes installation depends on a good understanding of the Kubernetes system architecture. Here you'll look at all the components that make up a Kubernetes installation.

### What is a computer cluster?

**[Image of a computer cluster.]**

A cluster is a set of computers that you configure to work together and view as a single system. The computers configured in the cluster will typically do the same kinds of tasks. For example, host websites, APIs, or run compute-intensive work.

A cluster uses centralized software that is responsible for scheduling and controlling these tasks. The computers in a cluster that runs the tasks are called nodes, and the computers that run the scheduling software are called masters or control planes.

## Kubernetes architecture

Recall from earlier, that an orchestrator is a system that deploys and manages applications. You also learned that a cluster is a set of computers that work together and viewed as a single system. You use Kubernetes as the orchestration and cluster environment to deploy your apps and respond to changes in compute resource needs.

A Kubernetes cluster contains at least one master and one or more nodes. Both the master and node instances can be physical devices, virtual machines, or instances in the cloud. The default host operating system in Kubernetes is Linux, with default support for Linux-based workloads. It is, however, also possible to run Microsoft workloads using Windows Server 2019 or later on cluster nodes.

Let's look at both the master and worker nodes and the software that runs on each in more detail. Understanding the role of each component and where each component runs in the cluster helps you when it comes to installing Kubernetes.

**[Diagram of a Kubernetes cluster architecture that shows the components installed on the control plane and the worker nodes.]**

### The Kubernetes master

The Kubernetes master node, also known as the control plane in a Kubernetes cluster, runs a collection of services that manages the orchestration functionality in Kubernetes. All of the Kubernetes services can run in a single master node configuration. From a learning perspective, it makes sense to use a single master in your test environment as you explore Kubernetes functionality. However, in production and cloud deployments such as Azure Kubernetes Services, you'll find that the preferred configuration is a multi-master high availability deployment with three to five replicated masters.

The fact that a master node runs specific software to maintain the state of the cluster doesn't exclude the master node from running other compute workloads. However, you usually want to make sure to exclude the master from running noncritical and user application workloads.

### Services that run in a control plane

The following services make up the control plane in a Kubernetes cluster.

- The API server
- The backing store
- The Scheduler
- The controller manager
- The cloud controller manager

#### What is the API server?

We can think of the API server as the front end to the control plane in your Kubernetes cluster. All the communication done between the components in a Kubernetes is through this API. For example, as a user, you use a command-line application called `kubectl` that allows you to execute commands against your Kubernetes cluster's API server. The component that provides this API is called the `kube-apiserver`, and you can deploy several instances of this component to support scaling in your cluster.

This API exposes a RESTful API that allows you to post commands or YAML-based configuration files. YAML is a human-readable data serialization standard for programming languages. You use YAML files to define the intended state of all the objects within a Kubernetes cluster.

For example, let's assume you want to increase the number of instances of your application in the cluster. You'll define the new state using a YAML-based file and submit this file to the API server. The API server will validate the configuration, save the configuration to the cluster, and finally action the configured increase in application deployments.

#### What is the backing store?

The backing store is a persistence store your Kubernetes cluster uses to store the complete configuration of a cluster. Kubernetes uses a high-availability distributed reliable key-value store called, `etcd`. This key-value store stores the state of all objects within your cluster.

Keep in mind that `etcd` isn't responsible for data backup, and it's your responsibility to ensure an effective backup plan is in place to back up the etcd data.

In a production Kubernetes cluster, the official Kubernetes guidance is to have three to five replicated instances of the `etcd` database for high-availability.

#### What is the Scheduler?

The Scheduler is the component that is responsible for the assignment of workloads across all nodes. The Scheduler monitors the cluster for newly created containers and assigns them to nodes.

#### What is the controller manager?

Kubernetes make use of controllers to track the state of objects in the cluster. Each controller runs in a non-terminating loop while watching and responding to events in the cluster. For example, there are controllers to monitor nodes, containers, endpoints, and so on.

The controller communicates with the API server to determine the state of the object. If the current state is different from the desired state of the object, then the controller will take action to ensure the desired state.

Let's assume one of three containers running in your cluster stops responding and has died. In this case, a controller decides whether it's required to launch new containers to ensure that your applications are always available. If the desired state is to run three containers at any time, then a new container is scheduled to run.

The controller manager is responsible for launching the controllers configured for a cluster as well as monitoring them through the API server.

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

Kublete is the agent that runs on each node in the cluster and monitors work requests from the API server and makes sure that the requested unit of work is running and healthy.

Kubelet is responsible for monitoring the nodes and making sure that the containers scheduled on each node run as expected. Kubelete only manages containers created by Kubernetes. It's also not responsible for rescheduling work to run on other nodes should it not be possible to run the work on the current node.

#### What is  the Container runtime

The Container Runtime is the underlying software that runs containers on a Kubernetes cluster. The runtime is responsible for fetching, starting, and stopping container images. Kubernetes supports several container runtimes, including but not limited to docker, rkt, CRI-O, containerd, and frakti. The support for many container runtimes is based on the Container Runtime Interface (CRI). The CRI is a plugin design that provides a container runtime interface and allows Kubelet to communicate with the available container runtime.

The default container runtime in Azure Kubernetes Service is Docker. However, you may also use kata-containers and containerd. Keep in mind that the Windows support for containerd is experimental.

#### What is kube-proxy?

Kube-proxy is responsible for local cluster networking and runs on each node. It's kube-proxy's responsibility to make sure that each node has a unique IP address. Kube-proxy also implements rules to handle routing and load-balancing of traffic using IPTABLES and IPVS. Kube-proxy does not provide DNS services by itself. A DNS cluster add-on based on coreDNS is recommended and installed by default.

## Kubernetes Pods

The workloads you run on Kubernetes are containerized applications. However, unlike in a docker environment, you can't run containers directly on Kubernetes. You have to package the container into a Kubernetes object. This object is called a Pod and is the smallest object that you can create in Kubernetes.

A Pod represents a single instance of an application. A single Pod can also group of one or more containers. However, a Pod typically doesn't contain multiples of the same application.

A Pod includes information about the shared storage and network configuration, and a specification on how to run its packaged containers. You use Pod templates to define the information about the pods that run in your cluster. Pod templates are YAML coded files you reuse and include in other objects to deploy and manage pods.

To deploy your application in Kubernetes, you'll deploy the Pod that has the application container images and configuration.

For example, let's assume you deploy a pod that contains a website to a Kubernetes cluster. You'll define the Pod definition and deploy the Pod.

**[Image of Pod with a website as the primary container.]**

It's unlikely to see a web application that has a website as the only component in the solution. A web application typically has some kind of datastore and other supporting elements. Pods can also contain more than one container.

**[Image of Pod with a website as the primary container and a supporting container. The node has both an assigned IP address and a localhost host address.]**

Let's assume your site uses a database. Here the website is packaged in the main container and the database in the supporting container. For these two containers to function and communicate with each other, you expect them to run in an environment that provides a host OS, a network stack, kernel namespaces, shared memory, and volumes to persist data. The Pod is the sandbox environment that provides all of these services to your application and allows the containers to share the Pod's assigned IP address.

Since you can potentially create many Pods that are running on many nodes, it can hard to identify them. You recognize and group Pods using string labels you specify when you define a Pod.

### The lifecycle of a Kubernetes Pod

Kubernetes Pods have a distinct lifecycle that impacts the way you deploy, run, and update Pods.

You start by submitting the Pod YAML manifest to the cluster. Once submitted and persisted to the cluster, the manifest file defines the desired state of the Pod. The Scheduler schedules the Pod to a healthy node with enough resources to run the Pod.

**[Image that shows the lifecycle of the Pod]**

Let's look at the phases in a Pods lifecycle.

|||
|---|---|
| Pending | Once scheduled, the container runtime downloads container images and starts all containers for the Pod. |
| Running | The Pod transitions to a running state once all of the resources within a Pod are ready. |
| Succeeded | The Pod transitions to a succeeded state when the Pod completed its intended task and ran successfully. |
| Failed | Pods can fail for various reasons. For example, it could be that a container in the Pod failed, and all other containers terminated, or an image wasn't found while preparing the Pod containers. In these types of cases, the Pod can go to a Failed state. Pods can transition to a failed state from both pending and running. A specific failure can also place a Pod back into the Pending phase. |
| Unknown | If the state of the Pod can't be determined, the Pod is an unknown phase. |

Pods are kept on a cluster until a controller, the control plane, or a user explicitly removes them. When a Pod is deleted and is replaced by a new Pod, the new Pod is an entirely new instance of the Pod based on the Pod manifest. The cluster doesn't save the Pod's state or dynamically assigned configuration, for example, the Pod ID or IP address. This aspect impacts how you deploy Pods and how you design your apps. For example, you can't rely on preassigned IP addresses for your Pods.

### Container states

Keep in mind that the phases are a summary of where the Pod is in its lifecycle. When you inspect Pods, there are three states the cluster use to track your containers inside the Pod.

|||
|---|---|
| Waiting | The default state of a container and the state the container is in when it's not running or terminated.|
| Running | The container is executing as expected without any problems. |
| Terminated | The computer is no longer running. This state can either be because all tasks complete or the container failed for some reason. A reason and exit code are available when debugging both cases. |
