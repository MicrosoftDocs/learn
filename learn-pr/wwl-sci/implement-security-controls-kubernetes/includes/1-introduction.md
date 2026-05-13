Kubernetes gives development teams a consistent platform for deploying containerized workloads. That consistency also means that a single misconfiguration in the cluster's security posture can expose every workload running on it. Contoso Retail's Azure Kubernetes Service (AKS) environment reflects a pattern common to organizations that adopted Kubernetes quickly and addressed security incrementally: the clusters run, and the vulnerabilities are silent.

A penetration test against Contoso Retail's production AKS environment identified three independent but compounding security gaps in the same cluster. Cluster access is granted through permanent role assignments with no expiration or approval requirement—a developer's compromised credentials provide persistent cluster access with no natural time limit. The API server is publicly accessible with no source IP restrictions, so an attacker with valid credentials can reach it from anywhere on the internet. Workloads run without pod security policies, leaving a compromised pod free to query the node's Instance Metadata Service, access the host file system, or escalate privileges.

None of these failures surface as errors during normal operations. They become visible only when exploited.

AKS security operates in three distinct layers. Identity controls determine who can authenticate to the cluster and what actions they're authorized to take. Network controls determine what traffic can reach the API server and what traffic can flow between pods. Workload security controls determine what containerized processes can do at runtime—whether they can run as root, modify the file system, or access host resources.

This module addresses each layer in sequence, mapping to the gaps the penetration test identified.

By the end of this module, you're able to configure Microsoft Entra ID integration and RBAC for cluster authentication and authorization, enforce network policies and private cluster access, apply workload identity to eliminate credential exposure, and use pod security standards to restrict container privileges.

## Learning objectives

After completing this module, you'll be able to:

- Configure Microsoft Entra ID integration and RBAC for AKS API server authentication and authorization
- Implement network security controls including private clusters, authorized IP ranges, and network policies
- Apply workload identity and managed identities to eliminate credential management for AKS workloads
- Enforce pod security standards and container access restrictions
