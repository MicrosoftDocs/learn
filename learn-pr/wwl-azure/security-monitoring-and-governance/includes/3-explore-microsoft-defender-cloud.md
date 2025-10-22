**Microsoft Defender for Cloud** is Azure's unified cloud-native application protection platform (CNAPP) that provides comprehensive security posture management and threat protection across Azure, hybrid, and multi-cloud environments. Defender for Cloud combines security capabilities previously scattered across multiple tools into a single, integrated platform for protecting workloads, detecting threats, ensuring compliance, and providing actionable security recommendations.

As organizations adopt cloud infrastructure and DevOps practices, security visibility and threat detection become increasingly complex across distributed resources, multiple subscriptions, and diverse workload types. Defender for Cloud addresses these challenges by providing continuous security assessment, automated threat detection, workload-specific protection plans, and integration with development pipelines for DevSecOps workflows.

## Core capabilities

**Cloud Security Posture Management (CSPM):**

Defender for Cloud continuously assesses Azure resources, hybrid workloads, and multi-cloud deployments against security best practices and compliance standards. **CSPM** identifies misconfigurations, vulnerabilities, and compliance violations with actionable remediation guidance.

**Key CSPM features:**

- **Secure Score:** Centralized security posture metric quantifying organizational security health (0-100 score).
- **Security recommendations:** Prioritized list of configuration issues with remediation steps and Azure Policy integration.
- **Regulatory compliance dashboard:** Track compliance with standards including Azure Security Benchmark, PCI DSS, ISO 27001, HIPAA, SOC 2, and NIST.
- **Asset inventory:** Comprehensive view of all Azure resources with security status, vulnerabilities, and recommendations.
- **Attack path analysis:** Identify choke points where attackers could pivot between resources to reach high-value targets.
- **Cloud security graph:** Visualize relationships between resources, identities, and security controls to understand attack surface.

**Cloud Workload Protection (CWP):**

**Defender for Cloud** extends beyond posture assessment to provide **real-time threat detection** and protection for specific workload types through specialized Defender plans.

**Available Defender plans:**

- **Defender for Servers:** Vulnerability assessment, just-in-time VM access, file integrity monitoring, adaptive application controls, threat detection for Windows and Linux VMs.
- **Defender for Containers:** Kubernetes security, container image scanning, runtime threat detection, Kubernetes admission control.
- **Defender for App Service:** Web application firewall integration, threat detection for App Service plans, security recommendations for web apps.
- **Defender for Storage:** Malware scanning, sensitive data discovery, threat detection for Azure Storage accounts.
- **Defender for SQL:** Vulnerability assessment, threat detection, data classification for Azure SQL Database, SQL Managed Instance, and SQL on VMs.
- **Defender for Key Vault:** Anomaly detection, unusual access pattern identification, threat intelligence integration.
- **Defender for Resource Manager:** Azure control plane threat detection, suspicious management operations monitoring.
- **Defender for DNS:** DNS layer threat detection, domain generation algorithm detection, DNS tunneling identification.
- **Defender for open-source relational databases:** Threat detection for PostgreSQL, MySQL, and MariaDB.
- **Defender for Azure Cosmos DB:** Threat detection for NoSQL database operations, suspicious access pattern identification.

**DevSecOps integration:**

Defender for Cloud integrates with Azure DevOps and GitHub to **shift security left** by surfacing security findings directly in development workflows.

**DevSecOps capabilities:**

- **Code vulnerability scanning:** Scan infrastructure-as-code templates (ARM, Bicep, Terraform) for misconfigurations before deployment.
- **GitHub Advanced Security integration:** Surface GitHub code scanning, secret scanning, and dependency scanning findings in Defender for Cloud.
- **Pull request annotations:** Display security issues as pull request comments with remediation guidance.
- **Pipeline integration:** Block deployments with critical security issues through Azure Pipeline gates.
- **Security findings correlation:** Connect runtime security findings from Defender for Cloud to source code repositories for root cause analysis.

## Architecture and deployment

**Defender for Cloud architecture:**

Defender for Cloud operates through a combination of **Azure platform services** and **lightweight agents** deployed to resources.

**Foundational components:**

- **Microsoft Defender for Cloud portal:** Unified dashboard in Azure portal for managing security posture, viewing recommendations, investigating alerts, and configuring policies.
- **Azure Policy integration:** Security recommendations automatically generate Azure Policy assignments for governance enforcement.
- **Log Analytics workspace:** Centralized logging and analytics repository for security events, agent telemetry, and audit trails.
- **Microsoft Defender agents:** Lightweight agents (Azure Monitor Agent, Defender for Endpoint) collect security telemetry from VMs, containers, and hybrid resources.
- **Agentless scanning:** Vulnerability assessment and malware scanning without agent deployment (available for VMs and containers).

**Automatic provisioning:**

Defender for Cloud automatically provisions required agents when Defender plans are enabled:

**Azure Monitor Agent (AMA):**

- **Purpose:** Collect security events, file integrity monitoring data, and system logs from VMs.
- **Supported platforms:** Windows Server 2012+, Linux (various distributions).
- **Automatic deployment:** Enabled by default when Defender for Servers is activated.

**Defender for Endpoint integration:**

- **Purpose:** Advanced endpoint detection and response (EDR) capabilities including behavioral analysis, threat intelligence, and automated investigation.
- **Integration:** Defender for Cloud automatically onboards VMs to Microsoft Defender for Endpoint when Defender for Servers Plan 2 is enabled.
- **Unified experience:** Security alerts from Defender for Endpoint surface in Defender for Cloud dashboard.

**Agentless scanning:**

- **Purpose:** Vulnerability assessment and malware detection without deploying agents to VMs.
- **Mechanism:** Creates temporary disk snapshots, analyzes snapshots in isolated environment, deletes snapshots.
- **Benefits:** No performance impact, works with VMs where agent deployment isn't possible, scans stopped VMs.

## Enabling Defender for Cloud

**Defender for Cloud Foundational CSPM:**

**Foundational CSPM** (formerly Free tier) is automatically enabled for all Azure subscriptions at no cost, providing basic security posture assessment and recommendations.

**Foundational CSPM includes:**

- **Secure Score:** Basic security posture measurement.
- **Security recommendations:** Configuration issues and best practice violations.
- **Azure Security Benchmark:** Compliance assessment against Microsoft's security baseline.
- **Asset inventory:** List of Azure resources with basic security status.

**Enable Defender plans:**

**Defender plans** (formerly Standard tier) provide advanced threat protection, vulnerability assessment, and workload-specific security capabilities.

**Enable Defender plans for a subscription:**

1. **Navigate to Microsoft Defender for Cloud** in Azure portal.
2. **Click "Environment settings"** in left navigation.
3. **Select subscription** to protect.
4. **Click "Defender plans"** tab.
5. **Enable desired plans:**
   - Toggle specific plans (Servers, Containers, App Service, Storage, SQL, etc.) to **On**.
   - Configure plan settings (monitoring coverage, agent provisioning, data retention).
6. **Configure automatic provisioning:**
   - Click "Auto provisioning" tab.
   - Enable **Azure Monitor Agent** for VM data collection.
   - Enable **Defender for Endpoint** integration for advanced threat detection.
   - Enable **Vulnerability assessment** for automatic vulnerability scanning.
7. **Click "Save"** to apply configuration.

**Pricing considerations:**

- **Foundational CSPM:** Free for all Azure subscriptions.
- **Defender plans:** Priced per resource (VMs, storage accounts, SQL databases, etc.) with consumption-based billing.
- **Free trial:** 30-day free trial available for all Defender plans when first enabled.

## Secure Score

**Secure Score** is a centralized security posture measurement that quantifies organizational security health as a numerical score (0-100), with higher scores indicating better security posture.

**Score calculation:**

Secure Score is calculated based on the percentage of security recommendations successfully remediated:

$$
\text{Secure Score} = \frac{\text{Healthy Resources}}{\text{Total Resources}} \times \text{Recommendation Points}
$$

**Recommendation priority:**

Each recommendation contributes points to Secure Score based on its security impact:

- **High impact:** Recommendations addressing critical security risks (public-facing VM without NSG, storage account allowing anonymous access).
- **Medium impact:** Recommendations addressing important security improvements (missing OS patches, insecure TLS configuration).
- **Low impact:** Recommendations addressing minor security enhancements (diagnostic logging disabled, unused resources).

**Score improvement:**

**Improve Secure Score** by remediating security recommendations:

1. **Navigate to Secure Score** in Defender for Cloud.
2. **Review recommendations** sorted by potential score increase.
3. **Prioritize high-impact recommendations** addressing critical security risks.
4. **Implement remediation:**
   - **Manual remediation:** Follow step-by-step guidance in recommendation details.
   - **Quick fix:** Click "Quick fix" button to automatically remediate with Azure Policy or automation script.
   - **Bulk remediation:** Apply remediation to multiple resources simultaneously.
5. **Monitor score changes:** Secure Score updates reflect successful remediation (may take up to 24 hours).

**Score tracking:**

- **Score over time:** Historical view showing security posture trends and improvement progress.
- **Score by subscription:** Compare security posture across multiple Azure subscriptions.
- **Score by recommendation category:** Identify security areas requiring focused attention (identity, data, network, compute).

## Security recommendations

**Security recommendations** identify specific configuration issues, misconfigurations, and security best practice violations across Azure resources with actionable remediation guidance.

**Recommendation structure:**

Each recommendation includes:

- **Severity:** Critical, High, Medium, or Low based on security impact.
- **Recommendation name:** Descriptive title (e.g., "Virtual machines should encrypt temp disks, caches, and data flows").
- **Description:** Detailed explanation of security issue and potential risks.
- **Affected resources:** List of specific resources with the security issue.
- **Remediation steps:** Step-by-step instructions for resolving the issue.
- **Quick fix availability:** Automated remediation option using Azure Policy or scripts.
- **Secure Score impact:** Points contributed to Secure Score when remediated.

**Recommendation categories:**

- **Identity and access:** MFA enforcement, privileged account protection, role assignment reviews.
- **Data and storage:** Encryption at rest, encryption in transit, secure data transfer protocols.
- **Networking:** Network segmentation, firewall rules, DDoS protection, secure connectivity.
- **Compute:** VM security, container security, serverless security, patch management.
- **Application:** Web application firewall, CORS configuration, authentication settings.

**Remediation approaches:**

**Manual remediation:**

Follow detailed remediation steps provided in recommendation:

1. **Click recommendation** in Defender for Cloud.
2. **Review affected resources** list.
3. **Read remediation steps** in "Remediation steps" section.
4. **Apply changes** through Azure portal, CLI, or PowerShell.
5. **Verify remediation:** Resource disappears from affected resources list after assessment cycle.

**Quick fix remediation:**

Automated remediation for supported recommendations:

1. **Click recommendation** with "Quick fix available" badge.
2. **Select resources** to remediate.
3. **Click "Quick fix"** button.
4. **Review remediation details:** Preview changes to be applied (Azure Policy assignment, script execution).
5. **Click "Fix resources"** to apply automated remediation.
6. **Monitor progress:** Track remediation status and any errors.

**Azure Policy enforcement:**

**Prevent future violations** by enforcing compliance through Azure Policy:

1. **Click recommendation** with Azure Policy integration.
2. **Click "View policy definition"** to see underlying Azure Policy.
3. **Assign policy** at subscription or resource group scope.
4. **Configure effect:**
   - **Audit:** Log violations but don't prevent deployment.
   - **Deny:** Block deployment of non-compliant resources.
   - **DeployIfNotExists:** Automatically remediate during deployment.

## Security alerts and threat detection

**Security alerts** notify security teams of detected threats, suspicious activities, and potential security incidents across Azure resources.

**Alert types:**

- **Suspicious activity alerts:** Unusual resource access patterns, privilege escalation attempts, lateral movement indicators.
- **Threat intelligence alerts:** Known malicious IP addresses, domains, or file hashes detected accessing resources.
- **Anomaly detection alerts:** Behavioral analytics identify deviations from normal resource usage patterns.
- **Brute force alerts:** Password spray attacks, credential stuffing, repeated authentication failures.
- **Malware alerts:** Malicious software detected on VMs or in storage accounts.

**Alert properties:**

- **Severity:** High, Medium, Low, or Informational based on threat level.
- **Alert name:** Descriptive title indicating detected threat.
- **Description:** Detailed explanation of suspicious activity and potential impact.
- **Affected resource:** Specific resource (VM, storage account, SQL database) experiencing threat.
- **MITRE ATT&CK tactics:** Mapping to MITRE framework (Initial Access, Execution, Persistence, etc.).
- **Kill chain stage:** Attack progression stage (reconnaissance, exploitation, command and control, exfiltration).
- **Recommended actions:** Steps to investigate and remediate threat.

**Alert investigation:**

1. **Navigate to Security alerts** in Defender for Cloud.
2. **Click alert** to open investigation details.
3. **Review alert timeline:** Sequence of events leading to alert trigger.
4. **Examine affected resources:** Identify compromised systems and data.
5. **Check related alerts:** Identify multi-stage attacks with correlated alerts.
6. **Review recommended actions:** Follow investigation and remediation guidance.
7. **Take response actions:**
   - **Isolate resource:** Disconnect compromised VM from network.
   - **Block IP address:** Add malicious IPs to firewall deny rules.
   - **Reset credentials:** Change passwords and rotate keys for compromised accounts.
   - **Apply security updates:** Patch vulnerabilities exploited in attack.

**Alert lifecycle management:**

- **Active:** Alert requires investigation and response.
- **In progress:** Security team actively investigating alert.
- **Dismissed:** Alert determined to be false positive or acceptable risk.
- **Resolved:** Threat successfully remediated and verified.

## Just-in-time VM access

**Just-in-time (JIT) VM access** reduces attack surface by **dynamically opening management ports** (RDP, SSH, WinRM) only when needed for specific time periods, preventing persistent exposure to brute force attacks.

**JIT benefits:**

- **Reduces attack surface:** Management ports remain closed by default, eliminating standing exposure.
- **Prevents brute force attacks:** Attackers cannot continuously attempt authentication against closed ports.
- **Audit trail:** All JIT access requests are logged with requester identity, justification, and access duration.
- **Automated enforcement:** Network security group rules automatically open and close ports based on JIT policy.

**Configure JIT VM access:**

1. **Navigate to Microsoft Defender for Cloud**.
2. **Click "Workload protections"** in left navigation.
3. **Click "Just-in-time VM access"**.
4. **Select VMs** to protect with JIT.
5. **Configure JIT policy:**
   - **Ports:** RDP (3389), SSH (22), WinRM (5985, 5986).
   - **Allowed source IPs:** Specific IP addresses or ranges authorized to request access.
   - **Maximum access duration:** Time limit for access (1-24 hours).
6. **Enable JIT policy** to apply NSG rules.

**Request JIT access:**

Users request temporary access through Defender for Cloud or Azure portal:

1. **Navigate to VM** in Azure portal.
2. **Click "Connect"**.
3. **Click "Request access"** if JIT is enabled.
4. **Specify:**
   - **Port:** RDP (3389) or SSH (22).
   - **Source IP:** IP address from which to connect.
   - **Time range:** Duration of access needed (up to maximum configured).
   - **Justification:** Reason for access request.
5. **Submit request:** NSG rules automatically open port for specified IP and duration.
6. **Connect to VM:** Use RDP or SSH client to connect during access window.
7. **Automatic closure:** Port automatically closes when time expires.

## Regulatory compliance

**Regulatory compliance dashboard** provides continuous compliance assessment against industry standards and regulatory frameworks including Azure Security Benchmark, PCI DSS, ISO 27001, HIPAA, SOC 2, and NIST.

**Compliance assessment:**

Defender for Cloud maps security recommendations to compliance controls, showing percentage of controls successfully implemented for each standard.

**Compliance dashboard features:**

- **Compliance score:** Percentage of controls meeting compliance requirements for each standard.
- **Control mapping:** Security recommendations mapped to specific compliance controls.
- **Audit reports:** Exportable compliance reports for auditors and regulators.
- **Compliance over time:** Historical compliance trends showing improvement or regression.
- **Failed controls:** Prioritized list of non-compliant controls requiring remediation.

**Configure compliance standards:**

1. **Navigate to Regulatory compliance** in Defender for Cloud.
2. **Click "Manage compliance policies"**.
3. **Select subscription**.
4. **Enable compliance standards:**
   - **Azure Security Benchmark:** Microsoft's security baseline (enabled by default).
   - **PCI DSS v3.2.1:** Payment card industry compliance.
   - **ISO 27001:2013:** Information security management.
   - **HIPAA / HITRUST:** Healthcare data protection.
   - **SOC 2 Type 2:** Service organization controls.
   - **NIST SP 800-53 Rev. 5:** Federal information security standards.
5. **Save configuration** to enable continuous compliance assessment.

Microsoft Defender for Cloud provides comprehensive cloud security posture management, workload protection, and threat detection capabilities that integrate seamlessly with DevOps workflows to enable secure cloud adoption at scale. By continuously assessing security posture, detecting threats in real-time, and providing actionable recommendations, Defender for Cloud empowers organizations to maintain robust security across Azure, hybrid, and multi-cloud environments. The next unit examines practical Microsoft Defender for Cloud usage scenarios for common security challenges.
