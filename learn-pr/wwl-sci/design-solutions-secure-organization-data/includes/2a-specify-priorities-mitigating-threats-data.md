Organizations face dozens of potential data threats—from exfiltration and insider misuse to encryption weaknesses and key compromise—but limited resources mean not every threat can be addressed at once. A cybersecurity architect must specify which mitigations to implement first, which can be deferred, and why. This unit presents three complementary inputs for making those prioritization decisions:

- **MCSB v2 criticality levels** establish a baseline priority for each data protection control.
- **MITRE ATT&CK mappings and Defender for Cloud risk signals** adjust those priorities based on the threat landscape and environmental context.
- **A defense-in-depth layered model** translates the resulting priorities into a sequenced implementation roadmap.

## Baseline priorities: MCSB v2 data protection controls

The first step in specifying priorities is to understand which controls matter most by default. The [MCSB v2 data protection domain](/security/benchmark/azure/mcsb-v2-data-protection) defines eight controls organized into three pillars, each with a criticality level that directly informs implementation order. The criticality values—"Must have" (essential for baseline security), "Should have" (important for enhanced security), and "Nice to have" (beneficial for advanced scenarios)—give architects a starting point: all seven "Must have" controls take precedence over the single "Should have" control.

### Know and classify your data

- **DP-1 (Discover, classify, and label sensitive data)**—*Must have*—Establish a comprehensive inventory of sensitive data across all repositories. Without foundational classification, governance controls (DLP, conditional access, encryption workflows) cannot trigger. Risk: untracked regulated data (PCI, PHI, PII) bypasses required controls and over-privileged access persists because sensitivity and business impact aren't identified.
- **DP-2 (Monitor anomalies and threats targeting sensitive data)**—*Must have*—Detect silent exfiltration, insider misuse, and data staging that bypass coarse monitoring. DLP solutions and behavior analytics are essential to identify abnormal access patterns before data leaves the organization.

### Protect data with encryption

- **DP-3 (Encrypt sensitive data in transit)**—*Must have*—Enforce TLS 1.2 or higher for all network communications. Mitigates passive interception, man-in-the-middle attacks, protocol downgrade, and session hijacking that expose credentials and regulated data in plaintext.
- **DP-4 (Enable data at rest encryption by default)**—*Must have*—Ensure all data stores use encryption at rest with AES-256. Mitigates unauthorized data access from storage compromise, theft of physical media, and improper decommissioning.
- **DP-5 (Use customer-managed keys when required)**—*Should have*—Implement when regulations demand demonstrated control over key custody, rotation, and revocation. Provides stronger proof of data sovereignty but introduces operational overhead.

### Manage cryptographic infrastructure

- **DP-6 (Use a secure key management process)**—*Must have*—Centralize key lifecycle in Azure Key Vault. Mitigates key sprawl, stale cryptography, privilege overreach, and failed revocation—risks that undermine all other encryption controls.
- **DP-7 (Use a secure certificate management process)**—*Must have*—Automate certificate lifecycle including issuance, renewal, and revocation. Expired or misconfigured certificates cause service outages and create bypass opportunities for attackers.
- **DP-8 (Ensure security of key and certificate repository)**—*Must have*—Harden vault access with least-privilege RBAC, network isolation, soft delete, purge protection, and comprehensive logging. Repository compromise nullifies all upstream encryption and signing assurances.

The criticality levels above represent Microsoft's general guidance. However, the right priority order for a specific organization depends on which threats are most likely and most impactful in that environment.

## Adjusting priorities with threat intelligence

MCSB v2 criticality levels set the baseline, but architects should raise or lower the priority of specific controls based on which attack techniques their environment is most exposed to. Mapping each DP control to [MITRE ATT&CK](https://attack.mitre.org/) tactics provides the threat intelligence needed to make those adjustments:

| ATT&CK tactic | Techniques | Related DP controls |
|---------------|-----------|-------------------|
| **Credential Access (TA0006)** | Credential stores (T1555), unsecured credentials (T1552) | DP-6, DP-8 |
| **Collection (TA0009)** | Data from cloud storage (T1530) | DP-1, DP-4 |
| **Exfiltration (TA0010)** | Exfiltration over web services (T1567), automated exfiltration (T1020) | DP-2, DP-3 |
| **Defense Evasion (TA0005)** | Weaken encryption (T1600), adversary-in-the-middle (T1557) | DP-3, DP-6, DP-8 |
| **Impact (TA0040)** | Data destruction (T1485), inhibit recovery (T1490) | DP-8 |

**How to use this mapping for prioritization**: If threat intelligence or incident history shows that exfiltration (TA0010) is the dominant risk in your environment, elevate DP-2 (monitoring) and DP-3 (transit encryption) above controls that address less likely tactics. If credential theft (TA0006) is the primary concern, prioritize DP-6 and DP-8 (key management and vault hardening) above other controls at the same MCSB criticality level.

## Contextual prioritization with Defender for Cloud

MCSB criticality levels and ATT&CK mappings help set priorities at design time. At runtime, [Microsoft Defender for Cloud](/azure/defender-for-cloud/risk-prioritization) dynamically adjusts priorities based on environmental context—surfacing the specific data resources and vulnerabilities that need attention now. The risk-prioritization engine evaluates four key factors:

- **Internet exposure**: Whether data resources are accessible from the internet
- **Data sensitivity**: The presence of sensitive or confidential data identified through classification
- **Lateral movement**: Potential for attackers to move from compromised resources to data stores
- **Attack paths**: Whether the security issue is part of a potential attack chain that reaches sensitive data

Recommendations are classified into five risk levels: Critical, High, Medium, Low, and Not evaluated. This contextual approach ensures that a vulnerability on an internet-exposed storage account containing personal data is prioritized over the same vulnerability on an isolated internal resource—allowing architects to continuously validate and adjust their mitigation priorities as the environment changes.

### Data-aware prioritization with Defender CSPM

[Defender CSPM](/azure/defender-for-cloud/concept-data-security-posture) integrates Microsoft Purview sensitivity labels into the risk-prioritization engine, enabling three data-aware capabilities:

- **Attack path analysis**: Maps multistep paths from initial entry points to sensitive data stores, letting architects focus on vulnerabilities that are part of a viable attack chain rather than treating all findings equally
- **Cloud Security Explorer**: Queries the security graph to find specific combinations of risk—for example, storage accounts that are both publicly accessible and contain data labeled as confidential—across multicloud environments
- **Sensitivity-aware alerting**: Ranks security incidents by the classification level of affected data, so alerts involving regulated or confidential data are triaged before alerts on nonsensitive resources

## Translating priorities into a layered implementation plan

After establishing priorities through MCSB criticality levels, threat intelligence, and Defender for Cloud signals, an architect must translate those priorities into an implementation plan. The [CAF Secure methodology](/azure/cloud-adoption-framework/secure/) recommends organizing controls into defense-in-depth layers aligned with Zero Trust principles. No single control is sufficient—each layer compensates for potential failures in adjacent layers—so the implementation plan must address all layers while respecting the priority order.

| Layer | MCSB controls | Purpose | Key Microsoft capabilities |
|-------|--------------|---------|------------------------|
| **Classification** | DP-1 | Discover, classify, and label data to enable all downstream protection policies | Microsoft Purview Data Map, Microsoft Purview Data Catalog, Microsoft Purview Information Protection |
| **Encryption** | DP-3, DP-4, DP-5 | Protect data confidentiality through transit and at-rest encryption | Azure Storage Service Encryption, Azure SQL TDE, Azure Disk Encryption, Azure Front Door |
| **Key and certificate management** | DP-6, DP-7, DP-8 | Secure cryptographic material lifecycle with least-privilege access and audit logging | Azure Key Vault, Azure Key Vault Managed HSM |
| **Monitoring** | DP-2 | Detect anomalies, exfiltration attempts, and insider threats targeting sensitive data | Microsoft Purview DLP, Microsoft Defender for Storage, Microsoft Defender for SQL |

### How layers interact

Classification feeds encryption policy: sensitivity labels determine whether platform-managed or customer-managed keys are required and which DLP rules apply. Encryption depends on key management: if keys are compromised, encryption provides no protection. Monitoring validates all other layers: it detects when classification is missing, encryption is disabled, or key access is anomalous. This interdependence is why the MCSB rates seven of eight DP controls as "Must have"—gaps at any layer weaken the entire stack.

### Recommended implementation sequence

Combining MCSB criticality levels with layer dependencies produces the following recommended sequence for organizations building or maturing a data protection program:

1. **DP-1 first**: All other controls depend on classification—encryption policies, DLP rules, and monitoring alerts cannot target data that hasn't been discovered and labeled.
2. **DP-3 and DP-4 next**: Transit and at-rest encryption provide the broadest risk reduction per effort and protect data while more targeted controls are implemented.
3. **DP-6 and DP-8 in parallel**: Encryption is only as strong as its key management—centralizing keys and hardening the vault must follow immediately.
4. **DP-2 and DP-7 concurrently**: Monitoring detects gaps in the layers above, and certificate lifecycle management prevents operational failures that create bypass opportunities.
5. **DP-5 last**: Customer-managed keys require mature key management processes (DP-6, DP-8) to be operational—deploying CMK before those processes exist increases risk rather than reducing it.

