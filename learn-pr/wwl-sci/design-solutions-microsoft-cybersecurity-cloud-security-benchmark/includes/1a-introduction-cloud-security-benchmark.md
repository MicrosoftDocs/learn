New services and features are released daily in Azure and cloud service providers platforms. Developers rapidly publish new cloud applications built on these services. And bad actors constantly seek new ways to exploit misconfigured resources. The cloud moves fast. Developers move fast. Bad actors also move fast. How do you keep up and make sure that your cloud deployments are secure? How are security practices for cloud systems different from on-premises systems and different between cloud service providers? How do you monitor your workload for consistency across multiple cloud platforms?

Microsoft found that using security benchmarks can help you quickly secure cloud deployments. A comprehensive security best practice framework from cloud service providers can give you a starting point for selecting specific security configuration settings in your cloud environment, across multiple service providers.

## The Microsoft cloud security benchmark v2 (preview)

>[!NOTE]
>Microsoft cloud security benchmark v2 is currently in preview. This version supersedes Microsoft cloud security benchmark v1.

The [Microsoft cloud security benchmar v2 (MCSB)](/security/benchmark/azure/overview) is a collection of high-impact security recommendations you can use to help secure your cloud services in Azure and other cloud environments like AWS and GCP. It provides a comprehensive security best practice framework with specific configuration settings and guidance that you can monitor across multiple cloud platforms.

The **Microsoft cloud security benchmark** provides prescriptive best practices and recommendations to help improve the security of workloads, data, and services on Azure and your multicloud environment. This benchmark focuses on cloud-centric security areas with input from an extensive set of holistic Microsoft and industry security frameworks and guidance, including:

- **Cloud Adoption Framework**: The Microsoft Cloud Adoption Framework for Azure (CAF) delivers comprehensive, step-by-step guidance for cloud adoption success.
- **Azure Well-Architected Framework**: The Azure Well-Architected Framework (WAF) is a design framework and set of best practices that helps architects and developers build high-quality workloads on Microsoft Azure.
- **Microsoft Secure Future Initiative**: The Microsoft Secure First Initiative (SFI) is a Microsoft initiative launched to embed security into every stage of product design, development, and operations. The ongoing evolution of SFI informs security innovation, development, and best practices across Microsoft. It also provides us with ongoing opportunities to work with customers and the broader security industry to strengthen our collective defenses.
- **Other industry and cloud service providers security best practice standards and framework**: Examples include the Amazon Web Services (AWS) Well-Architected Framework, Center for Internet Security (CIS) Controls, National Institute of Standards and Technology (NIST), and Payment Card Industry Data Security Standard (PCI-DSS).

## Common use cases

As a cybsecurity architect, common use cases for the Microsoft cloud security benchmark include:

- New to Azure (and other major cloud platforms, such as AWS) and looking for security best practices to ensure a secure deployment of cloud services and your own application workload.
- Looking to improve security posture of existing cloud deployments to prioritize top risks and mitigations.
- Using multicloud environments (such as Azure and AWS) and facing challenges in aligning security control monitoring and evaluation using a single pane of glass.
- Evaluating the security features and capabilities of Azure (and other major cloud platforms, such as AWS) before onboarding or approving a service into the cloud service catalog.
- Having to meet compliance requirements in highly regulated industries, such as government, finance, and healthcare. These customers need to ensure their service configurations of Azure and other clouds to meet the security specification defined in framework such as CIS, NIST, or PCI. MCSB  provides an efficient approach with the controls already pre-mapped to these industry benchmarks.

## Terminology

The Microsoft cloud security benchmark uses several key terms to organize and describe security guidance. It's important to understand how MCSB uses these terms.

| Term | Description | Example |
|--|--|--|
| Security Domain | A high-level grouping of related security controls that address a specific area of security concern. | Artificial Intelligence Security is one of the 12 security domains in MCSB v2. It groups all security controls related to securing AI workloads and services. |
| Security Control | A specific security requirement or recommendation within a domain that needs to be addressed. Security controls are technology-agnostic descriptions of what you should achieve. | Within the Data Protection domain, "DP-1: Discover, classify, and label sensitive data" is a security control that describes the need to identify and categorize sensitive information. |
| Security Subcontrol | A detailed, granular recommendation or implementation guidance that supports a security control. A security subcontrol provides specific technical or procedural steps. | Under security control DP-1, security subcontrol DP-1.1 provides specific guidance for implementing data classification using Microsoft Purview or similar tools. |
| Baseline | A set of security control implementations tailored for a specific scenario, compliance framework, or industry. | While baselines for MCSB v2 (preview) aren't yet available, you can find information on the MCSB v1 baselines at [Overview of Microsoft cloud security benchmark v1](overview-mcsb-v1.md). |

### MCSB security domains

The following table summarizes the security domains in MCSB:

| Security Domains | Description |
|---|---|
| [Network security (NS)](/security/benchmark/azure/mcsb-network-security) | Network Security covers controls to secure and protect networks, including securing virtual networks, establishing private connections, preventing, and mitigating external attacks, and securing DNS. |
| [Identity Management (IM)](/security/benchmark/azure/mcsb-identity-management) | Identity Management covers controls to establish a secure identity and access controls using identity and access management systems, including the use of single sign-on, strong authentications, managed identities (and service principals) for applications, conditional access, and account anomalies monitoring. |
| [Privileged Access (PA)](/security/benchmark/azure/mcsb-privileged-access) | Privileged Access covers controls to protect privileged access to your tenant and resources, including a range of controls to protect your administrative model, administrative accounts, and privileged access workstations against deliberate and inadvertent risk. |
| [Data Protection (DP)](/security/benchmark/azure/mcsb-data-protection) | Data Protection covers control of data protection at rest, in transit, and via authorized access mechanisms, including discover, classify, protect, and monitor sensitive data assets using access control, encryption, key management and certificate management. |
| [Asset Management (AM)](/security/benchmark/azure/mcsb-asset-management) | Asset Management covers controls to ensure security visibility and governance over your resources. That includes recommendations on permissions for security personnel, security access to asset inventory, and managing approvals for services and resources (inventory, track, and correct). |
| [Logging and Threat Detection (LT)](/security/benchmark/azure/mcsb-logging-threat-detection) | Logging and Threat Detection covers controls for detecting threats on cloud, and enabling, collecting, and storing audit logs for cloud services, including enabling detection, investigation, and remediation processes with controls to generate high-quality alerts with native threat detection in cloud services; it also includes collecting logs with a cloud monitoring service, centralizing security analysis with a SIEM, time synchronization, and log retention. |
| [Incident Response (IR)](/security/benchmark/azure/mcsb-incident-response) | Incident Response covers controls in incident response life cycle - preparation, detection and analysis, containment, and post-incident activities, including using Azure services (such as Microsoft Defender for Cloud and Sentinel) and/or other cloud services to automate the incident response process. |
| [Posture and Vulnerability Management (PV)](/security/benchmark/azure/mcsb-posture-vulnerability-management) | Posture and Vulnerability Management focuses on controls for assessing and improving cloud security posture, including vulnerability scanning, penetration testing and remediation, as well as security configuration tracking, reporting, and correction in cloud resources. |
| [Endpoint Security (ES)](/security/benchmark/azure/mcsb-endpoint-security) | Endpoint Security covers controls in endpoint detection and response, including use of endpoint detection and response (EDR) and anti-malware service for endpoints in cloud environments. |
| [Backup and Recovery (BR)](/security/benchmark/azure/mcsb-backup-recovery) | Backup and Recovery cover controls to ensure that data and configuration backups at the different service tiers are performed, validated, and protected. |
| [DevOps Security (DS)](/security/benchmark/azure/mcsb-devops-security) | DevOps Security covers the controls related to the security engineering and operations in the DevOps processes, including deployment of critical security checks (such as static application security testing, vulnerability management) prior to the deployment phase to ensure the security throughout the DevOps process; it also includes common topics such as threat modeling and software supply security. |
| [Governance and Strategy (GS)](/security/benchmark/azure/mcsb-governance-strategy) | Governance and Strategy provide guidance for ensuring a coherent security strategy and documented governance approach to guide and sustain security assurance, including establishing roles and responsibilities for the different cloud security functions, unified technical strategy, and supporting policies and standards. |
| [AI Security (AIS)](/security/benchmark/azure/mcsb-ai-security) | AI Security is a new control domain that addresses security considerations specific to AI workloads. It covers protecting AI systems throughout their lifecycle, including data preparation, model training, deployment, and inference operations. |

### Security controls

A control is a high-level description of a recommended feature or activity, within a domain, that needs to be addressed. Controls aren't specific to a technology or implementation. Each control is numbered and includes information across the following sections: in sections, including

For example, the MCSBv2 domain for AI, includes the following controls:

- AI-1: Ensure use of approved models
- AI-2: Implement multi-layered content filtering
- AI-3: Adopt safety meta-prompts
- AI-4: Apply least privilege for agent functions
- AI-5: Ensure human-in-the-loop
- AI-6: Establish monitoring and detection
- AI-7: Perform continuous AI Red Teaming

The complete list of the security controls for each domain is available in the [Microsoft cloud security benchmark documentation](/security/benchmark/azure/).

Each security control in the benchmark includes the following sections:

- **Azure Policy**: Links to Azure built-in policy definitions that you can use to measure and enforce the security control, when applicable.
- **Security principle**: High-level description of the security control at the technology-agnostic level, explaining the "what" and "why" of the security control.
- **Risk to mitigate**: The specific security risks and threats that the security control aims to address.
- **MITRE ATT&CK**: The MITRE ATT&CK tactics, techniques, and procedures (TTPs) relevant to the security risks.
- **Implementation guidance**: Detailed Azure-specific technical guidance organized explaining how to implement the security control using Azure features and services.
- **Implementation example**: Practical real-world scenario demonstrating how to implement the security control, including the challenge, solution approach, and outcome.
- **Criticality level**: Indicates the relative importance of the security control for security posture.
- **Control Mapping**: Mappings to industry security standards and frameworks such as CIS, NIST, PCI, ISO, and others. 

### Service baselines

Security baselines are standardized documents for Azure product offerings, describing the available security capabilities and the optimal security configurations to help you strengthen security through improved tooling, tracking, and security features. We currently have service baselines available for Azure only.

Security baselines for Azure focus on cloud-centric control areas in Azure environments. These controls are consistent with well-known industry standards such as: Center for Internet Security (CIS) or National Institute for Standards in Technology (NIST). Our baselines provide guidance for the control areas listed in the Microsoft cloud security benchmark v1.

Each baseline consists of the following components:

- How does a service behave?
- Which security features are available?
- What configurations are recommended to secure the service?

The complete list of security baselines for Azure is available as part of the [Microsoft cloud security benchmark documentation](/security/benchmark/azure/).
