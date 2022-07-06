# Module design

## Title

Analyze costs and create budgets with Microsoft Cost Management

## Role(s)

- Administrator
- Business Analyst
- Developer
- DevOps Engineer
- Solution Architect

## Level

- Beginner

## Product(s)

- Microsoft Cost Management

## Prerequisites

- "Owner" access to an Azure subscription (a free trial is sufficient)
- Five or more Azure resources created within your subscription that have been accruing cost for at least one month
- Basic familiarity with the Azure Portal

## Summary

Learn how to use Cost Analysis to understand how your costs accrue each month. Use this understanding to create an Azure budget to monitor and alert on your costs.

## Learning objectives

1. Set up your organization for success when using Cost Management.
2. Analyze costs on a subscription using Cost Analysis.
3. Create your first Azure budget based on your analysis.

## Chunk your content into subtasks

Identify the subtasks of "Analyze costs and create budgets with Microsoft Cost Management"

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify key cost management methodologies | Understand best practices | Knowledge check | 1 | Yes |
| Identify the daily cost of one resource | Understand what is driving your costs | Exercise | 2 | Yes |
| Create a Budget and view it in Cost Analysis  | Proactively manage your spending to ensure you do not exceed your budget | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    You are a manager within your organization. Your team has been using Azure for the last several months and now has multiple resources that have been created and are costing you money. You would like to understand Cost Management best practices and analyze which resources are the primary drivers of your monthly bill. You would also like to set thresholds on your team's Azure expenses in order to stay within the budget that has been allocated to you by the finance department of your organization.

1. **Cost Management Principals**

    - Define key principals that should be adopted to achieve success
        - Planning
        - Visibility
        - Accountability
        - Optimization
        - Iterate
    - Define where to use cost management
        - Subscription / Resource Group blades
        - Cost Management + Billing blade
    - Define tools in Microsoft Cost Management and then identify that Cost Analysis / Exports and Budgets are the only tools that will be covered in detail.

     **Knowledge Check**

    - Ask a question about what the key principals are to achieve success with Cost Management

1. **Evaluate your costs using Cost Analysis**

    - Discuss different ways to use Cost Analysis, including:
        - Accumulated cost view
        - Actual cost
        - Forecast
        - Budget
        - Accumulated Granularity
        - Pivot (donut) charts
    - Discuss customized cost views
        - Accumulated cost
        - Daily costs
        - Cost by service
        - Cost by Resource
    - Date selection
    - Group by and filtering
    - Actual Versus amortized cost
    - Saving and sharing views
    - Exporting data

1. **Exercise - Determine your most expensive resource and see trends**

    - Have user select a subscription
    - Have user group by resource, determine the most expensive resource in their subscription
    - Have user remove the group by and filter down to just that resource
    - Have user change graph to bar chart, daily, with a time range of 1 month to see the daily cost trend of that resource

1. **Build budgets and alerts**

    - Discuss budgets overview
    - Walk through the creation experience
    - Discuss email and alert configuration
    - Discuss action group configuration with budgets

1. **Exercise - Create your first budget**

    - Have user create a budget based on the monthly cost of their most expensive resource. The user should filter down to that resource.
    - Have user view budget in Cost Analysis after creation

1. **Summary**

    - Cost Analysis to help with Visibility
    - Budgets to help with Accountability
