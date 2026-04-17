GitHub Copilot app modernization is a set of AI-powered agents, built on GitHub Copilot agent mode, that provides end-to-end support for application upgrade and migration. GitHub Copilot app modernization is more than using GitHub Copilot to refactor code. GitHub Copilot app modernization is a dedicated product with a structured workflow, specialized tooling, and deep integration with Azure migration best practices. GitHub Copilot app modernization supports Java, .NET, and Python.

GitHub Copilot app modernization has the following capabilities:

- **Application assessment and planning.** Analyzes your project's code, configuration, and dependencies. Generates assessment reports with cloud-readiness scoring, dependency mapping, and actionable recommendations. Assessment dashboards can be exported, imported, and shared with architects for review.
- **Code transformations.** Upgrades Java or .NET runtimes and frameworks, and migrates code to use Azure services. Uses open-source tools like OpenRewrite for automated API replacements and dependency updates. Predefined tasks encode expert knowledge for common migration scenarios. Custom tasks can be created from prior Git commits and reused across projects.
- **Build validation and CVE scanning.** Automatically builds the project after transformations and resolves compilation errors. Scans for Common Vulnerabilities and Exposures (CVEs) and applies security fixes. Migrates existing unit tests and generates new ones to validate modernization outcomes.
- **Containerization and deployment.** Generates Dockerfiles for containerization and Infrastructure as Code files for Azure deployment. Sets up CI/CD pipelines and addresses deployment errors automatically.
- **Predefined task library.** These tasks cover common migration scenarios including updating application code from password-based authentication to managed identities and migrating an application's data tier from on-premises or legacy databases to Azure SQL or Azure PostgreSQL.
- **Model Context Protocol (MCP) server.** GitHub Copilot app modernization uses an MCP server to deliver its specialized migration tools to the IDE. The MCP server is the underlying mechanism through which the agent executes code transformations, assessment tasks, and predefined migration patterns. When you open a Java project for the first time or upgrade the extension, you need to select Refresh to establish a connection with the MCP server and update the available tools in the chat agent. Because the MCP server follows the open Model Context Protocol standard, it can also be used outside the IDE extension. For example you can also use it with Copilot CLI, the Copilot Cloud Agent , or other MCP-compatible clients. 

The GitHub Copilot app modernization agent supports Java upgrades and Azure migration for Java backend applications listed in the table:

| **Capability** | **Details** |
|---|---|
| **Java versions** | JDK 8, 11, 17, 21, 25. Upgrade from JDK 8 to JDK 11, 17, 21 or 25. |
| **Frameworks** | Spring Boot (up to 3.5), Jakarta EE (up to 10), Spring Framework (up to 6.2+), JUnit. |
| **Build tools** | Maven (including Maven Wrapper), Gradle (Wrapper only, version 5+). Kotlin DSL-based Gradle isn't supported. |
| **Migration targets** | Azure App Service, Azure Container Apps, Azure Kubernetes Service (AKS), AKS Automatic. |

GitHub Copilot app modernization supersedes the free .NET Upgrade Assistant extension in Visual Studio. The modernization agent supports .NET upgrades and Azure migration for C# projects listed in the table:

| **Capability** | **Details** |
|---|---|
| **Upgrade paths** | Older .NET to latest .NET; .NET Framework to modern .NET. |
| **Project types** | ASP.NET Core (MVC, Razor Pages, Web API), Blazor, Azure Functions, WPF, WinForms, class libraries, console apps, test projects (MSTest, NUnit). |
| **Code language** | C# only. |
| **Migration targets** | Azure SQL DB, Azure Blob Storage, Azure Service Bus, Microsoft Entra ID, Azure Key Vault, and more. |

The modernization agent can migrate Python applications from Semantic Kernel or AutoGen to the Microsoft Agent Framework. This is triggered through the extension sidebar or detected automatically when the project is opened.

The modernization agent can also containerize applications by generating Dockerfiles and building container images and deploy applications to existing or new Azure resources.

GitHub Copilot app modernization has the following IDE and platform requirements:

| **Language** | **IDE** | **Platform** |
|---|---|---|
| **Java** | Visual Studio Code (with app modernization extension); IntelliJ IDEA | Windows, macOS |
| **.NET** | Visual Studio 2026 (or VS 2022 v17.14.17+); also Visual Studio Code via extension | Windows only (Visual Studio) |
| **Any** | Copilot CLI (terminal-based, with Node.js 22+ and npm 10+) | Any platform supporting Copilot CLI |
| **Any** | Copilot Cloud Agent  (via GitHub issues/PRs, runs in the cloud) | Any platform |

GitHub Copilot app modernization is a feature of GitHub Copilot. App modernization tasks consume premium requests, with each subscription plan offering a monthly allowance. 

GitHub Copilot app modernization has the following software prerequisites:

- A Git-based repository
- Installed source and target JDKs (for Java)
- The VS Code extension or Visual Studio with the correct workload
- Maven Central access (for Maven projects)
