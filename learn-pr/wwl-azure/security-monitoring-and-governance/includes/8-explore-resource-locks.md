**Resource locks** protect critical Azure resources from accidental deletion or modification by enforcing administrative restrictions that override user permissions. Even users with Owner or Contributor roles cannot delete or modify locked resources, providing essential protection against operational mistakes, unauthorized changes, and configuration drift for mission-critical infrastructure.

Organizations face risks from accidental resource deletion including production database deletion, network configuration changes disrupting connectivity, and critical VM deletions causing service outages. Resource locks provide final safeguard preventing these incidents regardless of user permissions or access levels.

## Lock types

Azure supports two lock levels providing different protection scopes:

**CanNotDelete lock:**

- **Read operations:** Allowed (viewing resource properties, monitoring metrics, accessing resource data).
- **Update operations:** Allowed (modifying configurations, changing settings, updating properties).
- **Delete operations:** **Blocked** (cannot delete resource regardless of permissions).

**Use cases for CanNotDelete:**

- **Production databases:** Prevent accidental deletion while allowing configuration updates.
- **Critical VMs:** Protect infrastructure VMs (domain controllers, monitoring servers) from deletion.
- **Network resources:** Secure virtual networks, VPN gateways, ExpressRoute circuits from removal.
- **Storage accounts:** Protect backup storage, audit log storage from accidental deletion.

**ReadOnly lock:**

- **Read operations:** Allowed (viewing resource properties, monitoring metrics).
- **Update operations:** **Blocked** (cannot modify any settings or configurations).
- **Delete operations:** **Blocked** (cannot delete resource).

**Use cases for ReadOnly:**

- **Compliance-frozen resources:** Resources under audit or regulatory hold requiring immutability.
- **Reference architectures:** Template resources serving as patterns for replication.
- **Change control periods:** Temporary restriction during change freezes or high-risk periods.
- **Shared services:** Core infrastructure requiring stability across multiple dependent workloads.

## Lock inheritance

Locks applied at parent scopes automatically inherit to child resources:

**Inheritance hierarchy:**

```
Subscription Lock (CanNotDelete)
├── Applies to ALL resource groups in subscription
│   ├── Resource Group A
│   │   ├── ALL resources inherit CanNotDelete
│   │   └── Resource Group Lock (ReadOnly) - Most restrictive wins
│   │       └── Resources have BOTH CanNotDelete AND ReadOnly
│   └── Resource Group B
│       ├── ALL resources inherit CanNotDelete
│       └── Individual resource lock can add ReadOnly
```

**Lock precedence:**

When multiple locks apply to resource, **most restrictive lock takes precedence**. ReadOnly is more restrictive than CanNotDelete, so resource with both locks becomes ReadOnly.

## Implementing resource locks

**Apply lock via Azure portal:**

1. **Navigate to resource** to lock (subscription, resource group, or individual resource).
2. **Click "Locks"** in Settings section of left navigation.
3. **Click "Add"** to create new lock.
4. **Configure lock:**
   - **Lock name:** Descriptive name explaining lock purpose.
   - **Lock type:** Select CanNotDelete or ReadOnly.
   - **Notes:** Explanation of why lock is applied (optional but recommended).
5. **Save** to apply lock.

**Apply lock via Azure CLI:**

```azurecli
# Apply CanNotDelete lock to resource group
az lock create \
  --name ProductionRGLock \
  --resource-group production-rg \
  --lock-type CanNotDelete \
  --notes "Prevents accidental deletion of production resources"

# Apply ReadOnly lock to storage account
az lock create \
  --name AuditStorageLock \
  --resource-type Microsoft.Storage/storageAccounts \
  --resource-name auditlogstorage \
  --resource-group compliance-rg \
  --lock-type ReadOnly \
  --notes "Storage account under regulatory hold - no modifications allowed"

# Apply lock to subscription
az lock create \
  --name SubscriptionProtection \
  --lock-type CanNotDelete \
  --notes "Prevents deletion of critical subscription resources"
```

**Apply lock via Azure PowerShell:**

```powershell
# Apply CanNotDelete lock to VM
New-AzResourceLock `
  -LockName "DomainControllerLock" `
  -LockLevel CanNotDelete `
  -ResourceName "dc01" `
  -ResourceType "Microsoft.Compute/virtualMachines" `
  -ResourceGroupName "infrastructure-rg" `
  -LockNotes "Domain controller - critical infrastructure"
```

## Lock operations

**View existing locks:**

```azurecli
# List locks on resource group
az lock list --resource-group production-rg --output table

# List all locks in subscription
az lock list --subscription {subscription-id} --output table
```

**Remove locks:**

```azurecli
# Delete lock by name
az lock delete --name ProductionRGLock --resource-group production-rg

# Delete lock by ID
az lock delete --ids /subscriptions/{subscription-id}/resourceGroups/production-rg/providers/Microsoft.Authorization/locks/ProductionRGLock
```

**Lock removal requirements:**

To remove lock, users must have:

- **Microsoft.Authorization/locks/delete** permission (Owner and User Access Administrator built-in roles have this permission).
- **Lock deletion:** Separate permission from resource deletion, providing additional protection layer.

## Lock management best practices

**Lock critical infrastructure immediately:**

Apply locks during initial resource deployment through ARM templates or Bicep:

```bicep
// Bicep template - Deploy resource with lock
resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: 'contoso-prod-sql'
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
  }
}

// Apply CanNotDelete lock to SQL Server
resource sqlServerLock 'Microsoft.Authorization/locks@2020-05-01' = {
  name: 'sql-server-lock'
  scope: sqlServer
  properties: {
    level: 'CanNotDelete'
    notes: 'Production SQL Server - prevents accidental deletion'
  }
}
```

**Document lock purposes:**

Always provide clear notes explaining why lock exists and under what conditions it can be removed.

**Regular lock reviews:**

Periodically review locks to ensure they remain necessary and appropriately configured. Remove locks for decommissioned resources.

**Balance protection with flexibility:**

- **Production resources:** Apply CanNotDelete locks to allow necessary updates while preventing deletion.
- **Change control:** Apply ReadOnly locks temporarily during change freeze periods, removing after freeze ends.
- **Emergency procedures:** Document emergency lock removal procedures for crisis situations requiring rapid changes.

**Combine with Azure Policy:**

Use Azure Policy to automatically apply locks to newly created resources matching specific criteria:

```json
{
  "policyRule": {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Sql/servers"
        },
        {
          "field": "tags['Environment']",
          "equals": "Production"
        }
      ]
    },
    "then": {
      "effect": "deployIfNotExists",
      "details": {
        "type": "Microsoft.Authorization/locks",
        "existenceCondition": {
          "field": "Microsoft.Authorization/locks/level",
          "equals": "CanNotDelete"
        },
        "deployment": {
          "properties": {
            "mode": "incremental",
            "template": {
              "resources": [
                {
                  "type": "Microsoft.Authorization/locks",
                  "name": "AutoAppliedProductionLock",
                  "properties": {
                    "level": "CanNotDelete",
                    "notes": "Automatically applied to production SQL Servers"
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

Resource locks provide essential protection against accidental deletion and modification of critical Azure resources. By strategically applying CanNotDelete and ReadOnly locks to mission-critical infrastructure, organizations prevent operational incidents, maintain compliance requirements, and enforce change control procedures across Azure environments. The next unit explores Microsoft Defender for Identity for detecting identity-based threats and suspicious activities.
