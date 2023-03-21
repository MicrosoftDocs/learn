In this module, you'll learn how to:

- Design security operations capabilities in hybrid and multicloud environments
- Design centralized logging and auditing
- Design Security Event Management (SIEM) solutions
- Design a solution for detection and response that includes Extended Detection and Response (XDR)
- Design a solution for security orchestration, automation and response (SOAR)
- Design security workflows
- Design and evaluate threat detection with the MITRE ATT&CK framework

The content in the module helps you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Advanced experience and knowledge in identity and access, platform protection, security operations, securing data, and securing applications.
- Experience with hybrid and cloud implementations.

## Introduction to security operations (SecOps)

The main objective of a cloud security operations (SecOps) function is to detect, respond to, and recover from active attacks on enterprise assets.

As SecOps matures, security operations should:

-   Reactively respond to attacks detected by tools
-   Proactively hunt for attacks that slipped past reactive detections

<!-- 
[](https://learn.microsoft.com/azure/cloud-adoption-framework/organize/cloud-security-operations-center#modernization)
-->
## Modernization

Detecting and responding to threats is currently undergoing significant modernization at all levels.

-   **Elevation to business risk management:** SOC is growing into a key component of managing business risk for the organization
-   **Metrics and goals:** Tracking SOC effectiveness is evolving from "time to detect" to these key indicators:
    -   **Responsiveness** via mean time to acknowledge (MTTA).
    -   **Remediation speed** via mean time to remediate (MTTR).
-   **Technology evolution:** SOC technology is evolving from exclusive use of static analysis of logs in a SIEM to add the use of specialized tooling and sophisticated analysis techniques. This provides deep insights into assets that provide high quality alerts and investigation experience that complement the breadth view of the SIEM. Both types of tooling are increasingly using AI and machine learning, behavior analytics, and integrated threat intelligence to help spot and prioritize anomalous actions that could be a malicious attacker.
-   **Threat hunting:** SOCs are adding hypothesis driven threat hunting to proactively identify advanced attackers and shift noisy alerts out of frontline analyst queues.
-   **Incident management:** Discipline is becoming formalized to coordinate nontechnical elements of incidents with legal, communications, and other teams. **Integration of internal context:** To help prioritize SOC activities such as the relative risk scores of user accounts and devices, sensitivity of data and applications, and key security isolation boundaries to closely defend.
<!--
[](https://learn.microsoft.com/azure/cloud-adoption-framework/organize/cloud-security-operations-center#team-composition-and-key-relationships)
-->

## Team composition and key relationships

The cloud security operations center is commonly made up of the following types of roles.

-   IT operations (close regular contact)
-   Threat intelligence
-   Security architecture
-   Insider risk program
-   Legal and human resources
-   Communications teams
-   Risk organization (if present)
-   Industry specific associations, communities, and vendors (before incident occurs)