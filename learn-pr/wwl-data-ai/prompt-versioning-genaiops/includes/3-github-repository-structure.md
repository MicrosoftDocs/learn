# Version Control for GenAI Prompts

Imagine deploying a critical customer service AI that suddenly starts responding rudely to customers because someone made an undocumented prompt change. Without proper version control, you'd have no way to track what changed, who changed it, or how to quickly revert to the working version. This scenario highlights why treating AI prompts with the same rigor as traditional code is essential for enterprise GenAI success.

## Version control fundamentals for prompts

**Version control** is the practice of tracking and managing changes to files over time, enabling teams to collaborate safely while maintaining a complete history of modifications. For AI prompts, this means treating each prompt as a critical piece of code that requires systematic management, documentation, and deployment processes.

**Why GitHub for prompt management?**

GitHub provides several key advantages for prompt versioning:

- **Distributed version control** with Git ensures every team member has a complete history
- **Pull request workflows** enable peer review and approval processes for prompt changes
- **Branch management** allows safe experimentation and parallel development
- **Integration capabilities** with CI/CD pipelines for automated testing and deployment
- **Issue tracking** to link prompt changes to business requirements and bug reports
- **Access controls** to manage who can modify production prompts

> **💡 Alternative version control options**
> 
> While this unit focuses on GitHub for educational consistency, other excellent options exist:
> - **Azure DevOps**: Integrated with Microsoft ecosystem, strong enterprise features
> - **GitLab**: Comprehensive DevOps platform with built-in CI/CD
> - **Bitbucket**: Atlassian integration, good for Jira workflows
> - **AWS CodeCommit**: Native AWS integration for cloud-first organizations
> 
> The choice often depends on existing tooling, compliance requirements, and team expertise. The core principles of prompt version control remain consistent across platforms.

## File formats for prompt storage

**Why standardize file formats?**

Choosing the right file format for prompt storage affects readability, tool compatibility, version control effectiveness, and team collaboration. The format should balance human readability with machine processingcapabilities.

**Markdown (`.md`) - The recommended choice**

Markdown offers the optimal balance for prompt management:

- **Human-readable**: Plain text with simple formatting that anyone can edit
- **Version control friendly**: Git shows clear line-by-line differences between versions
- **Documentation support**: Headers, lists, tables, and code blocks for rich prompt context  
- **Universal tool support**: Works in every editor, IDE, and documentation platform
- **Lightweight**: No complex dependencies or proprietary formats

**Alternative file formats**

- **JSON (`.json`)**: Excellent for structured data and API integration, but less readable for complex prompts
- **YAML (`.yaml`)**: Good balance of readability and structure, popular in DevOps workflows
- **Plain text (`.txt`)**: Simple but lacks formatting and metadata capabilities
- **Python files (`.py`)**: Good for programmatic prompt templates with logic
- **Jinja2 templates (`.jinja2`)**: Powerful templating but requires technical knowledge

**Azure AI Foundry compatibility**

Azure AI Foundry supports multiple formats for prompt flows, with YAML being the primary configuration format. According to the [official documentation](https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/flow-develop?view=foundry-classic), prompt flows use:

- **flow.dag.yaml**: Main flow definition in YAML format
- **Python files (.py)**: For custom logic and processing  
- **Jinja2 templates (.jinja2)**: For dynamic prompt content
- **Markdown (.md)**: For documentation and human-readable prompt content

For deeper integration with Azure AI Foundry, see the [complete prompt flow development guide](https://learn.microsoft.com/en-us/azure/ai-foundry/how-to/flow-develop?view=foundry-classic).

> **📋 Format choice for this course**
> 
> We'll use Markdown (`.md`) throughout this course for its readability and universal compatibility. This choice simplifies learning while demonstrating industry best practices. In real projects, you might use multiple formats depending on specific requirements—YAML for configuration, Markdown for documentation, and JSON for API integration.

## Repository organization and naming conventions

**Hierarchical folder structure**

A well-organized repository makes prompt discovery and maintenance straightforward:

```
prompts-repository/
├── README.md                    # Repository overview and setup guide
├── prompts/
│   ├── customer-support/
│   │   ├── greeting.md          # Customer interaction prompts
│   │   ├── troubleshooting.md
│   │   └── escalation.md
│   ├── content-generation/
│   │   ├── blog-posts.md        # Marketing content prompts
│   │   ├── social-media.md
│   │   └── newsletters.md
│   ├── data-analysis/
│   │   ├── report-summary.md    # Analytics and reporting prompts
│   │   └── insight-extraction.md
│   └── templates/
│       └── prompt-template.md    # Standardized prompt structure
├── configs/
│   ├── development.yaml         # Environment-specific configurations
│   ├── staging.yaml
│   └── production.yaml
├── tests/
│   ├── unit-tests/              # Individual prompt validation
│   └── integration-tests/       # End-to-end workflow testing
├── docs/
│   ├── deployment-guide.md      # How to promote prompts
│   ├── testing-standards.md     # Quality assurance procedures
│   └── style-guide.md           # Writing and formatting standards
└── .github/
    └── workflows/               # CI/CD automation
        ├── test-prompts.yml
        └── deploy-prompts.yml
```

**Naming convention best practices**

**File naming:**
- Use descriptive, lowercase names: `customer-greeting.md`
- Separate words with hyphens: `password-reset-assistance.md`  
- Include functional context: `sales-product-demo.md`
- Avoid spaces, special characters, and abbreviations
- Use consistent file extensions

**Folder organization:**
- Group by business function: `customer-support/`, `marketing/`, `analytics/`
- Maintain shallow hierarchies (maximum 3 levels deep)
- Use clear, descriptive folder names
- Consider lifecycle stages: `development/`, `testing/`, `production/`
- Include version indicators when needed: `v1/`, `v2/`, `legacy/`

> **🎯 Educational approach note**
> 
> This structure represents one proven approach optimized for learning and common enterprise scenarios. Alternative organizations might work better for specific contexts:
> 
> - **Model-centric**: Organize by AI model type (GPT-4, Claude, etc.)
> - **Application-centric**: Group by end-user application or service
> - **Team-centric**: Separate by owning team or department
> - **Lifecycle-centric**: Organize by development stage
> 
> The best structure depends on your organization size, team distribution, deployment patterns, and governance requirements. Start simple and evolve as your prompt management needs become more sophisticated.

This foundational structure establishes the groundwork for treating prompts as first-class code assets, enabling reliable collaboration, change tracking, and deployment processes essential for production GenAI systems.