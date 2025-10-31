Azure Pipelines supports multiple source control systems, allowing teams to use their preferred version control platform while maintaining modern CI/CD practices with YAML-based pipeline definitions.

## Supported source control systems

Azure Pipelines supports the following Git-based source control systems:

|   **Repository type**    | **Azure Pipelines Support** |
| :----------------------: | :-------------------------: |
|     Azure Repos Git      |             Yes             |
|          GitHub          |             Yes             |
| GitHub Enterprise Server |             Yes             |
|     Bitbucket Cloud      |             Yes             |

## Key benefits

Azure Pipelines uses a modern infrastructure-as-code approach where pipeline definitions are stored as YAML files alongside your source code. This provides several advantages:

- **Version control integration**: Pipeline changes follow the same review process as code changes
- **Code reuse**: Share pipeline templates and reusable components across projects
- **Branch-specific pipelines**: Different pipeline configurations for different branches
- **Transparency**: Pipeline logic is visible and auditable in source control

## Best practices

When choosing a source control system for Azure Pipelines:

- **Prefer Git-based systems** for modern development workflows and full Azure Pipelines feature support
- **Use branch policies** to ensure pipeline definitions are reviewed before merging
- **Store pipeline templates** in centralized repositories for reuse across teams
- **Implement proper access controls** to secure both source code and pipeline definitions

Git-based source control systems provide the best integration with Azure Pipelines, enabling teams to implement effective CI/CD workflows with pipeline-as-code practices.
