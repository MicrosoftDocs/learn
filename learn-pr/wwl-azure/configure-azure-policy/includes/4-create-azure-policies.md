Azure Administrators use Azure Policy to create policies that define conventions for resources. A _policy definition_ describes the compliance conditions for a resource, and the actions to complete when the conditions are met. One or more policy definitions are grouped into an _initiative definition_, to control the scope of your policies and evaluate the compliance of your resources.

:::image type="content" source="../media/implement-azure-policy-b4a4a47c.png" alt-text="Diagram that shows an initiative definition for a group of policy definitions that are applied to resources." border="false":::

There are four basic steps to create and work with policy definitions in Azure Policy.

### Step 1: Create policy definitions

A policy definition expresses a condition to evaluate and the actions to perform when the condition is met. You can create your own policy definitions, or choose from built-in definitions in Azure Policy. You can create a policy definition to prevent VMs in your organization from being deployed, if they're exposed to a public IP address.

### Step 2: Create an initiative definition

An initiative definition is a set of policy definitions that help you track your resource compliance state to meet a larger goal. You can create your own initiative definitions, or use built-in definitions in Azure Policy. You can use an initiative definition to ensure resources are compliant with security regulations.

### Step 3: Scope the initiative definition

Azure Policy lets you control how your initiative definitions are applied to resources in your organization. You can limit the scope of an initiative definition to specific management groups, subscriptions, or resource groups.

### Step 4: Determine compliance

After you assign an initiative definition, you can evaluate the state of compliance for all your resources. Individual resources, resource groups, and subscriptions within a scope can be exempted from having the policy rules affect it. Exclusions are handled individually for each assignment.
