This module covers best practices for cybersecurity capabilities and controls, which are essential to reduce the risk of attackers succeeding.

## Learning objectives

In this module, you learn how to:

- Use Microsoft Cybersecurity Reference Architecture (MCRA) to design more secure solutions.
- Use Microsoft cloud security benchmark (MCSB) to design more secure solutions.

The content in the module helps you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Conceptual knowledge of security policies, requirements, zero trust architecture, and management of hybrid environments
- Working experience with zero trust strategies, applying security policies, and developing security requirements based on business goals

## Overview of MCRA

The [Microsoft Cybersecurity Reference Architectures (MCRA)](/security/cybersecurity-reference-architecture/mcra) are a set of technical diagrams that describe Microsoft’s cybersecurity capabilities. The diagrams describe how Microsoft security capabilities integrate with the following:

- Microsoft platforms like Microsoft 365 and Microsoft Azure
- Third party apps like ServiceNow and salesforce
- Third party platforms like Amazon Web Services (AWS) and Google Cloud Platform (GCP)

The MCRA contains diagrams on the following topics:

- Microsoft cybersecurity capabilities
- Zero Trust and a Zero Trust rapid modernization plan (RaMP)
- Zero trust user access
- Security operations
- Operational technology (OT)
- Multicloud and cross-platform capabilities
- Attack chain coverage
- Azure native security controls
- Security organizational functions

## Overview of MCSB

New services and features are released daily in Azure and other cloud platforms. Developers are rapidly publishing new cloud applications built on these services, and attackers are constantly seeking new ways to exploit misconfigured resources. The cloud moves fast, developers move fast, and attackers also move fast. How do you keep up and make sure that your cloud deployments are secure? How are security practices for cloud systems different from on-premises systems and different between cloud service providers? How do you monitor your workload for consistency across multiple cloud platforms?

Microsoft has found that using security benchmarks can help you quickly secure cloud deployments. A comprehensive security best practice framework from cloud service providers can give you a starting point for selecting specific security configuration settings in your cloud environment, across multiple service providers and allow you to monitor these configurations using a single pane of glass.

### Security controls

A control is a high-level description of a recommended feature or activity that needs to be addressed. Controls aren't specific to a technology or implementation. Security control recommendations are applicable to multiple cloud workloads. Each control is numbered and the control's recommendations identify a list of stakeholders that are typically involved in planning, approval, or implementation of the benchmark.

### MCSB control domains/control families
<!--
https://learn.microsoft.com/security/benchmark/azure/overview
-->
In the MCSB controls are grouped into "families" or "domains". The following table summarizes the security control domains in MCSB:

| Control Domains | Description |
|---|---|
| [Network security (NS)](https://learn.microsoft.com/security/benchmark/azure/mcsb-network-security) | Network Security covers controls to secure and protect networks, including securing virtual networks, establishing private connections, preventing, and mitigating external attacks, and securing DNS. |
| [Identity Management (IM)](https://learn.microsoft.com/security/benchmark/azure/mcsb-identity-management) | Identity Management covers controls to establish a secure identity and access controls using identity and access management systems, including the use of single sign-on, strong authentications, managed identities (and service principals) for applications, conditional access, and account anomalies monitoring. |
| [Privileged Access (PA)](https://learn.microsoft.com/security/benchmark/azure/mcsb-privileged-access) | Privileged Access covers controls to protect privileged access to your tenant and resources, including a range of controls to protect your administrative model, administrative accounts, and privileged access workstations against deliberate and inadvertent risk. |
| [Data Protection (DP)](https://learn.microsoft.com/security/benchmark/azure/mcsb-data-protection) | Data Protection covers control of data protection at rest, in transit, and via authorized access mechanisms, including discover, classify, protect, and monitor sensitive data assets using access control, encryption, key management and certificate management. |
| [Asset Management (AM)](https://learn.microsoft.com/security/benchmark/azure/mcsb-asset-management) | Asset Management covers controls to ensure security visibility and governance over your resources. That includes recommendations on permissions for security personnel, security access to asset inventory, and managing approvals for services and resources (inventory, track, and correct). |
| [Logging and Threat Detection (LT)](https://learn.microsoft.com/security/benchmark/azure/mcsb-logging-threat-detection) | Logging and Threat Detection covers controls for detecting threats on cloud, and enabling, collecting, and storing audit logs for cloud services, including enabling detection, investigation, and remediation processes with controls to generate high-quality alerts with native threat detection in cloud services; it also includes collecting logs with a cloud monitoring service, centralizing security analysis with a SIEM, time synchronization, and log retention. |
| [Incident Response (IR)](https://learn.microsoft.com/security/benchmark/azure/mcsb-incident-response) | Incident Response covers controls in incident response life cycle - preparation, detection and analysis, containment, and post-incident activities, including using Azure services (such as Microsoft Defender for Cloud and Sentinel) and/or other cloud services to automate the incident response process. |
| [Posture and Vulnerability Management (PV)](https://learn.microsoft.com/security/benchmark/azure/mcsb-posture-vulnerability-management) | Posture and Vulnerability Management focuses on controls for assessing and improving cloud security posture, including vulnerability scanning, penetration testing and remediation, as well as security configuration tracking, reporting, and correction in cloud resources. |
| [Endpoint Security (ES)](https://learn.microsoft.com/security/benchmark/azure/mcsb-endpoint-security) | Endpoint Security covers controls in endpoint detection and response, including use of endpoint detection and response (EDR) and anti-malware service for endpoints in cloud environments. |
| [Backup and Recovery (BR)](https://learn.microsoft.com/security/benchmark/azure/mcsb-backup-recovery)[Backup and Recovery (BR)](https://learn.microsoft.com/security/benchmark/azure/mcsb-backup-recovery) | Backup and Recovery covers controls to ensure that data and configuration backups at the different service tiers are performed, validated, and protected. |
| [DevOps Security (DS)](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security) | DevOps Security covers the controls related to the security engineering and operations in the DevOps processes, including deployment of critical security checks (such as static application security testing, vulnerability management) prior to the deployment phase to ensure the security throughout the DevOps process; it also includes common topics such as threat modeling and software supply security. |
| [Governance and Strategy (GS)](https://learn.microsoft.com/security/benchmark/azure/mcsb-governance-strategy) | Governance and Strategy provides guidance for ensuring a coherent security strategy and documented governance approach to guide and sustain security assurance, including establishing roles and responsibilities for the different cloud security functions, unified technical strategy, and supporting policies and standards. |

### Service baselines
<!--
https://learn.microsoft.com/security/benchmark/azure/security-baselines-overview
-->
Security baselines are standardized documents for Azure product offerings, describing the available security capabilities and the optimal security configurations to help you strengthen security through improved tooling, tracking, and security features. We currently have service baselines available for Azure only.

Security baselines for Azure focus on cloud-centric control areas in Azure environments. These controls are consistent with well-known industry standards such as: Center for Internet Security (CIS) or National Institute for Standards in Technology (NIST). Our baselines provide guidance for the control areas listed in the Microsoft cloud security benchmark v1.

Each baseline consists of the following components:

- How does a service behave?
- Which security features are available?
- What configurations are recommended to secure the service?

## Implement Microsoft cloud security benchmark

- **Plan** your MCSB implementation by reviewing the documentation for the enterprise controls and service-specific baselines to plan your control framework and how it maps to guidance like Center for Internet Security (CIS) Controls, National Institute of Standards and Technology (NIST), and the Payment Card Industry Data Security Standard (PCI-DSS) framework.
- **Monitor** your compliance with MCSB status (and other control sets) using the Microsoft Defender for Cloud – Regulatory Compliance Dashboard for your multicloud environment.
- **Establish** guardrails to automate secure configurations and enforce compliance with MCSB (and other requirements in your organization) using features such as Azure Blueprints, Azure Policy, or the equivalent technologies from other cloud platforms.

## Common use cases

Microsoft cloud security benchmark can often be used to address common challenges for customers or service partners who are:

- New to Azure (and other major cloud platforms, such as AWS) and looking for security best practices to ensure a secure deployment of cloud services and your own application workload.
- Looking to improve security posture of existing cloud deployments to prioritize top risks and mitigations.
- Using multicloud environments (such as Azure and AWS) and facing challenges in aligning the security control monitoring and evaluation using a single pane of glass.
- Evaluating the security features/capabilities of Azure (and other major cloud platforms, such as AWS) before onboarding/approving a service(s) into the cloud service catalog.
- Having to meet compliance requirements in highly regulated industries, such as government, finance, and healthcare. These customers need to ensure their service configurations of Azure and other clouds to meet the security specification defined in framework such as CIS, NIST, or PCI. MCSB provides an efficient approach with the controls already premapped to these industry benchmarks.

## Terminology

The terms "control" and "baseline" are often used in the Microsoft cloud security benchmark documentation. It's important to understand how MCSB uses these terms.

| Term | Description | Example |
|---|---|---|
| Control | A control is a high-level description of a feature or activity that needs to be addressed and isn't specific to a technology or implementation. | Data Protection is one of the security control families. Data Protection contains specific actions that must be addressed to help ensure data is protected. |
| Baseline | A baseline is the implementation of the control on the individual Azure services. Each organization dictates a benchmark recommendation and corresponding configurations are needed in Azure. Note: Today we have service baselines available only for Azure. | The Contoso company looks to enable Azure SQL security features by following the configuration recommended in the Azure SQL security baseline.|
