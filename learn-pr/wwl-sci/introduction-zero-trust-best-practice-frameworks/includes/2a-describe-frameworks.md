Microsoft provides several best practice frameworks that cybersecurity architects use to design and evaluate security across the organization. Each framework serves a different purpose and audience. Understanding the scope and intent of each framework helps you choose the right guidance for a given situation.

## Cloud Adoption Framework

The Microsoft Cloud Adoption Framework (CAF) is a structured roadmap that helps organizations successfully adopt Azure and integrate it into their existing IT environments. CAF provides best practices and guidance throughout the entire cloud adoption lifecycle.

CAF organizes guidance into seven core methodologies: **Strategy**, **Plan**, **Ready**, **Adopt**, **Govern**, **Secure**, and **Manage**. The foundational methodologies (Strategy, Plan, Ready, and Adopt) are sequential and help you define business outcomes, prepare your organization and environment, and deploy workloads. The operational methodologies (Govern, Secure, and Manage) help ensure your Azure environment remains compliant, protected, and optimized over time.

CAF includes security guidance related to organizational roles and responsibilities, security best practices, and reference implementations. It serves organizations across all industries and scales that are pursuing cloud adoption.

:::image type="content" source="../media/cloud-adoption-framework.png" alt-text="Diagram showing the Cloud Adoption Framework methodologies including Strategy, Plan, Ready, Adopt, Govern, Secure, and Manage.":::

## Azure Well-Architected Framework

The Azure Well-Architected Framework (WAF) is a design framework that improves the quality of a workload. WAF helps you design workloads that are resilient, secure, cost-optimized, operationally excellent, and efficient.

WAF is founded on five pillars of architectural excellence:

- **Reliability:** Ensures workloads are resilient, available, and recoverable.
- **Security:** Protects workloads against threats.
- **Cost Optimization:** Ensures workloads deliver sufficient return on investment.
- **Operational Excellence:** Supports responsible development and operations.
- **Performance Efficiency:** Ensures workloads accomplish their purpose within acceptable timeframes.

WAF is workload-focused. It applies to teams responsible for improving individual workloads and addressing cross-cutting design concerns. If you're seeking guidance for improving a portfolio of workloads through centralized controls, CAF is the more appropriate framework.

:::image type="content" source="../media/well-architected-framework.png" alt-text="Diagram showing the Azure Well-Architected Framework pillars including Reliability, Security, Cost Optimization, Operational Excellence, and Performance Efficiency.":::

## Microsoft Cybersecurity Reference Architectures

The Microsoft Cybersecurity Reference Architectures (MCRA) are technical architectures that enable you to adopt end-to-end security using Zero Trust principles. MCRA describes end-to-end security for the "hybrid of everything" technology estate, spanning legacy IT, multicloud, Internet of Things (IoT), Operational Technology (OT), Artificial Intelligence (AI), and more.

MCRA is a component of Microsoft's Security Adoption Framework (SAF) and includes:

- Antipatterns (common mistakes) and best practices.
- Guidance for successfully adopting an end-to-end security approach using Zero Trust principles.
- Detailed diagrams for Microsoft cybersecurity capabilities, Zero Trust user access, security operations, operational technology, multicloud capabilities, and more.
- Mapping of Microsoft capabilities to Zero Trust standards and organizational roles.

Organizations commonly use MCRA as a starting template for a security architecture, a comparison reference for security capabilities, a learning tool for Microsoft capabilities and integration investments, or a way to understand cybersecurity concepts.

## Microsoft cloud security benchmark

The Microsoft cloud security benchmark version 2 (MCSBv2) provides prescriptive best practices and recommendations to help improve the security of workloads, data, and services across Azure and multicloud environments. MCSBv2 builds on input from Microsoft and industry security guidance, including the Cloud Adoption Framework, the Azure Well-Architected Framework, and industry standards such as CIS Controls, NIST SP 800-53, PCI-DSS, and ISO 27001.

MCSBv2 organizes security controls into 12 **security domains**—high-level groupings of related controls that address a specific area of security concern. These domains include Network Security (NS), Identity Management (IM), Privileged Access (PA), Data Protection (DP), Asset Management (AM), Logging and Threat Detection (LT), Incident Response (IR), Posture and Vulnerability Management (PV), Endpoint Security (ES), Backup and Recovery (BR), DevOps Security (DS), and a new domain introduced in version 2: Artificial Intelligence Security (AI).

Each domain contains numbered controls and subcontrols. For example, the Network Security domain includes the control **NS-1: Establish network segmentation boundaries**, which provides a security principle, risk analysis, MITRE ATT&CK mapping, and implementation guidance through subcontrols such as NS-1.1 and NS-1.2.

MCSBv2 maps each control to multiple compliance frameworks, including NIST, PCI-DSS v4, CIS Controls v8.1, and others. Organizations use MCSBv2 to plan and monitor their security posture, map controls to regulatory requirements, and establish guardrails to automate secure configurations through more than 420 Azure Policy built-in definitions. You can monitor MCSBv2 compliance using the Microsoft Defender for Cloud regulatory compliance dashboard.
