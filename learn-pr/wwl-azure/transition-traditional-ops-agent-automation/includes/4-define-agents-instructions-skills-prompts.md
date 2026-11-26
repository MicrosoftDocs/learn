::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=58774614-bee7-4586-b7f0-b2142c9b3eca]

> [!TIP]
> The video for this section is also available in text-based form below.

::: zone-end

::: zone pivot="text"

An agentic workflow is built from four components that work together: **agents**, **skills**, **instructions**, and **prompts**. Each serves a different purpose, and understanding how they relate is essential to designing effective multi-agent systems.

A user prompt flows into an agent with a defined role and available tools. In GitHub Copilot, a custom agent can be defined in an `.agent.md` file. Skills supply reusable workflows and supporting resources; instructions supply applicable repository or file-scoped guidance. The host determines discovery, loading, tool availability, and approval behavior, so validate the configuration in the actual Copilot experience you intend to use.

For an existing DevOps engineer, the optimization is to make recurring expertise reusable without confusing model guidance with enforcement. Start with one bounded role and its required evidence, not a collection of agents with unrestricted tools.

## Agents

An agent is a persona with a defined role, a system prompt, access to tools, and optionally the ability to delegate to other agents. In practice, an agent is a Markdown file with YAML front matter that defines its configuration and a Markdown body that serves as its system prompt.

Here's the structure of an agent definition file:

```yaml
---
name: infra-review-agent
description: Reviews supplied infrastructure changes and returns evidence-backed findings
tools: ['read', 'search']
---
```

The Markdown body below the front matter contains the agent's instructions: what it should do, in what order, and what rules to follow. This body is the agent's system prompt, and it's where you encode the operational logic that the agent follows.

Key properties of an agent:

| Property | Purpose |
|---|---|
| `name` | Identifier used for delegation and selection |
| `description` | Short summary shown in the UI or used by the conductor |
| `tools` | Which tools (terminal, file creation, search) the agent can use |
| Delegation configuration | Host-specific selection of subagents and delegation tools; not a universal `agents` header |

A conductor can use the host's supported delegation tool and subagent configuration. Tool identifiers and delegation options vary across Copilot hosts; don't copy an IDE definition unchanged into CLI or hosted automation. For example, the current VS Code reference distinguishes the Local schema's `agents` field from the Copilot harness, which doesn't accept that field.

The example is deliberately read-only. Its body should define expected findings, evidence references and stop conditions. Confirm that the agent appears without configuration errors and that its actual tools match the intended boundary. Selecting a tool doesn't grant its underlying identity new repository or Azure permissions.

## Skills

A skill is a reusable workflow package that an agent can load when relevant. It can include instructions, scripts, templates, examples and supporting resources, rather than just a large knowledge document.

For example, place a repository skill in `.github/skills/azure-deployment-defaults/SKILL.md`, with the following front matter and body. Keep supporting resources beside it and use the host's supported locations:

```yaml
---
name: azure-deployment-defaults
description: "Default configurations for Azure infrastructure deployments"
---
```
```Markdown
## Naming conventions
- Resource groups: rg-{workload}-{environment}-{region}
- App Services: app-{workload}-{environment}
- SQL Servers: sql-{workload}-{environment}

## Security baseline
- TLS 1.2 minimum for all public endpoints
- Managed identity for service-to-service authentication
- HTTPS-only for web applications

## Default SKUs
| Service | Development | Production |
|---------|------------|------------|
| App Service | B1 | P1v3 |
| SQL Database | Basic | S1 |
| Key Vault | Standard | Standard |
```

**How agents consume skills:** Supported hosts discover skill metadata and load relevant content on demand. Selection can be automatic or explicit where supported; it isn't universally a manual file-read instruction. This progressive loading avoids putting every workflow into every conversation. Check that the intended skill was available and loaded before attributing an outcome to it.

This design lets multiple agents reuse reviewed expertise while keeping context focused. Include prerequisites, applicable workload/environment scope, required evidence and stop conditions. A skill containing a deployment script doesn't itself authorize execution of that script.

## Instructions

Instructions express repository conventions or file-scoped guidance. Supported hosts load repository-wide guidance or match scoped instructions to relevant file context. Loading isn't limited to a universal "file edited" trigger, and it doesn't guarantee model compliance.

A scoped file such as `.github/instructions/bicep.instructions.md` can include a glob pattern:

```yaml
---
description: "Infrastructure as Code best practices for Bicep templates"
applyTo: "**/*.bicep"
---
```

```Markdown
## Bicep standards
- Use Azure Verified Modules when available
- Include resource locks on production resources
- Add diagnostic settings for all supported resources
- Use parameter decorators for validation
```

For matching Bicep context, a supporting host can include this guidance. Verify the loaded instructions and their precedence in the selected experience. Repository-wide `.github/copilot-instructions.md` and scoped instruction files have different activation rules; hosted code review also has platform-specific behavior.

Common instruction patterns for ops teams:

| Instruction | Target pattern | Purpose |
|---|---|---|
| Bicep best practices | `**/*.bicep` | IaC standards and security defaults |
| Markdown formatting | `**/*.md` | Documentation structure and style rules |
| PowerShell standards | `**/*.ps1` | Script conventions and error handling |
| YAML validation | `**/*.yml` | Configuration file structure rules |

## When to use skills vs. instructions

The distinction between skills and instructions matters for maintainability:

| Aspect | Skills | Instructions |
|---|---|---|
| **Activation** | Relevant content loaded on demand by a supporting host | Repository-wide or file-scoped loading, where supported |
| **Scope** | Domain knowledge and patterns | Coding standards for a file type |
| **Size** | Can be large (hundreds of lines) | Focused rules for one language or format |
| **Audience** | One or more specific agents | Any agent editing matching files |

Use **skills** when you need to encode organizational knowledge that agents reference during planning. For example, which Azure services to recommend for different workloads, or what naming conventions your organization follows.

Use **instructions** to guide output toward team standards. Enforce those standards separately through reviewed tests, linters, branch policies, environment checks and platform permissions.

## Prompts

The prompt is the user's natural-language message that initiates the workflow. In an agentic system, the prompt flows to whichever agent is selected as the entry point. For multi-agent workflows, it's typically the conductor agent.

Effective prompts for agentic workflows describe the desired outcome rather than the individual steps:

> **Less effective:** "Generate a Bicep template for App Service"
>
> **More effective:** "Build an Azure environment with a web application on App Service, connected to a SQL Database, with Key Vault for secrets management and Application Insights for monitoring. Use managed identity for all service-to-service authentication."

The second prompt gives the conductor more useful architecture context. It still needs an approved target, scope, evidence requirements and action boundary before execution. Prefer "prepare a plan and reviewed diff; don't deploy" when the authorized task is a proposal. A desired outcome alone isn't a safe operational contract.

## Agent memory and constraints

Beyond skills and instructions, supported hosts can provide **memory** to retain selected context. Persistence, scope, review and deletion controls vary; ordinary repository files aren't automatically a memory service.

Possible memory scopes include:

| Scope | Persistence | Purpose |
|---|---|---|
| **Session memory** | Current conversation only | Task-specific context and in-progress notes |
| **User memory** | Across all workspaces | Personal preferences and patterns |
| **Repository memory** | Workspace-scoped | Project-specific facts and conventions |

**Constraints documents** capture project requirements for reviewable guidance. They don't establish platform authorization or deterministic policy enforcement. Give retained facts and constraints a source, owner, applicable environment, reviewed revision and freshness check; keep hypotheses and sensitive data out of reusable memory.

Example constraints file structure:

```Markdown
## Deployment constraints
- All resources must deploy to West Europe or North Europe regions
- Production environments require approval from the platform team
- Cost center tag (cc-12345) is mandatory on all resources

## Security constraints
- No public endpoints without WAF
- Storage accounts must deny public blob access
- Key Vault soft-delete and purge protection are required

## Naming constraints
- Resource group prefix: rg-contoso-
- Environment suffixes: -dev, -test, -prod
```

**How memory differs from skills:**

| Aspect | Skills | Memory/Constraints |
|---|---|---|
| **Origin** | Authored by humans | Can be authored or learned |
| **Volatility** | Relatively stable | Updated as agents learn |
| **Scope** | Shareable across projects | Often project-specific |
| **Authority** | Reusable guidance, not permission | Retained facts/requirements, not a platform enforcement mechanism |

Use **memory** for approved, verifiable facts that remain useful across tasks. Use **constraints** to express project requirements, and separate enforceable controls from natural-language expectations. If retained guidance conflicts with current evidence, stop and resolve the conflict rather than silently following stale memory.

An ordinary file such as `.github/constraints.md` has no guaranteed special loading behavior. Reference it explicitly through supported guidance if the workflow needs it. Test both discovery and behavior; a well-named document doesn't prevent a prohibited operation.

## Putting the building blocks together

When a user submits a prompt, the system resolves all four components:

1. The user selects an agent and types a prompt.
2. The agent's definition file (front matter + body) loads as the system prompt.
3. The host discovers applicable skills and loads relevant content when selected.
4. Supported repository/file-scoped instructions supply guidance for the task context.
5. The agent starts reasoning, calls tools, and produces artifacts.
6. If the agent has subagents listed, it can delegate via subagent calls.

Version the definitions, skills and instructions alongside the operational code. Validate the selected host's actual configuration and use a small regression set before rolling out changes. A successful invocation proves availability, not that the agent follows every rule.

The following unit adds artifact contracts, bounded retries and repeatable workflow evaluation. Keep the same separation throughout: the model proposes and reasons; independently configured controls establish what can actually happen.

Learn more about [Copilot custom agents](https://code.visualstudio.com/docs/agent-customization/custom-agents), [host-specific agent configuration](https://code.visualstudio.com/docs/agents/reference/custom-agent-file-reference), and [agent skills](https://code.visualstudio.com/docs/agent-customization/agent-skills).

::: zone-end
