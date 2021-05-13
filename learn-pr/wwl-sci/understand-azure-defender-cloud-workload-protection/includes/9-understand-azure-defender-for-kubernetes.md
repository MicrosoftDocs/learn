Azure Kubernetes Service (AKS) is Microsoft's managed service for developing, deploying, and managing containerized applications.

Azure Security Center and AKS form the best cloud-native Kubernetes security offering, and together they provide environment hardening, workload protection, and runtime protection as outlined below.

For threat detection for your Kubernetes clusters, enable Azure Defender for Kubernetes.  Host-level threat detection for your Linux AKS nodes is available if you enable Azure Defender for servers.

## What are the benefits of Azure Defender for Kubernetes?

Through continuous analysis of the following AKS sources, Security Center provides real-time threat protection for your containerized environments and generates alerts for threats and malicious activity detected at the host and AKS cluster level. You can use this information to quickly remediate security issues and improve the security of your containers.

Security Center provides threat protection at different levels:

- **Host level (provided by Azure Defender for servers)** - Using the same Log Analytics agent that Security Center uses on other VMs, Azure Defender monitors your Linux AKS nodes for suspicious activities, such as web shell detection and connection with known suspicious IP addresses. The agent also monitors for container-specific analytics such as privileged container creation, suspicious access to API servers, and Secure Shell (SSH) servers running inside a Docker container.

- If you choose not to install the agents on your hosts, you will only receive a subset of the threat protection benefits and security alerts. You'll still receive alerts related to network analysis and communications with malicious servers.

- **AKS cluster level (provided by Azure Defender for Kubernetes)** - At the cluster level, the threat protection is based on analyzing Kubernetes' audit logs. To enable this agentless monitoring, enable Azure Defender. To generate alerts at this level, Security Center monitors your AKS-managed services using the logs retrieved by AKS. Examples of events at this level include exposed Kubernetes dashboards, creation of high privileged roles, and creation of sensitive mounts.

## How does Security Center's Kubernetes protection work?

Below is a high-level diagram of the interaction between Azure Security Center, Azure Kubernetes Service, and Azure Policy.

You can see that the items received and analyzed by Security Center include:

- audit logs from the API server

- raw security events from the Log Analytics agent

- cluster configuration information from the AKS cluster

- workload configuration from Azure Policy (via the Azure Policy add-on for Kubernetes)

![Azure Defender Kubernetes](../media/kubernetes-service-security-center-integration-detailed.png)

