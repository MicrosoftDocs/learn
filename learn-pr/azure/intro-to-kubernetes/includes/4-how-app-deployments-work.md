Several Kubernetes configuration concepts need consideration when you deploy applications to Kubernetes.

For example, the drone tracking application has several services. These services include:

- public tracking website
- private in-memory cache service
- public RESTful API
- private persisted queue
- private data processing service
- private NoSQL database

Each of these services has requirements for user network access, inter-process network access, and data storage. Let's have a look at networking and storage options with Kubernetes before we look at pod deployment options.

## Kubernetes Networking

Part of the installation choices you make when installing a Kubernetes cluster is choosing a cluster networking solution.

Assume you have a cluster with one master and two nodes. When you add nodes to Kubernetes, an IP address gets automatically assigned to each node from an internal private network range. For example, assume your local network range is 192.168.1.0/24.

:::image type="content" source="../media/4-nodes-assigned-ip-addresses-tmp.svg" alt-text="Diagram of nodes with assigned IP addresses in cluster." border="false":::

Each pod that you deploy gets assigned an IP from a pool of IP addresses. For example, assume your configuration uses the 10.32.0.0/12 network range.

:::image type="content" source="../media/4-nodes-pods-assigned-ip-addresses-tmp.svg" alt-text="Diagram of nodes and pods with assigned IP addresses in cluster." border="false":::

By default the pods and nodes can't communicate with each other using theses different IP address ranges.

To further complicate matters, recall that pods are transient. The pod IP address is temporary and can't be used to reconnect to a newly created pod. This configuration impacts on how your application communicates with its internal components and how you and services interact with it externally.

To simplify communication, Kubernetes expects you to configure networking in such a way that:

- pods can communicate with one another across nodes without Network Address Translation (NAT)
- nodes can communicate with all pods and vice-versa without NAT
- agents on a node can communicate with all nodes and pods

Kubernetes offers several networking options you can install to configure networking. For example, Antrea, Cisco Application Centric Infrastructure (ACI), Cilium, Flannel, Kubenet, VMware NSX-T, Weave Net, and so on.  

Cloud providers may also provide their networking solutions. For example, Azure Kubernetes Service (AKS) supports the Azure Virtual Network container network interface (CNI) in addition to the Kubenet, Flannel, Cilium, and Antrea.

## Services

A Service is a Kubernetes object that provides stable networking for pods. A Kubernetes Service enables communication between nodes, pods, and users of your application, both internal and external, to the cluster.

Kubernetes assigns a Service an IP address on creation just like a node or pod. These addresses get assigned from a service cluster IP range. For example, 10.96.0.0/12. A Service is also assigned a DNS name based on the service name, and an IP port.

In the drone tracking application, network communication is as follows:

- The website and RESTful API is accessible to users outside of the cluster

- The in-memory cache and message queue services are accessible to the front-end and RESTFul API respectively, but not to external users

- The message queue needs access to the data processing service, but not to external users

- The NoSQL database is accessible to the in-memory cache and data processing service, but not to external users

To support these scenarios, you can configure three types of services to expose your app's components.

|||
|---|---|
| **ClusterIP** | The address assigned to a service that makes the Service available to a set of services inside the cluster. For example, communication between the front and back-end components of your application. |
| **NodePort** | The Kubernetes control plane assigns a node port, between 30000 and 32767, to the Service. For example, 192.169.1.11 on clusters01. You then configure the Service with a target port on the pod you want to expose. For example, port 80 on the pod running one of the front-ends. You can now access the front end through a node IP and port address.  |
| **LoadBalancer** | Allows for the distribution of load between nodes running your application and exposing pod to public network access. You typically configure load balancers when you use cloud providers. In this case, traffic from the external load balancer is directed to the pods running your application. |

In the drone tracking application, you'll expose all public applications by using LoadBalancer services. For example, the tracking website and the RESTful API.

You'll then configure all other components that require private network access using ClusterIP services.

### How to group pods

Pod IP addresses change as controllers recreate them, and you may have any number of pods running. Managing pods by IP address isn't practical.

A Service allows you to target and manage specific pods in your cluster by using selector labels. You set the selector label in a service definition to match the pod label defined in the pod's definition file.

:::image type="content" source="../media/4-service-with-selector-tmp.svg" alt-text="Diagram of Service with selector labels." border="false":::

For example, assume you have many running pods. Only a few of these are front-end pods and you want to set a LoadBalancer service that targets only the front-end pods. You can apply your Service to expose these pods by referencing the pod label as a Selector value in the Service's definition file. The Service will now  group only these pods that match the label. If a pod gets removed and recreated, the new pod is automatically added to the service group using its matching label.

## Kubernetes Storage

Kubernetes makes use of the same storage volume concept that you find when using Docker. Docker volumes are less managed than the Kubernetes volumes as Docker volume lifetimes are not managed. The Kubernetes volume's lifetime is an explicit lifetime that matches the pod's lifetime. This lifetime match means that a volume outlives the containers that run in the pod. However, if the pod is removed, so is the volume.

Kubernetes provides options to provision persistent storage with the use of *PersistentVolumes*. You're also allowed to request specific storage for pods by using *PersistentVolumeClaims*.

Both of these options are considerations that you'll have to take into mind when deploying the tracking solution's private persisted queue and NoSQL database.

In a cloud environment, such as Azure, you have access to components outside of the Kubernetes cluster, such as Azure Service Bus Messaging and Azure Cosmos DB. Switching to these solutions can simplify the management deployment of your application.

## Pod deployment

The drone tracking application has several components that are deployed separately from each other. It's your job to configure deployments for these components on the cluster using the Kubernetes `kubectl` command-line application.

### What is `kubectl`?

`kubectl` is the Kubernetes command-line tool that you use to manage your cluster. You use `kubectl` to send commands to the cluster's control plane via the API server. The tool uses a configuration file to identify a *Cluster*, a *User*, and a *Context*.

The *Cluster* configuration allows you to specify a cluster name, certificate information, and the service API endpoint associated with the cluster. This definition enables you to connect from a single workstation to multiple clusters.

The *User* configuration allows you to specify the users and their permissions levels when accessing the configured clusters.

The *Context* configuration allows you to group clusters and users using a friendly name. For example, you may have a 'dev-cluster' and a 'prod-cluster' to identify your development and production clusters.

## Pod deployment options

There are several options to manage the deployment of pods in a Kubernetes cluster when using `kubectl`. You can use any of four object type definitions to deploy a pod or pods. These files make use of YAML to describe the intended state of the pod or pods that will be deployed.

### Pod templates

You use a pod template to deploy pods manually. Keep in mind that a manually deployed pod doesn't get relaunched after it fails, gets deleted, or terminates.

### Replication Controllers

A Replication Controller uses pod templates and defines a specified number of pods that must run. The controller helps you run multiple instances of the same pod and ensures that the number of pods specified is always running on one or more nodes in the cluster. A Replication Controller will replace pods launched in this way with new pods if they fail, are deleted or terminated.

For example, assume you deploy the drone tracking front-end website and users start accessing the website. If all the pods fail for any reason, the website is unavailable to your users unless you launch new pods. A Replication Controller helps you make sure your website is always available.

### Replica Sets

Replica Sets replaces the Replication Controller in terms of the preferred way to deploy replicas. A Replica Set includes the same functionality as a Replication Controller. However, it includes an extra configuration option to include a selector value.

A Selector allows the Replica Set to identify all the pods running underneath it. This feature allows you to manage pods labeled with the same value as the selector value, but not created with the replicate set.

### Deployments

A Deployment creates a management object one lever higher than a Replica Set. The deployment management updates allow you to manage how you update pods in a cluster.

Assume you have five instances of your application deployed in your cluster. There are five pods running version 1.0.0 of your application.

:::image type="content" source="../media/4-pods-running-same-version-tmp.svg" alt-text="Diagram that shows five pods running on a node with the same pod version." border="false":::

If you decide to update your application manually, you can terminate all pods and then launch new pods running version 2.0.0 of your application. With this strategy, your application will experience downtime.

What you instead want to do is execute a rolling update where you launch pods running the new version of your application before you terminate the pods running the older version of your application. Rolling updates will launch one pod at a time instead of taking down all the older pods at once. Deployments honor the number of replicas configured in the replica set information section. It will make sure to maintain that the amount of pods specified in the Replica Set as it terminates old pods and launches new pods.

:::image type="content" source="../media/4-pods-running-different-version-tmp.svg" alt-text="Diagram that shows five pods running on a node with two of the same version and tree with a later version." border="false":::

Deployments, by default, provide a rolling update strategy when updating pods. You also have the option to use a recreate strategy. This strategy will terminate pods before launching new pods.

Deployments also provide you with a rollback strategy, which you can execute using `kubectl`.

Deployments make use of YAML-based definition files and make it easy to manage deployments. Keep in mind that deployments allow you to apply any changes to your cluster. For example, deploy new versions of an app, updating labels, running other replicas of your pods, and so on.

`kubectl` has convenient syntax to create a deployment automatically when using the `kubectl run` command to deploy a pod. This command creates a deployment with the required replica set and pods. However, the command doesn't create a definition file. A best practice is to manage all deployments with deployment definition files and track changes using a version control system.

### Helm

Alternatively, you can use package managers like Helm to deploy Kubernetes pods. Helm helps you to define, install, and upgrade your Kubernetes apps by using Helm charts. A Helm chart is a collection of files that describes a group of Kubernetes resources, for example, a website and its related database and supporting services. You'll typically use Helm to deploy third-party applications. However, nothing prevents you from creating a Helm chart for your deployments.
