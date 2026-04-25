## Scenario: secure a virtual network deployment

> [!NOTE]
> The prompts shown in this unit illustrate how an operations engineer might interact with the Plan agent for each scenario. They are examples of effective prompt patterns that demonstrate the kind of context the agent needs — they are not step-by-step instructions to follow.

Suppose a team receives a request to deploy a new Azure virtual network with specific security requirements. The virtual network needs three subnets for web, application, and data tiers, each with its own network security group (NSG). Before writing any infrastructure code, the engineer wants a clear plan that covers all the components and their relationships.

To start, the engineer selects **Plan** from the agents dropdown in the Chat view and describes the goal. An example of how that prompt might be structured:

```text
/plan Create Bicep templates to deploy an Azure virtual network named vnet-prod-001 in the eastus region with three subnets (web, app, data), each with a dedicated network security group. The web subnet should allow inbound HTTP/HTTPS traffic, the app subnet should only accept traffic from the web subnet, and the data subnet should only accept traffic from the app subnet.
```

The Plan agent examines your workspace for existing Bicep files, modules, or parameter files. It then generates a plan that might include:

<!-- IMAGE PLACEHOLDER: Portal or UI screenshot
Alt text: The VS Code Chat view showing a Plan agent session with a generated infrastructure plan for a virtual network deployment.
Suggested source: Custom screenshot needed
Capture instructions: Open VS Code, use Plan agent with the virtual network prompt, and capture the chat output showing the generated plan steps.
Suggested filename: plan-agent-vnet-output.png
Priority: High
-->

1. Create a `main.bicep` file with the virtual network resource and three subnet definitions.
2. Create an `nsg-web.bicep` module with rules allowing inbound ports 80 and 443 from the internet.
3. Create an `nsg-app.bicep` module with rules allowing inbound traffic only from the web subnet address range.
4. Create an `nsg-data.bicep` module with rules allowing inbound traffic only from the app subnet address range.
5. Create a `parameters.prod.json` file with environment-specific values.
6. Add verification steps to validate the Bicep templates with `az bicep build` and run a what-if deployment.

## Iterate on the plan

After reviewing the initial plan, the engineer notices it doesn't account for diagnostics logging. A follow-up prompt to address this might look like:

```text
Add NSG flow logs for each network security group, storing them in an existing storage account. Also include a Log Analytics workspace for traffic analytics.
```

The Plan agent updates the plan to include additional implementation steps for NSG flow logs and traffic analytics configuration.

## Scenario: automate resource group tagging compliance

An organization requires that all resource groups carry specific tags for cost allocation and ownership. The team needs an Azure Policy that enforces tagging and a remediation script for existing noncompliant resources. An example prompt for this scenario:

```text
/plan Create an Azure Policy definition that requires 'CostCenter', 'Environment', and 'Owner' tags on all resource groups. Include a PowerShell remediation script that scans existing resource groups and applies default tags where they're missing.
```

The Plan agent generates a plan covering:

1. Create a policy definition JSON file with the `deny` effect for missing tags.
2. Create a policy assignment targeting the subscription scope.
3. Create a PowerShell script that uses `Get-AzResourceGroup` to find noncompliant resource groups and `Set-AzResourceGroup` to apply default tags.
4. Add verification steps to test the policy with a noncompliant resource group creation attempt.

## Scenario: plan a role-based access control review

When a team needs to audit and update Role-Based Access Control (RBAC) role assignments across multiple subscriptions, the scope of changes can be significant. Using Plan mode helps map out the full approach before making any modifications. An example of how an engineer might describe this goal to the Plan agent:

```text
/plan Create a PowerShell script that audits RBAC role assignments across all subscriptions in our tenant. The script should export a CSV report of all users with Owner or Contributor roles, flag any assignments to individual user accounts (versus groups), and identify role assignments that haven't been used in the last 90 days using Azure AD sign-in logs.
```

<!-- IMAGE PLACEHOLDER: Conceptual diagram
Alt text: Diagram showing RBAC audit script flow across multiple Azure subscriptions, filtering by role type and cross-referencing sign-in logs.
Suggested source: Custom diagram needed
Capture instructions: Create a diagram showing the script flow from subscription enumeration to role assignment filtering to sign-in log correlation and CSV export.
Suggested filename: rbac-audit-flow.png
Priority: Medium
-->

The plan might include steps for:

1. Create a script that iterates through subscriptions using `Get-AzSubscription`.
2. Retrieve role assignments with `Get-AzRoleAssignment` and filter for Owner and Contributor roles.
3. Cross-reference assignments with Microsoft Entra ID sign-in logs to identify inactive assignments.
4. Export results to a CSV file with columns for subscription, principal name, role, assignment type (user versus group), and last sign-in date.
5. Add error handling for subscriptions where the current identity lacks read access.

## Tips for writing effective infrastructure prompts

When you use the Plan agent for cloud infrastructure tasks, include these details in your prompts:

- **Target environment**: Specify the Azure region, subscription context, or resource group.
- **Naming conventions**: Include your organization's naming standards (for example, `vnet-prod-001`).
- **Dependencies**: Mention existing resources the new infrastructure needs to reference.
- **Security requirements**: State any compliance standards or security rules that apply.
- **Tooling preferences**: Specify whether you prefer Bicep, ARM templates, Terraform, or Azure CLI scripts.

> [!TIP]
> If your repository includes a `.github/copilot-instructions.md` file with your organization's infrastructure standards, the Plan agent automatically incorporates those instructions when generating plans. This helps ensure that generated plans follow your team's conventions for naming, tagging, and architecture patterns.
