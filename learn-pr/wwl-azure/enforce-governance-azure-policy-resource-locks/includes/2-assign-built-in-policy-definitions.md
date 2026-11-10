Azure Policy ships with hundreds of built-in definitions that enforce common security, compliance, and operational standards. For Contoso's security engineer, these definitions provide a ready-made catalog for detecting and blocking risky configurations without writing custom rules. Here, you learn how to assign built-in policy definitions and initiatives, configure policy effects, and use the compliance dashboard to identify noncompliant resources across the organization.

Use the following workflow when assigning a built-in definition or initiative:

| Step | Action |
|------|--------|
| Choose a built-in definition or initiative | Browse the policy definitions catalog filtered by security category |
| Select the appropriate scope | Assign at management group, subscription, or resource group level |
| Configure the policy effect | Choose an effect supported by the definition and an appropriate assignment enforcement mode for testing |
| Review compliance results | Use the compliance dashboard to identify noncompliant resources |

## What happens when a resource doesn't comply

The **policy effect** determines what happens when a resource evaluation detects a policy violation. As a security engineer, you select a suitable definition and configure its supported parameters and assignment enforcement mode.

Azure Policy supports several effects, but four are essential for security governance workflows:

| Effect | What it does | When to use it |
|--------|--------------|----------------|
| **Audit** | Marks an applicable resource noncompliant without blocking the request | Discovering noncompliant resources without disrupting operations |
| **Deny** | Blocks a noncompliant create or update request at the Azure Resource Manager (ARM) layer | Enforcing a supported control after testing and remediating existing resources |
| **DeployIfNotExists** | Checks for a related resource or configuration and can deploy a template after a successful create or update and an evaluation delay | Deploying required configuration, such as diagnostic settings |
| **Modify** | Adds, replaces, or removes tags; can also add or replace supported properties during create or update processing | Enforcing tagging standards or supported resource configurations |

With the Audit effect, Azure evaluates applicable resources against the policy rule and records the compliance state. Noncompliant resources appear in the compliance dashboard with a reason code, but the resources remain operational. This approach provides visibility into the current state without breaking existing workloads.

A related effect, **AuditIfNotExists**, behaves like Audit but evaluates associated resources rather than the resource itself. For example, a policy that audits whether a VM has a specific extension installed uses AuditIfNotExists because the extension is a separate resource.

With the Deny effect, Azure blocks a noncompliant resource creation or update request. For example, when the secure-transfer policy is configured with Deny and enforced, a deployment that allows HTTP on a storage account fails with an error referencing the policy. Deny doesn't retroactively repair existing resources.

DeployIfNotExists combines evaluation with automated deployment. After an applicable create or update request succeeds, Azure Policy waits for the configured evaluation delay, checks the related resource, and can deploy the policy's template using the assignment's managed identity. For example, a diagnostic-deployment policy can create a missing diagnostic setting. This process is asynchronous, not a pre-deployment blocking control.

During a background compliance scan, DeployIfNotExists marks existing resources noncompliant but doesn't deploy the missing configuration. Create a remediation task to repair those resources or later configuration drift. Audit and AuditIfNotExists report findings but can't repair resources through a policy remediation task.

Modify isn't a general-purpose resource editor. Only tags support removal. Adding or replacing a resource property requires an alias marked **Modifiable** for the request's API version, and behavior also depends on the request payload and conflict handling. Existing noncompliant resources require remediation tasks rather than being modified by a background scan.

> [!TIP]
> Use a supported audit effect or the assignment's `DoNotEnforce` mode to assess impact before enforcement. Review results with application teams and switch to Deny only when the definition supports it. AuditIfNotExists isn't interchangeable with Deny, and assignment overrides don't make unsupported effects valid. `DoNotEnforce` still records compliance; explicitly initiated remediation tasks can still change resources.

## Policy scope hierarchy: where to assign matters

Policy assignments inherit through the Azure resource hierarchy: management group, subscription, resource group, and resource. The scope you choose determines which resources the policy evaluates.

Assigning a policy at the **management group** scope covers every subscription within that management group, including new subscriptions added in the future. For organization-wide baseline controls, this approach works best. Contoso's security engineer plans a Microsoft cloud security benchmark assignment at a management group so its subscriptions inherit the same assessment baseline.

Assigning at the **subscription** scope only covers resources within that subscription. New subscriptions created later aren't covered automatically. This scope is appropriate for policies that apply only to a specific workload or business unit.

Resource group and resource scopes support targeted controls. A resource group or test subscription is also useful for validating a policy before a broader rollout.

Use assignment **exclusions** (`notScopes`) for scopes intentionally outside the baseline. Excluded resources aren't included in that assignment's compliance count. For example, Contoso might exclude a sandbox subscription used for proof-of-concept testing from a production assignment. Use exclusions sparingly and document the business justification.

Use an **exemption** when a resource should remain tracked against the assignment but has an approved waiver or mitigation. An exemption applies to one assignment, so another assignment can still enforce an equivalent control.

### Understand overlapping assignments

Azure Policy evaluates each applicable assignment independently. A more specific assignment doesn't replace an inherited assignment. For example, if a subscription assignment denies storage accounts that allow HTTP, adding an Audit assignment for the same control at resource group scope doesn't allow those accounts to be created. Setting the resource group assignment to `DoNotEnforce` doesn't disable the subscription assignment either.

Conflicting Deny requirements can prevent every deployment of an affected resource type. For example, a subscription policy that permits only one region and a resource group policy that permits only a different region leave no permitted location in that group. Review all applicable assignments and resolve conflicting requirements with their policy owners. Apply an approved, narrowly scoped exemption or exclusion to the relevant assignment only when an exception is justified. Additional RBAC permissions don't override a policy denial.

## Built-in definitions: the security engineer's starting catalog

Azure Policy includes hundreds of **built-in definitions** maintained by Microsoft. These definitions cover common security, compliance, and operational requirements, and most organizations use them as the foundation for their governance baseline.

You find built-in definitions in the Azure portal by navigating to **Policy** > **Definitions** and filtering by the **Category** field. The "Security Center" category contains security-focused definitions, while categories like "SQL," "Storage," and "Key Vault" contain service-specific policies.

Review the actual policy rule, operative effect parameter, and allowed values before assignment. The following standalone defaults describe the built-in definitions; an initiative can supply different parameter values.

| Built-in definition | Default effect | Supported operative effects | What it checks |
|---|---|---|---|
| **Transparent Data Encryption on SQL databases should be enabled** | AuditIfNotExists | AuditIfNotExists, Disabled | Enabled TDE on the related resource for a SQL database other than master |
| **Secure transfer to storage accounts should be enabled** | Audit | Audit, Deny, Disabled | The storage account's secure-transfer configuration |
| **Storage accounts should restrict network access** | Audit | Audit, Deny, Disabled | Network ACL default action, subject to the definition's exclusions |
| **Azure Key Vaults should use private link** | Audit | Audit, Disabled | An approved private endpoint connection; the operative effect parameter is `audit_effect` |
| **Resource logs in Key Vault should be enabled** | AuditIfNotExists | AuditIfNotExists, Disabled | Its diagnostic-log existence condition, not guaranteed delivery to a specified workspace |

Each definition includes a JSON policy rule that specifies the evaluation logic, the target resource type, and the default effect. You review the JSON by selecting a definition in the portal and choosing the **JSON** tab.

> [!NOTE]
> An approved private endpoint doesn't by itself disable a Key Vault's public endpoint. If the requirement is to disable public network access, assess that setting with the corresponding policy and validate private connectivity and DNS before enforcement.

**Initiatives** (also called policy sets) group multiple related definitions into a single assignable unit. The **Microsoft cloud security benchmark** initiative contains security definitions covering compute, networking, data, identity, and privileged access. Assigning an initiative is more efficient than assigning definitions one by one, but the configured effect determines whether each check is active and whether it enforces a control.

For Contoso's scenario, the initiative includes checks for SQL databases without TDE, storage accounts allowing HTTP, and missing diagnostic logs. With the relevant checks enabled, a management-group assignment creates a common assessment baseline whose results become available after propagation and evaluation. Enforcement is configured separately.

The walkthrough uses the established built-in initiative with this resource ID:

```text
/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8
```

> [!NOTE]
> As of November 10, 2026, Microsoft Learn labels Microsoft cloud security benchmark v2 as preview, while its maintained initiative JSON has a version without a preview suffix. Confirm release status and tenant availability before adopting v2. This walkthrough doesn't require migration or imply that the established initiative is retired.

## Assign a built-in initiative: portal walkthrough

To perform the walkthrough, use an appropriate test subscription, access to the management-group hierarchy used in the example, and permission to create policy assignments at the chosen scope. **Resource Policy Contributor** is a relevant policy-management role; Contributor alone can't create or update policy definitions and assignments. Granting a managed identity access also requires separate authority to create the required role assignments.

> [!IMPORTANT]
> Test at a limited scope before a broad rollout and use least-privilege role assignments. The assignment identity separately needs the permissions required for remediation, including access to any destination outside the assignment scope. A definition's `roleDefinitionIds` declaration isn't itself an RBAC grant.

Check existing assignments at the chosen scope and its ancestors first. Defender for Cloud enables the benchmark by default for Azure, so an applicable assignment might already exist. Review its scope and parameters before adding another management-group assignment. If overlap is intentional, document its purpose.

### Record the baseline version

The initiative ID identifies the baseline, but doesn't by itself identify all the policy content that an assignment evaluates. Review the assignment's `definitionVersion` and automatic-update settings. When you create an assignment, the default selects the latest major version and automatically accepts minor and patch updates within that major-version track. You can select an available minor-version track to limit automatic changes to patches. Patch updates are always ingested, so this isn't a way to freeze every change.

Record the selected version settings together with the assignment's scope, parameters, exclusions, enforcement mode, and any overrides. Minor updates can change rule logic, required roles, or initiative membership. Review supported version changes in an isolated scope before production rollout, compare compliance results, and check application behavior. For larger rollouts, resource selectors and version overrides can stage a supported built-in version change across regions.

Assigning the Microsoft cloud security benchmark initiative to the Contoso management group follows this workflow:

1. In the Azure portal, go to **Policy** > **Assignments** > **+ Assign initiative**.
1. Under **Scope**, select the ellipsis (`...`) and choose the intended test scope. After validation, use the management group that covers the intended Contoso subscriptions for the broader rollout.
1. Under **Initiative definition**, search for "Microsoft cloud security benchmark" and confirm the built-in initiative ID shown earlier.
1. Review the available **Version** and automatic-update settings for the selected initiative. Record the chosen version track and inspect the policy content and parameter mappings that it resolves to before continuing.
1. Under **Parameters**, inspect each relevant parameter rather than assuming it matches the standalone default. For assessment, use AuditIfNotExists for `sqlDbEncryptionMonitoringEffect` and Audit for `secureTransferToStorageAccountMonitoringEffect`. Check the storage-network parameter explicitly because it can default to Disabled. Use only effects supported by each definition.
1. Don't create a remediation task for this audit rollout. Tasks apply only to DeployIfNotExists or Modify policies with an authorized assignment identity. For a management-group assignment, create any required tasks after evaluation through **Policy** > **Remediation** or **Compliance**.
1. Under **Non-compliance messages**, optionally enter a custom message that appears when a resource is blocked by a Deny policy. For example: "This resource configuration violates Contoso security policy. Contact security@contoso.com for assistance."
1. Review the assignment details and select **Create**.

A new or updated assignment triggers compliance evaluation after it propagates to its scope. Propagation typically takes about five minutes, and evaluation can take longer for a large initiative or scope. Azure also evaluates applicable create or update requests and normally reevaluates assignments every 24 hours. An assignment doesn't need to wait for the next daily scan.

> [!TIP]
> For an on-demand scan, first select the intended subscription with `az account set --subscription "<subscription-id>"`, then run `az policy state trigger-scan --resource-group "<rg-name>"`. Omit `--resource-group` to scan the current subscription. Scan execution is asynchronous; it doesn't provide immediate results or scan an entire management group.

To view compliance results:

1. Go to **Policy** > **Compliance** to open the compliance dashboard.
1. Review the overall compliance percentage together with detailed resource and policy states. The aggregate can include **Exempt** and other states in addition to **Compliant**. Resources excluded through `notScopes` are outside the compliance count.
1. Drill into the assignment and its policy definitions to distinguish technical compliance, approved exemptions, noncompliance, errors, and evaluations that haven't completed. Inspect noncompliant resources and their reason codes and locations. For exempt resources, add the **Compliance substate** column to inspect the compliance state they'd have without the exemption.

The compliance dashboard organizes results by policy definition, subscription, and resource type. Filter by subscription to see which workloads have the most violations, or filter by policy to identify which controls have the lowest compliance rate.

> [!NOTE]
> A high compliance percentage doesn't prove that every resource implements every control. Review exemption justification, assignment exclusions, and enabled effects when using the dashboard as audit evidence.

## Review the compliance dashboard for Contoso's findings

After the first policy evaluation cycle completes, Contoso's security engineer reviews the compliance dashboard and discovers significant gaps:

- **47 storage accounts** with "Secure transfer to storage accounts should be enabled" marked noncompliant across three production subscriptions. These accounts allow HTTP traffic, exposing data in transit to potential interception.
- **12 Azure SQL databases** without TDE enabled, all in the finance and operations subscriptions. These databases store sensitive customer data without TDE protection at rest.

The compliance dashboard organizes these findings by policy definition and subscription. Each noncompliant resource includes a reason code (for example, "Resource doesn't match policy rule") and a link to the resource's properties in the Azure portal.

Audit and AuditIfNotExists produce this visibility without disrupting existing workloads. Contoso first reviews the results and tests application changes. For secure transfer, the team can move the supported effect from Audit to Deny after updating affected clients and accounts. For the SQL database TDE findings, the team keeps the audit definition and separately enables TDE, for example through **Deploy SQL DB transparent data encryption** with an authorized assignment identity and a remediation task. Deny doesn't retroactively repair existing resources.

## More info

The following resources describe policy behavior, built-in definitions, and compliance reporting:

- [Policy permissions](/azure/governance/policy/overview#azure-rbac-permissions-in-azure-policy) and [assignment overrides](/azure/governance/policy/concepts/assignment-structure#overrides).
- [DeployIfNotExists](/azure/governance/policy/concepts/effect-deploy-if-not-exists), [Modify](/azure/governance/policy/concepts/effect-modify), and [remediation tasks](/azure/governance/policy/how-to/remediate-resources).
- Built-in SQL TDE definitions: [audit](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/SQL/SqlDBEncryption_Audit.json) and [deployment](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/SQL/SqlDBEncryption_DINE.json).
- Built-in Storage definitions: [secure transfer](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Storage/Storage_AuditForHTTPSEnabled_Audit.json) and [network ACLs](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Storage/Storage_NetworkAcls_Audit.json).
- Built-in Key Vault definitions: [private link](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Key%20Vault/Should_Use_PrivateEndpoint_Audit.json), [public network access](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Key%20Vault/PublicNetworkAccess_Audit.json), and [resource logs](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Key%20Vault/AuditDiagnosticLog_Audit.json).
- [Benchmark initiative](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Security%20Center/AzureSecurityCenter.json), [Defender for Cloud default standards](/azure/defender-for-cloud/concept-regulatory-compliance-standards#default-compliance-standards), and benchmark v2 [documentation](/security/benchmark/azure/overview) and [initiative](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Security%20Center/MCSBv2.json).
- [Evaluation triggers](/azure/governance/policy/how-to/get-compliance-data#evaluation-triggers), [compliance rollup](/azure/governance/policy/concepts/compliance-states#compliance-rollup), and [scope and exclusions](/azure/governance/policy/concepts/scope).
- [How layered policy assignments combine](/azure/governance/policy/concepts/effect-basics#layering-policy-definitions).
- [Azure Policy and Azure RBAC](/azure/governance/policy/overview#azure-policy-and-azure-rbac).
- [Assignment definition versions](/azure/governance/policy/concepts/assignment-structure#policy-definition-id-and-version) and [definition version semantics](/azure/governance/policy/concepts/definition-structure-basics#version).
- [Safely updating a built-in definition version](/azure/governance/policy/how-to/policy-safe-deployment-practices#steps-for-safely-updating-built-in-definition-version-within-azure-policy-assignment).
- [Exemption compliance substate](/azure/governance/policy/concepts/exemption-structure#compliance-substate).
