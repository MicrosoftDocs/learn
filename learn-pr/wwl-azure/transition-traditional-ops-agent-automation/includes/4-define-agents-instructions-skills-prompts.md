## The four building blocks

An agentic workflow is built from four components that work together: **agents**, **skills**, **instructions**, and **prompts**. Each serves a different purpose, and understanding how they relate is essential to designing effective multi-agent systems.

A user prompt flows into an agent defined in an `.agent.md` file. The agent defines its identity, the tools it can use, and which subagents it can delegate to. From there, the agent draws on two sources of supporting content. The first is `skills`: domain knowledge documents that the agent reads explicitly at runtime. The second is `instructions`: coding and format standards that are automatically injected based on the type of file the agent is working with.`

### Agents

An agent is a persona with a defined role, a system prompt, access to tools, and optionally the ability to delegate to other agents. In practice, an agent is a Markdown file with YAML front matter that defines its configuration and a Markdown body that serves as its system prompt.

Here's the structure of an agent definition file:

```yaml
---
name: deploy-agent
description: Deploys infrastructure using Azure Developer CLI
tools: [runInTerminal, readFile, createFile]
agents: []
---
```

The Markdown body below the front matter contains the agent's instructions: what it should do, in what order, and what rules to follow. This body is the agent's system prompt, and it's where you encode the operational logic that the agent follows.

Key properties of an agent:

| Property | Purpose |
|---|---|
| `name` | Identifier used for delegation and selection |
| `description` | Short summary shown in the UI or used by the conductor |
| `tools` | Which tools (terminal, file creation, search) the agent can use |
| `agents` | Other agents this agent can delegate to via subagent calls |

A conductor agent, for example, lists all specialized agents in its `agents` array and uses `runSubagent` calls to delegate tasks. A leaf agent (one that does the actual work) typically has an empty `agents` array and relies on tools like `runInTerminal` or `createFile` to produce outputs.

### Skills

A skill is a reusable knowledge document that agents read at runtime. Skills contain domain-specific information that is too large or too volatile to embed directly in an agent's system prompt. Including  patterns, lookup tables, code snippets, and default configurations.

Skills live in a dedicated folder (for example, `.github/skills/`) and follow a standard format:

```yaml
---
name: azure-deployment-defaults
description: "Default configurations for Azure infrastructure deployments"
---
```

```markdown
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

**How agents consume skills:** Agents use a **pull model**. The agent's system prompt contains an explicit instruction like "Read the deployment-defaults skill before starting work." The agent then calls a file-read tool to load the skill content into its context. Skills aren't automatically injected. The agent must request them.

This design lets you share the same skill across multiple agents while keeping each agent's context focused on what it needs. A deployment agent reads the deployment-defaults skill, while an architecture agent reads an architecture-patterns skill. Both skills live in the same folder, but each agent pulls only what's relevant to its task.

### Instructions

Instructions are coding standards that are automatically injected into an agent's context based on file patterns. Unlike skills, which agents pull explicitly, instructions use a **push model**. They activate whenever an agent creates or edits a file matching the instruction's target pattern.

An instruction file includes a glob pattern that determines when it applies:

```yaml
---
description: "Infrastructure as Code best practices for Bicep templates"
applyTo: "**/*.bicep"
---
```

```markdown
## Bicep standards
- Use Azure Verified Modules when available
- Include resource locks on production resources
- Add diagnostic settings for all supported resources
- Use parameter decorators for validation
```

When an agent creates a `.bicep` file, the environment automatically includes the Bicep instruction in the agent's context. The agent doesn't need to know about the instruction. It gets silently applied.

Common instruction patterns for ops teams:

| Instruction | Target pattern | Purpose |
|---|---|---|
| Bicep best practices | `**/*.bicep` | IaC standards and security defaults |
| Markdown formatting | `**/*.md` | Documentation structure and style rules |
| PowerShell standards | `**/*.ps1` | Script conventions and error handling |
| YAML validation | `**/*.yml` | Configuration file structure rules |

### When to use skills vs. instructions

The distinction between skills and instructions matters for maintainability:

| Aspect | Skills | Instructions |
|---|---|---|
| **Activation** | Agent reads explicitly | Autoinjected by file glob |
| **Scope** | Domain knowledge and patterns | Coding standards for a file type |
| **Size** | Can be large (hundreds of lines) | Focused rules for one language or format |
| **Audience** | One or more specific agents | Any agent editing matching files |

Use **skills** when you need to encode organizational knowledge that agents reference during planning. For example, which Azure services to recommend for different workloads, or what naming conventions your organization follows.

Use **instructions** when you need to enforce standards on the output. For example, how Bicep templates should be structured, or what formatting rules apply to documentation.

### Prompts

The prompt is the user's natural-language message that initiates the workflow. In an agentic system, the prompt flows to whichever agent is selected as the entry point. For multi-agent workflows, it's typically the conductor agent.

Effective prompts for agentic workflows describe the desired outcome rather than the individual steps:

> **Less effective:** "Generate a Bicep template for App Service"
>
> **More effective:** "Build an Azure environment with a web application on App Service, connected to a SQL Database, with Key Vault for secrets management and Application Insights for monitoring. Use managed identity for all service-to-service authentication."

The second prompt gives the conductor enough context to plan the full workflow across requirements, architecture, code generation, and deployment, rather than handling a single step.

## Putting the building blocks together

When a user submits a prompt, the system resolves all four components:

1. The user selects an agent and types a prompt.
2. The agent's definition file (front matter + body) loads as the system prompt.
3. The agent's body instructs it to read specific skills.
4. When the agent creates or edits files, matching instructions are autoinjected.
5. The agent starts reasoning, calls tools, and produces artifacts.
6. If the agent has subagents listed, it can delegate via subagent calls.

This resolution chain means that the combination of the agent's definition, defines its behavior. The skills it reads, the instructions that apply to the files it touches, and the user's prompt. Changing any of these components changes the agent's output.
