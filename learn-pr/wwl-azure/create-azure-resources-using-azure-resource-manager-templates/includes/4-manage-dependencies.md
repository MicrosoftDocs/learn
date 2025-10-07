**Resource dependencies** ensure that Azure resources are deployed in the correct order. Some resources require other resources to exist before they can be created successfully.

## Why dependencies matter

**Real-world scenario:** You cannot create a SQL Database without first having a SQL Server to host it. Similarly, a virtual machine requires a virtual network, network interface, and storage account to exist first.

**Azure Resource Manager** automatically handles deployment ordering when you define dependencies properly. This prevents deployment failures and ensures your infrastructure is created in a logical sequence.

**Key concepts:**

- **Explicit dependencies:** You manually define using the `dependsOn` element.
- **Implicit dependencies:** Automatically detected when using the `reference()` function.
- **Parallel deployment:** Resource Manager deploys independent resources simultaneously to reduce deployment time.
- **Template scope:** Dependencies only apply to resources within the same template deployment.

## How Resource Manager handles dependencies

**Resource Manager evaluates dependencies** between resources and deploys them in the correct order:

1. **Analyzes dependencies:** Scans all resources and their `dependsOn` declarations.
2. **Creates deployment plan:** Determines which resources can deploy in parallel and which must wait.
3. **Deploys independent resources first:** Resources with no dependencies start immediately.
4. **Respects dependency chains:** Waits for parent resources before deploying dependent children.
5. **Maximizes parallelism:** Deploys as many resources simultaneously as possible.

**Example deployment order:**

1. Virtual Network (no dependencies) → deploys first
2. Public IP Address (no dependencies) → deploys in parallel with VNet
3. Network Interface (depends on VNet and Public IP) → waits for both
4. Virtual Machine (depends on Network Interface) → deploys last

## The dependsOn element

The **dependsOn element** explicitly defines dependencies between resources. It accepts a comma-separated list (array) of resource names or resource IDs.

**Syntax example:**

```json
{
  "type": "Microsoft.Compute/virtualMachines",
  "apiVersion": "2023-03-01",
  "name": "[variables('vmName')]",
  "location": "[parameters('location')]",
  "dependsOn": [
    "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]",
    "[resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))]"
  ],
  "properties": {
    ...
  }
}
```

**What happens here:**

- The virtual machine won't start deploying until both the network interface and storage account are created.
- Resource Manager waits for the dependencies to complete before proceeding.
- If dependencies fail, the VM deployment is skipped.

**Best practices:**

- **Be specific:** Use `resourceId()` function for clarity and to avoid naming conflicts.
- **Minimize dependencies:** Only declare necessary dependencies to maximize parallel deployment.
- **Document why:** Add comments explaining non-obvious dependency relationships.

**Example with multiple resources:**

```json
"resources": [
  {
    "type": "Microsoft.Network/virtualNetworks",
    "apiVersion": "2023-04-01",
    "name": "[variables('vnetName')]",
    ...
  },
  {
    "type": "Microsoft.Network/networkInterfaces",
    "apiVersion": "2023-04-01",
    "name": "[variables('nicName')]",
    "dependsOn": [
      "[resourceId('Microsoft.Network/virtualNetworks', variables('vnetName'))]",
      "[resourceId('Microsoft.Network/publicIPAddresses', variables('publicIPName'))]"
    ],
    ...
  }
]
```

## Implicit dependencies with reference()

You can also create **implicit dependencies** using the **reference() function**. When you use `reference()`, Resource Manager automatically understands the dependency without requiring `dependsOn`.

**Example:**

```json
{
  "type": "Microsoft.Compute/virtualMachines",
  "apiVersion": "2023-03-01",
  "name": "[variables('vmName')]",
  "properties": {
    "networkProfile": {
      "networkInterfaces": [
        {
          "id": "[resourceId('Microsoft.Network/networkInterfaces', variables('nicName'))]",
          "properties": {
            "primary": true
          }
        }
      ]
    },
    "storageProfile": {
      "imageReference": {
        "publisher": "MicrosoftWindowsServer",
        "offer": "WindowsServer",
        "sku": "2022-Datacenter",
        "version": "latest"
      }
    }
  }
}
```

**When to use each approach:**

- **dependsOn:** Use when one resource must exist before another, but you don't reference its properties.
- **reference():** Use when you need property values from another resource (creates implicit dependency).

## Circular dependencies

A **circular dependency** occurs when resources depend on each other in a loop, making it impossible to determine deployment order.

**Example of circular dependency:**

```
Resource A depends on Resource B
Resource B depends on Resource C
Resource C depends on Resource A ← Circular!
```

**Resource Manager identifies circular dependencies** during template validation before deployment starts. You'll receive an error message like:

```
"Circular dependency detected: 'resourceA' -> 'resourceB' -> 'resourceC' -> 'resourceA'"
```

## Resolving circular dependencies

**Step 1: Evaluate necessity**

- Review each dependency and determine if it's truly required.
- Remove any dependencies that aren't essential for the deployment to succeed.

**Step 2: Use child resources**
If removing dependencies doesn't work, deploy some operations as **child resources** after the parent deployment:

```json
{
  "type": "Microsoft.Sql/servers",
  "apiVersion": "2021-11-01",
  "name": "[variables('sqlServerName')]",
  "resources": [
    {
      "type": "databases",
      "apiVersion": "2021-11-01",
      "name": "[variables('databaseName')]",
      "dependsOn": [
        "[resourceId('Microsoft.Sql/servers', variables('sqlServerName'))]"
      ]
    }
  ]
}
```

**Step 3: Break into multiple deployments**
Split the template into multiple linked templates and deploy them sequentially.

**Prevention tips:**

- Design your architecture with clear dependency hierarchies (avoid bidirectional dependencies).
- Use deployment scripts or extensions for post-deployment configuration instead of complex dependencies.
- Validate templates locally using `az deployment group validate` before actual deployment.
