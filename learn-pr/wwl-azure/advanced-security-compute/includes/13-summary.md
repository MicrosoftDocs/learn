In this module, you learned how to plan and implement advanced security measures for Azure compute resources to protect against vulnerabilities and evolving security threats.

## Key learnings

You explored comprehensive security strategies across multiple Azure compute services:

### Secure remote access
- **Azure Bastion** provides secure RDP/SSH access without exposing virtual machines to the public internet, with four SKU tiers:
  - **Developer SKU**: Cost-effective option for dev/test scenarios (two concurrent connections)
  - **Basic SKU**: Standard secure remote access (no native client support)
  - **Standard SKU**: Enhanced features including native client support and shareable links
  - **Premium SKU**: Advanced capabilities including session recording, private-only deployment, and custom port support
- **Just-in-time (JIT) VM access** reduces attack surfaces by providing time-limited access to virtual machines

### Azure Kubernetes Service (AKS) security
- **Workload identity** with OIDC federation provides secure authentication to Azure resources (replaces deprecated pod-managed identity)
- **Network isolation** through network policies controls pod-to-pod communication
- **Pod Security Standards** enforce security policies at the pod level
- **AKS Automatic** offers simplified, production-ready cluster configuration
- **Azure Linux 3** should be used as Azure Linux 2.0 support ends November 30, 2025

### Container security and monitoring
- **Microsoft Defender for Containers** provides comprehensive threat protection across five core domains:
  - Cloud security posture management
  - Vulnerability assessment powered by Microsoft Defender Vulnerability Management (MDVM)
  - Run-time threat detection
  - Kubernetes environment hardening
  - Software supply chain protection
- **Container insights** (a feature of Azure Monitor) provides performance and health monitoring for container workloads
- **Gated deployment** (GA) prevents vulnerable images from being deployed to production
- **Runtime container scanning** (GA) provides continuous vulnerability assessment

### Container registry security
- **Azure Container Registry (ACR)** supports seven built-in RBAC roles for granular access control
- **Authentication methods** include Microsoft Entra identities, repository-scoped permissions, and admin accounts
- **Integration with Microsoft Entra ID** enables centralized identity management

### Data protection
- **Azure Disk Encryption (ADE)** uses BitLocker (Windows) and dm-crypt (Linux) to encrypt VM disks
- **Encryption at host** provides end-to-end encryption for VM data
- **Confidential disk encryption** protects sensitive workloads with hardware-based security
- **Azure Key Vault** serves as centralized key and certificate management
- **Envelope encryption** with DEK/KEK hierarchy provides layered data protection

### API security
- **Azure API Management** security baseline aligns with Microsoft Cloud Security Benchmark (v2 preview available)
- **Virtual Network integration** enables internal or external network configurations
- **Private endpoints** provide secure access without public exposure
- **Microsoft Entra ID integration** enables OAuth 2.0 authentication for APIs
- **Managed identities** simplify secure access to Azure resources like Key Vault

## Best practices applied

Throughout this module, you learned to apply security best practices:

- Use **workload identity** instead of deprecated pod-managed identity for AKS authentication
- Enable **Microsoft Entra ID** authentication over local authentication methods wherever possible
- Implement **least privilege access** using Azure RBAC for granular permission control
- Use **managed identities** to avoid storing credentials in code or configuration
- Enable **encryption at rest** and **encryption in transit** for all sensitive data
- Deploy **private endpoints** to keep traffic off the public internet
- Monitor with **Microsoft Defender for Containers** and **Container insights** for comprehensive visibility
- Apply **network policies** to enforce micro-segmentation in AKS clusters
- Store **secrets and keys in Azure Key Vault** rather than in application code
- Use **Azure Policy** to enforce security configurations across resources

## Next steps

To continue strengthening your Azure security expertise:

- Explore [Microsoft Defender for Cloud](/azure/defender-for-cloud/) for unified security management
- Review [Azure security baselines](/security/benchmark/azure/security-baselines-overview) for service-specific guidance
- Implement [Microsoft Cloud Security Benchmark](/security/benchmark/azure/overview) controls in your environment
- Learn about [Azure confidential computing](/azure/confidential-computing/) for protecting data in use
- Configure [Azure Policy](/azure/governance/policy/) to enforce organizational security standards
