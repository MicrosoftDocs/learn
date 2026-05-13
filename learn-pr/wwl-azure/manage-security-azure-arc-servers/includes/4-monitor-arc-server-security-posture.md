Arc-enabled servers integrate seamlessly with Microsoft Defender for Cloud, appearing in asset inventory, security recommendations, and regulatory compliance assessments alongside Azure virtual machines. This unified view eliminates the operational overhead of managing separate security tools for cloud and on-premises infrastructure.

## View Arc servers in asset inventory

Arc-enabled servers appear in Defender for Cloud's asset inventory under the resource type filter **Machines - Azure Arc**. The inventory view displays each server's subscription, resource group, location (the Azure region where the Arc resource is registered, not the physical server location), and Defender coverage status.

When you enable Microsoft Defender for Servers Plan 1 or Plan 2 on a subscription containing Arc machines, Defender for Cloud automatically extends coverage to those servers. The inventory Coverage column indicates whether each Arc server has Defender enabled and which plan is active. Machines without coverage show actionable recommendations to enable Defender.

Filter the inventory by resource type to isolate Arc servers, by Defender coverage to identify gaps, or by subscription to review regional deployments. Tag-based filtering helps you segment servers by function, such as "production-scheduling" or "supply-chain," allowing focused security reviews for business-critical workloads.

## Review security recommendations for Arc servers

Defender for Cloud assesses Arc-enabled servers using the same security controls applied to Azure VMs. Recommendations appear in the **Recommendations** pane organized by severity: High, Medium, and Low. Each recommendation includes a description, remediation steps, and an estimated effort level.

Common recommendations for Arc servers include:

- **Install endpoint protection solution on machines** - prompts deployment of Microsoft Defender for Endpoint (MDE) via the MDE extension
- **System updates should be installed on your machines** - identifies missing security patches and provides remediation guidance through Azure Update Manager integration
- **Machines should be configured securely** - indicates noncompliance with OS security baselines, requiring Machine Configuration extension for detailed assessment

Recommendations that require extensions to provide detailed findings automatically deploy those extensions if you assigned the corresponding Azure Policy with DeployIfNotExists effect. For example, assigning the OS security baseline policy deploys the Machine Configuration extension, which then scans hundreds of configuration settings and reports specific noncompliant controls.

| Recommendation Severity | Meaning | Example |
|------------------------|---------|----------|
| High | Exposes server to immediate risk | Missing endpoint protection |
| Medium | Increases attack surface | Weak password policy |
| Low | Best practice improvement | Audit logging not optimized |

Remediate high-severity recommendations first to address the most critical risks. Many recommendations provide automated remediation workflows, such as one-click extension deployment or Azure Policy assignment links.

## Track regulatory compliance posture

Arc-enabled servers contribute to regulatory compliance assessments in Defender for Cloud. When you enable a compliance standard such as ISO 27001, PCI DSS, or NIST SP 800-53, Defender for Cloud evaluates Arc servers against the relevant controls and reports aggregate compliance scores.

The **Regulatory Compliance** dashboard displays compliance percentage for each standard and breaks down control categories. Select a standard to view individual controls, then drill into specific controls to see which Arc servers are compliant or noncompliant. This granular visibility supports audit preparation by providing evidence of control implementation across hybrid infrastructure.

Contoso Manufacturing is pursuing ISO 27001 certification. By enrolling factory servers with Arc and enabling Defender for Cloud, the security team tracks compliance across on-premises and Azure resources in a single dashboard. Auditors can review the compliance report to verify that Contoso's hybrid infrastructure meets ISO 27001 control requirements, such as access management, change tracking, and security monitoring.

## Monitor coverage with workbooks

The Defender for Cloud Coverage workbook visualizes which subscriptions have Defender plans enabled and which resources are protected. Filter the workbook by resource type to view Arc server coverage across your organization. The workbook highlights subscriptions with partial coverage, helping you identify gaps where Arc servers exist but Defender for Servers isn't enabled.

Use the workbook to track coverage expansion over time. As Contoso enrolls other factory servers with Arc, the workbook reflects increasing protected resource counts, providing a measurable metric for security program progress.

## Investigate security alerts for Arc servers

When Defender for Servers is enabled, Arc-enrolled servers generate security alerts based on behavioral analysis, threat intelligence, and anomaly detection. Alerts appear in the **Security Alerts** pane with details about the detected threat, affected resources, and recommended response actions.

Defender for Cloud correlates alerts across Azure and hybrid environments, creating unified incident views when a threat spans multiple resources. For example, if an attacker compromises an Arc server and uses it to probe Azure storage accounts, Defender for Cloud links the related alerts into a single incident, accelerating investigation and response.

Alert severity levels (High, Medium, Low, Informational) help you prioritize investigation. High-severity alerts indicate active exploitation or critical security violations requiring immediate action. Configure alert notifications to send high-severity alerts to your security operations center (SOC) via email, webhook, or integration with Microsoft Sentinel.

## Manage Extended Security Updates for Arc servers

Arc-enabled servers running Windows Server 2012 or Windows Server 2012 R2 can receive Extended Security Updates (ESUs) through Azure Arc using a monthly pay-as-you-go billing model via your Azure subscription—no traditional volume licensing keys or manual key activation required. Extended Security Updates (ESUs) are free only for servers hosted in Azure; on-premises servers connected via Arc must purchase ESU coverage. ESU Year 3 support ends October 13, 2026, making server modernization the long-term priority.

Defender for Cloud tracks ESU patch status and surfaces recommendations when critical ESU patches are missing. Integrate Arc servers with Azure Update Manager to automate ESU deployment on a recurring schedule, ensuring servers remain protected against vulnerabilities in end-of-support operating systems.

## Review posture at Contoso Manufacturing

Contoso's engineering team uses Defender for Cloud to monitor the security posture of Arc-enrolled factory servers. The team filters the asset inventory to view all **Machines - Azure Arc**, confirms that Defender for Servers Plan 1 is enabled on all resources, and reviews the top three security recommendations: install endpoint protection, apply system updates, and configure machines securely.

The regulatory compliance dashboard shows 78% compliance with ISO 27001 controls for Arc servers, up from 0% before Arc enrollment. The remaining noncompliant controls require machine configuration policy remediation and endpoint protection deployment, both scheduled for completion in the next sprint.

By centralizing security monitoring in Defender for Cloud, Contoso gains unified visibility across Azure and on-premises infrastructure, accelerates compliance reporting, and reduces the operational burden of managing separate security tools for hybrid environments.
