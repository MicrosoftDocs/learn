## The operations maturity model

Infrastructure operations evolve through distinct stages. Understanding in which stage your organization is, helps you identify the opportunities that agentic approaches unlock.

### Stage 1: Manual operations

In the earliest stage, administrators perform tasks directly through portals, command-line tools, or remote desktop sessions. You sign in to the Azure portal, select settings from dropdown menus, and configure resources one at a time.

Manual operations work for small environments, but they don't scale. Every deployment requires the same select in the same order. Mistakes happen when you skip a step or enter the wrong value in a configuration field. There's no audit trail beyond what you remember to document, and knowledge stays locked in the person who performed the task.

### Stage 2: Scripted automation

To address these limitations, teams adopt scripts and infrastructure-as-code (IaC). You write Azure CLI commands, PowerShell scripts, or Bicep templates that capture your deployment steps as repeatable code. Version control provides an audit trail, and peer review catches errors before they reach production.

Scripted automation is a significant improvement, but it introduces its own challenges:

- **Template sprawl**: Each new scenario requires a new template or significant modifications to existing ones.
- **Context switching**: You move between documentation, code editors, terminals, and deployment tools throughout the workflow.
- **Coordination overhead**: Multi-step workflows still need a human to sequence the steps, pass outputs between stages, and handle failures.

### Stage 3: AI-assisted prompts

The introduction of AI assistants like GitHub Copilot adds a new capability. You describe what you need in natural language, and the AI generates code, suggests configurations, or explains error messages. This approach removes some of the friction from stage 2. You don't need to remember every CLI flag or Bicep syntax pattern.

For example, you might prompt an AI assistant:

> "Generate a Bicep template for an Azure App Service with a SQL Database, Key Vault for secrets, and Application Insights for monitoring. Use managed identity for authentication."

The assistant produces a draft template in seconds. You review it, make adjustments, and deploy. This process is faster than writing from scratch, but the workflow still has limitations:

- **One prompt, one task**: Each prompt handles a single step. You still orchestrate the overall workflow manually.
- **No persistent context**: The AI doesn't retain your organization's naming conventions, security requirements, or preferred architectures between sessions.
- **No validation chain**: The AI generates code, but it doesn't verify that the output meets your compliance requirements or integrates with your existing infrastructure.

### Stage 4: Agentic workflows

Agentic workflows address these gaps by turning individual AI interactions into coordinated pipelines. Instead of prompting an AI for each step, you describe the overall goal once. A system of specialized AI agents handles the full workflow. Each agent is responsible for a specific domain, from parsing requirements through deployment to documentation.

The key differences from prompt-based AI:

- **Persistent domain knowledge**: Agents carry organizational standards as reusable knowledge, which gets applied automatically. Think of naming conventions, security baselines, and approved SKUs.
- **Multi-step orchestration**: A conductor agent coordinates the workflow. It passes artifacts between specialized agents without human intervention at each handoff.
- **Validation at every stage**: Each agent verifies its outputs before passing them to the next step. Allowing for catching errors early rather than at deployment time.

## Where ops roles fit in this evolution

As a cloud administrator, system administrator, or DevOps engineer, you're likely already somewhere in stages 2 or 3. You have scripts and templates, and you might use AI assistants to help write code faster. The transition to stage 4 doesn't require you to abandon what you already built. Instead, you encode your existing knowledge into agent definitions that automate the coordination layer. Including  scripts, checklists, and team knowledge about how deployments should work.

Think of it this way: scripted automation captures *what* to deploy. AI assistants help you write *how* to deploy it. Agentic workflows handle *when* to run each step, *what context* to carry forward, and *how to verify* each stage completed correctly.

## Identify tasks that benefit from an agentic approach

Not every task needs an agent. Simple, one-off operations are fine as manual commands or single prompts. The agentic approach adds the most value when:

- **Multiple steps need coordination**: Environment provisioning involves requirements gathering, architecture decisions, code generation, deployment, and documentation.
- **Domain knowledge must be applied consistently**: Security baselines, naming conventions, or compliance rules should be enforced on every deployment.
- **Outputs from one step feed into the next**: An architecture assessment determines which Bicep modules to generate. A deployment summary feeds into a documentation template.
- **The same workflow repeats with different inputs**: Building demo environments, onboarding new applications, or provisioning development workspaces.

The next unit examines what agentic DevOps looks like in practice and how multi-agent orchestration works.
