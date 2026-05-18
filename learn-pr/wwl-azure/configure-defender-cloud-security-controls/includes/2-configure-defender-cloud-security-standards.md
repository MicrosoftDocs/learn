Configuring Microsoft Defender for Cloud correctly ensures the tool generates accurate, actionable recommendations that align with your organization's security and compliance requirements. Contoso's 847 recommendations reflect gaps across multiple security standards—some are baseline controls from Microsoft Cloud Security Benchmark, others come from regulatory frameworks the organization needs to meet. Before you can remediate findings, you need to configure Defender for Cloud's environment settings and assign the right security standards at the appropriate scope.

## Environment settings—configure before you govern

Defender for Cloud environment settings is where you configure per-subscription settings for data collection, autoprovisioning of monitoring agents, and workload protection plan coverage. These settings control what Defender for Cloud monitors and how it collects security data from your resources.

Management group onboarding is the key to scaling configuration across subscriptions. Connecting Defender for Cloud at the management group level lets you push settings across all child subscriptions in a single operation. New subscriptions added to the management group automatically inherit the configuration—you don't need to configure each subscription individually.

Autoprovisioning deploys monitoring extensions to Azure resources without manual installation. Defender for Cloud can automatically deploy:

- **Azure Monitor Agent**—replaces the retired Log Analytics agent (MMA) and collects security events from VMs and Arc-connected machines
- **Defender for Endpoint sensor**—provides endpoint detection and response capabilities on Windows and Linux VMs
- **Vulnerability assessment agent**—scans VMs for missing patches, misconfigurations, and installed software vulnerabilities

Data collection configuration determines which Log Analytics workspace receives security data. Use a central workspace for cross-subscription visibility—this gives your security team a single location to query logs, investigate incidents, and build custom detection rules. Defender for Cloud can send data to a workspace in a different subscription. Contoso's security team operates a dedicated workspace in a separate "security tooling" subscription that all production subscriptions send logs to.

## Security standards—what generates recommendations

Security standards are collections of security controls. Each control contains one or more policy definitions that evaluate resource configurations. When you assign a standard to a subscription or management group, Defender for Cloud evaluates all covered resources against the controls and surfaces findings as recommendations.

| Standard | Description | Use case |
|----------|-------------|----------|
| **Microsoft Cloud Security Benchmark (MCSB)** | Default baseline covering identity, network, data protection, compute, and logging controls | Foundational security posture—assigned to every subscription automatically |
| **CIS Microsoft Azure Foundations Benchmark** | Community-developed best practices for Azure security configuration | Demonstrate alignment with industry-standard hardening guidance |
| **NIST SP 800-53** | US government security controls framework | Federal compliance or vendors serving federal agencies |
| **ISO 27001** | International information security management standard | Global compliance for data handling and security management |
| **PCI DSS** | Payment card industry data security requirements | Organizations processing credit card transactions |
| **SOC 2** | Trust service criteria for security, availability, and confidentiality | SaaS providers demonstrating controls to customers |

**Microsoft Cloud Security Benchmark** is the default standard assigned to every subscription when Defender for Cloud is enabled. It provides the baseline security posture for Azure resources. You can't remove MCSB—it remains assigned regardless of what other standards you add. MCSB covers identity controls (MFA enforcement, privileged access management), and network controls (private endpoints, network segmentation). MCSB also covers data protection (encryption at rest and in transit), compute security (patch management, secure configurations), and logging and monitoring (diagnostic settings, audit trails).

Regulatory standards add controls beyond the baseline. Defender for Cloud includes built-in mappings to CIS, NIST, ISO, PCI, SOC 2, and other frameworks. Adding a regulatory standard adds its controls to the compliance dashboard, which you explore in Module 3. The same resource can be evaluated against multiple standards simultaneously—a storage account is checked for MCSB compliance, PCI DSS requirements, and ISO 27001 controls if all three standards are assigned.

To add a regulatory standard, go to **Environment settings** → select a subscription, or management group → **Security policies** → **Add more standards** → select from the list of built-in standards. The standard becomes active immediately and Defender for Cloud begins evaluating resources against its controls.

## Create a custom security standard from an Azure Policy initiative

Custom security standards enforce internal security requirements that aren't covered by built-in standards. Contoso has a requirement that all resources must send audit logs to the central SIEM workspace—this isn't enforced by MCSB or any regulatory standard, so the security team creates a custom standard from an Azure Policy initiative.

Any Azure Policy initiative you create appears as an assignable standard in Defender for Cloud. The integration lets you manage custom security requirements using the same governance and remediation workflows you use for built-in standards. The steps to create a custom standard are:

1. Create an Azure Policy initiative containing the relevant policy definitions. For Contoso's logging requirement, the initiative contains policy definitions that audit or enforce diagnostic settings for each resource type.

2. In Defender for Cloud, go to **Environment settings** → select the target subscription or management group → **Security policies**.

3. Select **+ Create** → **Custom standard**.

4. Enter a name and description for the standard. The name appears in the regulatory compliance dashboard alongside built-in standards.

5. Select the Azure Policy initiative from the dropdown. Only initiatives in the same or parent scope are available.

6. Assign the custom standard to the subscription or management group. The assignment scope determines which resources are evaluated.

7. Save the configuration. The custom standard now appears in the regulatory compliance dashboard, and Defender for Cloud generates recommendations for any resources that don't comply with the initiative's policy definitions.

Custom standards let security teams enforce organization-specific requirements without waiting for those requirements to appear in Microsoft-maintained standards. Contoso's security team creates custom standards for internal data classification policies, approved resource naming conventions, and mandatory security tool integrations.

## Understanding how standards generate recommendations

Each policy definition in security standard maps to a security control. When a resource violates the policy definition, Defender for Cloud surfaces a recommendation. The recommendation includes the resource name, affected subscription, severity rating (Critical, High, Medium, or Low), secure score value, and remediation description.

Recommendation anatomy: **"Enable secure transfer for storage accounts"** is a recommendation generated by an MCSB control. The recommendation lists all storage accounts where `supportsHttpsTrafficOnly` is set to `false`. The severity is High because unencrypted HTTP traffic exposes data to interception. The secure score value is four points—remediating this recommendation on all affected storage accounts improves Contoso's secure score by four points. The remediation description explains how to enable the setting through the portal, Azure CLI, or Azure Resource Manager template.

Recommendations can be in scope or out of scope depending on whether the relevant Defender plan is enabled. Some recommendations require Defender for Servers (for example, recommendations about missing OS patches) or Defender CSPM (for example, attack path analysis). If the plan isn't enabled, the recommendation appears but is marked as requiring plan enablement.

The total number of recommendations reflects every gap across all assigned standards. Contoso's 847 recommendations come from MCSB controls evaluated across hundreds of VMs, storage accounts, SQL databases, Key Vaults, and networking resources. Multiple standards assigned to the same subscription increase the recommendation count—a single misconfiguration can generate recommendations from MCSB, CIS, and PCI DSS if all three standards include a control for that configuration.

Now that Defender for Cloud is configured with the right standards and generating accurate recommendations, you deploy the security controls that remediate those findings.
