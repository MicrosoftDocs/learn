
This unit explores the key architectural and operational insights surfaced through the interactive case study on Contoso Healthcare Solutions’ hybrid identity and threat resilience posture. The simulation reveals systemic gaps common and provides a structured lens for you to analyze and reflect on them.

### Situation assessment summary

Contoso Healthcare Solutions operates a hybrid IT environment with legacy on-premises systems and cloud-hosted workloads. The organization faces several operational and security challenges:

- Remote access relies on legacy VPNs without adaptive controls or device posture checks.
- Data protection is compromised by outdated tape-based backups vulnerable to ransomware.
- Compliance is hindered by slow archival workflows and fragmented authentication mechanisms.
- Authentication is inconsistent across internal and external users, preventing uniform enforcement of Conditional Access and MFA.
- Incident response is siloed across departments, delaying containment and remediation.

These issues reflect systemic gaps in Zero Trust maturity and highlight the need for unified identity governance and coordinated threat response

### Threat analysis summary

Contoso Healthcare’s infrastructure and access control weaknesses expose the organization to significant security threats.

Key attack vectors include:

- Legacy VPN access without device posture checks or session controls, enabling lateral movement and data exfiltration.
- Fragmented identity systems that prevent consistent enforcement of multifactor authentication (MFA) and Conditional Access, leaving critical systems vulnerable.
- Outdated tape-based backups that lack modern detection and recovery safeguards, increasing the impact of ransomware attacks.
- Manual incident response processes and limited visibility that delay threat detection and hinder coordinated response efforts.

The threat analysis in the case study shows how traditional perimeter-based defenses fall short in hybrid environments and why unified identity governance and modern access controls are essential.

### Architectural Solution Summary

To address these challenges, the case study guides you through designing a Zero Trust–aligned architecture using Microsoft technologies.

Key components include:

- Microsoft Entra Private Access and Application Proxy to replace legacy VPNs and enforce identity-based access controls.
- Azure Backup with immutable vaults and anomaly detection to strengthen ransomware resilience.
- Microsoft Sentinel, Defender XDR, and Security Copilot for centralized, AI-assisted threat detection and response.
- Azure Arc and Azure Policy to enforce compliance baselines across hybrid workloads.
- Microsoft Entra Lifecycle Workflows and Entitlement Management to automate identity governance and streamline access reviews.

This integrated solution improves visibility, enforces consistent policies, and enhances operational resilience across Contoso’s hybrid environment.
