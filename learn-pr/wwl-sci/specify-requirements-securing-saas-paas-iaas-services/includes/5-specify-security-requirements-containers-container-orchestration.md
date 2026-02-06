Organizations increasingly adopt containers and container orchestration platforms to modernize application deployment. As a security architect, you must specify requirements that protect the container lifecycle from image creation through runtime operation, while addressing the unique security challenges these platforms introduce.

## Cluster identity and access control requirements

Access control for container orchestration platforms must address both the management plane and the data plane. Security architects should specify requirements for identity integration and role-based access.

For cluster authentication specifications, require integration with Microsoft Entra ID to leverage your organization's existing identity governance. This integration enables conditional access policies, multifactor authentication, and centralized identity management for cluster administrators and developers.

For authorization requirements, implement a layered approach. Kubernetes role-based access control (RBAC) governs access to Kubernetes resources like pods, deployments, and namespaces. Azure RBAC manages Azure-level operations such as cluster scaling, upgrades, and credential retrieval. Require separation of these permission sets based on the principle of least privilege.

Specify requirements for service account management. Default service accounts should have minimal permissions. Workloads requiring Azure resource access must use workload identities, which replace legacy pod-managed identity with a more secure federated token-based approach for authenticating pods to Azure services.

## Network security requirements

Container orchestration platforms require network security at multiple layers. Traditional network security groups filter traffic at the infrastructure level, but container platforms need additional controls.

Specify requirements for API server protection. Private clusters restrict API server access to private endpoints within your virtual network, eliminating public internet exposure. For scenarios requiring public access, define authorized IP ranges that can communicate with the API server.

Container-to-container communication requires network policies. By default, all pods can communicate freely within a cluster. Network policies define rules that restrict traffic between pods based on labels, namespaces, or ports. Specify a default-deny posture with explicit allow rules for required communication paths.

For network policy implementation, specify the policy engine. Options include Cilium for clusters using Azure CNI Powered by Cilium, Azure Network Policy Manager, or Calico. Cilium provides the most efficient enforcement using Linux Berkeley Packet Filter technology and enables Layer 7 policies for application-layer traffic control.

## Container image security requirements

Images represent the foundation of container security. Specification requirements should address image sources, vulnerability management, and registry security.

Require that all images deploy from trusted, private registries. Azure Container Registry with token-based authentication or managed identity integration provides secure image storage. Specify private endpoints for registry access to eliminate public network exposure.

Image vulnerability scanning must occur at multiple stages. Registry scanning evaluates images on push and continuously while stored. CI/CD pipeline scanning identifies vulnerabilities before images reach the registry. Runtime scanning detects vulnerabilities in running containers. Specify vulnerability severity thresholds that block deployment of images containing critical or high-severity vulnerabilities.

Define image provenance requirements. Only signed images from approved sources should deploy to production clusters. Implement admission controllers that validate image signatures and enforce approved registry policies.

## Runtime threat protection requirements

Container runtime environments require continuous monitoring for threats and anomalous behavior. Specify requirements for detection and response capabilities.

Microsoft Defender for Containers provides comprehensive runtime protection. Specify requirements for the Defender sensor deployment, which collects telemetry including Kubernetes events, process execution, and network activity. The sensor enables detection of over 60 threat scenarios aligned with the MITRE ATT&CK matrix for containers.

Require security posture management capabilities that evaluate cluster configurations against the Microsoft Cloud Security Benchmark and CIS Kubernetes Benchmark. Specify automated remediation for misconfigurations where possible, with alerting for issues requiring manual intervention.

Gated deployment capabilities prevent vulnerable or misconfigured workloads from reaching clusters. Specify admission control policies that validate security requirements before workload deployment. Azure Policy for Kubernetes provides these controls through integration with the Gatekeeper admission controller.

## Pod security requirements

Pod configurations directly impact container security posture. Specify requirements using Pod Security Standards to restrict privileged operations.

The three Pod Security Standards levels provide a framework for specification. The Privileged level allows unrestricted pod configurations for system workloads. The Baseline level prevents known privilege escalations for most applications. The Restricted level enforces hardening best practices for security-sensitive workloads.

Specify Pod Security Admission enforcement at the namespace level. Require the Restricted level for production namespaces containing sensitive workloads. Allow Baseline for development environments while requiring Privileged only for explicitly approved system components.

Define requirements for container runtime security contexts. Specify that containers must not run as root unless explicitly required and approved. Require read-only root filesystems where possible. Restrict containers from mounting sensitive host paths or acquiring additional capabilities.

## Summary of key security requirements

When specifying container and orchestration security requirements, prioritize:

- Microsoft Entra ID integration with Kubernetes RBAC for identity and access control
- Private clusters with network policies enforcing default-deny communication
- Private container registries with vulnerability scanning at all lifecycle stages
- Defender for Containers for runtime threat detection and security posture management
- Pod Security Standards enforcing baseline or restricted configurations

These requirements establish a defense-in-depth approach protecting containers from supply chain attacks through runtime threats.
