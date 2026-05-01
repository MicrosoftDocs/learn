The quality of a plan depends directly on the quality of your prompt. Vague prompts produce vague plans. For operations tasks, include specific details about what you're trying to accomplish:

**Less effective:**

```text
/plan Create a script to manage Azure resources
```

**More effective:**

```text
/plan Create a PowerShell script that decommissions Azure virtual machines tagged with 'Environment=Dev' that haven't been started in the last 30 days. The script should snapshot OS disks before deletion, export a report of deleted VMs to CSV, and send a summary email to the operations team.
```

The more context you provide, the more detailed and actionable the plan becomes. Include naming conventions, target environments, compliance requirements, and any constraints the implementation must respect.

## Use custom instructions to encode team standards

Operations teams typically follow established standards for naming, tagging, security, and coding conventions. Instead of repeating these standards in every prompt, a `.github/copilot-instructions.md` file in the repository root provides a way to communicate those standards to the Plan agent automatically. The agent reads this file as part of its context-gathering phase before generating any plan.

The content of the file is specific to each team's own standards and conventions. An illustrative example of what such a file might contain is below. It isn't a template to copy directly. The actual values should reflect your organization's real naming schemes, tag requirements, and tooling decisions:

```markdown
## Infrastructure standards

- All Azure resources must follow the naming convention: {resource-type}-{workload}-{environment}-{region}-{instance}
- All resource groups require tags: CostCenter, Environment, Owner, Application
- Use Bicep for infrastructure-as-code; do not use ARM templates directly
- All scripts must include error handling with try/catch blocks
- PowerShell scripts must use approved verbs (Get, Set, New, Remove)

## Security requirements

- No secrets or connection strings in source code
- Use Azure Key Vault for secret management
- All network security group rules must include a description
- Administrative access requires just-in-time (JIT) activation
```

When the Plan agent reads this file, it incorporates the defined standards into every plan it generates for that workspace. This ensures that naming conventions, tagging requirements, and security rules apply consistently across all generated plans—without requiring you to restate them in each prompt.

## Iterate before implementing

Don't accept the first plan the agent generates. Treat the initial plan as a draft and refine it through follow-up prompts:

1. **Review for completeness**: Check whether the plan covers all edge cases. For example, does an infrastructure deployment plan include rollback steps?
2. **Check for dependencies**: Verify that the plan accounts for prerequisites, like existing resources or required permissions.
3. **Validate the order of operations**: Ensure steps are sequenced correctly. Creating an NSG rule that references a subnet before the subnet exists causes deployment failures.
4. **Add verification steps**: If the plan lacks verification, ask the agent to include them. For operations changes, verification might include running `az deployment what-if`, checking resource compliance, or testing connectivity.

The following are example follow-up prompts that illustrate the kinds of refinements worth adding to any operations plan before handoff:

```text
Add rollback steps in case the deployment fails at any stage
```

```text
Include a pre-flight check that validates required permissions before starting
```

```text
Add a dry-run option that shows what changes would be made without applying them
```

## Choose the right handoff strategy

After finalizing a plan, choose the implementation path that matches your operations workflow:

| Handoff option | Best for |
|----------------|----------|
| **Same session (Agent)** | Quick, low-risk changes where you want to review edits immediately |
| **Copilot CLI (background)** | Larger implementations where you want to keep working on other tasks |
| **Cloud agent (pull request)** | Changes that require team review, approval workflows, or CI/CD validation |

For production infrastructure changes, handing off to a cloud agent is often the best choice. The cloud agent creates a pull request, which enables peer review, automated validation through CI pipelines, and a documented approval trail.

## Break complex tasks into smaller plans

A single plan that tries to cover too much ground becomes difficult to review and implement. If your task involves multiple independent components, create separate plans for each:

Instead of:

```text
/plan Set up complete monitoring, alerting, backup, and disaster recovery for our Azure production environment
```

Break it into focused plans:

```text
/plan Set up Azure Monitor alerts for VM CPU, memory, and disk metrics in the production resource group
```

```text
/plan Configure Azure Backup policies for all production VMs with daily and weekly retention
```

Each focused plan is easier to review, implement, and verify independently.

## Use workspace context effectively

The Plan agent reads your existing codebase to generate context-aware plans. To maximize this benefit:

- **Keep infrastructure code in your repository.** Store Bicep templates, PowerShell scripts, parameter files, and configuration documents alongside your application code.
- **Use consistent file organization.** A well-organized repository helps the agent understand your project structure and generate plans that follow existing patterns.
- **Include documentation files.** If your repository contains a `README.md` or `ARCHITECTURE.md` that describes your infrastructure, the agent uses that context to generate better plans.

> [!IMPORTANT]
> Always review generated plans against your organization's change management requirements before proceeding to implementation. The Plan agent helps you create a structured approach, but the responsibility for validating the plan against production standards remains with you and your team.
