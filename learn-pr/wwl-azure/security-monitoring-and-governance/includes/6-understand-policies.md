Creating custom Azure policies enables organizations to enforce organization-specific governance requirements beyond built-in policies. Custom policies address unique compliance mandates, security standards, operational procedures, and business rules specific to organizational needs. This unit explores policy authoring, testing, deployment, and management of custom policies for comprehensive governance.

## Policy authoring workflow

**Custom policy development follows structured workflow:**

1. **Identify governance requirement:** Define specific compliance or operational requirement needing enforcement.
2. **Design policy logic:** Determine evaluation conditions and enforcement effect.
3. **Author policy definition:** Create JSON policy definition with conditional logic.
4. **Test policy:** Validate policy behavior in non-production environment.
5. **Deploy policy:** Assign policy to target scopes (subscriptions, resource groups).
6. **Monitor compliance:** Track policy effectiveness and remediate violations.
7. **Iterate and improve:** Refine policy based on feedback and compliance results.

## Custom policy structure

Custom policies use JSON format with specific schema defining evaluation logic and enforcement actions.

**Complete policy definition example:**

```JSON
{
    "properties": {
        "mode": "all",
        "parameters": {
            "allowedLocations": {
                "type": "array",
                "metadata": {
                    "description": "The list of locations that can be specified when deploying resources",
                    "strongType": "location",
                    "displayName": "Allowed locations"
                }
            }
        },
        "displayName": "Allowed locations",
        "description": "This policy enables you to restrict the locations your organization can specify when deploying resources.",
        "policyRule": {
            "if": {
                "not": {
                    "field": "location",
                    "in": "[parameters('allowedLocations')]"
                }
            },
            "then": {
                "effect": "deny"
            }
        }
    }
}

```

**Common custom policy scenarios:**

- **Allowed Storage Account SKUs (Deny):** Determines if storage account being deployed is within approved SKU sizes, denying storage accounts that don't adhere to defined SKU sizes.
- **Allowed Resource Types (Deny):** Defines resource types that can be deployed, denying all resources not part of defined list.
- **Allowed Locations (Deny):** Restricts available locations for new resources to enforce geo-compliance requirements.
- **Allowed Virtual Machine SKUs (Deny):** Specifies set of virtual machine SKUs that can be deployed.
- **Add tags to resources (Modify):** Applies required tag and default value if deploy request doesn't specify it.
- **Not allowed resource types (Deny):** Prevents specific resource types from being deployed.

## Testing custom policies

**Policy testing approach:**

Before deploying custom policies to production, test in non-production environment to validate behavior:

1. **Create test subscription or resource group:** Isolated environment for policy testing.
2. **Assign policy in audit mode:** Set effect parameter to "Audit" instead of "Deny" to observe violations without blocking deployments.
3. **Deploy test resources:** Create resources that should comply and resources that should violate policy.
4. **Review compliance results:** Verify policy correctly identifies compliant and non-compliant resources.
5. **Adjust policy logic:** Refine conditions and effects based on test results.
6. **Promote to production:** After successful testing, assign policy with enforcement effect (Deny, DeployIfNotExists, Modify) to production scopes.

**Example test workflow:**

```azurecli
# Create test resource group
az group create --name policy-test-rg --location eastus

# Assign policy in audit mode
az policy assignment create \
  --name test-vm-size-policy \
  --display-name 'Test: Allowed VM Sizes (Audit Mode)' \
  --scope /subscriptions/{subscription-id}/resourceGroups/policy-test-rg \
  --policy /subscriptions/{subscription-id}/providers/Microsoft.Authorization/policyDefinitions/custom-vm-size-policy \
  --params '{"effect": {"value": "Audit"}, "allowedSKUs": {"value": ["Standard_D2s_v3", "Standard_D4s_v3"]}}'

# Deploy test VMs (both compliant and non-compliant)
az vm create \
  --resource-group policy-test-rg \
  --name compliant-vm \
  --image UbuntuLTS \
  --size Standard_D2s_v3

az vm create \
  --resource-group policy-test-rg \
  --name non-compliant-vm \
  --image UbuntuLTS \
  --size Standard_B2ms  # Should trigger policy violation

# Check compliance
az policy state list \
  --resource-group policy-test-rg \
  --query "[?complianceState=='NonCompliant'].{Resource:resourceId, Policy:policyDefinitionName}"
```

## Policy parameters

**Parameterized policies** enable policy reuse with different configuration values across multiple assignments.

**Parameter definition:**

```json
{
  "properties": {
    "displayName": "Require specific tags on resources",
    "parameters": {
      "tagName": {
        "type": "String",
        "metadata": {
          "displayName": "Tag Name",
          "description": "Name of the tag to require"
        }
      },
      "tagValue": {
        "type": "String",
        "metadata": {
          "displayName": "Tag Value",
          "description": "Required value for the tag"
        }
      },
      "effect": {
        "type": "String",
        "defaultValue": "Deny",
        "allowedValues": ["Audit", "Deny", "Disabled"],
        "metadata": {
          "displayName": "Effect",
          "description": "Policy enforcement effect"
        }
      }
    },
    "policyRule": {
      "if": {
        "not": {
          "field": "[concat('tags[', parameters('tagName'), ']')]",
          "equals": "[parameters('tagValue')]"
        }
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
    }
  }
}
```

**Parameter usage in assignment:**

```azurecli
# Assign policy with different parameter values for different environments
az policy assignment create \
  --name production-tagging \
  --scope /subscriptions/{subscription-id}/resourceGroups/production-rg \
  --policy custom-tag-requirement \
  --params '{
    "tagName": {"value": "Environment"},
    "tagValue": {"value": "Production"},
    "effect": {"value": "Deny"}
  }'

az policy assignment create \
  --name development-tagging \
  --scope /subscriptions/{subscription-id}/resourceGroups/development-rg \
  --policy custom-tag-requirement \
  --params '{
    "tagName": {"value": "Environment"},
    "tagValue": {"value": "Development"},
    "effect": {"value": "Audit"}
  }'
```

## Policy remediation

**Remediation tasks** bring existing non-compliant resources into compliance by executing **deployIfNotExists** or **modify** effects on resources that already exist.

**Remediation scenarios:**

- **Missing diagnostic settings:** Deploy diagnostic settings to existing resources lacking logging configuration.
- **Missing tags:** Add required tags to existing resources that don't have them.
- **Missing security configurations:** Deploy security agents or enable security features on existing resources.

**Create remediation task:**

1. **Navigate to Azure Policy** in Azure portal.
2. **Click "Compliance"** in left navigation.
3. **Select non-compliant policy** with deployIfNotExists or modify effect.
4. **Click "Create remediation task"**.
5. **Configure remediation:**
   - **Policy assignment:** Select assignment to remediate.
   - **Resources:** Choose specific resources or remediate all non-compliant resources.
   - **Re-evaluate compliance before remediating:** Optional pre-check.
6. **Create remediation task** to execute remediation.

**Remediation via Azure CLI:**

```azurecli
# Create remediation task for non-compliant resources
az policy remediation create \
  --name remediate-diagnostic-settings \
  --policy-assignment /subscriptions/{subscription-id}/providers/Microsoft.Authorization/policyAssignments/require-diagnostic-settings \
  --resource-group production-rg

# Monitor remediation progress
az policy remediation show \
  --name remediate-diagnostic-settings \
  --resource-group production-rg

# List remediation deployments
az policy remediation deployment list \
  --name remediate-diagnostic-settings \
  --resource-group production-rg
```

**Automated bulk remediation:**

```powershell
# PowerShell script for bulk remediation across subscription
$policyAssignment = Get-AzPolicyAssignment -Name "require-backup-for-vms"
$nonCompliantResources = Get-AzPolicyState -PolicyAssignmentName $policyAssignment.Name | Where-Object {$_.ComplianceState -eq "NonCompliant"}

foreach ($resource in $nonCompliantResources) {
    Write-Host "Remediating resource: $($resource.ResourceId)"

    Start-AzPolicyRemediation `
        -Name "remediation-$(Get-Date -Format 'yyyyMMddHHmmss')" `
        -PolicyAssignmentId $policyAssignment.Id `
        -ResourceId $resource.ResourceId
}

Write-Host "Remediation tasks created for $($nonCompliantResources.Count) resources"
```

## Policy versioning and lifecycle

**Version control for policies:**

Store custom policy definitions in Git repositories to enable:

- **Version tracking:** Track policy changes over time with commit history.
- **Code review:** Review policy changes through pull requests before deployment.
- **Rollback capability:** Revert to previous policy versions if issues arise.
- **CI/CD deployment:** Automate policy deployment through pipelines.

**Policy repository structure:**

```
policies/
├── custom/
│   ├── compute/
│   │   ├── allowed-vm-sizes.json
│   │   └── require-vm-backup.json
│   ├── storage/
│   │   ├── require-encryption.json
│   │   └── require-private-endpoints.json
│   └── networking/
│       ├── require-nsg.json
│       └── deny-public-ip.json
├── assignments/
│   ├── production.parameters.json
│   └── development.parameters.json
└── README.md
```

**Policy deployment pipeline:**

```yaml
# Azure Pipelines - Policy deployment
trigger:
  branches:
    include:
      - main
  paths:
    include:
      - policies/**

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: AzureCLI@2
    displayName: "Validate policy definitions"
    inputs:
      azureSubscription: "Policy-Management-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        # Validate JSON syntax
        for policy in policies/custom/**/*.json; do
          echo "Validating $policy..."
          az policy definition validate --rules $policy
        done

  - task: AzureCLI@2
    displayName: "Deploy policy definitions"
    inputs:
      azureSubscription: "Policy-Management-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        # Deploy custom policies
        for policy in policies/custom/**/*.json; do
          policy_name=$(basename $policy .json)
          echo "Deploying policy: $policy_name..."
          
          az policy definition create \
            --name $policy_name \
            --display-name "$(jq -r '.properties.displayName' $policy)" \
            --description "$(jq -r '.properties.description' $policy)" \
            --rules $policy \
            --mode $(jq -r '.properties.mode' $policy)
        done

  - task: AzureCLI@2
    displayName: "Assign policies to subscriptions"
    inputs:
      azureSubscription: "Policy-Management-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        # Assign policies based on environment
        az policy assignment create \
          --name production-governance \
          --scope /subscriptions/{prod-subscription-id} \
          --policy-set-definition production-governance-initiative \
          --params @policies/assignments/production.parameters.json
```

Creating and managing custom Azure policies enables organizations to enforce organization-specific governance requirements, security standards, and operational procedures across Azure environments. Through parameterized policies, comprehensive testing, automated remediation, and version-controlled deployment pipelines, organizations achieve scalable, maintainable governance that adapts to evolving business needs. The next unit explores policy initiatives for bundling multiple policies into logical compliance frameworks.
