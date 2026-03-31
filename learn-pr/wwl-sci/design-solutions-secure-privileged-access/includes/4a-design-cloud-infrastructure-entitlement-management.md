Organizations operating in multicloud environments face significant challenges managing identities and permissions across Azure, AWS, and GCP. Cloud infrastructure entitlement management (CIEM) addresses these challenges by providing visibility into who has access to what resources and whether those permissions align with the principle of least privilege.

## Design considerations for CIEM

When designing a solution for cloud infrastructure entitlement management, security architects should address these key requirements:

### Multicloud visibility

Organizations need unified visibility into identities and permissions across all cloud platforms. Consider:

- Which cloud platforms require identity monitoring (Azure, AWS, GCP)?
- How will you correlate identities that exist across multiple clouds?
- What identity types need coverage (human users, service principals, managed identities, service accounts)?

### Permission analysis and right-sizing

Understanding effective permissions—what identities can actually do versus what they're assigned—is critical for enforcing least privilege. Consider:

- How will you identify overprovisioned identities with more permissions than needed?
- What process will detect unused permissions that should be removed?
- How will you analyze actual permission usage patterns over time?

### Identity lifecycle and hygiene

Stale identities and orphaned permissions create unnecessary risk. Consider:

- How will you detect inactive accounts that retain access to resources?
- What process identifies guest or external accounts with excessive permissions?
- How will CIEM findings integrate with identity governance access reviews?

### Risk prioritization

Not all permission issues carry equal risk. Consider:

- How will you identify which overprovisioned identities can reach sensitive resources?
- What analysis shows potential lateral movement paths from compromised identities?
- How will you prioritize remediation based on actual business impact?

## How Defender for Cloud addresses CIEM requirements

Microsoft Defender for Cloud includes native CIEM capabilities within the [Defender Cloud Security Posture Management (CSPM)](/azure/defender-for-cloud/concept-cloud-security-posture-management) plan that address these design considerations.

### Supported identity types

| Cloud platform | Identity types analyzed |
|----------------|------------------------|
| **Azure** | Microsoft Entra ID users, groups, and service principals |
| **AWS** | IAM users, roles, groups, serverless functions, and compute resources |
| **GCP** | IAM users, groups, service accounts, and serverless functions |

### Mapping capabilities to design considerations

| Design consideration | Defender for Cloud capability |
|---------------------|------------------------------|
| **Multicloud visibility** | Unified view tracking permissions across Azure, AWS, and GCP with continuous analysis of identity configurations |
| **Permission analysis** | Evaluates effective permissions and recommends right-sizing overprovisioned identities based on actual usage |
| **Identity lifecycle** | Surfaces inactive, guest, or blocked accounts that retain access; integrates with identity governance workflows |
| **Risk prioritization** | [Attack path analysis](/azure/defender-for-cloud/how-to-manage-attack-path) correlates identity risks with lateral movement opportunities to sensitive resources |

### Alignment with security controls

These capabilities directly support [Microsoft Cloud Security Benchmark (MCSB) v2](/security/benchmark/azure/mcsb-privileged-access) privileged access controls:

- **PA-1**: Identifies accounts with administrative privileges and recommends limiting scope
- **PA-2**: Detects unused permissions and inactive identities for removal
- **PA-3**: Surfaces stale accounts that retain access to cloud resources
- **PA-4**: Provides continuous analysis with remediation recommendations
- **PA-7**: Analyzes actual usage and recommends right-sizing permissions

## Monitoring and remediation interfaces

Defender for Cloud provides multiple tools for investigating and addressing identity risks:

- **Cloud Security Explorer**: Query identities with access to specific resources and map cloud entitlements with contextual information
- **Attack Path Analysis**: Visualize how attackers could exploit identity misconfigurations to reach sensitive targets
- **Recommendations**: Review and remediate CIEM-specific recommendations for inactive identities and overprovisioned permissions
- **CIEM Workbook**: Use customizable visual reports to monitor identity security posture over time

## Implementation guidance

When implementing CIEM with Defender for Cloud:

- **Enable Defender CSPM** for all subscriptions, AWS accounts, and GCP projects requiring identity visibility
- **Establish remediation workflows** with approval processes for acting on permission change recommendations
- **Coordinate with identity governance** to align CIEM findings with Microsoft Entra ID Governance access reviews
- **Configure alerting** for high-severity identity risks discovered through attack path analysis

For more information, see [Permissions management in Defender for Cloud](/azure/defender-for-cloud/permissions-management).
