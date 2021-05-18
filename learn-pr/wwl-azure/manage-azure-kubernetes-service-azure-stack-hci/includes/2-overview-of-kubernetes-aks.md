As you're exploring the principles of containerization to increase workload agility and density in Contoso's computing environment, you realize that you need to focus on container orchestration, rather than on deployment of individual containers. Although the latter offers simplicity, it lacks scalability and resiliency. In your research of container orchestration, you quickly identified Kubernetes and AKS as the most suitable candidates for your planned implementation.

## What is Kubernetes?

Kubernetes is an extensible, Linux-based, open-source platform for orchestrating containerized workloads. To ensure resiliency, a typical Kubernetes deployment consists of multiple clustered servers, which are referred to as nodes. Some of them form a control plane, responsible for managing the remaining nodes, onto which you deploy your workloads. For Kubernetes, these workloads consist of instances of containerized applications referred to as pods. 

> [!NOTE] 
> One of the core components of the control plane is API Server, which provides the interface for configuring and managing Kubernetes clusters. 

> [!NOTE] 
> A pod corresponds roughly to a container, although it can include multiple, tightly-coupled containers running on the same cluster node.

Typically, pods are stateless and do not offer any inherent resiliency features. To implement high availability and redundancy, you can provision them by using deployments. Usually, a deployment consists of multiple replicas of pods sharing the same configuration and running containers based on the same image. Kubernetes automatically manages the lifecycle of pods within a deployment, recreating any failed ones across available cluster nodes in an optimal manner. 

Deployments also streamline updates to images of containers running within pods without affecting the availability of the containerized workload. By defining disruption budgets, you control the number of pod replicas that must remain online throughout the update process. 

For direct connectivity to pods, you can implement another Kubernetes resource type known as a service. For example, a service allows you set up external, load-balanced connectivity from the internet to a web service hosted on a group of pods as part of the same deployment. 

Kubernetes offers the ability to isolate pods, services, deployments, and many other cluster components into namespaces. Namespaces form logical boundaries, which allow you to restrict access to create, view, or use cluster resources.

### What are the key benefits of Kubernetes?

Kubernetes provides a consistent management model for a multi-container environment that uses shared compute, networking, and storage resources. It offers a declarative deployment and management model, in which you describe the desired configuration and leave its implementation to the Kubernetes control plane. 

> [!NOTE] 
> With the declarative management model, you use YAML-formatted manifest files to provision, modify, and delete Kubernetes components, such as pods, services, and deployments. You can also use packaged collections of YAML files, referred to as Helm charts. Helm is a package manager for Kubernetes and facilitates deployment of more complex workloads to Kubernetes clusters.

Also, Kubernetes delivers benefits such as:

- Self-healing of pods
- Autoscaling of pods
- Autoscaling of autocluster nodes in virtualized scenarios
- Automated rolling update and rollback of pod deployments
- Auto-discovery of new pod deployments
- Load balancing across pods running the same workloads

Kubernetes allows you to treat a group of physical or virtual servers as a unified compute resource, simultaneously optimizing the servers by using the agility and density of containerized workloads. Although Kubernetes simplifies container management, its administration involves many configuration, management, and maintenance tasks:

- Aspects such as deployment, scaling, load balancing, logging, and monitoring are all optional. It is up to you to identify and implement the optimal configuration that addresses your specific needs.
- Kubernetes does not natively provide middleware, data-processing frameworks, or databases. However, you have the option of implementing any of the corresponding functionalities by using containers.
- You're responsible for maintaining your Kubernetes environment. For example, you need to manage operating system upgrades and Kubernetes upgrades. You also manage the hardware resources available to cluster nodes, such as networking, memory, and storage.

> [!NOTE] 
> Managed Kubernetes offerings, such as AKS, minimize or even eliminate some of these challenges.