Azure Machine Configuration extends Azure Policy from cloud resource management into guest operating system configuration. While standard Azure Policy governs resource-level settings like network rules and disk encryption, Machine Configuration reaches inside the guest OS to audit and enforce security configurations at the operating system level.

| Aspect | Description |
|--------|-------------|
| **Scope** | Audits and enforces OS-level settings (registry, services, files, permissions) |
| **Platform** | Azure VMs (Windows and Linux) and Azure Arc-enabled servers |
| **Delivery mechanism** | Azure Machine Configuration extension running inside the VM |
| **Compliance reporting** | Results appear as Azure Policy compliance data |
| **Authentication** | System-assigned managed identity authenticates to Azure |

## How Machine Configuration works

The Azure Machine Configuration extension runs as a guest agent inside each virtual machine. The extension evaluates OS settings against a configuration definition—either a built-in Microsoft baseline or a custom configuration you author. Configuration definitions specify required states for registry keys, running services, file permissions, security policies, and application settings.

When the extension completes an evaluation cycle, it reports results to Azure Policy using the VM's system-assigned managed identity. These results populate the same compliance dashboard you use for resource-level policies, providing unified visibility across both infrastructure and OS configuration.

The system-assigned managed identity serves two purposes: it authenticates the extension to Azure when reporting compliance data, and it enables the extension to access Azure resources during remediation tasks. Both the extension and the managed identity are prerequisites—without them, compliance evaluation can't occur.

## Audit mode vs. enforce mode

Machine Configuration operates in two distinct modes, each using a different Azure Policy effect. Understanding the difference prevents unexpected service disruptions.

**Audit mode** uses the `AuditIfNotExists` policy effect. The extension evaluates settings and reports noncompliance, but never modifies the system. If a registry value is set incorrectly or a service that should be stopped is running, the policy marks the resource as noncompliant. No changes occur. This mode carries no risk of disrupting running workloads.

**Enforce mode** uses the `DeployIfNotExists` policy effect. The extension evaluates settings and automatically remediates noncompliance. If a required registry value is missing, the extension creates it. If a prohibited service is running, the extension stops it. While this provides automated hardening, it can disrupt applications that depend on the current configuration state.

For production deployments, always assign policies in audit mode first. Review which settings are noncompliant, assess whether remediation would break application functionality, and document any exceptions required for business operations. Only after this review should you promote the policy to enforce mode. This audit-to-enforce promotion path protects against unintended outages.

## Configuration scope and capabilities

Machine Configuration can audit and enforce a wide range of OS-level settings. On Windows systems, this includes registry keys and values, Windows services (required running state or prohibited state), local security policies (password complexity, account lockout thresholds, audit policies), user rights assignments, and Windows Defender configuration. On Linux systems, the extension manages SSH daemon configuration, filesystem permissions and ownership, kernel parameters via sysctl, systemd service states, and package installation requirements.

The same configuration definitions work across both Azure VMs and Azure Arc-enabled servers. Contoso's factory environment includes both Azure-native Windows Server VMs running manufacturing dashboards and Arc-enrolled Ubuntu servers controlling programmable logic controllers on the factory floor. A single policy assignment at the management group scope applies the appropriate baseline to both platform types.

## Integration with Defender for Servers

When you enable Microsoft Defender for Servers Plan 2, the OS configuration assessment capability uses Azure Machine Configuration to evaluate security baselines. The "Machines should have a vulnerability assessment solution" and related OS misconfiguration recommendations in Defender for Cloud rely on the same extension and managed identity prerequisites covered in this module.

This integration means deploying Machine Configuration provides value beyond policy compliance—it powers Defender for Cloud's security posture assessment and contributes to your overall secure score.

## Contoso's deployment approach

Contoso Manufacturing operates a mixed environment: Windows Server VMs in Azure running ERP systems, and Ubuntu servers enrolled through Azure Arc that interfaces with factory automation equipment. Both platform types require consistent security baselines to prevent configuration drift.

The security team deploys Machine Configuration at the management group level, ensuring every subscription hosting factory infrastructure receives the same baseline policies. Because Arc-enrolled servers already have the Azure Connected Machine agent installed, they automatically gain the managed identity prerequisite—only the Machine Configuration extension needs deployment.

With this foundation in place, you're ready to deploy the extension prerequisites and assign the first baseline policies.
