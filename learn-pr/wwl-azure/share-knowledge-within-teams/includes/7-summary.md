This module equipped you with practical strategies and tools for sharing knowledge effectively within development teams. You learned to create accessible documentation, preserve organizational learning, and establish collaboration patterns that keep teams informed and productive as they evolve.

## What you accomplished

Throughout this module, you gained hands-on understanding of knowledge sharing approaches, documentation tools, and team collaboration integrations. You learned when and how to document team knowledge, create wikis for structured information, write technical documentation with Markdown, and connect DevOps tools with communication platforms for real-time awareness.

**Key concepts you learned:**

**Knowledge sharing strategies:**

- **Cost of lost knowledge:** Understanding how undocumented knowledge leads to repeated mistakes, slower problem resolution, inconsistent practices, and extended onboarding
- **What to document:** Focusing on architecture decisions, coding standards, setup guides, troubleshooting solutions, process workflows, and system knowledge
- **Documentation approaches:** Starting with "just enough" documentation, making content discoverable, assigning ownership, keeping docs close to code, using templates, and automating where possible
- **Tool selection:** Choosing appropriate tools for different knowledge types—wikis for lasting documentation, work items for feature context, code comments for implementation details, Teams for real-time collaboration

**Azure DevOps Wikis:**

- **Wiki types:** Project wikis (dedicated repository for project documentation) vs. published wikis (existing code folder published as documentation)
- **Permission model:** Create Repository permission for wiki creation, Contributors group for editing, stakeholders for viewing
- **Git-backed storage:** Wikis stored in Git repositories providing version control, branching, and merge capabilities
- **When to use each type:** Project wikis for cross-cutting documentation, published wikis for code-related documentation versioned with software

**Markdown documentation:**

- **Markdown fundamentals:** Plain text format with simple syntax for headings, bold, italic, lists, links, images, code blocks, tables, and blockquotes
- **GitHub Flavored Markdown (GFM):** Extensions including task lists, tables, strikethrough, autolinks, and syntax highlighting
- **Why Markdown works:** Plain text format, version control friendly, human readable, tool independent, developer friendly
- **Multimedia support:** File attachments, images, and video embedding in wiki pages

**Mermaid diagrams:**

- **Text-based diagrams:** Plain text syntax that renders as visual diagrams, solving binary image merge problems
- **Diagram types:** Flowcharts for processes, sequence diagrams for interactions, class diagrams for structure, ER diagrams for data models, Gantt charts for timelines
- **Benefits:** Version control friendly, no external tools required, always current with documentation, collaboration ready
- **Best practices:** Keep diagrams simple, use consistent styling, include legends, test rendering, break large diagrams into focused views

**Microsoft Teams integration:**

- **GitHub with Teams:** Notifications for pull requests and issues, subscriptions with filters, workflow approvals, issue creation from conversations, link previews, pull request reminders
- **Azure Boards with Teams:** Work item creation and monitoring, subscriptions for area paths, threaded notifications, compose extension for search
- **Azure Repos with Teams:** Repository monitoring, pull request notifications, subscription management, threaded discussions
- **Azure Pipelines with Teams:** Pipeline monitoring, deployment approvals from Teams, customizable subscriptions, run notifications, compose extension

## Additional resources

**Official Microsoft documentation:**

- [Create a project wiki to share information - Azure DevOps | Microsoft Learn](/azure/devops/project/wiki/wiki-create-repo)
- [Publish a Git repository to a wiki - Azure DevOps | Microsoft Learn](/azure/devops/project/wiki/publish-repo-to-wiki)
- [Markdown syntax for wikis - Azure DevOps | Microsoft Learn](/azure/devops/project/wiki/markdown-guidance)
- [Overview of extensions for Azure Boards - Azure DevOps | Microsoft Learn](/azure/devops/boards/extensions/)
- [Azure Pipelines with Microsoft Teams - Azure DevOps | Microsoft Learn](/azure/devops/pipelines/integrations/microsoft-teams)

**GitHub resources:**

- [GitHub Flavored Markdown Spec](https://github.github.com/gfm/)
- [Basic writing and formatting syntax - GitHub Docs](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
- [GitHub app for Microsoft Teams](https://github.com/integrations/microsoft-teams)

**Mermaid resources:**

- [Mermaid Introduction and Documentation](https://mermaid-js.github.io/mermaid/)
- [Mermaid Live Editor](https://mermaid.live/) - Interactive diagram creation and testing
- [Mermaid Examples Gallery](https://mermaid-js.github.io/mermaid/#/examples)

**Knowledge sharing practices:**

- [Architecture Decision Records (ADR)](https://adr.github.io/) - Template and guidance for documenting architecture decisions
- [The Documentation System](https://documentation.divio.com/) - Framework for organizing technical documentation
- [Write the Docs Community](https://www.writethedocs.org/) - Community and resources for technical documentation
