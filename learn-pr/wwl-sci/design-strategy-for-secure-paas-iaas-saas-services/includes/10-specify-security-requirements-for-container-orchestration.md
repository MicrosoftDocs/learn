
The application that manages the containers is called a container
orchestrator. The process of orchestration typically involves tooling
that can automate all aspects of application management from initial
placement, scheduling, and deployment to steady-state activities, such
as deployment, update, and health monitoring functions that support
scaling and failover.

Kubernetes, the most popular container orchestration system and one of
the fastest-growing projects in the history of open source, has become a
significant part of many companies' compute stack. The Azure platform
has three services that make it easy to deploy and manage Kubernetes
clusters. The services are Azure Kubernetes managed Service (AKS), Azure
Container Service Engine (ACS-engine), and Azure Container Instance.
Kubernetes is a popular solution and has a strong developer community.
The application has been proven at scale and is evolving constantly. It
is the only orchestrator that has cloud-provider concept natively, which
allows seamless integration into public clouds, such as Microsoft Azure,
Amazon Web Services, and Google Cloud Platform.

While Kubernetes has many advantages, it also brings new security
challenges that should be considered. Therefore, it's crucial to
understand the various security risks that exist in containerized
environments, and specifically in Kubernetes.

When you enable Microsoft Defender for Containers, Azure Kubernetes
Service clusters, and Azure Arc enabled Kubernetes clusters (Preview)
protection are both enabled by default. You can configure your
Kubernetes data plane hardening when you enable Microsoft Defender for
Containers. The security recommendations will appear in Defender for
Cloud dashboard as shown below:

:::image type="content" source="../media/security-recommendations.png" alt-text="Screenshot showing security recommendations in the Microsoft Defender for Cloud dashboard." lightbox="../media/security-recommendations.png":::

When Defender for Cloud protects a cluster hosted in Azure Kubernetes
Service, the collection of audit log data is agentless and frictionless.
The Defender profile deployed to each node provides the runtime
protections and collects signals from nodes. The Azure Policy add-on for
Kubernetes collects cluster and workload configuration for admission
control policies as explained in Protect your Kubernetes workloads. The
diagram below provides an overview of this solution:

:::image type="content" source="../media/azure-kubernetes-service-cluster.png" alt-text="Diagram that shows securing an Azure Kubernetes Service Cluster with Microsoft Defender for Cloud." lightbox="../media/azure-kubernetes-service-cluster.png":::

-   Defender profile includes a *DaemonSet*, which is a set of containers that focus on collecting inventory and security events from the Kubernetes environment.
-   Gatekeeper, Azure Policy, which is the admission controller webhook for Open Policy Agent (OPA), to apply at-scale enforcements and safeguards on your clusters in a centralized, consistent manner.