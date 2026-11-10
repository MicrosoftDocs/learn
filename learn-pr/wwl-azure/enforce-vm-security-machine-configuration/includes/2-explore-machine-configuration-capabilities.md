Azure Machine Configuration extends Azure Policy from cloud resource management into guest operating system configuration. While standard Azure Policy governs resource-level settings like network rules and disk encryption, Machine Configuration reaches inside the guest OS to assess settings and apply approved custom configurations.

The following table summarizes its scope and delivery mechanisms.

| Aspect | Description |
|--------|-------------|
| **Scope** | Audits OS-level settings and applies selected changes through change-capable configurations |
| **Platform** | Azure VMs (Windows and Linux) and Azure Arc-enabled servers |
| **Delivery mechanism** | Azure Machine Configuration VM extension for Azure VMs; component included in the Connected Machine agent for Arc-enabled servers |
| **Compliance reporting** | Results appear as Azure Policy compliance data |
| **Authentication** | The machine's system-assigned managed identity authenticates to the Machine Configuration service |

## How Machine Configuration works

The Machine Configuration agent evaluates OS settings against an assigned configuration—either a built-in Microsoft baseline or a custom configuration you author. Configurations specify required states for settings such as registry values, services, file permissions, and application settings. The agent reports results to the Machine Configuration service, where Azure Policy can use them for compliance reporting.

Azure VMs require the Azure Machine Configuration VM extension and a system-assigned managed identity. Arc-enabled servers receive both the Machine Configuration component and their system-assigned identity through the Azure Connected Machine agent. Don't install the Azure VM extension separately on an Arc-enabled server.

The built-in **Deploy prerequisites to enable Guest Configuration policies on virtual machines** initiative prepares eligible Azure VMs. Its identity policies use `Modify`, and its extension policies use `DeployIfNotExists`. Remediation tasks for the applicable constituent policies prepare existing VMs. For Arc servers, verify onboarding, agent health, supported versions, and connectivity instead.

Keep these identities and execution contexts separate.

| Identity or context | Purpose |
|---|---|
| Machine's system-assigned managed identity | Authenticates to the service and can download private packages when explicitly granted storage data access |
| Policy assignment's managed identity | Performs authorized Azure resource deployments or modifications during remediation |
| LocalSystem on Windows or root on Linux | Runs guest configuration resource code locally; granting Azure roles doesn't change this execution context |

The portal can grant the roles listed in a policy definition only when the operator has role-assignment authority. For scripted deployments, grant and verify the definition's actual `roleDefinitionIds`. Permission to create or assign a policy doesn't itself grant permission to assign roles.

## Package capabilities and guest assignment types

An `Audit` package checks settings. An `AuditAndSet` package also contains resource code that can apply the declared configuration. A guest assignment determines when changes are permitted; package capability alone doesn't enable remediation.

The three guest assignment types have different behavior.

| Guest assignment type | Behavior |
|---|---|
| `Audit` | Reports the current state without applying the desired configuration |
| `ApplyAndMonitor` | Applies changes when remediation is triggered. With policy enforcement enabled, VM creation or updates can also trigger application or reapplication. Later guest-only drift is reported rather than continuously corrected. |
| `ApplyAndAutoCorrect` | Applies the configuration when remediation is triggered and corrects subsequent drift at the next guest evaluation |

Azure Policy effects are a separate layer: `AuditIfNotExists` assesses related resource state, while `DeployIfNotExists` can deploy a guest assignment. Azure Policy's assignment `enforcementMode` (`Default` or `DoNotEnforce`) controls policy-effect enforcement, not the guest assignment type. It isn't a switch for converting an audit package into a change-capable one.

> [!IMPORTANT]
> The two built-in Windows and Linux compute security baseline definitions used for the audit exercise support `AuditIfNotExists` and `Disabled`, not `DeployIfNotExists`. You can't turn them into enforcement policies by changing an assignment setting. The custom remediation workflow in this module uses a tested `AuditAndSet` package and a policy that deploys its guest assignment. A separate baseline-remediation public preview supports selected settings through remediation-capable definitions and explicit opt-in controls, as described in the next unit.

Start with audit findings, review application impact, and document approved exceptions before piloting custom remediation. For existing machines, deployment policies also need an authorized assignment identity and an initial remediation task. After successful deployment, `ApplyAndAutoCorrect` corrects later drift locally without a recurring Azure Policy remediation task.

> [!IMPORTANT]
> Audit avoids intended changes to the assessed settings, but it isn't a zero-risk rollout. Prerequisite deployment and custom resource execution still require testing. Adding a system-assigned identity can change which identity an existing application receives from IMDS when it doesn't request a specific user-assigned identity. Confirm application behavior before deploying prerequisites broadly.

## Configuration scope and capabilities

Machine Configuration can assess settings such as Windows registry values, services, local security policies, and user rights. Linux configurations can assess settings such as SSH configuration, filesystem permissions, kernel parameters, and systemd service states. Coverage and the ability to change each setting depend on the package's resources; an audit baseline doesn't automatically provide remediation for everything it assesses.

An OS-specific configuration can target eligible Azure VMs and Arc-enabled servers, but Windows and Linux resources aren't interchangeable. Contoso uses separate baseline policies for its Azure Windows Server VMs and Arc-enabled Linux servers. Management-group assignments provide broad audit coverage; custom application configurations need explicit workload targeting as well as an OS filter.

> [!NOTE]
> Machine Configuration supports up to 50 guest assignments per machine. Inventory the actual guest-assignment resources created by built-in policies, custom configurations, and Defender OS assessment before expanding coverage. This isn't a separate allowance per policy category, and individual rules or recommendation findings aren't guest assignments.
>
> The agent is CPU-governed, with a documented default limit of 5%. Supported agent versions allow the limit to be configured, so check the platform and agent settings rather than treating 5% as a fixed or per-assignment budget. CPU-constrained machines can experience evaluation timeouts. Account for resource limits and sequential configuration execution when interpreting delayed reports.

## Integration with Defender for Servers

Defender for Servers Plan 2 uses Machine Configuration for its Microsoft Cloud Security Benchmark OS configuration assessment. Azure VMs require the relevant extension and identity, while Arc-enabled servers use the component included in the Connected Machine agent.

Software vulnerability assessment is a different capability. Defender Vulnerability Management supplies vulnerability findings through supported agentless scanning or Defender for Endpoint integration, with its own prerequisites. Installing Machine Configuration doesn't by itself enable software vulnerability scanning or endpoint detection and response.

In the current Defender for Cloud recommendation model, individual `HostMisconfigurations` recommendations represent OS configuration findings. Keep these separate from Azure Policy guest-assignment compliance and from software vulnerability recommendations. The change to individual recommendations doesn't replace the Machine Configuration collector for OS assessment.

## Contoso's deployment approach

Contoso Manufacturing operates a mixed environment: Windows Server VMs in Azure running ERP systems and supported Ubuntu servers enrolled through Azure Arc that interface with factory automation equipment. Both platform types need baseline assessment to identify configuration drift.

The security team assigns the OS-specific audit baseline policies at management-group scope. Both policies default `IncludeArcMachines` to `false`. To include its Arc servers, the team explicitly sets this parameter to `true` for both assignments after reviewing and acknowledging the applicable charges; assignment scope alone doesn't enable Arc coverage. The team deploys the prerequisite initiative for eligible Azure VMs and separately verifies the Connected Machine agents on Arc servers. After reviewing audit findings, application owners approve a small, workload-targeted pilot for any custom configuration that changes settings.

With these distinctions in place, you're ready to prepare the machines and assign the first baseline policies.
