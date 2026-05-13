Contoso Retail's penetration test identified three security gaps in their Azure Kubernetes Service (AKS) environment: permanent role assignments with no expiration or approval requirement, a public API server with no source IP restrictions, and workloads running without pod isolation policies. This module addressed each gap with controls that operate across four distinct security layers.

Identity controls closed the first gap. Microsoft Entra ID integration was enabled and local accounts were disabled, ensuring all cluster authentication flows through Contoso Retail's identity governance infrastructure. Role bindings were mapped to Microsoft Entra groups, so access changes require only group membership updates rather than modifications to Kubernetes RBAC objects. Azure RBAC governs who retrieves cluster credentials from Azure; Kubernetes RBAC governs what authenticated identities can do inside the cluster.

Network controls addressed the second gap. Private clusters and authorized IP ranges limit who can reach the API server at the network layer. Kubernetes network policies replaced the default allow-all pod communication model with explicit ingress and egress rules—traffic flows only where policy permits. A dedicated egress policy blocks pod access to the Azure Instance Metadata Service, eliminating one of the most reliable paths attackers use to obtain node-level credentials.

Workload identity eliminated credential storage across the cluster. Microsoft Entra Workload ID replaced service principal secrets and static API keys with short-lived, federated tokens generated on demand. The Key Vault Secrets Store CSI Driver mounted secrets directly into pods without writing them to etcd. ACR integration removed image-pull secrets from pod specifications entirely.

Pod security standards enforced the third gap's remediation. The Restricted Pod Security Standard blocked privilege escalation, required nonroot execution, and mandated a seccomp profile at the namespace level. Security context settings in pod specifications made these constraints explicit and auditable per container. User namespaces and AppArmor profiles provided extra host isolation depth.

Each layer addressed a distinct attack surface. Together, they transformed Contoso Retail's AKS posture from permissive defaults to explicitly governed security controls that align with the security engineer's responsibilities.

## Learn more

- [Security concepts for applications and clusters in AKS](/azure/aks/concepts-security)
- [Best practices for cluster security and upgrades in AKS](/azure/aks/operator-best-practices-cluster-security)
- [Secure pod traffic with network policies in AKS](/azure/aks/use-network-policies)
- [Use Microsoft Entra Workload ID with AKS](/azure/aks/workload-identity-overview)
- [Enforce Pod Security Standards in AKS](/azure/aks/use-psa)
