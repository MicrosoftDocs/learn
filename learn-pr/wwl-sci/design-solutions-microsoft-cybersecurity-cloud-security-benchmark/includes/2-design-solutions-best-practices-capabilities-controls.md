As a Security Architect, you should approach solution design by using Microsoft’s security frameworks in unison rather than in silos. In practice, this means applying Zero Trust principles as your strategic mindset, using the Microsoft Cybersecurity Reference Architecture (MCRA) as an end-to-end blueprint to cover all security domains, and implementing the Microsoft Cloud Security Benchmark (MCSB) controls to configure and validate each domain according to best practices. This integrated approach ensures that all key cybersecurity capabilities – identity, devices, networks, applications, data, monitoring, etc. – are accounted for in your design and aligned with proven recommendations.

With this unified strategy in mind, let's break down the key security capability areas and the best practices for each, showing how to apply Zero Trust principles, MCRA's architectural guidance, and MCSB controls in a practical way.

The following best practices and MCSB controls are technology-agnostic security principles. Separate learning paths in the SC-100 training content cover specific Microsoft solutions (such as Microsoft Entra, Microsoft Defender, Microsoft Sentinel, and Microsoft Purview) that can be used to implement these best practices and controls.

### Identity and privileged Access

Identity is the foundation of Zero Trust security. A centralized identity provider serves as the policy engine for access decisions. Key practices include:

- **Centralize identity and enable strong authentication**: Use a single, centralized identity provider. Enforce multifactor authentication (MFA) for all users, block legacy authentication, and use passwordless methods where possible. *MCSB Controls: IM-1 (centralize identity), IM-6 (MFA), IM-7 (conditional access).*
- **Apply conditional access policies**: Evaluate every access request in real time based on user role, device compliance, location, and risk signals. Block high-risk sign-ins and enforce device compliance for sensitive apps. *MCSB Controls: IM-7 (conditional access).*
- **Protect privileged accounts**: Implement least privilege with role-based access control (RBAC), use just-in-time elevation for administrative access, maintain separate admin accounts, and require Privileged Access Workstations (PAWs) for sensitive tasks. *MCSB Controls: PA-1 (protect admin accounts), PA-3 (use PAWs).*
- **Govern and monitor identities**: Automate identity lifecycle with HR integration, conduct regular access reviews, and monitor sign-in anomalies with identity protection and security information and event management (SIEM) solutions. *MCSB Controls: IM-2 (protect identity systems), PA-8 (access review process).*

| MCSB Control | Name |
|---------|------|
| [IM-1](/security/benchmark/azure/mcsb-v2-identity-management#im-1) | Centralize identity and authentication while ensuring isolation |
| [IM-2](/security/benchmark/azure/mcsb-v2-identity-management#im-2) | Protect identity and authentication systems |
| [IM-6](/security/benchmark/azure/mcsb-v2-identity-management#im-6) | Use strong authentication controls |
| [IM-7](/security/benchmark/azure/mcsb-v2-identity-management#im-7) | Restrict resource access based on conditions |
| [PA-1](/security/benchmark/azure/mcsb-v2-privileged-access#pa-1) | Separate and limit highly privileged/administrative users |
| [PA-3](/security/benchmark/azure/mcsb-v2-privileged-access#pa-3) | Manage lifecycle of identities and entitlements |
| [PA-8](/security/benchmark/azure/mcsb-v2-privileged-access#pa-8) | Determine access process for cloud provider support |

### Endpoint and device Security

Zero Trust requires continuous verification of device security posture. Key practices include:

- **Enroll devices and enforce compliance**: Manage all corporate devices with a mobile device management (MDM) solution using compliance policies (encryption, patching, antivirus). Use compliance signals in conditional access to restrict access from noncompliant devices. *MCSB Controls: ES-1 (endpoint security), ES-2 (anti-malware).*
- **Deploy Endpoint Detection and Response (EDR)**: Deploy EDR solutions on all endpoints for threat detection, automated response, and vulnerability management. Enable tamper protection. *MCSB Controls: ES-1 (EDR solution), ES-3 (anti-malware updates).*
- **Manage updates and vulnerabilities**: Use centralized patch management. Scan for vulnerabilities continuously and enforce application control in high-risk environments. *MCSB Controls: PV-3 (secure configurations), PV-5 (vulnerability assessments).*
- **Protect BYOD and mobile**: Use mobile application management (MAM) policies for personal devices. Apply conditional access session controls via a cloud access security broker (CASB) to limit data downloads on unmanaged devices. *MCSB Controls: ES-1 (endpoint security).*

| MCSB Control | Name |
|---------|------|
| [ES-1](/security/benchmark/azure/mcsb-v2-endpoint-security#es-1) | Use Endpoint Detection and Response (EDR) |
| [ES-2](/security/benchmark/azure/mcsb-v2-endpoint-security#es-2) | Use modern anti-malware software |
| [ES-3](/security/benchmark/azure/mcsb-v2-endpoint-security#es-3) | Ensure anti-malware software and signatures are updated |
| [PV-3](/security/benchmark/azure/mcsb-v2-posture-vulnerability-management#pv-3) | Define and establish secure configurations for compute resources |
| [PV-5](/security/benchmark/azure/mcsb-v2-posture-vulnerability-management#pv-5) | Perform vulnerability assessments |

### Network and infrastructure Security

Network controls remain essential for defense-in-depth and breach containment. Key practices include:

- **Segment and restrict network access**: Use network security groups, subnets, and firewalls to limit lateral movement. Allow only necessary traffic between segments. *MCSB Controls: NS-1 (network segmentation), NS-2 (secure cloud services).*
- **Secure cloud network perimeter**: Use firewalls and web application firewalls (WAF) for traffic inspection. Enable DDoS protection, use just-in-time access for management ports, and enforce TLS for all web apps. *MCSB Controls: NS-4 (firewall and WAF), NS-5 (DDoS protection).*
- **Use private access**: Use private endpoints and service endpoints for PaaS services. Implement Zero Trust Network Access (ZTNA) instead of legacy VPN for remote access. *MCSB Controls: NS-2 (secure cloud services), NS-3 (private access).*
- **Monitor network traffic**: Analyze network flow logs, enable threat intelligence filtering on firewalls, and monitor DNS for command-and-control (C2) activity. *MCSB Controls: NS-10 (DNS security), LT-1 (threat detection).*

| MCSB Control | Name |
|---------|------|
| [NS-1](/security/benchmark/azure/mcsb-v2-network-security#ns-1) | Establish network segmentation boundaries |
| [NS-2](/security/benchmark/azure/mcsb-v2-network-security#ns-2) | Secure cloud native services with network controls |
| [NS-3](/security/benchmark/azure/mcsb-v2-network-security#ns-3) | Deploy firewall at the edge of enterprise network |
| [NS-4](/security/benchmark/azure/mcsb-v2-network-security#ns-4) | Deploy intrusion detection/intrusion prevention systems (IDS/IPS) |
| [NS-5](/security/benchmark/azure/mcsb-v2-network-security#ns-5) | Deploy DDOS protection |
| [NS-10](/security/benchmark/azure/mcsb-v2-network-security#ns-10) | Ensure Domain Name System (DNS) security |
| [LT-1](/security/benchmark/azure/mcsb-v2-logging-threat-detection#lt-1) | Enable threat detection capabilities |

### Application security and DevOps

Applications and Azure pipelines must be secured to prevent vulnerabilities. Key practices include:

- **Secure configuration of cloud services**: Apply security benchmark baseline settings to all cloud services. Use managed identities with least privilege, secure vaults for secrets, and policy enforcement for compliance. *MCSB Controls: PV-2 (secure configurations), AM-2 (managed identities).*
- **Integrate DevSecOps**: Embed static application security testing (SAST), dependency scanning, and secret scanning in CI/CD (Continuous Integration/Continuous Delivery) pipelines. Enforce code quality gates before deployment. *MCSB Controls: DS-6 (secure DevOps), DS-7 (code scanning).*
- **Protect running applications**: Use a CASB for SaaS monitoring, integrate apps with your identity provider for authentication, and use API management with WAF rules. Deploy container security solutions for Kubernetes workloads. *MCSB Controls: DS-2 (application security), AM-5 (restrict app access).*
- **Secure data in applications**: Enforce data validation, encryption at rest and in transit (TLS 1.2+), and use masking/tokenization for sensitive data. *MCSB Controls: DP-3 (encryption in transit), DP-4 (encryption at rest).*

| MCSB Control | Name |
|---------|------|
| [PV-2](/security/benchmark/azure/mcsb-v2-posture-vulnerability-management#pv-2) | Audit and enforce secure configurations |
| [AM-2](/security/benchmark/azure/mcsb-v2-asset-management#am-2) | Use only approved services |
| [AM-5](/security/benchmark/azure/mcsb-v2-asset-management#am-5) | Use only approved applications in virtual machine |
| [DS-2](/security/benchmark/azure/mcsb-v2-devop-security#ds-2) | Secure the software supply chain |
| [DS-6](/security/benchmark/azure/mcsb-v2-devop-security#ds-6) | Secure the workload lifecycle |
| [DS-7](/security/benchmark/azure/mcsb-v2-devop-security#ds-7) | Implement DevOps logging and monitoring |
| [DP-3](/security/benchmark/azure/mcsb-v2-data-protection#dp-3) | Encrypt sensitive data in transit |
| [DP-4](/security/benchmark/azure/mcsb-v2-data-protection#dp-4) | Enable data at rest encryption by default |

### Data protection and governance

Security is ultimately about protecting data. Key practices include:

- **Discover and classify sensitive data**: Use data governance tools to scan and classify data across documents, databases, and storage. Apply sensitivity labels to inform access and encryption policies. *MCSB Controls: DP-1 (discover data), DP-2 (classify data).*
- **Encrypt data at rest and in transit**: Use encryption with platform-managed or customer-managed keys and enforce TLS for all connections. Consider confidential computing for highly sensitive workloads. *MCSB Controls: DP-3 (encrypt in transit), DP-4 (encrypt at rest), DP-5 (key management).*
- **Implement data loss prevention (DLP)**: Use DLP policies across email, collaboration tools, file storage, and endpoints to prevent data exfiltration. Block or alert on unauthorized sharing of sensitive data. *MCSB Controls: DP-2 (monitor sensitive data).*
- **Apply least privilege data access**: Use row-level security, column encryption, and sensitivity labels to restrict data access. Monitor data access via database auditing and SIEM integration. *MCSB Controls: DP-2 (classify data), AM-3 (least privilege).*
- **Protect backups**: Enable soft delete on backups, use immutable storage for ransomware protection, and test recovery regularly. *MCSB Controls: BR-1 (backup strategy), BR-2 (protect backup data).*

| MCSB Control | Name |
|---------|------|
| [DP-1](/security/benchmark/azure/mcsb-v2-data-protection#dp-1) | Discover, classify, and label sensitive data |
| [DP-2](/security/benchmark/azure/mcsb-v2-data-protection#dp-2) | Monitor anomalies and threats targeting sensitive data |
| [DP-3](/security/benchmark/azure/mcsb-v2-data-protection#dp-3) | Encrypt sensitive data in transit |
| [DP-4](/security/benchmark/azure/mcsb-v2-data-protection#dp-4) | Enable data at rest encryption by default |
| [DP-5](/security/benchmark/azure/mcsb-v2-data-protection#dp-5) | Use customer-managed key option in data at rest encryption when required |
| [AM-3](/security/benchmark/azure/mcsb-v2-asset-management#am-3) | Ensure security of asset lifecycle management |
| [BR-1](/security/benchmark/azure/mcsb-v2-backup-recovery#br-1) | Ensure regular automated backups |
| [BR-2](/security/benchmark/azure/mcsb-v2-backup-recovery#br-2) | Protect backup and recovery data |

### Threat detection and response

Assume breach and build robust detection and response capabilities. Key practices include:

- **Centralize logging and monitoring**: Aggregate all logs (identity, device, network, application, cloud service) in a SIEM solution. Use built-in analytics and machine learning to detect anomalies. Retain logs 90+ days with tamper protection. *MCSB Controls: LT-1 (enable logging), LT-3 (centralize logs), LT-4 (network logging).*
- **Enable extended detection and response (XDR)**: Deploy XDR solutions that share signals across endpoints, identity, cloud apps, and email to detect multi-stage attacks. *MCSB Controls: LT-1 (threat detection), IR-2 (preparation).*
- **Establish incident response and automation**: Document incident response (IR) plans with roles and playbooks. Use security orchestration, automation, and response (SOAR) to automate containment (isolate machines, disable accounts). *MCSB Controls: IR-1 (IR preparation), IR-4 (detection and analysis), IR-5 (response).*
- **Continuous improvement**: Conduct regular red-team/blue-team drills and tabletop exercises. Track Mean Time To Detect/Mean Time To Respond (MTTD/MTTR) metrics and feed lessons learned into improving detection and response. *MCSB Controls: IR-6 (post-incident activity).*

| MCSB Control | Name |
|---------|------|
| [LT-1](/security/benchmark/azure/mcsb-v2-logging-threat-detection#lt-1) | Enable threat detection capabilities |
| [LT-3](/security/benchmark/azure/mcsb-v2-logging-threat-detection#lt-3) | Enable logging for security investigation |
| [LT-4](/security/benchmark/azure/mcsb-v2-logging-threat-detection#lt-4) | Enable network logging for security investigation |
| [IR-1](/security/benchmark/azure/mcsb-v2-incident-response#ir-1) | Preparation - update incident response plan and handling process |
| [IR-2](/security/benchmark/azure/mcsb-v2-incident-response#ir-2) | Preparation - setup incident notification |
| [IR-4](/security/benchmark/azure/mcsb-v2-incident-response#ir-4) | Detection and analysis - investigate an incident |
| [IR-5](/security/benchmark/azure/mcsb-v2-incident-response#ir-5) | Detection and analysis - prioritize incidents |
| [IR-6](/security/benchmark/azure/mcsb-v2-incident-response#ir-6) | Containment, eradication and recovery - automate the incident handling |

### Security posture management and compliance

Maintain and improve security posture continuously. Key practices include:

- **Use secure score and posture management**: Monitor security scores and cloud security posture management (CSPM) tools to track posture against best practices. Assign owners to address recommendations. *MCSB Controls: PV-1 (posture assessment).*
- **Policy-as-code**: Use policy enforcement tools to audit and enforce security configurations. Embed security in Infrastructure as Code (IaC) templates. *MCSB Controls: PV-1 (secure configurations), PV-2 (audit and enforce configurations).*
- **Regular audits**: Conduct periodic security reviews and threat modeling updates. Use Center for Internet Security (CIS) benchmarks and third-party assessments. *MCSB Controls: PV-5 (vulnerability assessments), AM-1 (asset inventory).*
- **Stay informed**: Track updates to security frameworks and benchmarks. Subscribe to vendor update feeds for new security features and controls. *MCSB Controls: PV-1 (secure configurations).*

| MCSB Control | Name |
|---------|------|
| [PV-1](/security/benchmark/azure/mcsb-v2-posture-vulnerability-management#pv-1) | Define and establish secure configurations |
| [PV-2](/security/benchmark/azure/mcsb-v2-posture-vulnerability-management#pv-2) | Audit and enforce secure configurations |
| [PV-5](/security/benchmark/azure/mcsb-v2-posture-vulnerability-management#pv-5) | Perform vulnerability assessments |
| [AM-1](/security/benchmark/azure/mcsb-v2-asset-management#am-1) | Establish and maintain asset inventory |

## Bringing it all together

As a Security Architect, your role is to design solutions that apply best practices across security domains into a cohesive defense strategy. These domains don't operate in isolation—they reinforce each other. Strong identity controls reduce the attack surface for endpoints. Network segmentation limits the blast radius if an endpoint is compromised. Data protection ensures that even if attackers breach your perimeter, sensitive information remains secure. Threat detection closes the loop by identifying gaps and driving continuous improvement.

The three frameworks work together to guide this integrated approach:

- **Zero Trust** provides the strategic mindset: never trust, always verify, assume breach.
- **MCRA** ensures breadth by mapping all security domains and showing how they interconnect.
- **MCSB** provides the specific controls to operationalize each capability with measurable outcomes.

By applying these frameworks collectively, you can design security architectures that are comprehensive, defensible, and aligned with industry best practices—regardless of the specific technologies you choose to implement them.
