**Policy initiatives** (also called **policy sets**) bundle multiple related policy definitions into logical groups representing comprehensive compliance frameworks, security baselines, or operational standards. Initiatives simplify governance by enabling organizations to assign and manage dozens or hundreds of policies as single units rather than individually managing each policy.

As organizations mature their Azure governance practices, the number of required policies grows rapidly—from initial handful of policies to potentially hundreds covering security, compliance, cost management, and operational requirements. Managing individual policy assignments at this scale becomes unwieldy. Initiatives address this complexity by grouping policies into manageable, purpose-driven collections.

## Initiative benefits

**Simplified management:**

- **Single assignment:** Assign entire compliance framework with single initiative assignment instead of dozens of individual policy assignments.
- **Centralized configuration:** Configure parameters for all policies in initiative through single parameter file.
- **Unified compliance tracking:** View compliance for entire framework rather than tracking individual policies separately.
- **Easier updates:** Add or remove policies from initiative without changing assignments.

**Compliance framework representation:**

Initiatives naturally map to regulatory and compliance frameworks:

- **Azure Security Benchmark:** Microsoft's security baseline with 100+ policies covering identity, network, data protection, and governance.
- **PCI DSS 3.2.1:** Payment Card Industry Data Security Standard with policies enforcing cardholder data protection requirements.
- **ISO 27001:2013:** Information security management policies aligned with ISO 27001 controls.
- **HIPAA / HITRUST:** Healthcare data protection policies ensuring compliance with healthcare regulations.
- **NIST SP 800-53 Rev. 5:** Federal information security policies for U.S. government systems.

## Built-in initiatives

Azure Policy provides built-in initiatives for common compliance frameworks:

**Azure Security Benchmark initiative:**

Comprehensive security baseline with policies covering:

- **Identity and access:** Multi-factor authentication, privileged account protection, role-based access control.
- **Network security:** Network segmentation, secure connectivity, DDoS protection, firewall rules.
- **Data protection:** Encryption at rest, encryption in transit, secure data transfer protocols.
- **Asset management:** Resource inventory, approved resource types, resource locks.
- **Logging and monitoring:** Diagnostic settings, activity log retention, security monitoring.
- **Posture and vulnerability management:** Security assessments, vulnerability scanning, patch management.
- **Endpoint security:** Endpoint protection, malware detection, application controls.
- **Backup and recovery:** Backup policies, disaster recovery configurations.
- **Governance and strategy:** Policy governance, security policies, compliance monitoring.

**Assign Azure Security Benchmark:**

```azurecli
# Assign Azure Security Benchmark to subscription
az policy assignment create \
  --name azure-security-benchmark \
  --display-name 'Azure Security Benchmark' \
  --scope /subscriptions/{subscription-id} \
  --policy-set-definition '/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8'
```

## Custom initiative definitions

Organizations create custom initiatives bundling policies for organization-specific requirements.

**Custom initiative structure:**

```json
{
  "properties": {
    "displayName": "Contoso Security and Compliance Framework",
    "description": "Comprehensive security and compliance policies for Contoso production environments",
    "metadata": {
      "category": "Security",
      "version": "1.0.0"
    },
    "parameters": {
      "effect": {
        "type": "String",
        "defaultValue": "Audit",
        "allowedValues": ["Audit", "Deny", "Disabled"]
      },
      "allowedLocations": {
        "type": "Array",
        "defaultValue": ["eastus", "westus", "centralus"]
      }
    },
    "policyDefinitions": [
      {
        "policyDefinitionId": "/providers/Microsoft.Authorization/policyDefinitions/0a914e76-4921-4c19-b460-a2d36003525a",
        "policyDefinitionReferenceId": "RequireMFAforPrivilegedAccounts",
        "parameters": {
          "effect": {
            "value": "[parameters('effect')]"
          }
        }
      },
      {
        "policyDefinitionId": "/subscriptions/{subscription-id}/providers/Microsoft.Authorization/policyDefinitions/custom-encryption-policy",
        "policyDefinitionReferenceId": "RequireStorageEncryption",
        "parameters": {
          "effect": {
            "value": "Deny"
          }
        }
      },
      {
        "policyDefinitionId": "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c",
        "policyDefinitionReferenceId": "AllowedLocations",
        "parameters": {
          "listOfAllowedLocations": {
            "value": "[parameters('allowedLocations')]"
          }
        }
      }
    ]
  }
}
```

**Create custom initiative:**

```azurecli
# Create custom initiative definition
az policy set-definition create \
  --name contoso-security-framework \
  --display-name 'Contoso Security and Compliance Framework' \
  --description 'Custom security policies for Contoso production environments' \
  --definitions '[
    {
      "policyDefinitionId": "/providers/Microsoft.Authorization/policyDefinitions/0a914e76-4921-4c19-b460-a2d36003525a",
      "parameters": {"effect": {"value": "Audit"}}
    },
    {
      "policyDefinitionId": "/subscriptions/{subscription-id}/providers/Microsoft.Authorization/policyDefinitions/custom-encryption-policy",
      "parameters": {"effect": {"value": "Deny"}}
    }
  ]'

# Assign custom initiative to subscription
az policy assignment create \
  --name contoso-security-assignment \
  --display-name 'Contoso Security Framework Assignment' \
  --scope /subscriptions/{subscription-id} \
  --policy-set-definition contoso-security-framework
```

## Initiative compliance tracking

**Initiative compliance dashboard** shows aggregate compliance for all policies within initiative.

**Access initiative compliance:**

1. **Navigate to Azure Policy** in Azure portal.
2. **Click "Compliance"** in left navigation.
3. **Select initiative assignment** to view compliance details.
4. **View compliance metrics:**
   - **Overall compliance percentage:** Aggregate compliance across all policies in initiative.
   - **Non-compliant policies:** Policies with violations within initiative.
   - **Non-compliant resources:** Resources violating initiative policies.
5. **Drill down to policy details:** Click individual policies to see affected resources and remediation guidance.

**Compliance monitoring example:**

```azurecli
# Get initiative compliance state
az policy state list \
  --policy-set-definition contoso-security-framework \
  --query "[].{Resource:resourceId, Policy:policyDefinitionName, Compliance:complianceState}" \
  --output table

# Get summary of non-compliant resources by policy
az policy state summarize \
  --policy-set-definition contoso-security-framework \
  --filter "complianceState eq 'NonCompliant'" \
  --query "policyAssignments[].{Policy:policyDefinitionName, NonCompliant:results.nonCompliantResources}"
```

Policy initiatives simplify governance at scale by bundling related policies into logical compliance frameworks. Organizations leverage built-in initiatives for industry compliance standards and create custom initiatives for organization-specific requirements, enabling centralized management and unified compliance tracking across entire Azure estates. The next unit explores resource locks for protecting critical Azure resources from accidental deletion or modification.
