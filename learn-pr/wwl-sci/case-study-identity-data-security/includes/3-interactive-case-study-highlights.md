This unit explores the key architectural and operational insights surfaced through the interactive case study on Woodgrove Bank’s hybrid identity and data security posture. The simulation reveals systemic gaps that are common in enterprise environments and provides a structured lens for you to analyze and reflect on them.

### Situation Assessment

Woodgrove Bank faces several identity and data security challenges in its hybrid environment:

- Decentralized identity provisioning leads to stale and overprivileged accounts.
- Unmanaged external access via self-service guest invitations lacks role restrictions and expiration.
- Uniform MFA enforcement without contextual triggers causes user fatigue and frequent lockouts.
- Siloed monitoring delays detection of suspicious activity.
- Weak data governance allows sensitive data to be stored and shared in unclassified, guest-accessible environments.

These issues reflect systemic governance and visibility gaps that elevate identity-based risks.

### Threat Analysis

Operational weaknesses translate into tangible threats:

- Privilege escalation and unauthorized access due to long-lived, overprivileged accounts.
- External threat surfaces from unmanaged guest access.
- Credential abuse and insider threats enabled by lack of contextual MFA and automated provisioning.
- Data leaks from absent classification and data loss prevention (DLP) controls, often undetected due to fragmented monitoring.

These vulnerabilities highlight how poor identity hygiene can be exploited, especially in hybrid environments.

### Architectural Solution

A Zero Trust–aligned strategy using integrated Microsoft tools addresses Woodgrove Bank’s risks:

- Microsoft Entra Privileged Identity Management for managing standing privileges.
- Purview Information Protection and DLP for classifying and protecting sensitive data.
- Defender for Identity and Microsoft Sentinel for unified visibility and incident response.

This architecture emphasizes:

- Automation
- Policy-driven controls
- Telemetry correlation across cloud and on-premises systems

It's scalable, integrated, and operationally efficient—directly addressing overprivileged accounts, inconsistent provisioning, unmanaged guest access, and unclassified data.
