In this unit, you'll analyze the criteria experts employ when choosing a DevOps tool or service for a given business need.  Understanding the criteria can also help you better understand the nuanced differences between each product.

## Do you need to automate and manage test lab creation?

If your aim is to automate the creation and management of test lab environments, you should chose Azure DevTest Labs. It is the only of the three tools/services that offer this functionality.

However, provisioning new labs can be automated as part of a toolchain using Azure Pipelines or GitHub Actions.

## Are you building open-source software?

While Azure DevOps can publish public code repositories, GitHub has long been the defacto host for open-source software. If you are building open-source software, you would likely choose GitHub if for no other reason than visibility and general acceptance by the open-source development community.

The remainder of the decision criteria is specific to choosing between either Azure DevOps or GitHub.

> [!NOTE]
> You are not limited to choosing either Azure DevOps Services or GitHub and GitHub Actions. In practice, you can mix and match these services as needed. For example, you can use GitHub repos with Azure Boards for work item tracking.

### Regarding source code management and DevOps tools, what level granularity do you need for permissions?

GitHub works on a simple model of read/write permissions to every feature.  Meanwhile, Azure DevOps has a much more granular set of permissions that allow organizations to refine who is able to perform most operations across the entire toolset.

### Regarding source code management and DevOps tools, how sophisticated does your project management and reporting need to be?

While GitHub has work items, issues, and a Kanban board, project management and reporting is the area where Azure DevOps excels.  Azure DevOps is highly customizable, allowing an administrator to add custom fields to capture metadata and other information along side each work item.  By contrast, GitHub Issues uses tags as its primary means of helping a team categorize issues.

### Regarding source code management and DevOps tools, how tightly do you need to integrate with third-party tools?

While there's no specific recommendation here, it's important to understand your organization's existing investments in tools and services and evaluate how these dependencies might impact your choice.  It's likely that most vendors creating DevOps tools create hooks or APIs that can be leveraged by both Azure Pipelines and GitHub Actions.  Even so, it's probably worth the effort to validate that assumption.