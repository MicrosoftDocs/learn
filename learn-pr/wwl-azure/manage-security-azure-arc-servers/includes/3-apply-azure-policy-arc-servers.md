Arc-enabled servers appear in Azure as first-class resources under the `Microsoft.HybridCompute/machines` resource type. This integration means you can apply the same Azure Policy governance framework to hybrid servers that you use for Azure virtual machines, enabling consistent security controls across cloud and on-premises infrastructure.

## Assign policies at the right scope

Azure Policy assignments cascade from parent scopes to child resources. For organizations with hybrid infrastructure distributed across multiple subscriptions, assigning policies at the management group level ensures uniform coverage without repetitive per-subscription configurations.

Contoso Manufacturing organizes its Azure environment with a management group hierarchy: a root management group contains a "Factory Operations" management group, which in turn contains subscriptions for North America, Europe, and Asia-Pacific factories. By assigning Arc security policies at the Factory Operations management group, all current and future subscriptions inherit the same controls automatically. When a new regional subscription is created, its Arc-enrolled servers are immediately subject to the established security policies.

| Scope Level | Coverage | Use Case |
|-------------|----------|----------|
| Management group | All subscriptions within the group | Enterprise-wide or division-wide standards |
| Subscription | All resources in one subscription | Subscription-specific requirements |
| Resource group | Resources in a single group | Granular control for specific server sets |

This scope strategy reduces configuration drift and ensures consistent security posture as infrastructure scales.

## Use built-in policies for Arc servers

Azure provides built-in policy definitions designed for Arc-enabled servers. These policies cover security agent deployment, configuration baseline enforcement, and security feature enablement.

The **Configure Azure Defender for Servers to be enabled (with 'P1' subplan) for all resources** policy automatically enables Microsoft Defender for Servers Plan 1 on all Arc-enrolled machines. This DeployIfNotExists policy creates the necessary Defender configuration when it detects an Arc server without coverage, ensuring all hybrid servers receive threat detection and vulnerability assessment capabilities.

The **Configure ChangeTracking Extension for Windows Arc machines** and **Configure ChangeTracking Extension for Linux Arc machines** policies deploy the ChangeTracking extension to enable File Integrity Monitoring (FIM). FIM alerts you when critical system files, registry keys, or configuration files are modified, providing early warning of unauthorized changes or malware activity.

The **Windows machines should meet requirements of the Azure compute security baseline** and **Linux machines should meet requirements for the Azure compute security baseline** policies assess operating system configurations against CIS benchmarks and Microsoft security baselines. These policies require the Machine Configuration extension (covered in detail in Module 7) and report compliance status for hundreds of individual settings, such as password complexity requirements, audit logging configuration, and service hardening.

Preview policies such as **vTPM should be enabled on supported virtual machines** and **Secure Boot should be enabled on supported Windows virtual machines** enforce security features on virtualized Arc servers, protecting against boot-level malware and ensuring trusted boot chains.

## Assign and remediate policies

The policy assignment workflow for Arc servers follows the standard Azure Policy pattern. Navigate to **Azure Policy** in the Azure portal, select **Assign Policy** or **Assign Initiative**, and choose the management group, subscription, or resource group scope.

When configuring a DeployIfNotExists policy, specify the Azure region for the remediation managed identity. This system-assigned managed identity performs the deployment actions on your behalf. Grant the identity the minimum permissions needed to deploy the target extension or configuration—typically the Azure Connected Machine Resource Administrator role scoped to the assignment's target resources.

After assignment, Azure Policy evaluates resources on a periodic cycle and marks noncompliant resources. For existing Arc servers that were enrolled before policy assignment, compliance violations appear immediately but no automatic remediation occurs. Create a **remediation task** from the policy assignment detail pane to deploy extensions or apply configurations to preexisting noncompliant resources. New Arc servers enrolled after policy assignment are automatically remediated as they appear.

| Policy Effect | Behavior | Remediation Required |
|---------------|----------|---------------------|
| Audit | Reports compliance status only | No |
| AuditIfNotExists | Reports compliance for nested conditions | No |
| DeployIfNotExists | Automatically deploys resources for new violations | Yes, for existing resources |
| Deny | Blocks noncompliant resource creation | No |

## Understand policy applicability for Arc versus Azure VMs

Some built-in policies apply exclusively to Azure virtual machines, some target only Arc-enabled servers, and some cover both resource types. Review the policy definition's description and the `if` condition clause to determine applicability. Policies that reference `"type": "Microsoft.Compute/virtualMachines"` affect only Azure VMs, while those referencing `"type": "Microsoft.HybridCompute/machines"` target Arc servers. Policies with both conditions in an `anyOf` block cover hybrid and cloud resources.

This distinction matters when interpreting compliance reports. If you assign a policy intended for Azure VMs to a scope containing Arc servers, the Arc servers appear as "Not applicable" rather than compliant or noncompliant, preventing false compliance metrics.

## Recognize policy limitations and layer controls

Azure Policy assignments are mutable resources. Any user with `Microsoft.Authorization/policyAssignments/write` permissions at the target scope can modify or delete assignments, disabling controls. For this reason, combine cloud-based Azure Policy with agent-level extension controls (configured in the previous unit). Azure Policy provides ease of management and visibility; agent-level allow lists to enforce against privileged threats.

## Prepare for machine configuration policies

Azure Machine Configuration policies (formerly Azure Guest Configuration) assess and enforce configurations inside the operating system, such as registry settings, file permissions, installed software, and service states. These policies use the Machine Configuration extension, which runs on both Azure VMs and Arc-enabled servers. You can assign machine configuration policies to Arc servers through the same Azure Policy mechanism described in this unit. Module 7 covers machine configuration in depth, including how to create custom policies for organization-specific security requirements.

## Apply policies at Contoso Manufacturing

Contoso's security team assigns three policies at the Factory Operations management group scope:

- **Configure Azure Defender for Servers to be enabled (with 'P1' subplan) for all resources** — ensures all Arc servers receive vulnerability scanning and threat detection
- **Configure ChangeTracking Extension for Windows Arc machines** — enables FIM on all factory Windows servers
- **Windows machines should meet requirements of the Azure compute security baseline** — assesses compliance with CIS benchmarks

After assignment, the team creates remediation tasks to deploy extensions to the 47 Arc-enrolled servers that existed before the policies were assigned. All future Arc enrollments receive these extensions automatically within minutes of registration.

With policies assigned and remediation underway, you're ready to monitor the security posture of Arc-enrolled servers in Microsoft Defender for Cloud.
