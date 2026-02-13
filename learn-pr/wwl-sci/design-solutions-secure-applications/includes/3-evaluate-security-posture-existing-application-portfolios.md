With standards defined and a lifecycle strategy in place, you need to assess where your existing applications stand against these security expectations. Most organizations have a portfolio of applications built over time under varying security standards. Evaluating the security posture of this portfolio helps you prioritize remediation, identify systemic weaknesses, and demonstrate compliance progress to stakeholders.

This unit focuses on the tools and approaches a cybersecurity architect uses to assess application security posture, centered on Microsoft Defender for Cloud and Microsoft Defender for Cloud Apps.

## Microsoft Defender for Cloud as a CNAPP

Microsoft Defender for Cloud is a Cloud Native Application Protection Platform (CNAPP) that unifies three core capabilities into a single solution:

- **Cloud Security Posture Management (CSPM)** checks and improves security posture across cloud resources.
- **Development Security Operations (DevSecOps)** manages code-level security across multicloud and multi-pipeline environments.
- **Cloud Workload Protection Platform (CWPP)** defends workloads such as VMs, containers, databases, and serverless functions from threats.

For application portfolio evaluation, the CSPM and DevSecOps capabilities are particularly relevant. They provide security recommendations, a composite secure score, and compliance assessments that help you understand the aggregate security posture of your application portfolio.

### Foundational vs. advanced CSPM

Defender for Cloud provides free Foundational CSPM capabilities, including centralized policy management, a secure score, and multicloud coverage. The paid Defender CSPM plan adds advanced capabilities that are critical for comprehensive portfolio evaluation:

- **Attack path analysis** models traffic patterns and identifies potential risk paths through your environment before changes are implemented.
- **Cloud Security Explorer** builds queries across a graph of your cloud environment to find security risks, such as internet-exposed applications with known vulnerabilities.
- **Security governance** assigns remediation tasks to resource owners with deadlines and tracks progress toward security policy alignment.
- **Regulatory compliance** assessments verify your application portfolio against standards such as Microsoft Cloud Security Benchmark, NIST SP 800-53, PCI-DSS, and ISO 27001.

### DevSecOps insights

Defender for Cloud extends posture management to the development pipeline itself. By connecting Azure DevOps, GitHub, and GitLab repositories, you gain visibility into infrastructure-as-code misconfigurations and exposed secrets in your codebase. These findings correlate with runtime cloud security posture data, giving you a code-to-cloud view of risk.

For example, Defender for Cloud can identify that a container image deployed in production was built from a repository with known IaC misconfigurations, connecting the development-time issue to the runtime exposure.

## Microsoft Defender for Cloud Apps

While Defender for Cloud focuses on the security of your IaaS and PaaS workloads, Microsoft Defender for Cloud Apps (a Cloud Access Security Broker, or CASB) provides visibility and control over the SaaS applications in your portfolio. This includes both Microsoft SaaS applications (such as Microsoft 365) and non-Microsoft SaaS applications (such as Salesforce, Box, or ServiceNow).

Defender for Cloud Apps delivers full protection for SaaS applications across four capability areas:

- **Fundamental CASB functionality.** Discover and identify over 31,000 cloud apps in use across your organization through Shadow IT discovery. Risk-rank each app based on more than 90 risk factors covering security, compliance, and legal requirements. Classify and protect sensitive data across sanctioned and unsanctioned cloud apps using Microsoft Purview Information Protection integration. Evaluate whether your cloud apps meet regulatory compliance requirements and enforce data residency policies.
- **SaaS Security Posture Management (SSPM).** Assess and improve the security configuration of your SaaS applications. SSPM identifies misconfigurations in connected apps and provides recommendations to strengthen their security posture, helping security teams reduce risk across the SaaS estate.
- **Advanced threat protection.** As part of the Microsoft Defender XDR solution, detect anomalous behavior across cloud apps, including impossible travel, suspicious inbox rules, ransomware activity, and compromised accounts. Signal correlation across the full kill chain of advanced attacks provides broader visibility than standalone CASB solutions.
- **App-to-app protection.** Monitor and govern OAuth-enabled apps that have permissions and privileges to critical data and resources. Detect overprivileged or unused apps, enforce app hygiene policies, and identify risky app-to-app interactions including unmanaged generative AI applications.

The architecture of Defender for Cloud Apps uses Cloud Discovery (which analyzes traffic logs to identify apps in use), app connectors (API-level integration with major SaaS providers), and Conditional Access App Control (which proxies sessions for real-time monitoring and control).

## Evaluation approach for architects

As an architect designing a portfolio evaluation strategy, consider the following structured approach:

### Establish a security baseline

Define the minimum security requirements all applications must meet. Use the Microsoft Cloud Security Benchmark as a starting point and customize it based on your organization's risk tolerance, industry regulations, and data classification policies.

### Classify applications by risk

Not all applications warrant the same level of scrutiny. Classify your portfolio into tiers based on:

- **Data sensitivity:** applications processing regulated or classified data require the most rigorous assessment.
- **External exposure:** internet-facing applications and APIs carry more risk than internal tools.
- **Business criticality:** applications supporting critical business processes require higher availability and security assurance.
- **User population:** applications serving external customers face different threat profiles than internal employee tools.

### Assess and prioritize findings

Use the Defender for Cloud secure score and compliance dashboards to establish a portfolio-wide view. Identify systemic patterns, such as consistently misconfigured network security groups, missing encryption at rest, or overly permissive identity configurations. Systemic issues indicate gaps in standards or governance that affect multiple applications simultaneously.

Prioritize remediation based on attack path analysis rather than individual finding severity alone. A medium-severity finding on an internet-exposed application with access to sensitive data may represent greater risk than a high-severity finding on an isolated internal tool.

### Track progress and report

Use security governance features to assign remediation tasks with deadlines and owners. Track Secure Score trends over time to demonstrate improvement. Report against regulatory compliance frameworks to satisfy audit requirements.

### Integrate with DevOps workflows

Connect your code repositories to Defender for Cloud to extend posture assessment to the development pipeline. This creates a continuous feedback loop where security issues identified in production inform development practices, and security gates in the pipeline prevent new issues from reaching production.

## Defender for specific application workloads

Defender for Cloud includes specialized plans for evaluating specific application types:

- **Defender for App Service** identifies attacks targeting applications running on Azure App Service.
- **Defender for Containers** provides environment hardening, vulnerability assessment, and runtime protection for Kubernetes clusters and container workloads.
- **Defender for APIs** provides visibility into business-critical APIs, improves API security posture, and detects active real-time threats.
- **Defender for Key Vault** detects unusual attempts to access or exploit key vault accounts that store application secrets.

These workload-specific plans supplement the general CSPM assessment with deep, service-aware security intelligence.


