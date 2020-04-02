There are several Kubernetes configuration concepts that needs consideration when you deploy applications to Kubernetes.

Let's review the drone the components of the drone tracking application. There is:

- A public tracking website
- A private in-memory cache services
- A public RESTFul API
- A private persisted queue
- A private data processing service
- A private NoSQL database

Each of these services has requirements in terms of user network access, inter-process network access and data storage. Let's have a brief look at networking and storage options with Kubernetes before we look at Pod deployment options.

## Kubernetes Networking

Part of the installation choices you make when installing a Kubernetes cluster is choosing a cluster networking solution. Let's explore why cluster networking is essential to use and how it impacts your tracking application.

Assume you have a cluster with one master and two nodes. When you add nodes to Kubernetes, an IP address gets automatically assigned to each node from an internal private network range.

[Image of simple cluster configuration]

Each node in the cluster is assigned an IP address from your example local network range 192.168.1.0/24.

Each Pod that you deploy gets assigned an IP from a pool of IP addresses, in your example, the 10.32.0.0/12 network range.

10.32.0.94    clusters01
10.42.0.14    clusters02

Recall from earlier that Pods are transient. The Pod IP address is also temporary and can't be used to reconnect to a newly created Pod. This configuration impacts on how your application communicates with its internal components and how you and services interact with it externally.

To simplify communication, Kubernetes expects you to configure networking in such a way that all:

pods can communicate with one another across nodes without Network Address Translation (NAT)
nodes can communicate with all Pods and vice-versa without NAT
agents on a node can communicate with all nodes and pods.

It's your responsibility to install a networking solution when you set up your Kubernetes cluster. However, Kubernetes does not specify a preferred networking solution, and there are several options available. For example, Antrea, Cisco Application Centric Infrastructure (ACI), Cilium, Flannel, Kubenet, VMware NSX-T, Weave Net, and so on. Cloud providers may also provide their networking solutions, for example, Azure Kubernetes Service (AKS) support Azure Virtual Network container network interface (CNI) by default. AKS does however also support the Kubenet, Flannel, Cilium, and Antrea network plugins.

Each of these solutions has its strengths that you can leverage. See the learn more section at the end of the module to learn more.

## Services

We use Kubernetes Services to enable communication between nodes, pods, and users of your application, both internal and external, to your cluster. A Service is a Kubernetes object that provides stable networking for Pods.

A Service, just like a node or Pod, gets an IP address assigned by Kubernetes when you create them. These addresses get assigned from a service cluster IP range, in your example, 10.96.0.0/12. A Service is also assigned a DNS name based on the service name, and an IP port.

In your example, the front-end, back-end, and worker components need to interact with each other. The website and API must be accessible to users outside of the cluster. Both the database servers need to be available to the front-ends, but not to external users. Keep in mind that Pod IP addresses change as controllers recreate them, and you may have any number of pods running.

To support these scenarios, you can configure three types of services to expose your app's components.

|||
|---|---|
| **ClusterIP** | The address assigned to a service that makes the Service available to a set of services inside the cluster. For example, communication between the front and back-end components of your application. |
| **NodePort** | The Kubernetes control plane assigns a node port, between 30000 and 32767, to the Service. For example, 192.169.1.11 on clusters01. You then configure the Service with a target port on the Pod you want to expose. For example, port 80 on the Pod running one of the front-ends. You can now access the front end through a node IP and port address.  |
| **LoadBalancer** | Allows for the distribution of load between nodes running your application and exposing Pod to public network access. You typically configure load balancers when you use cloud providers. In this case, traffic from the external load balancer is directed to the Pods running your application. | 

In the drone tracking application, you'll expose all public applications by using LoadBalancer services. For example, the tracking website and the RESTFul API.

You'll then configure all other components that require private network access using ClusterIP services.

### How to group Pods

Services allow you to target specific components in your cluster by using a selector value. The selector matches the Pod label you define when you create the Pod's definition file.

**[Image of Service with labels]**

For example, assume you have many running pods. Only a few of these are front-end pods. You can apply your Service to expose these pods by referencing the Pod label as a Selector value in the Service's definition file. The Service will now effectively group only these Pods that match the label.

## Kubernetes Storage

Kubernetes makes use of the same storage volume concept that you find when using Docker. Docker volumes are less managed than the Kubernetes volumes as Docker volume lifetimes are not managed. The Kubernetes volume's lifetime is an explicit lifetime that matches the Pod's lifetime. This means that a volume outlives the containers that run in the Pod. However, if the Pod is removed, so is the volume.

Kubernetes provides options to provision persistent storage with the use of *PersistentVolumes*. You're also allowed to request specific storage for Pods by using *PersistentVolumeClaims*.

Both of these options are considerations that you'll have to take into mind when deploying the tracking solution's private persisted queue and NoSQL database.

In a cloud environment, such as Azure, you have access to components outside of the Kubernetes cluster, such as Azure Service Bus Messaging and Azure Cosmos DB. Switching to these solutions can simplify the management deployment of your application.

## Pod deployment

The drone tracking application has several components that are deployed separately from each other. It's your job to configure deployments for these components on the cluster using the Kubernetes `kubectl` command-line application.

### What is kubectl?

`kubectl` is the Kubernetes command-line tool that you use to manage your cluster. You use `kubectl` to send commands to the cluster's control plane via the API server. The tool uses a configuration file to identify a *Cluster*, a *User*, and a *Context*.

The *Cluster* configuration allows you to specify a cluster name, certificate information, and the service API endpoint associated with the cluster. This definition enables you to connect from a single workstation to multiple clusters.

The *User* configuration allows you to specify the users and their permissions levels when accessing the configured clusters.

The *Context* configuration allows you to group clusters and users using a friendly name. For example, you may have a 'dev-cluster' and a 'prod-cluster' to identify your development and production clusters.

## Pod deployment options

There are several options to manage the deployment of Pods in a Kubernetes cluster when using `kubectl`. You can use any of four object type definitions to deploy a Pod or Pods. These files make use of YAML to describe the intended state of the Pod or Pods that will be deployed.

### Pod templates

You use a Pod template to deploy pods manually. Keep in mind that a manually deployed Pod does not get relaunched after it fails, gets deleted, or terminates.

### Replication Controllers

A Replication Controller uses Pod templates and defines a specified number of pods that must run. The controller helps you run multiple instances of the same Pod and ensures that the number of Pods specified is always running on one or more nodes in the cluster. A Replication Controller will replace pods launched in this way with new pods if they fail, are deleted or terminated.

### Replica Sets

Replica Sets replaces the Replication Controller in terms of the preferred way to deploy replicas. A Replica Set includes the same functionality as a Replication Controller. However, it includes an extra configuration option to include a selector value.

**[Diagram that shows five Pods group with a Selector in a Node.]**

A Selector allows the Replica Set to identify all the Pods running underneath it. This feature allows you to manage Pods labeled with the same value as the selector value, but not created with the replicate set.

### Deployments

A Deployment creates a management object one lever higher than a Replica Set. The deployment management updates allow you to manage how you update Pods in a cluster.

**[Diagram that shows five Pods running on a Node with the same Pod version.]**

Assume you have five instances of your application deployed in your cluster. There are five pods running version 1.0 of your application. If you decide to update your application manually, you can terminate all Pods and then launch new Pods running version 1.1 of your application. With this strategy, you're your application will experience downtime.

**[Diagram that shows five Pods running on a Node with two of the same version and tree with a later version.]**

What you instead want to do is execute a rolling update where you launch Pods running the new version of your application before you terminate the Pods running the older version of your application. Rolling updates will launch one Pod at a time instead of taking down all the older Pods at once. Deployments honor the number of replicas configured in the replica set information section. It will make sure to maintain that the amount of Pods specified in the Replica Set as it terminates old Pods and launches new Pods.

Deployments, by default, provide a rolling update strategy when updating Pods. You also have the option to use a recreate strategy. This strategy will terminate Pods before launching new Pods.

Deployments also provide you with a rollback strategy, which you can execute using `kubectl`.

Deployments make use of YAML-based definition files and make it easy to manage deployments. Keep in mind that deployments allow you to apply any changes to your cluster. For example, deploy new versions of an app, updating labels, running other replicas of your Pods, and so on.

`kubectl` has convenient syntax to create a deployment automatically when using the `kubectl run` command to deploy a Pod. This command creates a deployment with the required replica set and pods. However, the command doesn't create a definition file. A best practice is to manage all deployments with deployment definition files and track changes using a version control system.

### Helm

Alternatively, you can use package managers like Helm to deploy Kubernetes Pods. Helm helps you to define, install, and upgrade your Kubernetes apps by using Helm charts. A Helm chart is a collection of files that describes a group of Kubernetes resources, for example, a website and its related database and supporting services. You'll typically use Helm to deploy 3rd party applications. However, nothing prevents you from creating a Helm chart for your deployments.
