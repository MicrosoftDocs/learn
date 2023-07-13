In this module, you learn how to:

-   Evaluate security posture of existing application portfolios
-   Evaluate threats to business-critical applications by using threat modeling
-   Design and implement a full lifecycle strategy for application security
-   Design and implement standards and practices for securing the application development process
-   Design a solution for workload identity to authenticate and access Azure cloud resources
-   Design a solution for API management and security
-   Design a solution for secure access to applications

The content in the module helps you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Advanced experience and knowledge in identity and access, platform protection, security operations, securing data, and securing applications.
- Experience with hybrid and cloud implementations.

## Application and DevOps security

DevOps Security covers the controls related to the security engineering and operations in the DevOps processes, including deployment of critical security checks (such as static application security testing, vulnerability management) prior to the deployment phase to ensure the security throughout the DevOps process; it also includes common topics such as threat modeling and software supply security.

This unit gives a summary of the Microsoft cloud security benchmark controls in the [DevOps Security family](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security).

Please refer to [Introduction to Microsoft Cybersecurity Reference Architecture and cloud security benchmark](/training/modules/design-solutions-microsoft-cybersecurity-cloud-security-benchmark/1-introduction-reference-architecture-benchmark) for more background on Microsoft Cloud Security Benchmark. 

In the summary below, we have included controls from the full baseline where:

* Security controls were *supported* but *not* enabled by default
* There was explicit guidance which contained action to be taken on the part of the customer

Microsoft cloud security benchmark outlines seven critical controls for DevOps security.

1. [DS-1: Conduct threat modeling](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security#ds-1-conduct-threat-modeling)
2.  [DS-2: Ensure software supply chain security](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security#ds-2-ensure-software-supply-chain-security)
3.  [DS-3: Secure DevOps infrastructure](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security#ds-3-secure-devops-infrastructure)
4.  [DS-4: Integrate static application security testing into DevOps pipeline](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security#ds-4-integrate-static-application-security-testing-into-devops-pipeline)
5.  [DS-5: Integrate dynamic application security testing into DevOps pipeline](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security#ds-5-integrate-dynamic-application-security-testing-into-devops-pipeline)
6.  [DS-6: Enforce security of workload throughout DevOps lifecycle](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security#ds-6-enforce-security-of-workload-throughout-devops-lifecycle)
7.  [DS-7: Enable logging and monitoring in DevOps](https://learn.microsoft.com/security/benchmark/azure/mcsb-devops-security#ds-7-enable-logging-and-monitoring-in-devops)

Those controls are summarized in the following table:

| Control number | Title | Summary |
|---|---|---|
| DS-1  | Conduct threat modeling  | Perform threat modeling to identify the potential threats and enumerate the mitigating controls  |
| DS-2  | Ensure software supply chain security  | Ensure your enterprise’s SDLC (Software Development Lifecycle) or process include a set of security controls to govern the in-house and third-party software components (including both proprietary and open-source software) where your applications have dependencies. Define gating criteria to prevent vulnerable or malicious components being integrated and deployed into the environment.  |
| DS-3  | Secure DevOps infrastructure  | Ensure the DevOps infrastructure and pipeline follow security best practices across environments including your build, test, and production stages.  |
| DS-4  | Integrate static application security testing into DevOps pipeline  | Ensure static application security testing (SAST) fuzzy testing, interactive testing, mobile application testing, are part of the gating controls in the CI/CD workflow. The gating can be set based on the testing results to prevent vulnerable packages from committing into the repository, building into the packages, or deploying into the production.  |
| DS-5  | Integrate dynamic application security testing into DevOps pipeline  | Ensure dynamic application security testing (DAST) is part of the gating controls in the CI/CD workflow. The gating can be set based on the testing results to prevent vulnerability from building into the packages or deploying into the production.  |
| DS-6  | Enforce security of workload throughout DevOps lifecycle  | Ensure the workload is secured throughout the entire lifecycle in development, testing, and deployment stage. Use Microsoft Cloud Security Benchmark to evaluate the controls (such as network security, identity management, privileged access, and so on) that can be set as guardrails by default or shift left prior to the deployment stage. In particular, ensure the following controls are in place in your DevOps process:- Automate the deployment by using Azure or third-party tooling in the CI/CD workflow, infrastructure management (infrastructure as code), and testing to reduce human error and attack surface.  |
| DS-7  | Enable logging and monitoring in DevOps  | Ensure your logging and monitoring scope includes nonproduction environments and CI/CD workflow elements used in DevOps (and any other development processes). The vulnerabilities and threats targeting these environments can introduce significant risks to your production environment if they aren't monitored properly. The events from the CI/CD build, test and deployment workflow should also be monitored to identify any deviations in the CI/CD workflow jobs.  |
