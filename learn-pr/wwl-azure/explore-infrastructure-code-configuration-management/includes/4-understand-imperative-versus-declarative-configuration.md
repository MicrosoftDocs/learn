When implementing Infrastructure as Code and Configuration as Code, you can choose between two fundamental approaches: **declarative** and **imperative**. Understanding the difference helps you select the right tools and strategies.

## Declarative approach (functional)

**Declarative configuration describes _what_ you want, not _how_ to get there.**

You specify the desired end state, and the system figures out how to achieve it. Think of it like ordering food at a restaurant—you say "I want a cheeseburger" without explaining how to cook it.

**Example (declarative):**

```
resource "virtual_machine" "web_server" {
  name     = "web-vm-01"
  size     = "Standard_D2s_v3"
  location = "East US"
}
```

This code declares: "I want a virtual machine with these properties." The IaC tool determines what actions are needed to create it.

:::image type="content" source="../media/declarative-703bb981.png" alt-text="An arrow points from a script icon to an icon of two cogs representing coding procedures.":::

**Popular declarative tools:**

- Azure Resource Manager (ARM) templates
- Bicep
- Terraform
- Kubernetes manifests

## Imperative approach (procedural)

**Imperative configuration describes _how_ to achieve the desired state.**

You specify step-by-step instructions. It's like following a recipe—do step 1, then step 2, then step 3.

**Example (imperative):**

```
az vm create --name web-vm-01 --size Standard_D2s_v3 --location eastus
az vm extension set --vm-name web-vm-01 --name IIS
az network nsg rule create --name AllowHTTP --priority 100
```

This code explicitly tells the system: "First create the VM, then install IIS, then configure the firewall rule."

:::image type="content" source="../media/imperative-a9e6a2ad.png" alt-text="An arrow points from a script icon to an icon of two cogs representing coding procedures, followed by another arrow pointing to an image representing an application in its final state.":::

**Imperative approaches often include:**

- For loops and conditionals (if-then statements)
- Explicit ordering of operations
- Error handling logic
- More procedural programming concepts

**Popular imperative tools:**

- PowerShell scripts
- Azure CLI scripts
- Ansible playbooks (can be used declaratively or imperatively)
- Python/Bash scripts

## Choosing the right approach

**When to use declarative:**

**Advantages:**

- **Easier to read and understand:** You see _what_ infrastructure exists, not implementation details
- **Idempotent by design:** Run the same template repeatedly—it creates resources that don't exist and ignores ones that do
- **Order-independent:** The tool figures out dependencies and correct ordering
- **Less code:** Shorter, more maintainable definitions
- **Better for teams:** Easier for team members to review and understand

**Best for:**

- Provisioning cloud infrastructure (VMs, networks, storage)
- Deploying containerized applications to Kubernetes
- Teams new to IaC
- Infrastructure that changes infrequently

**Example tools:** Azure Resource Manager templates, Bicep, Terraform, CloudFormation

---

**When to use imperative:**

**Advantages:**

- **Fine-grained control:** Specify exactly how things should happen
- **Easier for complex logic:** If you need loops, conditions, and complex workflows
- **Familiar to developers:** Looks like regular programming
- **Better for dynamic scenarios:** When you need to make decisions based on current state

**Best for:**

- Complex configuration workflows with conditional logic
- Migrating existing scripts to IaC
- Situations requiring precise control over execution order
- Integration with external systems and APIs

**Example tools:** PowerShell, Azure CLI, Python scripts, Ansible

---

**Hybrid approach:**

Many organizations use **both approaches together:**

- **Declarative for infrastructure provisioning** (creating VMs, networks, storage)
- **Imperative for configuration management** (installing software, configuring applications)

For example:

1. Use Terraform (declarative) to create Azure resources
2. Use Ansible or PowerShell (imperative) to configure those resources

**There's no single "best" approach**—choose based on your team's skills, project complexity, and organizational needs. Many modern tools support both styles, giving you flexibility.
