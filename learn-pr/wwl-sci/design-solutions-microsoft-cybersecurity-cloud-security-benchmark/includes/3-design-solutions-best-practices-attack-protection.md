As a Security Architect, you must design solutions that protect against three distinct threat categories: insider threats, external attacks, and supply chain compromises. Each category requires different controls, but they share common elements rooted in Zero Trust principles—verify explicitly, use least privilege, and assume breach.

An attack chain describes the typical sequence of events during an attack that leads to organizational damage. While there's no single linear path for any attack type, understanding common patterns helps you design layered defenses. The Microsoft Cybersecurity Reference Architecture (MCRA) and Microsoft Cloud Security Benchmark (MCSB) provide best practices for each threat category.

The following best practices and MCSB controls are technology-agnostic security principles. Separate learning paths in the SC-100 training content cover specific Microsoft solutions that can be used to implement these controls.

## 1. Insider threat protection

Insider threats originate from individuals with legitimate access—employees, contractors, or partners—who intentionally or accidentally cause harm. Key risks include data leaks, intellectual property theft, fraud, and compliance violations. Key practices include:

- **Implement least privilege access**: Restrict access to only what users need for their role. Use just-in-time access for sensitive operations and conduct regular access reviews. *MCSB Controls: PA-1 (limit privileged users), PA-7 (just enough administration), IM-2 (protect identity systems).*
- **Monitor user behavior**: Deploy user entity behavioral analytics (UEBA) to detect anomalous activity patterns such as unusual data access, off-hours activity, or bulk downloads. *MCSB Controls: LT-1 (threat detection), LT-2 (identity threat detection).*
- **Protect sensitive data**: Classify and label sensitive data, apply data loss prevention (DLP) policies to prevent unauthorized sharing, and use encryption to protect data at rest and in transit. *MCSB Controls: DP-1 (discover and classify data), DP-2 (monitor sensitive data), DP-3 (encrypt in transit).*
- **Enforce separation of duties**: Require multiple approvals for critical actions such as financial transactions, code deployments, or access changes. *MCSB Controls: PA-1 (separate privileged users), GS-3 (define roles).*

| MCSB Control | Name |
|---------|------|
| [PA-1](/security/benchmark/azure/mcsb-privileged-access#pa-1-separate-and-limit-highly-privilegedadministrative-users) | Separate and limit highly privileged/administrative users |
| [PA-7](/security/benchmark/azure/mcsb-privileged-access#pa-7-follow-just-enough-administration-least-privilege-principle) | Follow just enough administration (least privilege) principle |
| [IM-2](/security/benchmark/azure/mcsb-identity-management#im-2-protect-identity-and-authentication-systems) | Protect identity and authentication systems |
| [LT-1](/security/benchmark/azure/mcsb-logging-threat-detection#lt-1-enable-threat-detection-capabilities) | Enable threat detection capabilities |
| [LT-2](/security/benchmark/azure/mcsb-logging-threat-detection#lt-2-enable-threat-detection-for-identity-and-access-management) | Enable threat detection for identity and access management |
| [DP-1](/security/benchmark/azure/mcsb-data-protection#dp-1-discover-classify-and-label-sensitive-data) | Discover, classify, and label sensitive data |
| [DP-2](/security/benchmark/azure/mcsb-data-protection#dp-2-monitor-anomalies-and-threats-targeting-sensitive-data) | Monitor anomalies and threats targeting sensitive data |
| [GS-3](/security/benchmark/azure/mcsb-governance-strategy#gs-3-define-and-implement-data-protection-strategy) | Define and implement data protection strategy |

## 2. External attack protection

External attacks originate from threat actors outside your organization—cybercriminals, nation-states, or hacktivists. Effective defense requires balanced investments across the full attack lifecycle: identify, protect, detect, respond, and recover. Key practices include:

- **Deploy layered defenses**: Combine preventive controls (firewalls, endpoint protection, access controls) with detective controls (SIEM, XDR) across all attack surfaces. *MCSB Controls: NS-1 (network segmentation), ES-1 (endpoint detection), LT-1 (threat detection).*
- **Integrate XDR and SIEM**: Use extended detection and response (XDR) for high-fidelity alerts on covered assets, and SIEM for broad visibility and correlation across all data sources. Neither alone provides complete coverage. *MCSB Controls: LT-1 (threat detection), LT-5 (centralize logs), IR-3 (create incidents from alerts).*
- **Automate response with SOAR**: Use security orchestration, automation, and response (SOAR) to reduce manual effort, accelerate containment, and free analysts for complex investigations. *MCSB Controls: IR-6 (automate incident handling), IR-4 (investigate incidents).*
- **Prepare incident response**: Document incident response (IR) plans with clear roles, playbooks, and communication procedures. Conduct regular tabletop exercises and post-incident reviews. *MCSB Controls: IR-1 (IR preparation), IR-2 (incident notification), IR-7 (post-incident review).*
- **Adapt for OT environments**: Adjust tools and processes for operational technology constraints—prioritize safety, use passive network detection, and isolate legacy systems that can't be patched. *MCSB Controls: NS-1 (segmentation), LT-4 (network logging).*

| MCSB Control | Name |
|---------|------|
| [NS-1](/security/benchmark/azure/mcsb-network-security#ns-1-establish-network-segmentation-boundaries) | Establish network segmentation boundaries |
| [ES-1](/security/benchmark/azure/mcsb-endpoint-security#es-1-use-endpoint-detection-and-response-edr) | Use Endpoint Detection and Response (EDR) |
| [LT-1](/security/benchmark/azure/mcsb-logging-threat-detection#lt-1-enable-threat-detection-capabilities) | Enable threat detection capabilities |
| [LT-4](/security/benchmark/azure/mcsb-logging-threat-detection#lt-4-enable-logging-for-network-security-investigation) | Enable logging for network security investigation |
| [LT-5](/security/benchmark/azure/mcsb-logging-threat-detection#lt-5-centralize-security-log-management-and-analysis) | Centralize security log management and analysis |
| [IR-1](/security/benchmark/azure/mcsb-incident-response#ir-1-preparation--update-incident-response-plan-and-handling-process) | Preparation – update incident response plan and handling process |
| [IR-2](/security/benchmark/azure/mcsb-incident-response#ir-2-preparation--setup-incident-notification) | Preparation – setup incident notification |
| [IR-3](/security/benchmark/azure/mcsb-incident-response#ir-3-detection-and-analysis--create-incidents-based-on-high-quality-alerts) | Detection and analysis – create incidents based on high-quality alerts |
| [IR-4](/security/benchmark/azure/mcsb-incident-response#ir-4-detection-and-analysis--investigate-an-incident) | Detection and analysis – investigate an incident |
| [IR-6](/security/benchmark/azure/mcsb-incident-response#ir-6-containment-eradication-and-recovery--automate-the-incident-handling) | Containment, eradication, and recovery – automate the incident handling |
| [IR-7](/security/benchmark/azure/mcsb-incident-response#ir-7-post-incident-activity--conduct-lesson-learned-and-retain-evidence) | Post-incident activity – conduct lessons learned and retain evidence |

## 3. Supply chain attack protection

Supply chain attacks compromise trusted vendors, software, or services to gain access to your environment. These attacks are particularly dangerous because they bypass traditional perimeter defenses. Key practices include:

- **Verify software integrity**: Validate code signatures, checksums, and software bills of materials (SBOM) before deployment. Monitor for tampering in CI/CD pipelines. *MCSB Controls: DS-2 (software supply chain security), DS-6 (secure DevOps lifecycle).*
- **Assess third-party risk**: Evaluate vendor security practices before onboarding. Include security requirements in contracts and conduct periodic reassessments. *MCSB Controls: GS-1 (security strategy), GS-6 (third-party risk).*
- **Limit third-party access**: Apply least privilege to vendor accounts and service connections. Use dedicated accounts with time-limited access and monitor all third-party activity. *MCSB Controls: PA-6 (privileged access workstations), PA-8 (cloud provider access), IM-7 (conditional access).*
- **Isolate external integrations**: Segment networks and systems that connect to third parties. Use API gateways with security controls for external service integrations. *MCSB Controls: NS-1 (segmentation), NS-2 (secure cloud services), AM-2 (approved services).*

| MCSB Control | Name |
|---------|------|
| [DS-2](/security/benchmark/azure/mcsb-devops-security#ds-2-ensure-software-supply-chain-security) | Ensure software supply chain security |
| [DS-6](/security/benchmark/azure/mcsb-devops-security#ds-6-enforce-security-of-workload-throughout-devops-lifecycle) | Enforce security of workload throughout DevOps lifecycle |
| [GS-1](/security/benchmark/azure/mcsb-governance-strategy#gs-1-align-organization-roles-responsibilities-and-accountabilities) | Align organization roles, responsibilities, and accountabilities |
| [GS-6](/security/benchmark/azure/mcsb-governance-strategy#gs-6-define-and-implement-identity-and-privileged-access-strategy) | Define and implement identity and privileged access strategy |
| [PA-6](/security/benchmark/azure/mcsb-privileged-access#pa-6-use-privileged-access-workstations) | Use privileged access workstations |
| [PA-8](/security/benchmark/azure/mcsb-privileged-access#pa-8-determine-access-process-for-cloud-provider-support) | Determine access process for cloud provider support |
| [IM-7](/security/benchmark/azure/mcsb-identity-management#im-7-restrict-resource-access-based-on--conditions) | Restrict resource access based on conditions |
| [NS-1](/security/benchmark/azure/mcsb-network-security#ns-1-establish-network-segmentation-boundaries) | Establish network segmentation boundaries |
| [NS-2](/security/benchmark/azure/mcsb-network-security#ns-2-secure-cloud-native-services-with-network-controls) | Secure cloud native services with network controls |
| [AM-2](/security/benchmark/azure/mcsb-asset-management#am-2-use-only-approved-services) | Use only approved services |

## Bringing it all together

These three threat categories often intersect. An external attacker may compromise a supplier to gain initial access, then move laterally using compromised insider credentials. Effective security architecture addresses all three categories with overlapping controls that create defense in depth.

The common threads across all attack types are:
- **Assume breach** – Design controls that limit damage when preventive measures fail
- **Continuous monitoring** – Detect anomalies across identity, network, endpoint, and data
- **Rapid response** – Automate containment and maintain tested incident response plans

By applying these best practices and MCSB controls, you can design solutions that reduce risk from insider threats, external attacks, and supply chain compromises in an integrated, defensible architecture.
