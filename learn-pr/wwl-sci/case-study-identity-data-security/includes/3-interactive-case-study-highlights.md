This unit explores the key architectural and operational insights surfaced through the interactive case study on Woodgrove Bank’s hybrid identity and data security posture. The simulation reveals systemic gaps that are common in enterprise environments and provides a structured lens for learners to analyze and reflect on them.

- **Identity Provisioning and Lifecycle Management**
  - Provisioning is manual and fragmented across business units, leading to stale, overprivileged accounts.
  - Lack of automation and lifecycle workflows results in inconsistent deprovisioning and privilege creep.
  - These gaps increase the risk of insider threats and unauthorized access.

- **Guest Access and External Collaboration**
  - Guest users are invited via self-service without expiration policies or role-based access controls.
  - This creates unmanaged external surfaces that persist beyond intended access periods.
  - Collaboration sprawl and lack of oversight amplify exposure to data leakage and misuse.

- **Multi-Factor Authentication (MFA) Fatigue**
  - MFA is enforced uniformly without contextual triggers, causing user frustration and frequent lockouts.
  - The absence of adaptive policies undermines usability and security, especially for high-risk roles.
  - This friction can lead to resistance or circumvention, weakening the overall security posture.

- **Monitoring and Telemetry Fragmentation**
  - Security telemetry is siloed across identity systems, delaying detection of anomalous behavior.
  - Suspicious sign-ins, dormant account activity, and risky user behavior often go unnoticed.
  - Without centralized visibility, threat signals are missed or misinterpreted, reducing response effectiveness.

- **Data Governance and Classification Deficiencies**
  - Sensitive data is stored and shared in unclassified environments accessible to guests.
  - Manual labeling is inconsistent, and autolabeling isn't deployed, leading to misclassification.
  - Lack of policy enforcement allows data to flow unchecked, increasing the risk of exfiltration

- **Architectural Maturity Gaps**
  - Conditional Access policies are inconsistently applied.
  - Privileged access isn't time-bound or governed through approval workflows.
  - Legacy applications rely on weak authentication, and cloud adoption outpaces governance readiness.