Built-in policy definitions cover common security controls, but they can't address every organization-specific requirement. Contoso's security team needs to enforce controls like requiring specific tags on all resource groups, use designated Key Vault instances for customer-managed keys, and route diagnostic logs to a specific Log Analytics workspace. Here, you learn how to create custom Azure Policy definitions that enforce these unique requirements. Then you configure remediation tasks to fix existing noncompliant resources, and use policy exemptions when resources have valid reasons to deviate from standard controls.

| Task | Purpose |
|------|---------|
| Author a custom policy definition | Enforce organization-specific requirements that built-in definitions don't cover |
| Configure a remediation task | Automatically deploy required configurations to existing noncompliant resources |
| Grant an exemption | Exclude specific resources when compensating controls exist or leadership accepts the risk |

## When built-in definitions aren't enough

Built-in policy definitions cover common security controls like encryption, network access, and identity management, but they operate at a general level. Organizations need more granular control to match their specific security standards and compliance frameworks.

Contoso's security baseline requires controls that built-in definitions can't enforce. All resource groups must include three mandatory tags: CostCenter, DataClassification, and Owner. All storage accounts must use a specific customer-managed encryption key stored in Contoso's central Key Vault, not just any customer-managed key. Diagnostic settings on all resources must send logs to Contoso's designated Log Analytics workspace in the East US region, not just any workspace.

Custom policy definitions let you write the exact `policyRule` logic that implements these requirements. You define the condition that triggers evaluation, the parameters that make the definition reusable across environments, and the effect that enforces compliance.

## Anatomy of a custom policy definition

A custom policy definition uses a JSON (JavaScript Object Notation) structure with three core components: mode, parameters, and policyRule. Understanding each component helps you build definitions that enforce exactly what your organization requires.

```json
{
  "properties": {
    "displayName": "Storage accounts must use the approved Log Analytics workspace",
    "description": "Ensures diagnostic settings on storage accounts send logs to the Contoso central Log Analytics workspace.",
    "mode": "All",
    "parameters": {
      "approvedWorkspaceId": {
        "type": "String",
        "metadata": {
          "displayName": "Approved Log Analytics workspace ID",
          "description": "The resource ID of the required Log Analytics workspace."
        }
      },
      "effect": {
        "type": "String",
        "defaultValue": "AuditIfNotExists",
        "allowedValues": ["AuditIfNotExists", "Disabled"]
      }
    },
    "policyRule": {
      "if": {
        "field": "type",
        "equals": "Microsoft.Storage/storageAccounts"
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "type": "Microsoft.Insights/diagnosticSettings",
          "existenceCondition": {
            "field": "Microsoft.Insights/diagnosticSettings/workspaceId",
            "equals": "[parameters('approvedWorkspaceId')]"
          }
        }
      }
    }
  }
}
```

The **mode** property determines which resource types the policy evaluates. Use `"All"` to evaluate all resource types, including those without tags and location support, such as diagnostic settings and network security rules. Use `"Indexed"` to evaluate only resource types that support tags and location, which is appropriate for policies that check tag compliance or regional restrictions.

**Parameters** make the definition reusable across different environments and scopes. The `approvedWorkspaceId` parameter lets you specify a different Log Analytics workspace for each assignment without modifying the definition. Always include an `effect` parameter with `allowedValues` so the assignment can toggle between audit mode during testing and enforcement mode in production.

The **policyRule** contains two sections: `if` and `then`. The `if` section defines the condition that triggers evaluation, using the `field` keyword to access resource properties like type, location, tags, or SKU. The `then` section specifies the action when the condition is true, referencing the `effect` parameter. For AuditIfNotExists and DeployIfNotExists effects, the `details.existenceCondition` section checks whether the required associated resource or property exists.

## Create a custom definition in the portal

Creating a custom definition in the Azure portal involves setting the scope. Then providing metadata that helps security teams find and understand the definition, and pasting the policy rule JSON you authored.

1. In the Azure portal, go to **Policy** > **Definitions** > **+ Policy definition**.
2. Set **Definition location** to your management group. This makes the definition available for assignment in all child subscriptions, ensuring consistent enforcement across your entire Azure tenant.
3. Enter a **Name** that clearly describes what the policy enforces, such as "Require Contoso central Log Analytics workspace."
4. Enter a **Description** that explains the business justification and what resources the policy targets.
5. Set **Category** to an existing category like "Monitoring" or create a new category like "Contoso Security Baseline" to group organization-specific definitions.
6. Paste your JSON policy rule into the **POLICY RULE** editor.
7. Add parameters using the parameter editor if you need to make values configurable at assignment time.
8. Select **Save**.

> [!TIP]
> Before saving, use the **Evaluate** tab in the Azure portal to test the policy rule against a specific existing resource. The evaluation shows whether the resource is compliant or noncompliant, helping you confirm the logic produces the expected result before you assign the definition.

After you save the definition, it appears in the **Policy** > **Definitions** list and becomes available for assignment through initiatives or direct assignments.

## Configure a remediation task for existing noncompliant resources

Custom policies with DeployIfNotExists effects identify noncompliant resources but don't automatically fix them. Remediation tasks apply the required configuration to existing resources that were created before the policy assignment or that became noncompliant due to configuration drift.

Remediation tasks require a **managed identity** assigned to the policy assignment. The managed identity must have the role-based access control (RBAC) permissions needed to deploy the required resource. For a policy that deploys diagnostic settings, the managed identity needs the "Monitoring Contributor" role. For a policy that configures network security rules, the managed identity needs "Network Contributor."

1. In the Azure portal, go to **Policy** > **Remediation** > **+ Remediation task**.
2. Select the policy assignment that uses the DeployIfNotExists effect.
3. Select the scope where you want to remediate noncompliant resources, such as a specific subscription or management group.
4. Under **Managed identity**, confirm the managed identity location matches the region where you plan to deploy resources. Azure creates the managed identity in this region.
5. Under **Locations to remediate**, select the Azure regions where noncompliant resources exist.
6. Select **Start remediation task**.

The task appears in the remediation history with a progress indicator showing how many resources were successfully remediated. It also shows how many are in progress, and how many failed. Failed remediations typically indicate insufficient RBAC permissions or a policy rule logic error.

> [!IMPORTANT]
> The managed identity for the policy assignment must have the appropriate RBAC role at the scope where it deploys resources. Failing to grant this role causes remediation tasks to fail with an authorization error, even when the policy assignment itself evaluates resources successfully. Assign the role before creating the remediation task.

## Policy exemptions—when a resource shouldn't comply

Policy exemptions exclude specific resources from a policy assignment without changing the assignment for all other resources in the scope. Exemptions maintain strict enforcement for most resources while accommodating legitimate exceptions.

Azure Policy supports two exemption categories. A **waiver** exemption indicates the organization accepts the risk identified by the policy. No compensating control is in place, but leadership reviewed the risk and decided it's acceptable for this specific resource, often due to business constraints or legacy system limitations. A **mitigated** exemption indicates a compensating control addresses the same security objective that the policy targets. The resource doesn't technically comply with the policy definition, but the underlying security requirement is satisfied through an alternative mechanism.

Exemptions include optional expiration dates. Setting an expiration forces periodic review to confirm the exemption is still justified. When the exemption expires, the resource becomes subject to the policy assignment again, and compliance evaluation resumes. Exemptions appear in the Azure Policy compliance view and are included in compliance reports, ensuring transparency and audit trail for all deviations from standard controls.

Custom policy definitions and remediation tasks enforce what resources must have. The next control layer is preventing resources themselves from being deleted. Unit 4 covers resource locks—a last-resort protection against accidental or malicious deletion of critical infrastructure.
