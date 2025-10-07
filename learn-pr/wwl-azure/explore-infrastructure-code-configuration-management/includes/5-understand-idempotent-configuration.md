**Idempotence** is a key principle in Infrastructure as Code and Configuration as Code. It comes from mathematics but has a simple, practical meaning for infrastructure:

**An idempotent operation produces the same result no matter how many times you run it.**

Think of it like a light switch. If you want the lights on, flipping the switch multiple times doesn't matter—the lights end up on. The operation "turn lights on" is idempotent.

## Why idempotency matters

Consider these two scripts:

**Non-idempotent (bad):**

```bash
# This script fails if run twice!
az group create --name MyResourceGroup --location eastus
az vm create --resource-group MyResourceGroup --name MyVM
```

**Idempotent (good):**

```bash
# This script works whether resources exist or not
az group create --name MyResourceGroup --location eastus --query id --output none 2>/dev/null || true
az vm create --resource-group MyResourceGroup --name MyVM --query id --output none 2>/dev/null || true
```

Or better yet, use a declarative tool like Terraform that's idempotent by design:

```hcl
# Terraform automatically checks if resources exist
resource "azurerm_resource_group" "example" {
  name     = "MyResourceGroup"
  location = "East US"
}
```

:::image type="content" source="../media/idempotency-8f385c83.png" alt-text="A circle has two simultaneously repeating icons of a script and an application in its final state, demonstrating the repeating pattern of idempotence.":::

## Achieving idempotency

**You can make operations idempotent in two ways:**

1. **Check and configure (smart updates):**

   - Check if resource exists
   - If it exists and matches desired state: do nothing
   - If it exists but differs: update it
   - If it doesn't exist: create it

   Example: Terraform, Azure Resource Manager

2. **Replace rather than update (immutable infrastructure):**

   - Delete old resources
   - Create new resources with desired configuration
   - No in-place updates—always start fresh

   Example: Container deployments, blue/green deployments

## Benefits for cloud operations

**Idempotency is essential in cloud environments because:**

- **Auto-scaling:** Systems automatically create and destroy instances. Idempotent scripts ensure each instance configures correctly, even if the script runs multiple times
- **Recovery:** If a deployment fails halfway through, you can safely re-run it without causing errors or duplicates
- **Continuous deployment:** Pipelines can deploy repeatedly without checking current state
- **Disaster recovery:** Restore entire environments by running your IaC templates again

**Best practice:** Always design your Infrastructure as Code and Configuration as Code scripts to be idempotent. This prevents errors, enables automation, and makes your infrastructure more reliable.

> [!NOTE]
> Learn more about idempotency patterns: [Idempotency for Windows Azure Message Queues](https://www.atmosera.com/blog/idempotency-for-windows-azure-message-queues/).
