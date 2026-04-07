## Unit overview

Applying the Microsoft Power Platform Well-Architected Framework (WAF) ensures intelligent application workloads are designed for **resilience, security, operational excellence, performance efficiency, and experience optimization**. The framework is aligned with and built on the Microsoft Azure Well-Architected Framework, ensuring consistent architectural quality across both Azure and Power Platform solutions.

This unit prepares learners to apply these architectural pillars when building or modernizing intelligent applications with Power Apps, Power Automate, Copilot, and interconnected Azure services.

## Learning objectives

By the end of this unit, learners will be able to:
- Apply the **five pillars** of the Power Platform Well-Architected Framework to intelligent workloads.
- Evaluate workload design decisions using Power Platform Well-Architected principles.
- Map Azure Well-Architected architectural practices into Power Platform workloads.
- Identify architectural tradeoffs and align design choices with business outcomes.

## 1. Introduction to the Power Platform Well-Architected Framework

The **Power Platform Well-Architected Framework** provides a structured approach to designing modern application workloads that can meet current business requirements while adapting to future challenges.

The framework helps teams:

- Build reliable workloads.

- Increase security posture.

- Improve operational efficiency.

- Optimize performance.

- Deliver outstanding user experiences.

These pillars are derived from, and aligned with, the **Azure Well-Architected Framework**, ensuring consistency across cloud and low-code application architectures.

## 2. The five pillars of the Power Platform Well-Architected Framework

**Pillar 1: Reliability**

Build redundancy and resiliency into work loads so they meet uptime and recovery targets.

Examples:

- Redundant connectors and failover paths.

- Reliable retry policies in Power Automate.

- Resilient Dataverse architecture.

**Pillar 2: Security**

Secure workloads by protecting data confidentiality, integrity, and identity.

Examples:

- Least-privilege access through Microsoft Entra ID.

- DLP policies across environments.

- Secure connectors and API calls.

**Pillar 3: Operational Excellence**

Improve application reliability through observability, monitoring, and automated governance.

Examples:

- Power Platform Admin Center analytics.

- Application lifecycle management (ALM) with Azure DevOps or GitHub.

- Proactive alerts for performance changes.

**Pillar 4: Performance Efficiency**

Ensure workloads adjust to evolving demands with responsive and scalable architectures.

Examples:

- Using Dataverse for high-volume workloads.

- Offloading intensive tasks to Azure Functions.

- Right-sizing flows and action concurrency.

**Pillar 5: Experience Optimization**

Deliver meaningful experiences that help users achieve successful outcomes.

Examples:

- UX consistency across Power Apps.

- Copilot-assisted workflows for ease of use.

- Accessibility compliance.

## 3. Chart: Power Platform Well-Architected pillars

| **Pillar** | **Key Focus** | **Example Intelligent Workload Applications** |
|---|---|---|
| **Reliability** | Resiliency, uptime | Resilient automation systems, redundant connectors |
| **Security** | Identity, access, data protection | Secure customer data workflows |
| **Operational Excellence** | Monitoring, ALM | Automated governance and version control |
| **Performance Efficiency** | Scale, optimization | High-usage Power Apps with scalable Dataverse tables |
| **Experience Optimization** | UX, accessibility, user outcomes | Copilot-in-app guidance, streamlined app design |

## 4. Applying Azure Well-Architected principles to Power Platform

Azure WAF focuses on optimizing cloud workloads around **Reliability, Security, Cost Optimization, Operational Excellence, and Performance Efficiency**.

**Power Platform WAF adapts these principles** for low-code and intelligent application workloads:

| **Azure WAF Pillar** | **Power Platform Application** | **Example** |
|---|---|---|
| **Reliability** | Flow retries and fallback paths | Automated customer onboarding pipeline |
| **Security** | DLP, least privilege, secure connectors | Access-controlled HR applications |
| **Cost Optimization** | Efficient licensing, offloading compute | Evaluating premium connectors usage |
| **Operational Excellence** | ALM, monitoring | Automated deployment with governance |
| **Performance Efficiency** | Scalable Dataverse apps | Apps optimized for heavy data workloads |

## 5. References

These are the exact links provided for this unit:[[How to use...soft Learn | Learn.Microsoft.com]](/power-platform/well-architected/what-is-power-well-architected), [[Power Plat...soft Learn | Learn.Microsoft.com]](/power-platform/well-architected/), [[How to use...soft Learn | Learn.Microsoft.com]](/azure/well-architected/what-is-well-architected-framework).

