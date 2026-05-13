Infrastructure code is notoriously under-documented. A Bicep template may correctly deploy a complex, multi-tier architecture. But if no one documented what it deploys, why each resource exists, or what the parameters control, the template becomes tribal knowledge. Only the person who wrote it can safely change it.

This gap exists because documentation is tedious to write and easy to skip. After finishing and validating a 400-line Bicep template, writing a matching architecture description feels like a separate project.

GitHub Copilot changes this equation. Given a template, Copilot can generate a first draft of the documentation in seconds. The engineer's job shifts from writing documentation to reviewing and refining it. Documentation stops being optional and starts being part of the normal workflow.

## Generating plain-language architecture descriptions

The most immediate documentation need is a human-readable explanation of what a template deploys. This level of documentation is what a project manager, a security reviewer, or a new team member needs before they can understand or work with the infrastructure.

```
Explain what this Bicep template deploys in plain language.
Structure your explanation as follows:
1. A one-paragraph summary of the overall architecture
2. A section for each major resource group or logical component,
   describing what it does and why it exists
3. A description of how the components connect to each other
4. Any security controls that are configured

Use language that a technical project manager could understand.
Avoid Bicep-specific syntax in the explanation.

[paste template here]
```

The structure instruction is important. Without it, Copilot produces a flat list of resources rather than an explanation that conveys the architecture's intent.

### Example output structure

For a hub-spoke network template, a well-structured explanation might look like this:

```markdown
## Architecture Overview

This template deploys a hub-and-spoke network topology for Azure, a standard
pattern for enterprise environments that need centralized security controls
alongside segmented workload networks.

## Hub Network
The hub virtual network (10.0.0.0/16) is the central connection point for all
network traffic. It hosts the Azure Firewall, which inspects and filters all
traffic entering and leaving the environment. It also contains an Azure Bastion
host, which provides secure browser-based access to virtual machines without
exposing RDP or SSH ports to the internet.

## Spoke Network
The spoke virtual network (10.1.0.0/16) is where application workloads run.
It connects to the hub through VNet peering, a low-latency, private connection
within the Azure backbone. Traffic from the spoke to the internet is routed
through the hub firewall, ensuring all outbound connections are inspected.

## Observability
A Log Analytics workspace collects diagnostic logs from the Azure Firewall.
This enables security monitoring, threat detection, and compliance auditing
from a single location.

## Security Controls
- All internet-bound traffic from workloads is inspected by Azure Firewall
- No management ports (SSH, RDP) are exposed directly to the internet
- Network access to VMs is restricted to Azure Bastion sessions only
```

## Generating parameter reference documentation

Templates with many parameters are difficult to use without documentation. A parameter reference table tells users what each parameter does, what values are valid, and what the defaults are.

```
Generate a markdown parameter reference table for this Bicep template.
Include these columns:
| Parameter | Type | Default | Allowed Values | Description |

Cover all parameters. For parameters with @allowed() decorators,
list the allowed values. For parameters with no default, mark the
Default column as "Required". Write descriptions in plain language,
not a repeat of the parameter name.
```

Copilot generates this table accurately because it reads the `@description()`, `@allowed()`, and `@minLength()` decorators directly from the template. If your template lacks decorators, Copilot infers descriptions from the parameter names. Which is another reason to use descriptive parameter names when generating templates.

### Generating outputs reference

```
Add a second table below the parameters table documenting all outputs
from this template. Include: Output Name | Type | Description.
Describe what each output contains and when you would use it.
```

This example is useful for module outputs consumed by other templates. The output documentation tells the caller what they receive and what format it is in.

## Creating architecture diagrams with Mermaid

Mermaid is a text-based diagramming language supported natively in GitHub Markdown, Azure DevOps Wiki, and VS Code. It renders diagrams from plain text. This means diagrams can live in the same repository as the infrastructure code, versioned and updated alongside the templates.

```
Represent the network topology deployed by this Bicep template as a Mermaid diagram.
Use flowchart LR (left to right) direction.
Show:
- Each VNet as a subgraph
- Subnets as nodes inside their VNet subgraph
- Resources (Firewall, Bastion, VMs) as nodes in the appropriate subnet
- VNet peering as a double-headed arrow between VNets
- The Log Analytics workspace outside the VNets, with a log collection arrow
  from the Firewall
- Use descriptive labels on each node showing the resource name and type

Wrap the Mermaid code in a markdown code block with the mermaid language tag.
```

Mermaid diagrams aren't always pixel-perfect on the first generation. Ask Copilot to adjust the layout, add or remove components, or change the diagram type based on what renders best.

### Diagram validation

Preview the diagram in VS Code using the Markdown Preview (`Ctrl+Shift+V`). If GitHub renders Mermaid in your repository's README, push the file and check the rendered output there. GitHub's renderer has slightly different behavior from VS Code's.

If the diagram is too complex to render cleanly, ask Copilot to simplify:

```
Simplify this Mermaid diagram to show only the major components and their
connections. Remove subnet-level detail and focus on the resource relationships
at the VNet level.
```

## Generating change summaries

When infrastructure changes, someone needs to review what changed. Pull request descriptions like "updated Bicep template" provide no useful information to a reviewer. Copilot can generate meaningful change summaries by comparing two versions of a template.

```
Compare these two Bicep templates (v1 and v2) and generate a change summary
in markdown format.

For each change, include:
- What changed (resource added, modified, or removed)
- Why it likely changed (e.g., added for security, added for observability,
  fixed a misconfiguration)
- Impact on existing deployments (e.g., requires redeployment, causes downtime,
  is additive only)

Group changes by category: Security, Observability, Networking, Compute, Cost.

--- v1 template ---
[paste old template]

--- v2 template ---
[paste new template]
```

This change summary is immediately useful as a pull request description, a communication to stakeholders, or a section in a deployment runbook.

### Example change summary output

```markdown
## Infrastructure Change Summary — v1 to v2

### Security
- **Added:** AzureFirewallSubnet resized from /27 to /26
  - *Why:* Azure Firewall requires a minimum /26 subnet. The /27 caused deployment failures.
  - *Impact:* Requires redeployment of the hub VNet. Existing peering will need to be re-established.

- **Added:** CostCenter tag on all resources
  - *Why:* Azure Policy requires a CostCenter tag. Missing tag caused policy denial.
  - *Impact:* Additive only. No resource changes.

### Observability
- **Added:** Azure Bastion host in AzureBastionSubnet
  - *Why:* Provides browser-based secure access to VMs without exposing management ports.
  - *Impact:* Additive. New resource. Costs approximately $140/month per Bastion instance.

- **Added:** Log Analytics Workspace and Firewall diagnostic settings
  - *Why:* Required for security monitoring and compliance auditing.
  - *Impact:* Additive. Data ingestion costs depend on log volume.
```

## Keeping documentation in sync

The most common documentation failure is staleness. A document written when the template was version 1 becomes misleading by version 5.

Several practices help maintain accuracy over time.

**Generate documentation as part of the PR process.** Add a step to your CI pipeline that flags the PR for documentation review when the template changes significantly.

**Use `@description()` decorators as the source of truth.** Documentation embedded in the template via decorators is always in sync with the code because it lives in the same file. External markdown documentation can drift.

**Generate documentation for every major release.** Use the change summary prompt after every significant merge to main. Commit the updated documentation in the same PR as the template change.

**Prompt for a README update:**

```
The following changes were made to our infrastructure template in this release:
[paste change summary]

Update the Infrastructure README to reflect these changes. Specifically:
- Update the Architecture Overview section to mention Azure Bastion
- Add the new CostCenter parameter to the parameter reference table
- Update the "Resources Deployed" list
```
