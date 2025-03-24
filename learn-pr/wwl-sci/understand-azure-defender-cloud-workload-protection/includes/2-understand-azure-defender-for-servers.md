Microsoft Defender for Servers provides threat detection and advanced defenses to your Windows and Linux machines whether they're running in Azure, AWS, GCP, or on-premises. To protect machines in hybrid and multicloud environments, Defender for Cloud uses Azure Arc.


Microsoft Defender for Servers is available in two plans:

- **Microsoft Defender for Servers Plan 1** - deploys Microsoft Defender for Endpoint to your servers and provides these capabilities:

  - Microsoft Defender for Endpoint licenses are charged per hour instead of per seat, lowering costs for protecting virtual machines only when they are in use.
  - Microsoft Defender for Endpoint deploys automatically to all cloud workloads so that you know they're protected when they spin up.
  - Alerts and vulnerability data from Microsoft Defender for Endpoint is shown in Microsoft Defender for Cloud

- **Microsoft Defender for Servers Plan 2** - includes the benefits of Plan 1 and support for all of the other Microsoft Defender for Servers features.

To enable the Microsoft Defender for Servers plans:

Go to Environment settings and select your subscription.

If Microsoft Defender for Servers isn't enabled, set it to On. Plan 2 is selected by default.

If you want to change the Defender for Servers plan:

In the Plan/Pricing column, select Change plan.
Select the plan that you want and select Confirm.

## Plan features

Plan features are summarized in the table.

**Feature** | **Plan support** | **Details**
--- | --- | ---
**Multicloud and hybrid support** | Supported in Plan 1 and 2 | Defender for Servers can protect Azure VMs, AWS/GCP VMs, and on-premises machines connected to Microsoft Defender for Cloud.
**Defender for Endpoint automatic onboarding** | Supported in Plan 1 and 2 | Microsoft Defender for Cloud automatically onboards machines to Defender for Endpoint by installing the Defender for Endpoint extension on connected machines.
**Defender for Endpoint EDR** | Supported in Plan 1 and 2 | Supported endpoints receive near real-time threat detection using Defender for Endpoint's EDR capabilities.
**Threat detection (OS-level)** | Supported in Plan 1 and 2 | Defender for Endpoint integration provides OS-level threat detection.
**Integrated alerts and incidents** | Supported in Plan 1 and 2 | Defender for Endpoint alerts and incidents for connected machines are displayed in Microsoft Defender for Cloud, with drill-down in the Defender portal.
**Threat detection (Azure network layer)** | Supported in Plan 2 only  | Agentless detection identifies threats directed at the control plane on the network, including network-based security alerts for Azure VMs.
**Software inventory discovery** | Supported in Plan 1 and 2 | Software inventory discovery (provided by Defender Vulnerability Management) is integrated into Defender for Cloud.
**Vulnerability scanning (agent-based)** | Supported in Plan 1 and 2 | The Defender for Endpoint agent allows Defender for Servers to assess machines for vulnerabilities with Defender Vulnerability Management.
**Vulnerability scanning (agentless)** | Supported in Plan 2 only | As part of its agentless scanning capabilities, Defender for Cloud provides agentless vulnerability assessment, using Defender Vulnerability Management. Agentless assessment is in addition to agent-based vulnerability scanning.
**OS baseline misconfigurations** | OS recommendations based on Linux and Windows compute security baselines are supported in Plan 2 only. Other MCSB recommendations in Defender for Cloud continue to be included in free foundational posture management. | Defender for Cloud assesses and enforces security configurations using built-in Azure policy initiatives, including its default Microsoft Cloud Security Benchmark (MCSB) initiative. Defender for Servers collects machine information using the Azure machine configuration extension.
**Regulatory compliance assessment** | Supported in Plan 1 and 2 | As part of its free foundational posture management, Defender for Cloud provides a couple of default compliance standards. If you have a Defender for Servers plan enabled (or any other paid plan), you can enable other compliance standards.
**OS system updates** | Supported in Plan 2 only | Defender for Servers assesses machine to check that updates and patches are installed. It uses Azure Update Manager to gather update information. To take advantage of Azure Update integration in Defender for Servers Plan 2, on-premises, AWS, and GCP machines should be onboarded with Azure Arc.
**Defender for Vulnerability Management premium features** | Supported in Plan 2 only | Defender for Servers Plan 2 includes premium features in Defender Vulnerability Management. Premium features include certificate assessments, OS security baseline assessments, and more, and are available in the Defender portal only.
**Malware scanning (agentless)** | Supported in Plan 2 only | In addition to the next-generation anti-malware protection provided by the Defender for Endpoint integration, Defender for Servers Plan 2 provides malware scanning as part of its agentless scanning capabilities.
**Machine secrets scanning (agentless)** | Supported in Plan 2 only | As part of its agentless secrets scanning capabilities, Defender for Cloud provides machine secrets scanning to locate plain text secrets on machines. Secrets scanning is also available with the Defender Cloud Security Posture Management (CSPM) plan.
**File integrity monitoring** | Supported in Plan 2 only | File integrity monitoring examines files and registries for changes that might indicate an attack. You configure file integrity monitoring after enabling Defender for Servers Plan 2. File integrity monitoring uses the Defender for Endpoint extension to collect information. The previous collection method that used the MMA is now deprecated.
**Just-in-time virtual machine access** | Supported in Plan 2 only | Just-in-time virtual machine access locks down machine ports to reduce the attack surface.
**Network map** | Supported in Plan 2 only | The network map provides a geographical view of recommendations for hardening your network resources.
**Free data ingestion (500 MB)** | Supported in Plan 2 only | Free data ingestion is available for specific data types in Log Analytics workspaces.

## What are the benefits of Defender for Servers?

- **Protect multicloud and on-premises machines**: Defender for Servers protects Windows and Linux machines in multicloud environments (Azure, Amazon Web Services (AWS), Google Cloud Platform (GCP)) and on-premises.
- **Centralize management and reporting**: Defender for Cloud offers a single view of monitored resources, including machines protected by Defender for Servers. Filter, sort, and cross-reference data to understand, investigate, and analyze machine security.
- **Integrate with Defender services**: Defender for Servers integrates with security capabilities provided by Defender for Endpoint and Microsoft Defender Vulnerability Management.
- **Improve posture and reduce risk**: Defender for Servers assesses the security posture of machines against compliance standards and provides security recommendations to remediate and improve security posture.
- **Benefit from agentless scanning**: Defender for Servers Plan 2 provides agentless machine scanning. Without an agent on endpoints, scan software inventory, assess machines for vulnerabilities, scan for machine secrets, and detect malware threats.
- **Protect against threats in near real-time**: Defender for Servers identifies and analyzes real-time threats and issues security alerts as needed.
- **Get intelligent threat detection**: Defender for Cloud evaluates events and detects threats using advanced security analytics and machine-learning technologies with multiple threat intelligence sources, including the Microsoft Security Response Center (MSRC).

## How does Defender for Servers collect data?

For Windows, Microsoft Defender for Cloud integrates with Azure services to monitor and protect your Windows-based machines. Defender for Cloud presents the alerts and remediation suggestions from all of these services in an easy-to-use format.

For Linux, Defender for Cloud collects audit records from Linux machines by using auditd, one of the most common Linux auditing frameworks.

For hybrid and multicloud scenarios, Defender for Cloud integrates with Azure Arc to ensure these non-Azure machines are seen as Azure resources.

