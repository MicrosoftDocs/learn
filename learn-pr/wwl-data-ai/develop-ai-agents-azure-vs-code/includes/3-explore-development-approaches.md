Microsoft Foundry Agent Service provides flexibility in how you develop agents, with options ranging from visual interfaces to code-centric workflows. Understanding the different development approaches helps you choose the right tools for your scenarios and team preferences.

## Foundry portal development

The Foundry portal provides a web-based interface for creating and managing AI agents without writing code. This approach is ideal when you want to quickly prototype ideas, collaborate with non-technical stakeholders, or manage agents through a centralized interface.

### When to use the Foundry portal

The portal excels in these scenarios:

- **Quick prototyping** - Rapidly test agent concepts and configurations without setting up development environments
- **Visual configuration** - Configure agents through intuitive forms and dropdowns rather than code
- **Centralized management** - View and manage all agents across projects in one place
- **Team collaboration** - Share agent configurations with stakeholders who prefer visual interfaces
- **Resource oversight** - Monitor token usage, latency, and evaluation outcomes through dashboards

The Azure portal provides immediate access to agent creation without installing additional tools. You simply navigate to your Foundry project, select the Agents section, and start building.

## Visual Studio Code development

The Microsoft Foundry extension for Visual Studio Code brings enterprise-grade AI capabilities directly into your development environment. This approach suits developers who prefer working in familiar code editors and want tight integration with their development workflows.

### Key capabilities of the VS Code extension

The extension organizes its features into three main sections:

**Resources** - Browse and manage your Foundry project assets directly from VS Code, including:
- **Deployed models** - View and manage model deployments
- **Declarative agents** - View and configure prompt-based and workflow agents
- **Hosted agents** - View and manage containerized, code-deployed agents
- **Connections** - Manage connections to external services
- **Vector stores** - Organize document collections for File Search

**Tools** - Access development and testing capabilities:
- **Model Catalog** - Browse and deploy models from the catalog
- **Model Playground** - Experiment with models directly
- **Agent Playgrounds** - Test agents using remote or local playgrounds
- **Local Visualizer** - Debug and visualize agent behavior locally
- **Deploy Hosted Agents** - Deploy containerized agents to production

**Help and Feedback** - Access documentation and support resources.

The extension also provides a visual **Agent Designer** for configuring agent properties, integrated **code generation** for application integration, and direct **YAML configuration** editing for precise control.

![Screenshot of the Microsoft Foundry VS Code extension interface showing the Resources, Tools, and Help and Feedback sections.](../media/vs-code-agent.png)

### When to use Visual Studio Code

The VS Code extension is ideal for:

- **Developer-centric workflows** - Build agents alongside your application code in a single environment
- **Version control integration** - Track agent configurations in Git alongside your codebase
- **Rapid iteration** - Make quick changes and test immediately without switching tools
- **Code-first development** - Edit YAML configurations directly for precise control
- **Local development** - Work on agent designs offline before deploying to Azure

The extension installs directly from the Visual Studio Code Marketplace and connects to your existing Foundry projects. Detailed installation and setup steps are covered in the next unit.

## Typical development workflow

Regardless of your chosen approach, agent development follows a consistent pattern:

1. **Connect** to your Microsoft Foundry project
1. **Create** an AI agent in the Foundry portal with a descriptive name and purpose
1. **Configure** agent instructions defining its behavior and capabilities (in the portal or VS Code)
1. **Add tools** to extend what the agent can do
1. **Test** the agent using integrated playgrounds
1. **Iterate** on the design based on test results
1. **Deploy** the agent to production
1. **Integrate** the agent into your applications

The Foundry portal and VS Code extension both support this workflow, differing primarily in interface style rather than capabilities.

## Required Azure resources

Both development approaches require the same underlying Azure resources. To develop agents with Microsoft Foundry Agent Service, you need:

- **Microsoft Foundry project** - Organizes your agents, models, and related assets in one place
- **Model deployments** - Deployed AI models (such as GPT-4.1 or Claude Sonnet 4.6) that power your agents

When you create a Microsoft Foundry project, the necessary infrastructure is provisioned automatically. As you add capabilities to your agents, such as File Search or custom tools, the service seamlessly integrates any required supporting services behind the scenes. If you choose to extend the capabilities of your agent even further, for example with Foundry IQ, you may need to deploy some additional Azure services.

### Optional Azure services

Depending on your agent's capabilities, you might integrate additional Azure services:

- **Azure AI Search** - For advanced knowledge retrieval when using Foundry IQ or File Search tools
- **Azure Storage** - For storing and managing files that agents can access
- **Azure Key Vault** - For securely managing secrets and credentials
- **Azure Functions** - For custom tool implementations and business logic

These services integrate with your Foundry project as needed, but aren't required to get started building agents.

## Choosing your development approach

Both the Foundry portal and Visual Studio Code extension provide complete agent development capabilities. Your choice depends on your workflow preferences, team composition, and integration requirements:

Choose the **Foundry portal** when you want visual configuration, centralized management, or quick prototyping without local development setup.

Choose **Visual Studio Code** when you prefer developer-centric workflows, need tight integration with application code, or want version-controlled configuration files.

Many teams use both approaches — the portal for initial exploration and stakeholder reviews, and VS Code for detailed development and production deployments. The flexibility to switch between approaches based on your immediate needs is a key strength of Microsoft Foundry Agent Service.
