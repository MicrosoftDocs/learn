
Security updates protect workloads against security vulnerabilities that are continuously discovered by threat researchers and attackers. Security update solutions help you evaluate, track, and deploy patches across your environment to reduce exposure to known vulnerabilities.

A comprehensive security update strategy must address virtual machines, on-premises servers, and workloads running across multiple cloud platforms. The solution you select should provide unified visibility, flexible scheduling, and policy-based governance regardless of where workloads run.

### Patch management strategy

An effective patch management strategy addresses four key areas:

- **Discovery and assessment**: Continuously inventory all machines and assess their update status. Automated periodic assessments ensure newly discovered vulnerabilities are identified quickly.
- **Prioritization**: Not all patches carry equal risk. Prioritize updates based on severity (critical, security, feature), exploitability, and the criticality of the affected asset. Align with industry vulnerability scoring frameworks such as CVSS.
- **Deployment**: Deploy patches through a controlled process with defined maintenance windows, staged rollouts, and rollback plans. Balance security urgency with operational stability.
- **Verification and reporting**: Confirm deployment success, validate system functionality post-patch, and maintain audit trails for compliance reporting.

### Key capabilities to evaluate

When evaluating security update solutions, look for the following capabilities:

- **Flexible patching options**:
  - **Automatic guest patching**: Automatically downloads and installs patches classified as critical or security updates without manual intervention.
  - **Hot patching**: Installs updates that take effect without requiring a reboot, reducing downtime for production workloads.
  - **Scheduled patching**: Define custom maintenance windows to control when updates are deployed. Use dynamic scoping to group machines based on criteria such as environment, location, or tags.

- **Unified update assessment**:
  - Periodic assessment checks for new updates across all managed machines.
  - Single pane of glass visibility across on-premises, cloud, and multicloud environments.

- **Governance and compliance**:
  - Policy integration to audit and enforce update compliance.
  - Built-in reporting for update status, compliance trends, and deployment history.
  - Query-based dashboards for advanced analysis and custom views.

- **Hybrid and multicloud support**:
  - Consistent management experience across cloud VMs, on-premises servers, and machines in other cloud environments.
  - Management plane extensions (such as Azure Arc or similar agents) to bring non-native machines under centralized governance.

In Azure, Azure Update Manager provides these capabilities natively. It supports Windows and Linux machines across Azure, on-premises, and other cloud platforms through Azure Arc integration. It requires no additional onboarding, includes built-in role-based access control (RBAC), and supports Azure Policy for governance.

The following diagram shows how Update Manager assesses and applies security updates to all Azure and Arc-enabled machines for both Windows and Linux.

:::image type="content" source="../media/update-management-center-overview.png" alt-text="Diagram that shows the Update Manager workflow." lightbox="../media/update-management-center-overview.png":::

### Comparing update management approaches

When designing a security update strategy, consider the following approaches based on your environment:

| Approach | Best for | Key characteristics | Microsoft solution |
|---|---|---|---|
| **Cloud-native patch management** | Cloud VMs and arc/agent-enabled machines | Unified management, policy integration, no extra infrastructure | Azure Update Manager |
| **Cloud-native with management plane extensions** | Hybrid and multicloud environments | Extends cloud management to on-premises and other clouds | Azure Update Manager + Azure Arc |
| **Traditional enterprise (Windows Server Update Services (WSUS), System Center Configuration Manager (SCCM), or equivalent)** | Legacy Windows environments | Familiar tools, granular control, limited cross-platform support | WSUS, Microsoft Configuration Manager |
| **Third-party solutions** | Organizations with existing investments | Specialized features, potential added cost and complexity | N/A |

For most organizations, cloud-native patch management provides the optimal balance of coverage, governance, and operational simplicity. Extending the management plane through agents or extensions enables consistent update management across hybrid and multicloud environments without requiring separate tools for each platform.

### Integration with cloud security posture management

Security update compliance should be part of your overall security posture management. Cloud security posture management (CSPM) tools integrate with patch management to provide security-focused update recommendations:

- CSPM tools periodically check managed machines for system updates and surface missing critical and security patches as security recommendations.
- Policy enforcement can require periodic assessment and automatic patching, ensuring no machine goes unmonitored.
- Unified dashboards correlate update compliance with other security signals such as vulnerability findings and misconfigurations.

In Azure, Microsoft Defender for Cloud provides this integration, surfacing update recommendations alongside other security findings.

### AI considerations for security updates

As organizations deploy and manage AI systems, security update strategies must account for AI-specific requirements:

- **AI framework patching**: Machine learning frameworks (such as PyTorch, TensorFlow, ONNX Runtime) and AI service dependencies require regular security updates. Track and apply patches to AI-related packages in addition to operating system and middleware components.
- **AI-powered vulnerability prioritization**: CSPM tools increasingly use machine learning to prioritize vulnerability remediation based on exploitability, asset criticality, and environmental context. Integrate these prioritized recommendations with your update deployment schedule.
- **Predictive update impact analysis**: Evaluate how security updates might affect AI model serving performance, inference latency, and data pipeline operations. Schedule updates to AI infrastructure during maintenance windows that account for model retraining and validation.
- **Automated remediation for AI workloads**: Use policy-based automation to enforce security update compliance for AI compute resources, including GPU-enabled VMs, machine learning compute clusters, and inference endpoints.
- **Container and model serving updates**: AI workloads often run in containers. Incorporate container image scanning and patching into your security update strategy, including base image updates and runtime dependency patches.
