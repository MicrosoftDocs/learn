Azure Policy ships with hundreds of built-in definitions that enforce common security, compliance, and operational standards. For Contoso's security engineer, these definitions provide a ready-made catalog for detecting and blocking risky configurations without writing custom rules. Here, you learn how to assign built-in policy definitions and initiatives, configure policy effects, and use the compliance dashboard to identify noncompliant resources across the organization.

| Step | Action |
|------|--------|
| Choose a built-in definition or initiative | Browse the policy definitions catalog filtered by security category |
| Select the appropriate scope | Assign at management group, subscription, or resource group level |
| Configure the policy effect | Set to Audit (for discovery) or Deny (for enforcement) |
| Review compliance results | Use the compliance dashboard to identify noncompliant resources |

## What happens when a resource doesn't comply

The **policy effect** determines what happens when a resource evaluation detects a policy violation. As a security engineer, you control this behavior when you assign a policy or configure its parameters.

Azure Policy supports several effects, but four are essential for security governance workflows:

| Effect | What it does | When to use it |
|--------|--------------|----------------|
| **Audit** | Evaluates the resource and marks it noncompliant in the compliance dashboard but takes no other action | Phase 1 of a rollout—discover noncompliant resources without disrupting operations |
| **Deny** | Blocks the resource creation or update request at the Azure Resource Manager (ARM) layer before the resource is created; the request returns an error | Phase 2 of a rollout—enforce the policy after  remediating existing resources |
| **DeployIfNotExists** | Evaluates whether a related resource or setting exists; if it doesn't, deploys it automatically | Configurations that need to be provisioned alongside a resource (example: deploying diagnostic settings on every VM) |
| **Modify** | Automatically adds, updates, or removes a tag or property on a resource at creation or update time | Enforcing resource tagging standards or default configurations |

With the Audit effect, Azure evaluates every resource against the policy rule and records the compliance state. Noncompliant resources appear in the compliance dashboard with a reason code, but the resources remain operational. This approach provides visibility into the current state without breaking existing workloads.

With the Deny effect, Azure blocks the resource creation or update request entirely. When a developer attempts to deploy a storage account with HTTP enabled, the ARM template deployment fails immediately with an error message referencing the policy. The policy prevents new noncompliant resources from entering the environment.

The DeployIfNotExists effect combines evaluation with automated remediation. For example, a policy that requires diagnostic logs on Azure Key Vault uses DeployIfNotExists to check whether a diagnostic settings resource exists. If it doesn't, Azure deploys the diagnostic settings automatically during the next policy evaluation cycle.

> [!TIP]
> Use the Audit-first rollout pattern: assign a policy with the Audit effect, review the compliance results, communicate the findings to application teams, and then switch the effect to Deny after remediating the existing noncompliant resources.

A related effect, **AuditIfNotExists**, behaves like Audit but evaluates associated resources rather than the resource itself. For example, a policy that audits whether a VM has a specific extension installed uses AuditIfNotExists because the extension is a separate resource.

## Policy scope hierarchy—where to assign matters

Policy assignments inherit through the Azure resource hierarchy: management group → subscription → resource group → resource. The scope you choose determines which resources the policy evaluates.

Assigning a policy at the **management group** scope covers every subscription within that management group, including new subscriptions added in the future. For organization-wide baseline controls, this approach works best. Contoso's security engineer assigns the Azure Security Benchmark initiative at the root management group to ensure every subscription inherits the same security policies.

Assigning at the **subscription** scope only covers resources within that subscription. New subscriptions created later aren't covered automatically. This scope is appropriate for policies that apply only to a specific workload or business unit.

Resource group and resource scopes exist but are rarely used for security policies. Security controls typically apply broadly rather than to individual resources.

**Exclusions** let you carve out exceptions to a management group-level assignment. When a specific subscription, resource group, or resource has a justified exception, you exclude that scope from the assignment. For example, Contoso might exclude a sandbox subscription used for proof-of-concept testing from the production security policies. Use exclusions sparingly and document the business justification.

Policy assignments evaluate all resources within the assigned scope during the next evaluation cycle. Azure runs a full evaluation scan every 24 hours, but on-demand scans for a specific resource group are available using the Azure CLI.

## Built-in definitions—the security engineer's starting catalog

Azure Policy includes hundreds of **built-in definitions** maintained by Microsoft. These definitions cover common security, compliance, and operational requirements, and most organizations use them as the foundation for their governance baseline.

You find built-in definitions in the Azure portal by navigating to **Policy** → **Definitions** → filtering by the **Category** field. The "Security Center" category contains security-focused definitions, while categories like "SQL," "Storage," and "Key Vault" contain service-specific policies.

Key built-in definitions for a security baseline include:

- **"Transparent data encryption on SQL databases should be enabled"** - Audit or Deny effect; targets `Microsoft.Sql/servers/databases` resources. Detects SQL databases without TDE encryption.
- **"Secure transfer to storage accounts should be enabled"** - Audit or Deny effect; targets `Microsoft.Storage/storageAccounts` resources. Blocks storage accounts that allow HTTP traffic.
- **"Storage accounts should restrict network access"** - Audit effect; evaluates storage account network rules to ensure public access is limited.
- **"Azure Key Vault should use private link"** - Audit effect; detects Key Vaults exposed to the public internet.
- **"Diagnostic logs in Azure Key Vault should be enabled"** - AuditIfNotExists effect; checks whether Key Vault diagnostic settings are configured.

Each definition includes a JSON policy rule that specifies the evaluation logic, the target resource type, and the default effect. You review the JSON by selecting a definition in the portal and choosing the **JSON** tab.

**Initiatives** (also called policy sets) group multiple related definitions into a single assignable unit. The **Microsoft Cloud Security Benchmark** initiative contains dozens of security definitions covering compute, networking, data, identity, and privileged access. Assigning an initiative is more efficient than assigning definitions one by one, and it ensures all related controls deploy together.

For Contoso's scenario, the Microsoft Cloud Security Benchmark initiative includes the policies needed to detect SQL databases without TDE, storage accounts allowing HTTP, and missing diagnostic logs. Assigning this initiative at the management group scope immediately establishes a security baseline across all subscriptions.

## Assign a built-in initiative—portal walkthrough

Assigning the Microsoft Cloud Security Benchmark initiative to the Contoso management group follows this workflow:

1. In the Azure portal, go to **Policy** → **Assignments** → **+ Assign initiative**.
2. Under **Scope**, select the ellipsis (`...`) and choose the management group that covers all Contoso subscriptions. This ensures every subscription inherits the assignment.
3. Under **Initiative definition**, search for "Microsoft Cloud Security Benchmark" and select it from the built-in initiative list.
4. Under **Parameters**, review the default parameter values. Most built-in definitions default to the Audit effect for initial rollouts. Override individual policy parameters if needed (for example, changing a specific definition from Audit to Deny).
5. Under **Remediation**, leave the checkbox unchecked for an Audit rollout. Remediation tasks apply to policies with DeployIfNotExists or Modify effects, which you configure after the initial assessment phase.
6. Under **Non-compliance messages**, optionally enter a custom message that appears when a resource is blocked by a Deny policy. For example: "This resource configuration violates Contoso security policy. Contact security@contoso.com for assistance."
7. Review the assignment details and select **Create**.

After the assignment completes, Azure begins evaluating all resources within the scope during the next policy evaluation cycle. This process runs automatically every 24 hours.

> [!TIP]
> Newly assigned policies can’t show compliance results immediately. Trigger an on-demand evaluation for a specific resource group using the Azure CLI: `az policy state trigger-scan --resource-group <rg-name>`.

To view compliance results:

8. Go to **Policy** → **Compliance** to open the compliance dashboard.
9. The overall compliance percentage shows the fraction of resources meeting all assigned policies. A lower percentage indicates more noncompliant resources.
10. Select a specific policy definition to see the list of noncompliant resources with their reason code and location.

The compliance dashboard organizes results by policy definition, subscription, and resource type. Filter by subscription to see which workloads have the most violations, or filter by policy to identify which controls have the lowest compliance rate.

## Review the compliance dashboard for Contoso's findings

After the first policy evaluation cycle completes, Contoso's security engineer reviews the compliance dashboard and discovers significant gaps:

- **47 storage accounts** with "Secure transfer to storage accounts should be enabled" marked noncompliant—spread across three production subscriptions. These accounts allow HTTP traffic, exposing data in transit to potential interception.
- **12 Azure SQL databases** without TDE enabled—all in the finance and operations subscriptions. These databases store sensitive customer data without encryption at rest.

The compliance dashboard organizes these findings by policy definition and subscription. Each noncompliant resource includes a reason code (for example, "Resource doesn't match policy rule") and a link to the resource's properties in the Azure portal.

The Audit effect produces this visibility without disrupting existing workloads. Contoso's application teams continue operating while the security engineer plans the remediation approach. After security engineers coordinate with stakeholders and updating runbooks, the security engineer switches the policy effects to Deny, preventing new noncompliant resources from entering the environment.
