Built-in policy definitions cover many organization-specific requirements through parameters. Contoso's security team first checks that catalog, then writes custom logic where an existing definition doesn't fit. In this unit, you create a custom diagnostic policy for production-tagged Key Vaults, configure remediation for existing resources, and grant narrowly scoped policy exemptions.

The following tasks connect policy authoring to an operational governance workflow.

| Task | Purpose |
|------|---------|
| Select or customize a policy definition | Express the required resource condition without duplicating a suitable built-in |
| Configure a remediation task | Apply a deployment or supported modification to existing noncompliant resources |
| Grant an exemption | Record an approved waiver or mitigation for a particular assignment and scope |

## Decide whether a custom definition is necessary

First check whether a built-in definition or initiative can express the requirement through parameters. For example, assign **Require a tag on resource groups** with different `tagName` values for CostCenter, DataClassification, and Owner. If an exact value is required, use **Require a tag and its value on resource groups**. Tag presence alone doesn't establish that its value is nonempty or approved.

When you include several instances of a tag definition in an initiative, give each instance a distinct policy definition reference ID. These tag definitions have a fixed Deny effect, not an Audit parameter. Use a non-enforcing assignment to assess their impact before enforcement.

Diagnostic-deployment built-ins can also accept a designated Log Analytics workspace. For example, **Enable logging by category group for Key vaults (microsoft.keyvault/vaults) to Log Analytics** accepts the workspace's full resource ID in `logAnalytics`. Its `categoryGroup` parameter defaults to `audit`, so select `allLogs` explicitly when that's the requirement.

Write a custom definition when the required condition or behavior isn't available in a suitable built-in. In this example, Contoso adds a vault-level `Environment=Production` condition and requires an enabled `allLogs` category-group setting that targets the approved workspace. This demonstrates extending a supported diagnostic-deployment pattern with an organization-specific resource-selection rule.

## Understand the custom definition

A policy definition uses JSON with three core components: `mode`, `parameters`, and `policyRule`.

The **mode** determines which resource types are evaluated. Use `All` in most cases, including policies that need to evaluate resources without tag and location support. Use `Indexed` for tag or location policies on ordinary resources that support both properties. This example uses `Indexed` because Key Vaults support tags and location.

> [!IMPORTANT]
> Policies that check tags or locations on resource groups or subscriptions use `All`, not `Indexed`. Explicitly target `Microsoft.Resources/subscriptions/resourceGroups` or `Microsoft.Resources/subscriptions`, respectively.

**Parameters** make the definition reusable. `approvedWorkspaceId` selects the destination for each assignment. The `effect` parameter permits AuditIfNotExists, DeployIfNotExists, and Disabled because the definition includes the properties needed for those effects. An effect parameter doesn't make an otherwise unsupported effect valid.

The **policyRule** has `if` and `then` sections. The `if` condition selects production-tagged Key Vaults. The `then` section audits or deploys a related diagnostic setting. Each `field` must use a supported built-in field or an Azure Policy alias. A resource provider's JSON property path isn't automatically a valid policy alias.

Use the following object in the portal's **Policy rule** editor. It contains `mode`, `parameters`, and `policyRule`, without the outer `properties` envelope used for REST definition creation. Enter the display name and description in the portal fields.

```json
{
  "mode": "Indexed",
  "parameters": {
    "approvedWorkspaceId": {
      "type": "String",
      "metadata": {
        "displayName": "Approved Log Analytics workspace ID",
        "description": "Full resource ID of an existing Log Analytics workspace."
      }
    },
    "diagnosticSettingName": {
      "type": "String",
      "defaultValue": "contoso-production-alllogs",
      "metadata": {
        "displayName": "Diagnostic setting name",
        "description": "Use a dedicated setting name after checking existing settings."
      }
    },
    "effect": {
      "type": "String",
      "defaultValue": "AuditIfNotExists",
      "allowedValues": [
        "AuditIfNotExists",
        "DeployIfNotExists",
        "Disabled"
      ]
    }
  },
  "policyRule": {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.KeyVault/vaults"
        },
        {
          "field": "tags['Environment']",
          "equals": "Production"
        }
      ]
    },
    "then": {
      "effect": "[parameters('effect')]",
      "details": {
        "type": "Microsoft.Insights/diagnosticSettings",
        "evaluationDelay": "AfterProvisioning",
        "existenceCondition": {
          "allOf": [
            {
              "field": "Microsoft.Insights/diagnosticSettings/workspaceId",
              "equals": "[parameters('approvedWorkspaceId')]"
            },
            {
              "count": {
                "field": "Microsoft.Insights/diagnosticSettings/logs[*]",
                "where": {
                  "allOf": [
                    {
                      "field": "Microsoft.Insights/diagnosticSettings/logs[*].categoryGroup",
                      "equals": "allLogs"
                    },
                    {
                      "field": "Microsoft.Insights/diagnosticSettings/logs[*].enabled",
                      "equals": true
                    }
                  ]
                }
              },
              "greaterOrEquals": 1
            }
          ]
        },
        "roleDefinitionIds": [
          "/providers/Microsoft.Authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"
        ],
        "deployment": {
          "properties": {
            "mode": "incremental",
            "template": {
              "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
              "contentVersion": "1.0.0.0",
              "parameters": {
                "vaultName": {
                  "type": "string"
                },
                "workspaceId": {
                  "type": "string"
                },
                "settingName": {
                  "type": "string"
                }
              },
              "resources": [
                {
                  "type": "Microsoft.KeyVault/vaults/providers/diagnosticSettings",
                  "apiVersion": "2021-05-01-preview",
                  "name": "[concat(parameters('vaultName'), '/Microsoft.Insights/', parameters('settingName'))]",
                  "properties": {
                    "workspaceId": "[parameters('workspaceId')]",
                    "logs": [
                      {
                        "categoryGroup": "allLogs",
                        "enabled": true
                      }
                    ],
                    "metrics": []
                  }
                }
              ]
            },
            "parameters": {
              "vaultName": {
                "value": "[field('name')]"
              },
              "workspaceId": {
                "value": "[parameters('approvedWorkspaceId')]"
              },
              "settingName": {
                "value": "[parameters('diagnosticSettingName')]"
              }
            }
          }
        }
      }
    }
  }
}
```

The existence condition requires the approved workspace and an enabled `allLogs` entry on the same diagnostic setting. Field count checks the category group and enabled flag on the same array entry. A matching workspace alone, an empty logs array, disabled logging, or metrics-only collection doesn't satisfy this rule. The example deliberately standardizes on the `allLogs` category-group representation rather than an alternative collection of individual categories.

The embedded deployment receives the workspace ID, evaluated vault name, and setting name through parameter mappings. Expressions inside the embedded template reference template parameters, not policy parameters. The deployment creates the same configuration that the existence condition checks.

The `roleDefinitionIds` entry identifies **Log Analytics Contributor**, matching the maintained built-in deployment pattern. It includes diagnostic-setting and deployment operations. Confirm the identity's actual grants at the target and any out-of-scope workspace. For production, review whether a narrower custom role is appropriate.

> [!IMPORTANT]
> The workspace must already exist. Check existing diagnostic settings, the five-settings-per-resource limit, permissions, and expected ingestion charges before remediation. Use a dedicated setting name. If that name already exists, this deployment updates the setting's specified configuration, including its logs, metrics, and destinations. Review it to avoid replacing another team's diagnostic configuration.
>
> Before an approved update to an existing setting, record its full configuration and agree how you'll restore it if the change has an unintended result. Record the test assignment, managed identity, role grants, and any newly created settings so cleanup can target only those objects.

This rule evaluates tags on the vault itself, not on its resource group. Maintain tag governance and a baseline for other resources. An editable tag isn't an unchangeable security boundary, and this definition doesn't cover resources without the matching tag.

> [!NOTE]
> Storage service logs require service-specific configuration. Blob logs belong to `Microsoft.Storage/storageAccounts/blobServices`, not just the storage-account resource. **Configure diagnostic settings for Blob Services to Log Analytics workspace** deploys the StorageRead, StorageWrite, and StorageDelete categories and checks the chosen workspace. File, Queue, and Table services require their corresponding supported configurations.

## Create and assess the definition in the portal

Definition location determines where a custom definition can be assigned. A definition saved at a management group can be assigned there and within its descendant hierarchy, but not to unrelated branches. Saving a definition doesn't enforce it. A separate assignment determines which resources are evaluated.

Use these steps to create and assess the definition:

1. Open **Policy > Definitions > + Policy definition**.
1. Select a management group that's a common ancestor of the intended subscriptions, or a subscription for a subscription-specific definition.
1. Enter **Require production Key Vault allLogs in the approved workspace** as the name.
1. Enter a description such as "Audit or deploy an allLogs diagnostic setting to the approved Log Analytics workspace for Key Vaults tagged Environment=Production." Choose the **Monitoring** category or an appropriate custom category.
1. Paste the complete JSON object above into **Policy rule**, then select **Save**.
1. Assign the definition to an isolated test resource group or subscription inside its definition hierarchy. Set `approvedWorkspaceId` to the full resource ID of an existing test workspace and review `diagnosticSettingName`.
1. Leave the effect as **AuditIfNotExists**. After evaluation completes, inspect applicable production-tagged Key Vaults under **Policy > Compliance**. A vault with a diagnostic setting that meets the rule should be compliant. A vault without a matching setting should be noncompliant.
1. Verify the negative scope and tag cases separately. Compare the test resource IDs and vault-level tags with the assignment's scope, exclusions, and policy rule. A resource outside the assignment scope or in `notScopes` isn't assessed by this assignment. For this AuditIfNotExists rule, a vault without `Environment=Production` doesn't satisfy the complete `if` condition and isn't applicable. Don't expect these cases to appear as compliant resources in the assignment's results.
1. Continue with the managed-identity and remediation procedure to test **DeployIfNotExists** separately before expanding the assignment.

> [!TIP]
> Include test cases for a missing setting, the wrong workspace, disabled logging, a correctly configured production vault, and a vault without the production tag. Also check a resource outside the assignment scope when testing scope boundaries. Record the expected result for each case before evaluating it. Saving JSON validates the accepted definition format, not the policy's business logic.
>
> Missing results alone don't prove that a resource is outside scope or not applicable. Confirm the resource and assignment configuration, allow evaluation to complete, and check for reporting or permission problems. An exemption is a separate case that remains tracked against the assignment.

When you're ready to test the deployment effect, choose the assignment's enforcement mode deliberately.

> [!IMPORTANT]
> Assignment enforcement mode **Disabled** (`DoNotEnforce`) lets you evaluate a remediation-capable policy without automatically enforcing its effect. It isn't the same as the policy effect `Disabled`. An authorized operator can still explicitly start a DeployIfNotExists remediation task, so treat that task as a separate approved change.

## Configure the assignment identity and remediate existing resources

After an applicable create or update request succeeds, DeployIfNotExists can deploy its template following the configured evaluation delay. This example uses `AfterProvisioning`. Background compliance scans instead mark existing resources noncompliant without deploying the missing configuration.

Create a remediation task to repair existing resources, including resources that later drift out of compliance. DeployIfNotExists runs its embedded template, while Modify applies its supported operations. Audit and AuditIfNotExists report findings but aren't eligible for policy remediation tasks.

DeployIfNotExists and Modify assignments use a managed identity for remediation. Read the definition's `roleDefinitionIds` and grant the roles needed by its actual template or operations. The identity's location doesn't have to match the resource locations and doesn't limit its operation to that region.

> [!IMPORTANT]
> For a DeployIfNotExists evaluation triggered by a resource create or update request, Azure Policy uses the requester's identity to read related resources for the existence check. In this Key Vault example, the caller needs `Microsoft.Insights/diagnosticSettings/read` at the vault. The assignment's managed identity separately needs `Microsoft.Insights/diagnosticSettings/write`, the required template-deployment permissions, and appropriate access to the destination workspace. Giving the assignment identity more permissions doesn't supply a missing read permission to the caller.

Plan the size of the remediation task as well as its permissions.

> [!IMPORTANT]
> A remediation task can process a bounded subset of noncompliant resources. The documented `resourceCount` default is 500 and its maximum is 50,000. The `parallelDeployments` default is 10, with supported values from 1 to 30. Review the values selected for your task rather than assuming it'll process every resource in the assignment. Start with a small approved batch, choose concurrency appropriate to the workload, and review the failure threshold before starting.

Your identity choice also determines the permissions that the assignment operator needs.

> [!IMPORTANT]
> If you choose an existing user-assigned managed identity, the operator who attaches it needs read access and `Microsoft.ManagedIdentity/userAssignedIdentities/assign/action` on that identity. Managed Identity Operator at the identity's scope is one way to provide these permissions. The operator also needs permission to create or update the policy assignment. Attaching the identity, granting it roles, and using its permissions for remediation are separate authorization checks. Resource Policy Contributor alone doesn't grant identity-attachment permission.

Configure the assignment identity and run a remediation task with these steps:

1. In **Policy > Assignments**, edit the test assignment and change its effect parameter to **DeployIfNotExists**.
1. On the assignment's **Remediation** tab, choose a system-assigned identity and a supported location other than `global`, or choose an existing user-assigned identity in the same tenant. Save the assignment.
1. Verify the identity's role assignments at the target scope and any destination outside the assignment scope. An authorized operator can grant missing permissions through the relevant scope's **Access control (IAM)**.
1. After evaluation identifies noncompliant resources, open **Policy > Remediation > Policies to remediate** and select the assignment. Alternatively, open its compliance report and select **Create Remediation Task**.
1. For an initiative, select the individual DeployIfNotExists or Modify policy to remediate. A task targets one policy definition reference within that initiative.
1. Select a target scope within the assignment's scope. Use **Locations** only to filter the resources to remediate by region, not to configure the identity's reach.
1. Review the affected resources, resource-count limit, parallel-deployment setting, and failure threshold. Confirm that this batch is approved, then select **Remediate**.
1. Track progress under **Remediation tasks**. Inspect failed deployments and related events for authorization, template, resource-lock, or service-specific errors.
1. Inspect the resulting configuration and allow compliance results to refresh. Compare the task's deployment outcomes with the resources that remain noncompliant. A successful task doesn't prove that resources outside its filters or resource-count limit were repaired. Address failures and use further approved batches for remaining eligible resources.
1. Generate appropriate test activity and confirm that logs reach the intended workspace separately from checking policy compliance.

For an automatic create/update test, use policy enforcement **Enabled** (`Default`) in the isolated test scope. Run the resource operation as the intended deployment principal, confirm its related-resource read permissions, and verify the resulting deployment after provisioning. Expand the assignment only after reviewing the expected impact.

> [!NOTE]
> For a management-group assignment, create remediation tasks after evaluation through the Remediation or Compliance pages. The portal's create-a-task-during-assignment shortcut is documented for subscription assignments.

Before starting a task, separate the operator's role-assignment authority from the managed identity's deployment permissions.

> [!IMPORTANT]
> The portal can grant roles declared in `roleDefinitionIds` when the operator has permission to create those role assignments. The declaration isn't itself an RBAC grant. Don't assume SDK or script-created assignments receive grants automatically. Editing `roleDefinitionIds` doesn't automatically update an existing identity's roles. Check target and destination access and explicitly apply any missing grants.

### Preserve remediation evidence

Record the remediation task's final state, deployment successes and failures, affected resource IDs, and dated post-remediation compliance results. Keep the task ID, assignment ID, definition content and version where applicable, parameters, scope, filters, and approved change reference with that evidence. Record any recovery actions and retain the diagnostic-configuration baseline needed to explain what changed.

> [!IMPORTANT]
> Azure Policy deletes remediation task resources 60 days after their last modification. This removes the task record, not the configuration that remediation deployed. Preserve required evidence in an approved, access-controlled store before test cleanup or automatic task-record deletion, using your organization's retention requirements.
>
> The Azure Activity log has a separate 90-day retention period. If management-operation events must be retained longer, configure an appropriate Activity log diagnostic setting and destination retention. Exported Activity log events aren't a substitute for retaining the remediation task details, deployment outcomes, and relevant compliance results.

### Stop and recover an unintended remediation

Stopping policy enforcement and undoing a resource change are different operations. If a batch produces an unexpected result, pause expansion and follow these steps as part of your approved recovery process:

1. Promptly request cancellation of the affected remediation task at its actual scope. For a task created at resource-group scope, the following Azure CLI command targets that task. Replace every placeholder before running it.

   ```azurecli
   az policy remediation cancel --name "<task-name>" --resource-group "<rg-name>" --subscription "<subscription-id>"
   ```

1. If further automatic deployments from this assignment must stop, change its enforcement mode to `DoNotEnforce` and allow the assignment change to propagate. Review other applicable assignments that might deploy the same configuration. This mode change is separate from task cancellation and isn't an immediate stop for work already started.
1. Inspect the final remediation and deployment states and the resulting resource configuration. Cancellation isn't rollback. Some changes might already have completed or been partially applied.
1. Restore the approved diagnostic configuration from the recorded baseline where needed. Remove only settings created for the test. Confirm log delivery after recovery before resuming the rollout.

> [!WARNING]
> `DoNotEnforce` still permits an explicitly initiated DeployIfNotExists remediation task. Canceling a remediation, disabling enforcement, or removing an assignment doesn't restore configuration that its deployments already changed.

### Clean up the test configuration

Before removing test configuration, preserve the required remediation and recovery evidence, including the final task and deployment outcomes and the configuration baseline.

After testing, stop any remaining test remediation tasks and remove test assignments and settings that aren't needed. Restore any pre-existing setting that the test intentionally changed, and don't delete shared production resources.

A system-assigned identity is deleted with the assignment that owns it. A user-assigned identity has an independent lifecycle and might be shared. Remove an unused test-specific user-assigned identity only after confirming that nothing else needs it. Managed-identity deletion doesn't automatically remove its Azure RBAC role assignments. Have an authorized operator remove the test-specific grants that are no longer required, including any grants at an out-of-scope workspace. Preserve shared identities and the permissions their other consumers still need.

## Grant a scoped policy exemption

Use assignment exclusions for scopes intentionally outside the baseline. Resources excluded through `notScopes` aren't included in that assignment's compliance count. Use an exemption when a resource should remain tracked against an assignment but has an approved waiver or mitigation.

Azure Policy supports two exemption categories:

- **Waiver**: The organization accepts the resource's noncompliance, for example while a change is scheduled.
- **Mitigated**: Another method meets the policy's security intent. Record the evidence that the alternative control achieves that objective.

An exemption applies to one assignment. Another assignment can still enforce an equivalent control on the resource. To grant a narrow exemption:

1. Identify the existing assignment's full resource ID and the resource or resource hierarchy to exempt. Confirm that the exemption is within that assignment's scope.
1. Obtain approval and select **Waiver** or **Mitigated** based on whether the risk is accepted or the control's intent is met by another method.
1. Confirm `Microsoft.Authorization/policyExemptions/write` at the exemption scope and `Microsoft.Authorization/policyAssignments/exempt/action` on the target assignment.
1. Create the exemption with its exact scope, assignment ID, category, justification, and any approved expiration. For an initiative, select only the intended definition reference IDs rather than unintentionally exempting the entire initiative.
1. Inspect the saved exemption and resource compliance after reevaluation. Record the approver and approval-ticket reference in exemption metadata or a linked risk record, and schedule an organizational review.

The following Azure CLI example targets an individual policy assignment. Replace every placeholder before running it, and use an approved future UTC timestamp for the expiration.

```azurecli
az policy exemption create --name "<exemption-name>" --scope "<resource-id>" --policy-assignment "<assignment-id>" --exemption-category Waiver --expires-on "<YYYY-MM-DDTHH:MM:SSZ>" --description "<approved-justification>"
```

For an initiative assignment, add `--policy-definition-reference-ids "<reference-id>"`. Use the actual `policyDefinitionReferenceId` from the initiative, not the policy definition's GUID. Choose Mitigated instead of Waiver only when the alternative control satisfies the intended requirement.

> [!NOTE]
> An exemption's optional expiration ends its effect but preserves the object for records. Azure doesn't force an approval meeting or automatically delete the record. Maintain a review process and revisit expired exemptions.

### Review the technical state behind an exemption

An Exempt result records an approved exception, not proof that the resource meets the rule. Use **Compliance substate** to see what the resource's compliance state would be if its exemption were removed.

To review an exempt resource's compliance substate:

1. Go to **Policy > Compliance** and open the relevant assignment.
1. Select **Edit columns**, add **Compliance substate**, and select **Save**.
1. Review the exempt resource's substate with its justification, approval, and expiration. You can also select **Waiver** or **Mitigated** in the **Compliance details** column to see the substate.

> [!NOTE]
> Compliance substate is part of the compliance result, not a property to set on an exemption. It's populated only for exempt resources. A compliant substate can support a decision to remove an exception, but it doesn't automatically remove the exemption or replace the approval process.

Custom definitions and remediation tasks establish required configurations. The next unit adds management locks as safeguards against accidental control-plane deletion or modification of critical resources.

## More info

The following resources cover custom definitions, diagnostic settings, remediation, and exemptions:

- [Create a custom policy definition](/azure/governance/policy/tutorials/create-custom-policy-definition)
- [Create and manage policies in the portal](/azure/governance/policy/tutorials/create-and-manage)
- [Definition structure and modes](/azure/governance/policy/concepts/definition-structure-basics)
- [Policy applicability and ifNotExists effects](/azure/governance/policy/concepts/policy-applicability)
- [Assignment scopes and exclusions](/azure/governance/policy/concepts/scope)
- [Troubleshoot unexpected compliance results](/azure/governance/policy/troubleshoot/general#scenario-compliance-isnt-as-expected)
- [Policy assignment enforcement mode and identity](/azure/governance/policy/concepts/assignment-structure)
- [DeployIfNotExists behavior and template structure](/azure/governance/policy/concepts/effect-deploy-if-not-exists)
- [Array evaluation and field count](/azure/governance/policy/how-to/author-policies-for-arrays)
- [Remediate noncompliant resources](/azure/governance/policy/how-to/remediate-resources)
- [Remediation task limits and settings](/azure/governance/policy/concepts/remediation-structure)
- [Activity log retention and export](/azure/azure-monitor/fundamentals/activity-log)
- [Diagnostic settings and destination requirements](/azure/azure-monitor/data-collection/diagnostic-settings)
- [Maintained Key Vault category-group logging definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Monitoring/DS_LA_keyvault-vaults_DINE.json)
- [Maintained Blob service diagnostic definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Storage/BlobServicesLogsToWorkspace_DINE.json)
- [Policy exemption properties and permissions](/azure/governance/policy/concepts/exemption-structure)
- [Azure CLI policy exemptions](/cli/azure/policy/exemption)
- [Managed Identity Operator permissions](/azure/role-based-access-control/built-in-roles/identity#managed-identity-operator)
- [Resource Policy Contributor permissions](/azure/role-based-access-control/built-in-roles/management-and-governance#resource-policy-contributor)
- [Cancel a policy remediation](/cli/azure/policy/remediation#az-policy-remediation-cancel)
- [Remediation cancellation behavior](/powershell/module/az.policyinsights/stop-azpolicyremediation)
- [ARM deployment cancellation](/rest/api/resources/deployments/cancel)
- [Managed identity lifecycle and role-assignment cleanup](/entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations#maintenance)
- [Exemption compliance substate](/azure/governance/policy/concepts/exemption-structure#compliance-substate)
