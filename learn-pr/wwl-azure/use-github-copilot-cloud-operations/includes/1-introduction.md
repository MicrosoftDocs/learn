::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=0d5e9c10-5095-433f-96a7-29ed05ae1f4b]

::: zone-end

::: zone pivot="text"


Infrastructure as Code (IaC) is the practice of defining and managing cloud resources through machine-readable configuration files rather than through manual portal select or unplanned scripts. Instead of logging into the Azure portal to create a virtual network, you write a file that describes the network. A tool then reads that file and creates the resource for you.

This approach brings a fundamental shift in how infrastructure is managed. Changes are tracked in version control, deployments are repeatable, and environments can be recreated from scratch at any time. If something breaks, you can roll back to a previous state. If you need a staging environment that mirrors production, you apply the same files with different parameters.

IaC also brings infrastructure into the same engineering discipline as application code. The same pull request workflows, code reviews, and automated testing practices that apply to your application can now apply to the systems your application runs on.

Without AI assistance, the Infrastructure as Code (IaC) authoring cycle looks like this:

1. Write template
1. Look up documentation 
1. Fix syntax
1. Validate locally
1. Run what-if 
1. Deploy to staging 
1. Review changes
1. Deploy to production

And repeat the same for each deployment, whether new or update.

## Learning objectives

By the end of this module, you are able to:

- Explain what Infrastructure as Code is and why it matters in modern cloud operations
- Describe the difference between declarative and imperative approaches to IaC
- Identify the traditional IaC authoring workflow and its friction points
- Explain how GitHub Copilot changes the IaC inner loop
- Describe the GitHub Copilot capabilities most relevant to infrastructure work


## Infrastructure as Code challenges

Each step has friction. Writing a Bicep template from scratch requires knowledge of resource types, API versions, required properties, and Azure-specific naming conventions. Looking up the correct API version for `Microsoft.Network/virtualNetworks` means navigating documentation or copying from previous projects. Syntax errors get caught after running a build command. And keeping templates up to date as Azure APIs evolve, is an ongoing maintenance burden.

The result is that IaC is often treated as a specialist skill. Engineers who don't write templates regularly, fall back on portal select, breaking the consistency that IaC is meant to provide.

## Declarative vs. imperative approach

There are two fundamental styles of IaC. Understanding the difference helps you choose the right tool and craft better prompts for GitHub Copilot.

### Declarative IaC

In a declarative approach, you describe the **desired end state** of your infrastructure. The tool figures out how to get there.

> "I want a VNet with address space 10.0.0.0/16 and two subnets."

Azure Bicep and ARM templates are declarative. You define what resources should exist, and Azure Resource Manager handles the sequencing and creation. If the resource already exists in the correct state, no changes get applied. If it doesn't exist, it gets created. If it's different, it gets updated.

### Imperative IaC

In an imperative approach, you describe the **steps** needed to reach your desired state. You're writing a procedure, not a declaration.

> "Check if the VNet exists. If not, run `az network vnet create...`."

Azure CLI and Azure PowerShell scripts are typically imperative. You control the flow, handle errors, and manage ordering yourself. Giving you more control but also more responsibility. That includes handling idempotency, meaning the script must be safe to run multiple times.

### Which one should you use?

The right choice depends on the scenario. Declarative tools like Bicep are better for managing long-lived infrastructure resources because they handle state and drift automatically. Imperative tools like CLI scripts are better for operational tasks, one-time setup steps, or automation that involves logic, conditions, and loops.

In practice, most cloud engineers use both. And GitHub Copilot helps with both too.

## How GitHub Copilot changes the template authoring process

GitHub Copilot shortens and simplifies every step of the IaC authoring cycle.

**At the writing stage**, Copilot generates complete resource definitions from natural language descriptions. Instead of looking up the Bicep syntax for an Azure resource, you describe what you need and Copilot produces a starting point in seconds.

**At the review stage**, Copilot can analyze an existing template and identify security gaps, missing properties, or outdated patterns. It acts as a second set of eyes before the template is deployed.

**At the transform stage**, Copilot can convert between Azure CLI and PowerShell, between Azure Resource Manager JSON and Bicep, or between Azure Pipelines and GitHub Actions. Reducing the cost of switching tools or adapting examples from documentation.

**At the documentation stage**, Copilot can read a completed template and generate human-readable explanations, parameter references, and architecture descriptions. Work that is often skipped entirely because it's tedious to do manually.

The shift isn't just about speed. It's about lowering the barrier to entry. Engineers who aren't Bicep specialists can now produce correct, well-structured templates by describing their intent in plain language.

## GitHub Copilot capabilities for infrastructure work

GitHub Copilot surfaces in several ways inside VS Code, each suited to different parts of the IaC workflow.

### Inline suggestions

As you type in a `.bicep`, `.yaml`, `.ps1`, or `.sh` file, Copilot offers completions in real time. If you type the beginning of a resource definition, Copilot predicts the rest. Including required properties, default values, and common patterns. You accept with `Tab` or dismiss with `Escape`.

Inline suggestions work best for continuing patterns, already established in the file. If you define one resource correctly, Copilot picks up on the structure and suggests similar resources in the same style.

### Copilot chat

Copilot chat (`Ctrl+Alt+I`) is a conversation interface where you can ask questions, describe what you want built, paste existing code for review, or request explanations.

Chat is better than inline suggestions for tasks that require more context. Examples such as generating an entire template from scratch, refactoring a complex file, or asking for an explanation of how a resource works.

### Copilot with MCP (Model Context Protocol)

MCP allows Copilot to connect to external tools and data sources. The **Bicep MCP server** gives Copilot access to live Bicep type definitions, current API versions, and validation rules. Making its Bicep output more accurate than what it can produce from training data alone.

## Why IaC is well-suited for AI assistance

Infrastructure definitions have qualities that make them good candidates for AI-assisted generation:

- **They are highly structured**: Resource definitions follow schemas. Properties are based on known types, valid values, and required/optional designations. This structured nature makes it easier for a model to produce syntactically correct output.
- **They are pattern-rich**: Most Azure deployments use a relatively small set of common resource types: virtual networks, storage accounts, compute resources, and identity. These patterns appear frequently in training data, meaning Copilot relies on many examples.
- **They are expensive to research manually**: Finding the correct combination of API version, required properties, and valid SKUs for an unfamiliar resource type can take significant time. Copilot compresses that research into a prompt.
- **They are safe to iterate**: You validate before you deploy. A wrong suggestion from Copilot is caught at `az bicep build` or `what-if` before it touches any real resources. This safety net encourages experimentation.

## Key takeaways

- IaC treats infrastructure as code: version-controlled, repeatable, and reviewable.
- Declarative tools like Bicep describe the desired end state; imperative tools like CLI describe the steps to get there.
- The traditional IaC workflow has significant friction at every stage. Copilot reduces that friction.
- GitHub Copilot helps through inline suggestions, Copilot Chat, and MCP-enhanced context.
- IaC is well-suited for AI assistance because it's structured, pattern-rich, and safe to iterate.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
