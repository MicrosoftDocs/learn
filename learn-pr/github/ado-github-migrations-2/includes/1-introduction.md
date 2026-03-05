A successful migration begins long before you move a single repository. In this module, you’ll learn to read the “story” of an Azure DevOps (ADO) environment—its organizations, projects, repositories, and pipelines—and translate that story into a well-prepared GitHub Enterprise Cloud (GHEC) destination. We’ll move beyond checklists to focus on the “why” behind each step, helping you make confident, defensible decisions that minimize risk and guide stakeholders.

Think of this as laying a runway: Phase 2 ensures your source environment is fully understood and quantified, while Phase 3 builds a target environment that is secure, coherent, and ready to receive real workloads.

## Required token scopes

### Azure DevOps Personal Access Token

For full migration capabilities, your Azure DevOps PAT needs these scopes:

- **Build** (read) - Access build pipeline information
- **Code** (read) - Read repository content and history
- **Project and team** (read) - Access project and team metadata
- **Service connections** (read/manage) - Configure hybrid integrations
- **Work items** (read/write) - Access Azure Boards integration features

### GitHub Personal Access Token

Your GitHub PAT should include these scopes:

- **repo** - Full repository access for migration operations
- **admin:repo_hook** - Manage repository webhooks for integrations
- **admin:org** - Organization administration (if needed for setup)
- **read:org** - Read organization membership and teams
- **workflow** - Manage GitHub Actions workflows (if applicable)

Having proper token scopes configured upfront prevents authentication issues during migration execution.

Consider completing [Azure DevOps to GitHub Enterprise Migrations Part I](/training/modules/introduction-to-ado-to-github-migration/) before starting this module.
