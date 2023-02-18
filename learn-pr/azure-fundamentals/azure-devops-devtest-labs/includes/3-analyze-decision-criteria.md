In this unit, you'll analyze the criteria that experts employ when they choose DevOps tools or services to address specific business needs. Understanding the criteria can also help you better understand the nuanced differences between each product.

### Do you need to automate and manage test-lab creation?

If your aim is to automate the creation and management of a test lab environment, consider choosing Azure DevTest Labs. Among the three tools and services we've described, it's the only one that offers this functionality.

However, you can automate the provisioning of new labs as part of a toolchain by using Azure Pipelines or GitHub Actions.

### Are you building open-source software?

Although Azure DevOps can publish public code repositories, GitHub has long been the preferred host for open-source software. If you're building open-source software, you would likely choose GitHub if for no other reasons than its visibility and general acceptance by the open-source development community.

The remaining decision criteria are specific to choosing between Azure DevOps and GitHub.

> [!NOTE]
> Your choices aren't limited to Azure DevOps Services or GitHub and GitHub Actions. In practice, you can mix and match these services as needed. For example, you can use GitHub repos with Azure Boards for work-item tracking.

#### Regarding source-code management and DevOps tools, what level of granularity do you need for permissions?

GitHub works on a simple model of read/write permissions to every feature. Azure DevOps has a much more granular set of permissions that allow organizations to refine who is able to perform most operations across the entire toolset.

#### Regarding source-code management and DevOps tools, how sophisticated does your project management and reporting need to be?

Although GitHub has work items, issues, and a Kanban board, project management and reporting is the area where Azure DevOps excels. Azure DevOps is highly customizable, which allows an administrator to add custom fields to capture metadata and other information alongside each work item. By contrast, the GitHub Issues feature uses tags as its primary means of helping a team categorize issues.

#### Regarding source-code management and DevOps tools, how tightly do you need to integrate with third-party tools?

Although we make no specific recommendations about third-party tools, it's important for you to understand your organization's existing investments in tools and services and to evaluate how these dependencies might affect your choice. It's likely that most vendors that create DevOps tools create hooks or APIs that can be used by both Azure Pipelines and GitHub Actions. Even so, it's probably worth the effort to validate that assumption.
