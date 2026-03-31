**Azure Policy** is Azure's governance service enabling organizations to enforce compliance, security standards, and operational best practices through **policy-as-code**. Azure Policy evaluates Azure resources against defined rules, detects non-compliance, prevents deployment of non-compliant resources, and automatically remediates configuration drift.

As organizations scale Azure deployments across multiple subscriptions, resource groups, and teams, maintaining consistent security configurations, cost controls, and compliance standards becomes challenging. Manual governance processes cannot keep pace with rapid cloud resource provisioning. Azure Policy addresses these challenges by automating governance enforcement, ensuring every Azure resource adheres to organizational standards from deployment through its entire lifecycle.

Azure Policy integrates seamlessly with Azure DevOps and GitHub Actions, enabling **shift-left governance** by validating infrastructure-as-code templates before deployment, blocking non-compliant deployments, and providing immediate feedback to development teams.

## Core concepts

**Policy-as-code:**

Azure Policy implements governance through **JSON-based policy definitions** stored in version control, enabling governance rules to be versioned, reviewed, tested, and deployed through CI/CD pipelines like application code.

**Policy definition structure:**

```json
{
  "properties": {
    "displayName": "Require encryption for storage accounts",
    "description": "Enforces encryption in transit for all storage accounts",
    "mode": "All",
    "metadata": {
      "category": "Storage",
      "version": "1.0.0"
    },
    "parameters": {
      "effect": {
        "type": "String",
        "defaultValue": "Deny",
        "allowedValues": ["Audit", "Deny", "Disabled"]
      }
    },
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Storage/storageAccounts"
          },
          {
            "field": "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly",
            "notEquals": "true"
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
    }
  }
}
```

**Policy definition components:**

- **DisplayName:** Human-readable policy name displayed in Azure portal.
- **Description:** Detailed explanation of policy purpose and behavior.
- **Mode:** Evaluation mode (`All` for all resource types, `Indexed` for resources supporting tags and location).
- **Metadata:** Categorization and versioning information.
- **Parameters:** Configurable values allowing policy reuse with different settings.
- **PolicyRule:** Conditional logic defining compliance criteria and enforcement action.

**Policy effects:**

Azure Policy supports multiple **effects** controlling how non-compliant resources are handled:

**Enforcement effects:**

- **Deny:** Blocks deployment of non-compliant resources. Resource creation/update requests fail with error message explaining policy violation.
- **DeployIfNotExists (DINE):** Automatically deploys required resources or configurations if they don't exist. Used for deploying monitoring agents, diagnostic settings, or security configurations.
- **Modify:** Automatically modifies resource properties during deployment to enforce compliance. Used for adding required tags or enabling specific settings.

**Assessment effects:**

- **Audit:** Logs non-compliant resources but doesn't prevent deployment. Used for identifying violations without blocking operations.
- **AuditIfNotExists:** Logs when required related resources don't exist. Used for detecting missing configurations like diagnostic settings or backup policies.

**Control effects:**

- **Disabled:** Temporarily disables policy evaluation without removing policy assignment.
- **Append:** Adds specified fields to resources during creation or update. Useful for enforcing specific configurations like allowed IP ranges or required parameters.

**Policy evaluation:**

Azure Policy evaluates resources at multiple points:

- **Deployment-time evaluation:** Evaluates resources during ARM template deployments, Azure portal deployments, and API calls creating or updating resources.
- **Compliance scan:** Periodic background scans evaluating existing resources against policies (runs approximately every 24 hours).
- **On-demand evaluation:** Triggered manually through Azure portal or API for immediate compliance assessment.

**Evaluation flow:**

1. **Resource deployment initiated** via portal, CLI, PowerShell, or ARM template.
2. **Azure Resource Manager** receives deployment request.
3. **Policy engine** evaluates request against assigned policies at target scope.
4. **Policy effect applied:**
   - **Deny effect:** Deployment fails with policy violation error.
   - **DeployIfNotExists effect:** Additional resources deployed automatically.
   - **Modify effect:** Resource properties modified to meet compliance.
   - **Audit effect:** Non-compliance logged, deployment continues.
5. **Compliance state updated** in Azure Policy compliance dashboard.

## Policy assignment

**Policy assignment** applies policy definitions to specific **scopes** in Azure resource hierarchy.

**Azure resource hierarchy:**

```
Management Group (Root)
├── Management Group (Production)
│   ├── Subscription (Prod-01)
│   │   ├── Resource Group (Web-App-RG)
│   │   │   └── Resources (VMs, Storage, etc.)
│   │   └── Resource Group (Database-RG)
│   └── Subscription (Prod-02)
└── Management Group (Development)
    └── Subscription (Dev-01)
```

**Assignment scopes:**

- **Management group:** Policy applies to all subscriptions and resource groups within management group and child management groups.
- **Subscription:** Policy applies to all resource groups and resources within subscription.
- **Resource group:** Policy applies only to resources within specific resource group.

**Scope inheritance:**

Policies assigned at higher scopes **automatically inherit** to child scopes. Policy assigned at management group scope applies to all subscriptions, resource groups, and resources beneath it.

**Exemptions:**

Organizations can **exempt** specific scopes from policy assignment:

- **Exemption reasons:** Mitigation (temporary exemption while remediation planned), Waiver (permanent exemption with business justification).
- **Exemption expiration:** Exemptions can expire automatically, requiring renewal or remediation.

**Assign policy via Azure portal:**

1. **Navigate to Azure Policy** in Azure portal.
2. **Click "Assignments"** in left navigation.
3. **Click "Assign policy"**.
4. **Configure assignment:**
   - **Scope:** Select management group, subscription, or resource group.
   - **Exclusions:** Optionally exclude child scopes from policy.
   - **Policy definition:** Select built-in or custom policy.
   - **Assignment name:** Descriptive name for assignment.
   - **Description:** Explanation of why policy is assigned.
   - **Policy enforcement:** Enabled (enforces policy) or Disabled (assessment only).
5. **Configure parameters:** Set parameter values (effect, allowed locations, etc.).
6. **Configure remediation:** Enable remediation task for DeployIfNotExists or Modify effects.
7. **Click "Review + create"** to assign policy.

**Assign policy via Azure CLI:**

```azurecli
# Assign built-in policy to subscription
az policy assignment create \
  --name 'RequireEncryptionForStorage' \
  --display-name 'Require encryption for all storage accounts' \
  --scope '/subscriptions/{subscription-id}' \
  --policy '/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9' \
  --params '{
    "effect": {
      "value": "Deny"
    }
  }'
```

**Assign policy via Azure PowerShell:**

```powershell
# Assign custom policy to resource group
$rg = Get-AzResourceGroup -Name 'production-rg'
$policyDef = Get-AzPolicyDefinition -Name 'CustomVMSizePolicy'

New-AzPolicyAssignment `
  -Name 'EnforceVMSizes' `
  -DisplayName 'Enforce approved VM sizes in production' `
  -Scope $rg.ResourceId `
  -PolicyDefinition $policyDef `
  -PolicyParameter '{
    "allowedSKUs": {
      "value": ["Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3"]
    }
  }'
```

## Built-in policies

Azure Policy provides hundreds of **built-in policy definitions** covering common governance scenarios:

**Security policies:**

- **Require secure transfer for storage accounts:** Ensures all storage accounts enforce HTTPS-only access.
- **Deploy Advanced Threat Protection on storage accounts:** Automatically enables Defender for Storage.
- **Require encryption of SQL databases:** Enforces Transparent Data Encryption (TDE) for SQL databases.
- **Require MFA for accounts with write permissions:** Audits subscriptions without MFA enforcement for privileged accounts.

**Cost management policies:**

- **Allowed virtual machine size SKUs:** Restricts VM deployments to approved sizes, preventing oversized VMs.
- **Allowed locations for resources:** Restricts resource deployments to cost-effective or approved regions.
- **Not allowed resource types:** Prevents deployment of expensive resource types (e.g., HDInsight clusters, ExpressRoute circuits).

**Operational policies:**

- **Require diagnostic settings for resource types:** Ensures all resources send logs to Log Analytics workspace.
- **Require backup for virtual machines:** Ensures Azure Backup is configured for all production VMs.
- **Require tags on resources:** Enforces required tagging (CostCenter, Owner, Environment) for resource organization.

**Browse built-in policies:**

1. **Navigate to Azure Policy** in Azure portal.
2. **Click "Definitions"** in left navigation.
3. **Filter by category:** Security Center, Monitoring, Storage, Compute, Networking, etc.
4. **Search policies:** Use search box to find specific policies by name or keyword.
5. **Review policy details:** Click policy to view JSON definition, parameters, and effect.

## Policy compliance

**Compliance dashboard** provides centralized visibility into policy compliance across Azure estate.

**Access compliance dashboard:**

1. **Navigate to Azure Policy** in Azure portal.
2. **Click "Compliance"** in left navigation.
3. **View compliance summary:**
   - **Compliance percentage:** Overall percentage of compliant resources.
   - **Non-compliant resources:** Count of resources violating policies.
   - **Non-compliant policies:** List of policies with violations.

**Compliance states:**

- **Compliant:** Resource meets all assigned policy requirements.
- **Non-compliant:** Resource violates one or more assigned policies.
- **Conflict:** Resource is subject to conflicting policies (one policy denies, another allows).
- **Not started:** Policy evaluation hasn't run yet.
- **Exempt:** Resource is explicitly exempted from policy.

**Investigate non-compliance:**

1. **Click non-compliant policy** in compliance dashboard.
2. **View affected resources:** List of specific resources violating policy.
3. **Review resource details:** Click resource to see policy requirements and actual configuration.
4. **Check compliance history:** View when resource became non-compliant and previous compliance states.
5. **Generate compliance report:** Export compliance data for auditing or remediation planning.

## CI/CD pipeline integration

Azure Policy integrates with Azure DevOps and GitHub Actions to validate infrastructure-as-code templates before deployment.

**Azure Pipelines - Policy validation:**

**Pre-deployment policy check:**

```yaml
trigger:
  - main

pool:
  vmImage: "ubuntu-latest"

steps:
  - task: AzureCLI@2
    displayName: "Validate ARM template against policies"
    inputs:
      azureSubscription: "Production-Service-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        # Test ARM template deployment (what-if operation)
        az deployment group what-if \
          --resource-group production-rg \
          --template-file infrastructure/main.bicep \
          --parameters environment=production

  - task: AzurePolicyCheckGate@0
    displayName: "Check Azure Policy compliance"
    inputs:
      azureSubscription: "Production-Service-Connection"
      ResourceGroupName: "production-rg"
      Resources: "StorageAccount,VirtualMachine,SqlDatabase"

  - task: AzureResourceManagerTemplateDeployment@3
    condition: succeeded() # Only deploy if policy check passes
    displayName: "Deploy infrastructure"
    inputs:
      azureResourceManagerConnection: "Production-Service-Connection"
      subscriptionId: "$(AzureSubscriptionId)"
      resourceGroupName: "production-rg"
      location: "East US"
      templateLocation: "Linked artifact"
      csmFile: "$(Build.SourcesDirectory)/infrastructure/main.bicep"
      deploymentMode: "Incremental"
```

**Post-deployment compliance validation:**

```yaml
steps:
  - task: AzureCLI@2
    displayName: "Validate deployed resources comply with policies"
    inputs:
      azureSubscription: "Production-Service-Connection"
      scriptType: "bash"
      scriptLocation: "inlineScript"
      inlineScript: |
        # Trigger policy compliance scan
        az policy state trigger-scan \
          --resource-group production-rg \
          --no-wait

        # Wait for scan completion
        sleep 60

        # Check compliance state
        compliance=$(az policy state list \
          --resource-group production-rg \
          --filter "complianceState eq 'NonCompliant'" \
          --query "length(@)")

        if [ $compliance -gt 0 ]; then
          echo "ERROR: $compliance resources are non-compliant with policies"
          exit 1
        else
          echo "SUCCESS: All resources are policy compliant"
        fi
```

**GitHub Actions - Policy validation:**

```yaml
name: Infrastructure Deployment with Policy Validation

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  validate-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Validate infrastructure against policies
        uses: azure/arm-deploy@v1
        with:
          scope: resourcegroup
          resourceGroupName: production-rg
          template: ./infrastructure/main.bicep
          parameters: environment=production
          deploymentMode: Validate # Validation only, no actual deployment

      - name: Check policy compliance
        run: |
          # Scan for policy violations
          az policy state trigger-scan --resource-group production-rg

          # Get non-compliant resources
          non_compliant=$(az policy state list \
            --resource-group production-rg \
            --filter "complianceState eq 'NonCompliant'" \
            --query "length(@)")

          if [ $non_compliant -gt 0 ]; then
            echo "::error::Found $non_compliant non-compliant resources"
            exit 1
          fi

      - name: Deploy infrastructure
        if: success()
        uses: azure/arm-deploy@v1
        with:
          scope: resourcegroup
          resourceGroupName: production-rg
          template: ./infrastructure/main.bicep
          parameters: environment=production
          deploymentMode: Incremental
```

**Pipeline benefits:**

- **Early detection:** Policy violations detected before deployment, reducing remediation costs.
- **Fast feedback:** Developers receive immediate feedback on governance violations.
- **Compliance enforcement:** Non-compliant infrastructure cannot reach production.
- **Audit trail:** All policy validation attempts logged for compliance auditing.

## Policy-driven governance scenarios

**Scenario 1: Enforce region restrictions for data residency:**

**Requirement:** EU data protection regulations require all resources storing customer data to reside in EU regions.

**Policy implementation:**

```json
{
  "displayName": "Allowed locations for resources",
  "description": "Restricts resource deployment to EU regions for data residency compliance",
  "policyRule": {
    "if": {
      "allOf": [
        {
          "field": "location",
          "notIn": [
            "northeurope",
            "westeurope",
            "francecentral",
            "germanywestcentral"
          ]
        },
        {
          "field": "type",
          "notEquals": "Microsoft.Resources/resourceGroups"
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  }
}
```

**Scenario 2: Enforce required tagging for cost allocation:**

**Requirement:** All resources must have CostCenter and Owner tags for chargeback.

**Policy implementation:**

```json
{
  "displayName": "Require CostCenter and Owner tags",
  "description": "Enforces required tags for cost allocation and resource ownership",
  "policyRule": {
    "if": {
      "anyOf": [
        {
          "field": "tags['CostCenter']",
          "exists": "false"
        },
        {
          "field": "tags['Owner']",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  }
}
```

**Scenario 3: Automatically enable diagnostic logging:**

**Requirement:** All Azure resources must send diagnostic logs to Log Analytics for security monitoring.

**Policy implementation:**

```json
{
  "displayName": "Deploy diagnostic settings for storage accounts",
  "description": "Automatically configures diagnostic settings for all storage accounts",
  "policyRule": {
    "if": {
      "field": "type",
      "equals": "Microsoft.Storage/storageAccounts"
    },
    "then": {
      "effect": "deployIfNotExists",
      "details": {
        "type": "Microsoft.Insights/diagnosticSettings",
        "existenceCondition": {
          "field": "Microsoft.Insights/diagnosticSettings/logs[*].enabled",
          "equals": "true"
        },
        "deployment": {
          "properties": {
            "mode": "incremental",
            "template": {
              "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
              "contentVersion": "1.0.0.0",
              "parameters": {
                "storageAccountName": {
                  "type": "string"
                },
                "logAnalyticsWorkspaceId": {
                  "type": "string"
                }
              },
              "resources": [
                {
                  "type": "Microsoft.Storage/storageAccounts/providers/diagnosticSettings",
                  "apiVersion": "2021-05-01-preview",
                  "name": "[concat(parameters('storageAccountName'), '/Microsoft.Insights/default')]",
                  "properties": {
                    "workspaceId": "[parameters('logAnalyticsWorkspaceId')]",
                    "logs": [
                      {
                        "category": "StorageRead",
                        "enabled": true
                      },
                      {
                        "category": "StorageWrite",
                        "enabled": true
                      }
                    ]
                  }
                }
              ]
            }
          }
        }
      }
    }
  }
}
```

Azure Policy provides comprehensive governance capabilities enabling organizations to enforce compliance, security standards, and operational best practices through automated policy evaluation, deployment-time enforcement, and continuous compliance monitoring. By integrating Azure Policy with DevOps pipelines, organizations shift governance left, detecting violations early and preventing non-compliant infrastructure from reaching production. The next unit explores creating and managing custom Azure policies for organization-specific requirements.
