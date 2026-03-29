This guided project focuses on setting up cost guardrails using resource tags, budgets, and Azure Policy.

Azure provides several tools to help you control cloud spending. Tags let you categorize resources for cost reporting. Budgets send alerts when spending approaches a threshold. Azure Policy enforces organizational rules—like restricting which regions resources can be deployed to—automatically.

## Scenario

Your pilot team has a limited monthly cloud budget and needs clear controls in place before a broader rollout. You tag resources for cost tracking, create a budget with alert thresholds, and assign an Azure Policy that restricts resource creation to an approved region. These guardrails give the team early visibility into spending and prevent noncompliant deployments.

- Exercise 1 - Apply organizational tags for cost tracking.
- Exercise 2 - Create a budget with alert thresholds.
- Exercise 3 - Assign and test an Azure Policy for region compliance.

:::image type="content" source="../media/overview-architecture.png" alt-text="Diagram showing the three cost guardrail pillars: tags for categorization, budgets for spending alerts, and Azure Policy for compliance enforcement." border="false":::

By the end of this project, you have practical experience setting up cost controls and compliance policies that protect a cloud environment from overspending and configuration drift.

> [!NOTE]
> This is a guided project module where you complete a project by following step-by-step instructions.

## Skilling areas

In this project, you practice skills in the following areas:

**Apply resource tags for cost tracking**
+ Tag resource groups and resources with key-value pairs.
+ Use tags to categorize resources by environment and owner.

**Configure budgets and alerts**
+ Create a budget scoped to a resource group.
+ Set alert thresholds at 80% and 100% of the budget.
+ Configure email notifications for budget alerts.

**Assign and test Azure Policy**
+ Find and assign a built-in policy definition.
+ Test that the policy blocks noncompliant resource creation.
+ Review the compliance dashboard.

> [!IMPORTANT]
> This project uses the Azure portal for every step. No prior Azure experience is required.
