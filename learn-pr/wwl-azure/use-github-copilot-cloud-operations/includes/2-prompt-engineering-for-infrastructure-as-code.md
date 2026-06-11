::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=9ae69ce0-d037-4493-8417-5f98180b1fba]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

GitHub Copilot is only as useful as the instructions you give it. For infrastructure tasks, a vague prompt produces a generic template that may not match your naming conventions, security standards, or architectural patterns. A well-crafted prompt produces output that's close to production-ready.

This isn't a minor difference. A prompt like `create a Bicep template for a Virtual Network` might produce a minimal example with no subnets, no tags, and a hardcoded region. A prompt like the one you write by the end of this unit, might produce a fully parameterized, tagged, multi-subnet Virtual Network, with NSG associations and diagnostic settings. Correctly structured and ready to validate.

The skill of writing good prompts is learnable. This unit covers the techniques that consistently produce better infrastructure output from GitHub Copilot.

## The anatomy of an effective IaC prompt

Every strong infrastructure prompt contains some combination of four elements:

### Context

Context tells Copilot what kind of work you're doing and what constraints apply. Without context, Copilot makes assumptions. Those assumptions may not match your environment.

**Less good prompt**: "Create a storage account in Bicep."

**Optimized prompt**: "Create a Bicep resource definition for an Azure Storage Account. Running in a production environment in the Australia East region. The account should use Standard_LRS and require HTTPS-only access."

Context includes the target environment (dev/staging/production), the region, the tool or language, existing constraints (naming conventions, tagging policies), and any standards you want followed.

### Requirements

Requirements are the specific capabilities, properties, or behaviors the resource must have. Being explicit about requirements prevents Copilot from omitting things it can't infer.

For example:

`The storage account must: have soft delete enabled for blobs (7 days), use a private endpoint, disable public blob access, and be tagged with Environment, Owner, and CostCenter.`

List requirements as bullet points or numbered items when you have several. Copilot handles structured lists well and is less likely to skip items.

### Output format

Tell Copilot what kind of output you expect. For IaC, it usually means to specify the language or tool, whether you want a complete file or just a snippet, and how parameters should be handled.

For example:

`Output a complete Bicep file with parameters at the top, a resource block in the middle, and outputs at the bottom. Use decorators to add descriptions to all parameters.`

If you don't specify a format, Copilot chooses one. It may choose inline hardcoded values when you wanted parameters, or a snippet when you wanted a full file.

### Constraints

Constraints tell Copilot what to avoid. Easy to overlook, yet important, especially for security or compliance.

For example:

`Do not use any deprecated API versions. Do not expose any management ports (22, 3389) in NSG rules. Do not hardcode any subscription IDs or tenant IDs.`

## Zero-shot prompting

Zero-shot prompting means you describe what you want without providing any examples. It's the most common approach and works well for standard infrastructure patterns, based on Copilot's trained data.

For example:

```
Generate a Bicep template for an Azure Key Vault with the following requirements:
- SKU: Standard
- Soft delete enabled with a 90-day retention period
- Purge protection enabled
- RBAC authorization model (not access policies)
- Public network access disabled
- A private endpoint connected to a subnet parameter
- Tags: Environment, Owner, CostCenter (all as parameters)
Use descriptive parameter names and add @description() decorators to each.
```

Zero-shot works best when the resource type is common and your requirements are specific. If you're working with a less common resource type, or if you need a particular structure, consider providing an example.

## Few-shot prompting

Few-shot prompting means you provide one or more examples in your prompt so Copilot understands the pattern or style you want. Useful when you have an existing codebase with conventions that Copilot wouldn't know about otherwise.

A sample few-shot prompt could look like this:

```
Here is an example of how we define storage accounts in our Bicep codebase:

[paste your existing storage account resource block]

Using the same naming convention, parameter style, and tag structure, generate
a similar resource block for an Azure Service Bus namespace with these requirements:
- Standard SKU
- Geo-redundant disaster recovery enabled
- Minimum TLS 1.2
- Same tagging pattern as the example
```

By showing Copilot your existing pattern, you get output that blends into your codebase rather than output that follows Copilot's default style. Saving significant cleanup time when integrating generated code with existing templates.

## Role-based prompting

Role-based prompting asks Copilot to adopt a specific perspective before generating output. It's effective for security reviews and architectural guidance.

An example in the security context, could look like this:

```
You are a senior Azure security engineer reviewing Bicep templates for enterprise
production deployments. Review the following template and identify:
- Any security misconfigurations or missing security controls
- Resources that expose public endpoints unnecessarily
- Missing diagnostic settings or logging configuration
- RBAC assignments that are too broad
- Any deprecated API versions

For each issue found, explain the risk and provide the corrected Bicep snippet.
```

Role-based prompting shifts Copilot's output from "here's code that works" to "here's code that works, is secure, and follows the principle of least privilege." The quality difference is noticeable.

## Iterative refinement

The most effective way to work with GitHub Copilot on Infrastructure as Code tasks, isn't to write one perfect prompt. It's to start broad and progressively refine.

A sample authoring process would loop through the following stages:

**Step 1**: Start with the core resource

```
Generate a Bicep template for a hub-spoke VNet topology with one hub and one spoke.
```

Review the output. Is the basic structure correct? Are the address spaces sensible?

**Step 2**: Add security requirements

```
Add an NSG to the application subnet in the spoke that blocks all inbound
internet traffic except HTTPS (port 443). Add a deny-all rule at the end.
```

**Step 3**: Add observability

```
Add diagnostic settings to the NSG that send flow logs to a Log Analytics
workspace. Add the Log Analytics workspace as a new parameter.
```

**Step 4**: Add parameterization

```
Replace all hardcoded values (address spaces, location, resource names)
with parameters. Add @description() and @allowed() decorators where appropriate.
```

**Step 5**: Add tags

```
Add tag parameters for Environment, Owner, and CostCenter. Apply tags to
every resource in the template using a tags object parameter.
```

This five-step approach consistently produces better output than a single complex prompt because each step builds on validated output from the previous one. You review and accept each increment before adding the next layer of requirements.

## Common prompting mistakes

### Being too vague

**Problem:** using a prompt like `Create a Bicep template for my infrastructure`

**Result:** A minimal template with guessed values, wrong resource types, and no security settings.

**Fix:** Be specific about what resources you need, what SKUs, what regions, and what security requirements apply.

### Forgetting security constraints

**Problem:** Generating a VM template without specifying that management ports shouldn't be open

**Result:** An NSG that allows inbound SSH and RDP from the internet. Which is a critical security misconfiguration

**Fix:** Explicitly state security requirements as part of every infrastructure prompt. Don't assume Copilot defaults to secure

### Not specifying API version preferences

**Problem:** using a prompt like `Use the latest API version`

**Result:** Without MCP, Copilot may still use versions from its training data, which could be outdated.

**Fix:** Enable the Bicep MCP server or explicitly state the API version if known. At minimum, ask Copilot to flag if it's uncertain about the API version.

### Asking for too much in one prompt

**Problem:** 
A 20-line prompt asking for a complete Azure landing zone with networking, identity, governance, and monitoring. All at once.

**Result:** 
A long template with many gaps, missing cross-resource references, and properties Copilot guessed at.

**Fix:** 
Use iterative refinement. Build the template in layers and validate each layer before adding the next.

### Not providing context for existing codebases

**Problem:** Asking Copilot to `add a subnet to the Virtual Network` without sharing the existing Virtual Network resource definition.
**Result:** A new subnet resource that may conflict with the existing definition's structure or naming.
**Fix:** Always paste the relevant existing code into the prompt when you're extending or modifying existing templates.

## Prompt patterns for infrastructure

The following patterns are directly applicable to the tasks in this module.

### Generation pattern

Use when starting from scratch:

```
Generate a [tool: Bicep/CLI/YAML] [resource type] with the following requirements:
- [requirement 1]
- [requirement 2]
- [requirement 3]
Parameterize: [list of values to parameterize]
Tag every resource with: [tag names]
Do not: [constraints]
```

### Extension pattern

Use when adding to an existing template:

```
Given this existing [tool] [resource definition]:

[paste existing code]

Add the following:
- [addition 1]
- [addition 2]
Maintain the existing naming convention and parameter style.
```

### Review pattern

Use when auditing an existing template:

```
Review this [tool] template for:
- Security misconfigurations
- Missing required properties
- Deprecated API versions
- Resources exposed to the public internet unnecessarily
- Missing tags or diagnostic settings

For each issue, explain the problem and provide the corrected snippet.

[paste template]
```

### Translation pattern

Use when converting between tools:

```
Translate this [source tool] [script/template/pipeline] to [target tool].
Preserve:
- The same variable/parameter names where possible
- Error handling logic
- The same resource naming and tagging
Do not add features that are not in the original.

[paste source code]
```

### Explanation pattern

Use when you need to understand existing infrastructure:

```
Explain what this [tool] template deploys in plain language.
Describe each resource, its purpose, and how the resources relate to each other.
Identify any security controls that are configured.
Highlight anything that looks unusual or that might cause problems in production.

[paste template]
```

---

## The review mindset

GitHub Copilot is a collaborator, not an authority. Every output it produces should be reviewed before using. Especially for infrastructure, where a misconfiguration can expose systems to the internet, lock you out of resources, or incur unexpected cost.

The questions to ask when reviewing Copilot's infrastructure output:

- **Is the API version current?** Check against the Azure documentation or use Bicep MCP.
- **Are all required properties present?** Run `az bicep build` to catch missing required fields.
- **Are security defaults appropriate?** Check public network access, management port exposure, and encryption settings.
- **Are resources correctly cross-referenced?** Ensure symbolic names, not hardcoded IDs, are used for resource references.
- **Is it idempotent?** Would running this template twice create conflicts or duplicates?

Treating Copilot's output as a first draft, not a final answer, is the mindset that produces the best results.

## Key takeaways

- Effective IaC prompts include context, requirements, output format, and constraints.
- Zero-shot prompting works for common resource types; few-shot prompting works better when you have existing code patterns to match.
- Role-based prompting ("You're a senior Azure security engineer...") improves the quality of reviews and architectural guidance.
- Iterative refinement, by building in layers, produces better output than one large prompt.
- Always review Copilot's output before using it: check API versions, required properties, security settings, and resource references.

::: zone-end
