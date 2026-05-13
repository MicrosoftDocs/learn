Built-in security baseline policies provide immediate coverage of industry-standard OS hardening controls. These Microsoft-curated baselines map to the Microsoft Cloud Security Benchmark (MCSB) control PV-4: Audit and enforce secure configurations for compute resources.

| Deployment step | Action |
|-----------------|--------|
| 1. Deploy prerequisites | Assign initiative to install extension and managed identity |
| 2. Create remediation task | Deploy prerequisites to existing VMs |
| 3. Assign Windows baseline | Apply built-in security baseline policy in audit mode |
| 4. Assign Linux baseline | Apply built-in security baseline policy in audit mode |
| 5. Review compliance | Wait 24 hours, then assess noncompliance findings |
| 6. Promote to enforce | Reassign policies with DeployIfNotExists effect (optional) |

## Deploy prerequisite infrastructure

Before any baseline policy can evaluate compliance, two components must exist on each virtual machine: the Azure Machine Configuration extension and a system-assigned managed identity. The built-in initiative "Deploy prerequisites to enable Guest Configuration policies on virtual machines" automates this deployment.

Assign this initiative at the management group scope that covers Contoso's factory subscriptions. The initiative uses the `DeployIfNotExists` effect, which means it deploys the extension and identity automatically to new VMs. For existing VMs, you must create a remediation task after assignment to trigger the deployment.

The policy assignment itself requires a managed identity with permissions to deploy VM extensions and assign managed identities. During the assignment process, select "System assigned managed identity" in the remediation settings and specify the appropriate region. Azure automatically grants the required permissions.

For Arc-enabled servers, the deployment pattern differs slightly. The Azure Connected Machine agent already provides the system-assigned managed identity—no other identity deployment is needed. You only need to deploy the Machine Configuration extension. The same prerequisite initiative handles this automatically, detecting the Arc platform and skipping identity deployment.

## Assign the Windows security baseline

The built-in initiative "Windows machines should meet requirements of the Azure compute security baseline" evaluates over 250 Windows security settings. This baseline covers account policies (password length, complexity, history), and audit policies (sign-in events, privilege use, system events). It also covers security options (network access controls, user account control behavior), user rights assignments (who can sign-in locally, shut down the system, take ownership of files), and Windows Defender configuration.

Assign this initiative at the same management group scope where you deployed prerequisites. The initiative uses `AuditIfNotExists` by default—it reports noncompliance without modifying any settings. This audit-first approach gives Contoso's team visibility into current configuration state without risk of disrupting factory systems.

After assignment, Azure Policy begins evaluating Windows VMs within the scope. Initial compliance data appears within 30 minutes for new VMs, but a complete compliance scan of existing infrastructure can take up to 24 hours. The evaluation runs on a recurring schedule—every 24 hours for audit policies, and when configuration drift is detected for enforce policies.

## Assign the Linux security baseline

The companion initiative "Linux machines should meet requirements for the Azure compute security baseline" provides equivalent coverage for Linux systems. This baseline evaluates:

- SSH daemon configuration (PermitRootLogin disabled, protocol version, strong ciphers)
- Filesystem permissions and ownership on sensitive directories
- Kernel parameters affecting network security (IP forwarding, SYN cookies, ICMP redirect handling)
- Systemd service states (unnecessary services disabled)
- Package security configurations

Use the same assignment scope and policy settings as the Windows baseline. The initiative automatically applies only to Linux VMs—Windows systems are excluded from evaluation. Contoso's Arc-enrolled Ubuntu servers controlling factory automation equipment are covered by this single assignment.

Both baselines work together to provide platform-appropriate security controls across the entire server estate. A single compliance dashboard in Azure Policy shows aggregate compliance across both operating system families.

## Interpret compliance results

After the initial evaluation cycle completes, navigate to Azure Policy > Compliance and filter for your baseline policy assignments. Each initiative displays an overall compliance percentage and a count of noncompliant resources.

Drill into a noncompliant resource to see which specific settings failed evaluation. The compliance detail view shows the expected value (from the baseline definition) and the current value (detected on the VM). For example, a Windows Server might show "Audit: Force audit policy subcategory settings" expected as "Enabled" but currently set to "Disabled."

This detail is valuable when assessing whether to promote the policy to enforce mode. Some noncompliance findings represent genuine security gaps—default configurations that should be hardened. Other findings might indicate intentional configuration choices required for application compatibility. A service marked as "should be disabled" might be a legitimate requirement for manufacturing software to function.

Common noncompliance patterns in factory environments include:

- Services running that the baseline expects to be stopped (Remote Registry, Server service on workstations)
- Password policies that were never hardened post-deployment (minimum length set to 7 instead of 14)
- Audit policy gaps where critical event categories aren't logged
- User rights assignments that grant excessive privileges to default user groups.

## Create remediation tasks and promote to enforce mode

For the prerequisites initiative, create a remediation task immediately after assignment. This task deploys the Machine Configuration extension and managed identity to existing VMs that were deployed before the policy assignment. Navigate to Azure Policy > Remediation > Create remediation task, select the prerequisites initiative, and choose the specific policies to remediate. The task runs asynchronously and reports progress in the remediation view.

For the baseline initiatives themselves, remediation is a decision, not an automatic step. Because the built-in baseline policies use `AuditIfNotExists` by default, they never modify settings. The effect of built-in baseline policies is fixed—these policies can't be reassigned with a `DeployIfNotExists` effect.

To automatically remediate specific noncompliant settings, review the compliance findings and author custom Machine Configuration packages targeting those settings, then assign them in enforce mode. This approach is covered in the next unit. Before authoring custom remediation packages, export the compliance report, identify noncompliant settings, and work with application owners to validate that remediation won't disrupt operations. Settings that would cause application failures are documented as exceptions and addressed through custom configurations or application updates.

## Contoso's baseline deployment workflow

Contoso assigns the prerequisites initiative at their "Factory Infrastructure" management group, which contains three subscriptions hosting production factory systems. They create a remediation task targeting all three subscriptions, deploying the extension to 47 existing Azure VMs and 23 Arc-enrolled servers.

After the extension deployment completes, they assign both Windows and Linux baseline initiatives in audit mode. The initial compliance report shows 68% compliance—32 VMs have at least one noncompliant setting. Most findings are password policy gaps and unnecessary services. The team reviews each finding, documents legitimate exceptions (one service required by PLC software), and schedules a maintenance window to address the rest.

With your built-in baselines deployed and compliance visibility established, you're ready to extend coverage with custom configurations for Contoso-specific requirements.
