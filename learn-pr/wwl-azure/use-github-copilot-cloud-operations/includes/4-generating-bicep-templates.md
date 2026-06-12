::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8fe1c3f3-a59f-4298-bd4d-03f3605a3bb9]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Bicep is Microsoft's domain-specific language for deploying Azure resources. It compiles to Azure Resource Manager JSON templates but is more readable and concise. Bicep removes the boilerplate of Azure Resource Manager while keeping the declarative model.

A basic Bicep resource definition looks like this:

```bicep
param location string = 'eastus'
param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}
```

Three things to notice: the `@` symbol separates the resource type from the API version, parameters are declared at the top, and resource references use symbolic names rather than resource IDs. These patterns matter when reviewing Copilot's output.

This unit focuses on using Copilot to generate, extend, and optimize Bicep templates. For a full Bicep introduction, see [Introduction to Bicep](/training/modules/implement-bicep/1-introduction).

## Generating templates from natural language prompts

By default, Copilot generates Bicep based on its training data. No external tools or live schema data are involved. For common resource types with specific requirements, this already produces reliable output.

### Generating a simple template

Start with a focused, single-resource prompt to see what Copilot produces. A well-constrained prompt like this one gives Copilot everything it needs:

```
Generate a Bicep template for an Azure Storage Account with these requirements:
- Standard_LRS SKU
- StorageV2 kind
- HTTPS-only access enforced
- Minimum TLS version: TLS 1.2
- Blob soft delete enabled with 7-day retention
- Public blob access disabled
- Parameters for: storageAccountName, location (default: eastus),
  environment, owner, costCenter
- Apply tags using a tags object built from the environment, owner,
  and costCenter parameters
- Output the storage account's primary blob endpoint
```

You should get a complete Bicep file with parameters, a resource block, and an output. Validate it immediately with `az bicep build` before doing anything else.

### Generating a multi-resource template

Complexity increases when multiple resources depend on each other. Resource references, where one resource's symbolic name appears inside another resource's properties, are where Copilot sometimes needs correction.

Try this prompt to generate a connected set of resources:

```
Generate a Bicep template that deploys the following resources:
- An App Service Plan (Standard S1 SKU) on Linux
- An App Service (Web App) using Node 20 on the App Service Plan
- A Key Vault with RBAC authorization enabled and soft delete (90 days)
- A Role Assignment giving the Web App's system-assigned managed identity
  the "Key Vault Secrets User" role on the Key Vault
- Application settings on the Web App pointing to the Key Vault URI

Parameters: appName, location, environment, owner, costCenter
Use symbolic name references for all cross-resource dependencies.
Do not use hardcoded resource IDs.
```

Review the output for three common issues at this level:

- **Circular dependencies**: if two resources reference each other, Bicep doesn't compile. Check the dependency graph.
- **Role assignment scope**: the `roleAssignment` resource needs the Key Vault as its scope, not the resource group. Verify the `scope:` property.
- **Identity reference**: `webApp.identity.principalId` is the correct way to reference the managed identity. Confirm Copilot uses the symbolic name, not a hardcoded value.

### Modularizing a template

As templates grow, they become harder to maintain. Bicep modules let you split a large template into reusable components. Copilot can do this split for you.

```
Refactor this Bicep template into modules. Create:
- A module for the App Service Plan and Web App (modules/webapp.bicep)
- A module for the Key Vault and Role Assignment (modules/keyvault.bicep)
- A main.bicep that calls both modules and passes parameters between them

Show me the content of all three files. Ensure the output of the Key Vault
module (the Key Vault URI) is passed to the Web App module as an input.
```

Copilot generates the module files and the main orchestration file. The key thing to verify is that `output` values from one module are correctly wired as `param` inputs to another. That cross-module connection is the most common mistake when splitting templates.

## Bicep MCP: context-aware generation

### What is MCP?

Model Context Protocol (MCP) is an open standard that lets AI models connect to external tools and APIs. Instead of relying solely on training data, an MCP-enabled Copilot can query live data sources in real time.

The **Bicep MCP server** connects GitHub Copilot to the live Bicep type registry. Thanks to this connection, GitHub Copilot gets access to:

- Current API versions for every Azure resource type
- The complete property schema for each resource type
- Validation rules that flag misconfigurations before you run `bicep build`
- Deprecation notices when an API version is being retired

Without MCP, Copilot generates Bicep based on patterns from its training data. That data has a knowledge cutoff date, and Azure's API versions evolve continuously. The result can be templates that use outdated API versions, miss recently added required properties, or include deprecated parameters. With MCP active, Copilot queries the live registry before generating each resource block.

### Enabling the Bicep MCP server

1. In VS Code, open the Command Palette (`Ctrl+Shift+P`).
1. Search for **MCP: Enable Bicep Server**.
1. Confirm the server shows as active in the Copilot status bar.

Once enabled, Copilot Chat automatically uses the Bicep MCP server when you work on `.bicep` files or ask about Bicep resources.

### What changes with MCP active

The same prompt run with and without MCP produces noticeably different output in three areas.

**API versions**

Without MCP, Copilot might generate:

```bicep
resource firewall 'Microsoft.Network/azureFirewalls@2022-07-01' = {
```

With MCP, Copilot queries the registry and generates the current stable version:

```bicep
resource firewall 'Microsoft.Network/azureFirewalls@2024-03-01' = {
```

Newer API versions often include security improvements, new required properties, and bug fixes.

**Required properties**

Some resource types gained required properties in newer API versions. Without MCP, Copilot may produce a template that builds locally but fails during deployment when Azure validates the request. With MCP, Copilot knows about those requirements and includes them.

**Validation during generation**

With MCP active, Copilot can flag issues before you run `bicep build`. If you write a property name that doesn't exist in the schema, Copilot can identify it immediately, similar to IntelliSense for a typed language.

### Example: hub-spoke network with MCP

Use this prompt with MCP active to generate a complete hub-spoke topology:

```
Generate a Bicep template for a hub-spoke VNet topology:
- Hub VNet: 10.0.0.0/16 with AzureFirewallSubnet (/26) and GatewaySubnet (/27)
- Spoke VNet: 10.1.0.0/16 with an application subnet (/24)
- VNet peering between hub and spoke (both directions)
- Azure Firewall Standard tier in the hub
- Azure Firewall Policy linked to the firewall
- Public IP for the firewall
- NSG on the application subnet blocking inbound SSH and RDP from internet
- Log Analytics Workspace for diagnostic logging
- Diagnostic settings on the firewall sending logs to the workspace
Parameters: location, environment, owner, costCenter
Use latest stable API versions.
```

With MCP active, Copilot uses current API versions, correctly links the `firewallPolicy` to the `AzureFirewall` resource, generates the `diagnosticSettings` resource with the right `logs` and `metrics` array format, and uses `dependsOn` only where symbolic references aren't sufficient.

## Validation and best practices

### Always run `az bicep build`

After every Copilot generation, run:

```bash
az bicep build --file main.bicep
```

This command compiles Bicep to Azure Resource Manager JSON and catches syntax errors, missing required properties, and invalid references. It's a fast validation step that catches many issues before deployment.

### Use `what-if` before every deployment

The `what-if` command shows exactly what Azure creates, modify, or delete, without making any changes:

```bash
az deployment group what-if \
  --resource-group rg-iaclab \
  --template-file main.bicep \
  --parameters @params.json
```

Review the output before every deployment. Look for resources being deleted that you didn't intend to remove, modifications that look unexpected, and a resource count that matches your design.

### Use parameter files for environment-specific values

Copilot can generate parameter files from your templates:

```
Generate a Bicep parameters file (bicepparam format) for the template above.
Create values appropriate for a staging environment.
Include comments explaining what each parameter controls.
```

This kind of prompt produces a `.bicepparam` file you can version-control alongside the template, with one file per environment.

### Ask Copilot to document its output

```
Add @description() decorators to every parameter and output in this template.
The descriptions should be clear enough for someone who has never seen the template
to understand what each parameter controls and what constraints apply.
```

This example of a prompt makes the template self-documenting and improves the `what-if` output, which displays parameter descriptions.

## Fixing common issues with Copilot

### Invalid resource reference

**Symptom**: `bicep build` fails with `"The referenced resource could not be found."`

```
This Bicep template has an invalid resource reference at line [X].
The resource [name] references [other resource] but uses a hardcoded string
instead of the symbolic name. Fix all cross-resource references to use
symbolic names.
```

### Circular dependency

**Symptom**: `bicep build` fails with `"A cycle was detected in the template."`

```
This Bicep template has a circular dependency between [resource A] and
[resource B]. Restructure the template to break the cycle. One approach
is to use an existing() reference for one of the resources.
```

### Outdated API version

**Symptom**: Deployment fails with `"The resource type [X] was not found in the namespace."`

```
The resource type [Microsoft.Network/azureFirewalls@2021-02-01] appears to
use an outdated API version. Update it to the current stable API version
and adjust any properties that have changed.
```

::: zone-end
