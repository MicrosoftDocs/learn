In this unit, you learn about Kubernetes, and about the architecture and benefits of Azure Arc-enabled Kubernetes.

## Kubernetes

Kubernetes is an extensible open-source platform for orchestrating containerized workloads. To ensure resiliency, each Kubernetes deployment consists of multiple, clustered server nodes. Some servers are control plane nodes that manage the other worker nodes.

The worker nodes host containerized workloads as Kubernetes pods. A pod roughly corresponds to a container, although it can include multiple tightly coupled containers that run on the same node.

Besides container-based isolation, Kubernetes can also isolate pods and other resources like deployments into namespaces. Namespaces form logical boundaries to provide isolation between users and external applications that access different containerized workloads. Namespaces also let you restrict permissions to create, view, or manage resources within a cluster.

### Kubernetes benefits

Kubernetes abstracts away the complexity of a multicontainer environment combining compute, networking, and storage components that hundreds or thousands of containers might rely on. The Kubernetes declarative management model describes the desired target configuration and leaves its implementation details to the Kubernetes control plane.

Kubernetes lets you treat your datacenter as a unified compute resource. You don't have to worry about how and where you deploy your containers, only about deploying and scaling your apps as needed.

### Kubernetes challenges

Kubernetes is a highly customizable orchestration platform that requires proper configuration, management, and maintenance.

Capabilities like deployment, scaling, load balancing, logging, and monitoring are all optional. It's up to you to identify and implement the optimal configuration that addresses your specific needs.

You're responsible for maintaining your Kubernetes environment. For example, you need to manage operating system and Kubernetes upgrades. You must also manage the hardware resources available to cluster nodes, such as networking, memory, and storage.

Managed Kubernetes offerings, such as Azure Kubernetes Service (AKS), can minimize or eliminate some of these challenges.

## Azure Arc-enabled Kubernetes

Azure Arc-enabled Kubernetes allows you to attach Kubernetes clusters running anywhere so that you can manage and configure them in Azure. 

Azure Arc uses locally installed agents to establish a trusted channel with Azure. The connection to Azure requires deploying several agents as pods within a dedicated azure-arc namespace in the Kubernetes cluster. These agents maintain a connection to Azure and synchronize cluster state and metadata with the corresponding Azure resource.

Azure Arc-enabled Kubernetes works with any Cloud Native Computing Foundation (CNCF) certified Kubernetes clusters. This includes clusters running on other public cloud providers (such as GCP or AWS) and clusters running on your on-premises data center (such as VMware vSphere or Azure Stack HCI). 

### Azure Arc-enabled Kubernetes benefits

In addition to the general Azure Arc benefits described in the previous unit, Azure Arc-enabled Kubernetes offers the following capabilities:

- Single control plane to manage all Kubernetes resources across multicloud/hybrid environments.
- Arc-enabled Kubernetes clusters as a platform to host Azure services.
- Enhanced support for deploying applications by using GitOps. GitOps enables automatic deployment of configurations that describe the desired state of Kubernetes clusters. You can enforce specific GitOps-based configurations by using Azure Policy.
- Enforcement of runtime policies that affect the cluster and its pods by using Azure Policy for Kubernetes and centralized policy compliance reporting. For example, you can enforce the use of HTTPS for ingress traffic that targets your Azure Arc-enabled Kubernetes clusters, or ensure that containers listen only on specific ports.
- Use of Azure Monitor container insights to monitor containers.

You’ll learn more about these features in the remaining units of this module.
