Defender for Containers is designed differently for each Kubernetes environment whether they're running in:

 -  Azure Kubernetes Service (AKS) - Microsoft's managed service for developing, deploying, and managing containerized applications.<br>
 -  Amazon Elastic Kubernetes Service (EKS) in a connected Amazon Web Services (AWS) account - Amazon's managed service for running Kubernetes on AWS without needing to install, operate, and maintain your own Kubernetes control plane or nodes.<br>
 -  Google Kubernetes Engine (GKE) in a connected Google Cloud Platform (GCP) project - Google’s managed environment for deploying, managing, and scaling applications using GCP infrastructure.<br>
 -  An unmanaged Kubernetes distribution (using Azure Arc-enabled Kubernetes) - Cloud Native Computing Foundation (CNCF) certified Kubernetes clusters hosted on-premises or on IaaS.

To protect your Kubernetes containers, Defender for Containers receives and analyzes:

 -  Audit logs and security events from the API server
 -  Cluster configuration information from the control plane
 -  Workload configuration from Azure Policy
 -  Security signals and events from the node level

## Architecture for each Kubernetes environment<br>

### Architecture diagram of Defender for Cloud and AKS clusters

When Defender for Cloud protects a cluster hosted in Azure Kubernetes Service, the collection of audit log data is agentless and collected automatically through Azure infrastructure with no additional cost or configuration considerations. These are the required components in order to receive the full protection offered by Microsoft Defender for Containers:

 -  Defender agent: The DaemonSet that is deployed on each node, collects signals from hosts using the \*Extended Berkeley Packet Filter (eBPF) technology\*, and provides runtime protection. The agent is registered with a Log Analytics workspace, and used as a data pipeline. However, the audit log data isn't stored in the Log Analytics workspace. The Defender agent is deployed as an AKS Security profile.
     -  \*eBPF Background and Information\*: The Extended Berkeley Packet Filter (eBPF) is a powerful and versatile framework within the Linux kernel for programmatically analyzing and filtering network packets, as well as performing various other system-level tasks. Originally based on the Berkeley Packet Filter (BPF) introduced in the 1990s, eBPF expands upon its capabilities by allowing user-defined programs to run within the kernel, enabling dynamic and efficient packet processing without requiring modifications to the kernel itself.
     -  eBPF programs are written in a restricted subset of C and are loaded into the kernel, where they execute within a secure and sandboxed environment. This allows for a wide range of network-related tasks to be performed directly within the kernel, such as packet filtering, traffic monitoring, security enforcement, and even custom protocol parsing.
     -  One of the key advantages of eBPF is its versatility and performance. By executing within the kernel, eBPF programs can access and manipulate network packets directly, significantly reducing overhead compared to traditional user-space packet processing methods. Additionally, eBPF programs can be dynamically loaded and attached to various hooks within the kernel, allowing for real-time responsiveness and adaptability to changing network conditions.
     -  eBPF has become increasingly popular in modern networking and security applications due to its flexibility and efficiency. It is widely used in tools and frameworks for network monitoring, intrusion detection, traffic analysis, and performance tuning. Moreover, its capabilities extend beyond networking to other areas of system observability and control, making it a fundamental building block for a wide range of Linux-based applications and services.
 -  Azure Policy for Kubernetes: A pod that extends the open-source Gatekeeper v3 and registers as a web hook to Kubernetes admission control making it possible to apply at-scale enforcements, and safeguards on your clusters in a centralized, consistent manner. The Azure Policy for Kubernetes pod is deployed as an AKS add-on. It's only installed on one node in the cluster.

:::image type="content" source="../media/architecture-azure-kubernetes-service-cluster-f99dc18c.png" alt-text="Diagram showing an example of the Azure Kubernetes Service architecture.":::


### Defender agent component details

| **Pod Name**                         | **Namespace** | **Kind**   | **Short Description**                                                                                                                              | **Capabilities**                             | **Resource limits**            | **Egress Required** |
| ------------------------------------ | ------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- | ------------------------------ | ------------------- |
| microsoft-defender-collector-ds-\*   | kube-system   | DaemonSet  | A set of containers that focus on collecting inventory and security events from the Kubernetes environment.                                        | SYS\_ADMIN,<br>SYS\_RESOURCE,<br>SYS\_PTRACE | memory: 296Mi<br><br>cpu: 360m | No                  |
| microsoft-defender-collector-misc-\* | kube-system   | Deployment | A set of containers that focus on collecting inventory and security events from the Kubernetes environment that aren't bounded to a specific node. | N/A                                          | memory: 64Mi<br><br>cpu: 60m   | No                  |
| microsoft-defender-publisher-ds-\*   | kube-system   | DaemonSet  | Publish the collected data to Microsoft Defender for Containers backend service where the data will be processed for and analyzed.                 | N/A                                          | memory: 200Mi<br><br>cpu: 60m  | Https 443<br>       |

### How does agentless discovery for Kubernetes in Azure work?

The discovery process is based on snapshots taken at intervals:

:::image type="content" source="../media/diagram-permissions-architecture-ca4595b0.png" alt-text="Diagram showing an example of the kubernetes permissions architecture.":::
 When you enable the agentless discovery for Kubernetes extension, the following process occurs:

 -  **Create**:<br>
     -  If the extension is enabled from Defender CSPM, Defender for Cloud creates an identity in customer environments called CloudPosture/securityOperator/DefenderCSPMSecurityOperator.<br>
     -  If the extension is enabled from Defender for Containers, Defender for Cloud creates an identity in customer environments called CloudPosture/securityOperator/DefenderForContainersSecurityOperator.
     -  Assign: Defender for Cloud assigns a built-in role called Kubernetes Agentless Operator to that identity on subscription scope. The role contains the following permissions:
     -  AKS read (`Microsoft.ContainerService/managedClusters/read`)<br>
     -  AKS *Trusted Access* with the following permissions:
     -  `Microsoft.ContainerService/managedClusters/trustedAccessRoleBindings/write`
     -  `Microsoft.ContainerService/managedClusters/trustedAccessRoleBindings/read`
     -  `Microsoft.ContainerService/managedClusters/trustedAccessRoleBindings/delete`

 -  **Discover**: Using the system assigned identity, Defender for Cloud performs a discovery of the AKS clusters in your environment using API calls to the API server of AKS.
 -  **Bind**: Upon discovery of an AKS cluster, Defender for Cloud performs an AKS bind operation by creating a ClusterRoleBinding between the created identity and the Kubernetes ClusterRole aks:trustedaccessrole:defender-containers:microsoft-defender-operator. The ClusterRole is visible via API and gives Defender for Cloud data plane read permission inside the cluster.

## Get secure access for Azure resources in Azure Kubernetes Service by using Trusted Access (preview)

Many Azure services that integrate with Azure Kubernetes Service (AKS) need access to the Kubernetes API server. To avoid granting these services admin access or making your AKS clusters public for network access, you can use the AKS Trusted Access feature.

This feature gives services secure access to AKS and Kubernetes by using the Azure back end without requiring a private endpoint. Instead of relying on identities that have Microsoft Entra permissions, this feature can use your system-assigned managed identity to authenticate with the managed services and applications that you want to use with your AKS clusters.<br>

> [!IMPORTANT]
> AKS preview features are available on a self-service, opt-in basis. Previews are provided "as is" and "as available," and they're excluded from the service-level agreements and limited warranty. AKS previews are partially covered by customer support on a best-effort basis.

> [!NOTE]
> The Trusted Access API is generally available. We provide general availability (GA) support for the Azure CLI, but it's still in preview and requires using the aks-preview extension.

### Trusted Access feature overview

Trusted Access addresses the following scenarios:

 -  If an authorized IP range is set or in a private cluster, Azure services might not be able to access the Kubernetes API server unless you implement a private endpoint access model.
 -  Giving an Azure service admin access to the Kubernetes API doesn't follow the least privilege access best practice and can lead to privilege escalations or risk of credentials leakage. For example, you might have to implement high-privileged service-to-service permissions, and they aren't ideal in an audit review.

You can use Trusted Access to give explicit consent to your system-assigned managed identity of allowed resources to access your AKS clusters by using an Azure resource called a role binding. Your Azure resources access AKS clusters through the AKS regional gateway via system-assigned managed identity authentication. The appropriate Kubernetes permissions are assigned via an Azure resource called a role. Through Trusted Access, you can access AKS clusters with different configurations including but not limited to private clusters, clusters that have local accounts turned off, Microsoft Entra clusters, and authorized IP range clusters.

### Prerequisites<br>

 -  An Azure account with an active subscription. Create an account for free.
 -  Resource types that support system-assigned managed identity.
     -  If you're using the Azure CLI, the aks-preview extension version 0.5.74 or later is required.
 -  To learn what roles to use in different scenarios, see these articles:
     -  Azure Machine Learning access to AKS clusters with special configurations
     -  What is Azure Kubernetes Service backup?
     -  Turn on an agentless container posture

### Architecture diagram of Defender for Cloud and Arc-enabled Kubernetes clusters

These components are required in order to receive the full protection offered by Microsoft Defender for Containers:

 -  Azure Arc-enabled Kubernetes - Azure Arc-enabled Kubernetes - An agent based solution, installed on one node in the cluster, that connects your clusters to Defender for Cloud. Defender for Cloud is then able to deploy the following two agents as Arc extensions:
 -  Defender agent: The DaemonSet that is deployed on each node, collects host signals using eBPF technology and Kubernetes audit logs, to provide runtime protection. The agent is registered with a Log Analytics workspace, and used as a data pipeline. However, the audit log data isn't stored in the Log Analytics workspace. The Defender agent is deployed as an Arc-enabled Kubernetes extension.
 -  Azure Policy for Kubernetes: A pod that extends the open-source Gatekeeper v3 and registers as a web hook to Kubernetes admission control making it possible to apply at-scale enforcements, and safeguards on your clusters in a centralized, consistent manner. The Azure Policy for Kubernetes pod is deployed as an Arc-enabled Kubernetes extension. It's only installed on one node in the cluster. For more information, see Protect your Kubernetes workloads and Understand Azure Policy for Kubernetes clusters.<br>

:::image type="content" source="../media/architecture-arc-cluster-fb52bb2a.png" alt-text="Diagram showing an example of the Azure Arc-enabled architecture.":::


### Architecture diagram of Defender for Cloud and EKS clusters

When Defender for Cloud protects a cluster hosted in Elastic Kubernetes Service, the collection of audit log data is agentless. These are the required components in order to receive the full protection offered by Microsoft Defender for Containers:

 -  Kubernetes audit logs – AWS account’s CloudWatch enables, and collects audit log data through an agentless collector, and sends the collected information to the Microsoft Defender for Cloud backend for further analysis.
 -  Azure Arc-enabled Kubernetes - Azure Arc-enabled Kubernetes - An agent based solution, installed on one node in the cluster, that connects your clusters to Defender for Cloud. Defender for Cloud is then able to deploy the following two agents as Arc extensions:
 -  Defender agent: The DaemonSet that is deployed on each node, collects signals from hosts using eBPF technology, and provides runtime protection. The agent is registered with a Log Analytics workspace, and used as a data pipeline. However, the audit log data isn't stored in the Log Analytics workspace. The Defender agent is deployed as an Arc-enabled Kubernetes extension.
 -  Azure Policy for Kubernetes: A pod that extends the open-source Gatekeeper v3 and registers as a web hook to Kubernetes admission control making it possible to apply at-scale enforcements, and safeguards on your clusters in a centralized, consistent manner. The Azure Policy for Kubernetes pod is deployed as an Arc-enabled Kubernetes extension. It's only installed on one node in the cluster.

:::image type="content" source="../media/architecture-amazon-elastic-kubernetes-cluster-c8ecdcff.png" alt-text="Diagram showing an example of the Amazon Elastic Kubernetes Service architecture.":::
 How does agentless discovery for Kubernetes in AWS work?

The discovery process is based on snapshots taken at intervals:

When you enable the agentless discovery for Kubernetes extension, the following process occurs:

 -  Create:
     -  The Defender for Cloud role MDCContainersAgentlessDiscoveryK8sRole must be added to the aws-auth ConfigMap of the EKS clusters. The name can be customized.<br>
 -  Assign: Defender for Cloud assigns the MDCContainersAgentlessDiscoveryK8sRole role the following permissions:
     -  eks:UpdateClusterConfig<br>
     -  eks:DescribeCluster
 -  Discover: Using the system assigned identity, Defender for Cloud performs a discovery of the EKS clusters in your environment using API calls to the API server of EKS.

### Architecture diagram of Defender for Cloud and GKE clusters

When Defender for Cloud protects a cluster hosted in Google Kubernetes Engine, the collection of audit log data is agentless. These are the required components in order to receive the full protection offered by Microsoft Defender for Containers:

 -  Kubernetes audit logs – GCP Cloud Logging enables, and collects audit log data through an agentless collector, and sends the collected information to the Microsoft Defender for Cloud backend for further analysis.
 -  Azure Arc-enabled Kubernetes - Azure Arc-enabled Kubernetes - An agent based solution, installed on one node in the cluster, that connects your clusters to Defender for Cloud. Defender for Cloud is then able to deploy the following two agents as Arc extensions:
 -  Defender agent: The DaemonSet that is deployed on each node, collects signals from hosts using eBPF technology, and provides runtime protection. The agent is registered with a Log Analytics workspace, and used as a data pipeline. However, the audit log data isn't stored in the Log Analytics workspace. The Defender agent is deployed as an Arc-enabled Kubernetes extension.
 -  Azure Policy for Kubernetes: A pod that extends the open-source Gatekeeper v3 and registers as a web hook to Kubernetes admission control making it possible to apply at-scale enforcements, and safeguards on your clusters in a centralized, consistent manner. The Azure Policy for Kubernetes pod is deployed as an Arc-enabled Kubernetes extension. It only needs to be installed on one node in the cluster.

:::image type="content" source="../media/architecture-google-kubernetes-engine-968f94b9.png" alt-text="Diagram showing an example of the Google Kubernetes Engine architecture cluster.":::


### How does agentless discovery for Kubernetes in GCP work?

The discovery process is based on snapshots taken at intervals:

When you enable the agentless discovery for Kubernetes extension, the following process occurs:

 -  Create:
     -  The service account mdc-containers-k8s-operator is created. The name can be customized.
 -  Assign: Defender for Cloud attaches the following roles to the service account mdc-containers-k8s-operator:
     -  The custom role MDCGkeClusterWriteRole, which has the container.clusters.update permission
     -  The built-in role container.viewer
 -  Discover: Using the system assigned identity, Defender for Cloud performs a discovery of the GKE clusters in your environment using API calls to the API server of GKE.
