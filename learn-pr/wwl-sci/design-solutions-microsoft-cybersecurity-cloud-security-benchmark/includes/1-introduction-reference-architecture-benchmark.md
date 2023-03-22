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

The Microsoft cloud security benchmark (MCSB) includes a collection of high-impact security recommendations you can use to help secure your cloud services in a single or multicloud environment. MCSB recommendations include two key aspects:

- **Security controls**: Security controls recommendations are applicable across your cloud workloads. Each recommendation identifies a list of stakeholders that are typically involved in planning, approval, or implementation of the benchmark.
- **Service baselines**: Service baselines apply the controls to individual cloud services to provide recommendations on that specific service’s security configuration. We currently have service baselines available only for Azure.

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
