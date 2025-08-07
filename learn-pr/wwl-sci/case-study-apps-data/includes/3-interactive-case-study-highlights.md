This unit explores the architectural and operational insights surfaced through the interactive case study on Fabrikam Inc.’s multicloud application and data security posture. The simulation reveals systemic gaps common in cloud-native environments and provides a structured lens for learners to analyze and reflect on them.

### Situation Assessment

Fabrikam Inc. faces several application and data security challenges in its dual-cloud (Azure and AWS) environment:

- Static Kubernetes secrets and long-lived tokens are used for service-to-service authentication, with manual rotation and limited visibility.
- Database connections rely on public endpoints and connection strings, lacking network-layer isolation and robust access controls.
- CI/CD pipelines lack centralized security governance, allowing misconfigurations to reach production.
- Open-source dependency management is manual, relying on developer vigilance without integrated scanning.
- Monitoring is fragmented across cloud-native tools, with inconsistent triage processes and limited threat detection.

These issues reflect decentralized security practices and visibility gaps that elevate risks in cloud-native architectures.

### Threat Analysis

Operational weaknesses translate into tangible threats:

- Credential exposure due to manual secret handling and static tokens.
- Misconfigurations in infrastructure-as-code and admission policies introduce persistent vulnerabilities.
- Supply chain risks from unscanned dependencies and insecure CI/CD workflows.
- Data exposure from public database endpoints and insufficient encryption.
- Delayed incident detection due to fragmented monitoring and reactive diagnostics.

These vulnerabilities highlight how DevOps practices and cloud-native complexity can be exploited, especially in multicloud environments.

### Architectural Solution

A Zero Trust–aligned DevSecOps framework using integrated Microsoft tools addresses Fabrikam Inc.’s risks:

- Azure Arc extends governance and policy enforcement to Amazon EKS clusters.
- GitHub Advanced Security and Defender for Cloud DevOps enable shift-left security through code and infrastructure scanning.
- Workload identities replace static credentials with short-lived tokens tied to pod identities.
- Azure Key Vault, Always Encrypted, and Azure Private Link strengthen data protection and secure connectivity.
- Microsoft Sentinel correlates telemetry across pipelines, runtimes, and cloud apps for unified threat detection.

This architecture emphasizes:

- Automation and continuous validation
- Policy consistency across clouds
- Integrated telemetry and threat detection

It's scalable, developer-friendly, and operationally efficient—directly addressing credential sprawl, misconfigurations, fragmented monitoring, and insecure data access.