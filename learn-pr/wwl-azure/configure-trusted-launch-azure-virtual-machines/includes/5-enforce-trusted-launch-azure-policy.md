Manual configuration works for individual VMs but doesn't scale to enterprise environments with hundreds of virtual machines across multiple subscriptions. Contoso Manufacturing operates factory floor VMs in several Azure subscriptions, organized by geographic region and production line. Ensuring every VM has Trusted Launch enabled requires automated governance rather than manual checks.

Azure Policy provides the enforcement framework to audit Trusted Launch compliance, identify VMs eligible for upgrade, and remediate noncompliant resources at scale. You explore the built-in policies that work together to govern Trusted Launch adoption.

| Policy Focus | Policy Name | Effect Options |
|--------------|-------------|----------------|
| Eligibility assessment | Disks and OS image should support TrustedLaunch | Audit, Disabled |
| Security configuration | Virtual Machine should have TrustedLaunch enabled | Audit, Disabled |
| Secure Boot verification | Secure Boot should be enabled (preview) | Audit, Disabled |
| vTPM verification | vTPM should be enabled (preview) | Audit, Disabled |

## Recognize the Trusted Launch policy challenge

Contoso Manufacturing's factory environment presents a common policy challenge. The VMs span multiple subscriptions, were created over several years using different templates and processes, and have varying levels of Trusted Launch compatibility. Some VMs run on Gen2 architecture with supported operating systems and can be upgraded immediately. Others are Gen1 VMs that require full migration. Still others use legacy VM sizes or operating systems that can't support Trusted Launch at all.

A successful policy strategy must distinguish between these categories. Flagging every VM as noncompliant creates alert fatigue and obscures actionable findings. The policy framework must identify which VMs can be remediated, which require migration, and which can't support Trusted Launch under current configuration.

Azure provides built-in policies designed to address this challenge. The policies work together as a multi-stage assessment: first identify eligible VMs, then audit security configuration, then enforce compliance on capable resources.

## Use the Trusted Launch eligibility policy

The **"Disks and OS image should support TrustedLaunch"** policy identifies Gen2 virtual machines that have compatible operating systems and VM sizes for Trusted Launch upgrade. This eligibility assessment policy evaluates each VM's current configuration against Trusted Launch requirements without making assumptions about intent.

The policy checks:

- VM generation (must be Gen2)
- Operating system compatibility (current OS supports Trusted Launch)
- VM size compatibility (current size supports Trusted Launch security features)

VMs that meet all criteria appear as **Compliant** in the policy compliance report. VMs that fail one or more checks appear as **Non-compliant**. The policy uses an **Audit** effect, which means it evaluates and reports compliance but doesn't block VM creation or modification.

For Contoso Manufacturing, this policy provides the inventory needed to plan Trusted Launch rollout. The compliance report answers critical planning questions: How many VMs are already eligible for upgrade? Which subscriptions have the highest concentration of compatible VMs? Are there specific VM sizes or operating systems that dominate the noncompliant list?

Assign this policy first, before attempting to enforce Trusted Launch adoption. The eligibility data informs remediation priority and helps identify VMs that need migration versus simple security type upgrade.

## Use the Trusted Launch security configuration policy

The **"Virtual Machine should have TrustedLaunch enabled"** policy audits whether VMs actually have Trusted Launch configured as their security type. This policy focuses on security configuration rather than eligibility—it identifies VMs that could have Trusted Launch but currently use Standard security.

The policy evaluates the VM's security type property. VMs with security type set to **TrustedLaunch** appear as **Compliant**. VMs with security type set to **Standard** appear as **Non-compliant**.

This policy supports two effects:

- **Audit**: Evaluate and report compliance without blocking actions
- **Disabled**: Don't evaluate the policy

In **Audit** mode, the policy evaluates VMs and reports noncompliance but doesn't block VM creation or modification. This allows you to identify which VMs in your estate are using Standard security and are candidates for upgrade, without disrupting ongoing deployments.

For Contoso Manufacturing, assigning this policy in Audit mode across the factory subscriptions gives the security team a compliance baseline—a clear view of how many VMs have Standard security and need to be upgraded to Trusted Launch.

## Use individual Secure Boot and vTPM policies

Azure provides other built-in policies that verify specific Trusted Launch components rather than the overall security type:

- **"[Preview]: Secure Boot should be enabled on supported Windows virtual machines"**  
- **"[Preview]: vTPM should be enabled on supported virtual machines"**

These policies use the **Audit** effect. They evaluate whether Secure Boot or vTPM is enabled on VMs that support these features. VMs appear as noncompliant if the security type is Trusted Launch but individual components are disabled.

For Contoso Manufacturing, these policies catch a gap the configuration policy misses. A VM might have security type set to Trusted Launch but have Secure Boot disabled due to manual configuration changes. The configuration policy reports that VM as compliant; the Secure Boot policy flags it as noncompliant. Assign these policies alongside the eligibility and configuration policies so your compliance baseline covers both the security type setting and the individual component state.

## Assign the Trusted Launch policies

Azure doesn't provide a built-in initiative that bundles the Trusted Launch policies. Assign each policy individually, or group them into a custom initiative to simplify management across multiple subscriptions.

Assigning at management group scope provides the broadest coverage. For Contoso Manufacturing, assigning at the **Factory Operations** management group covers all subscriptions used for production systems—including subscriptions created in the future, so new factories automatically inherit the compliance requirement.

To assign each policy:

1. Navigate to **Policy** in the Azure portal
2. Select **Definitions** and search for the policy by name
3. Select the policy and choose **Assign**
4. Set the scope to the appropriate management group or subscription
5. Configure the policy effect:
   - Set the eligibility policy to **Audit**
   - Set the configuration policy to **Audit** to evaluate and report compliance
6. Create the assignment
7. Repeat for each remaining Trusted Launch policy

:::image type="content" source="../media/assign-trusted-launch-policy.png" alt-text="Screenshot of the Azure portal Policy Definitions page showing a Trusted Launch policy assignment being configured with scope and effect settings." lightbox="../media/assign-trusted-launch-policy.png":::

Policy evaluation begins within minutes of assignment. Azure scans all VMs in scope and populates the compliance dashboard. The initial scan typically completes within an hour for environments with hundreds of VMs.

## Interpret the compliance dashboard

The policy compliance dashboard shows compliance percentage and resource counts for each policy in the initiative. Understanding how to interpret these results is essential for planning remediation.

To view the compliance dashboard:

1. Navigate to **Policy** in the Azure portal
2. Select **Compliance** from the left menu
3. Select a Trusted Launch policy assignment to open the detailed compliance view

:::image type="content" source="../media/check-policy-compliance.png" alt-text="Screenshot of the Azure portal Policy Compliance page showing Trusted Launch policy compliance state and noncompliant resource counts." lightbox="../media/check-policy-compliance.png":::

The eligibility policy compliance report answers: "Which VMs are capable of running Trusted Launch?" Noncompliant VMs in this category require investigation. Are they Gen1 VMs that need migration? Do they use unsupported VM sizes that need to be resized? Do they run legacy operating systems that need to be upgraded?

The configuration policy compliance report answers: "Which capable VMs currently lack Trusted Launch?" Noncompliant VMs in this category are the primary remediation targets. These VMs meet all technical prerequisites but never configured for Trusted Launch yet.

For Contoso Manufacturing, the compliance dashboard reveals the remediation backlog. If 200 VMs are eligible but only 50 have Trusted Launch enabled, the gap of 150 VMs represents the immediate upgrade opportunity—no migration required, just a security type change.

## Create remediation tasks for noncompliant VMs

Azure Policy supports automated remediation for certain policy types through remediation tasks. For the Trusted Launch configuration policy, remediation tasks can automatically enable Trusted Launch on noncompliant Gen2 VMs that meet eligibility criteria.

To create a remediation task:

1. Navigate to the policy assignment in the Azure portal
2. Select **Create remediation task**  
3. Choose the policy to remediate (select the configuration policy)
4. Review the list of noncompliant resources
5. Configure remediation options:
   - Remediate all noncompliant resources, or select specific VMs
   - Set the **managed identity** location (required for remediation to modify resources)
6. Create the remediation task

Azure queues the remediation task and begins processing VMs. The task stops and deallocates each VM, updates the security type to Trusted Launch, enables Secure Boot and vTPM, and restarts the VM. This process takes several minutes per VM.

**Critical consideration**: VMs must be stopped and deallocated for remediation to succeed. Remediation tasks don't automatically stop running VMs—if the VM is running when the task executes, remediation fails. For Contoso Manufacturing's production environment, this means remediation tasks should target stopped VMs first. Then other maintenance should be scheduled during maintenance windows when VMs can be safely stopped.

Monitor remediation task progress through the **Remediation** tab in the policy assignment. The dashboard shows how many VMs were successfully remediated, how many failed, and detailed error messages for failures. Common failure reasons include: VM was running when remediation executed, VM uses Azure Backup with Standard policy, or VM size doesn't fully support Trusted Launch despite passing eligibility checks.
