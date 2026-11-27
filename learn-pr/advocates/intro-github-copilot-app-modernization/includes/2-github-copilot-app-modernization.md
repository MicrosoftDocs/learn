GitHub Copilot modernization provides specialized AI-assisted workflows for application upgrades and migration. It combines assessment, planning, language-specific tools, and reviewable code changes. Unlike an isolated code suggestion, a modernization workflow coordinates changes across a project and records the plan and results.

This module focuses on Java and .NET. Current documentation calls the .NET runtime/framework upgrade experience **GitHub Copilot upgrade**; Azure-specific dependency migrations use **GitHub Copilot modernization**. Other supported scenarios have different capabilities; support for a language doesn't mean every modernization task is available for it.

## Capabilities and scope

The following table summarizes the capabilities available for each scenario.

| Scenario | Documented capability |
| --- | --- |
| Java | Upgrade JDKs and frameworks; assess Azure readiness and update application code for Azure dependencies. |
| .NET | Upgrade supported C# and Visual Basic projects. Azure dependency migration has scenario-specific language and project requirements; don't assume every migration task supports both languages. |
| C++ | Upgrade and modernize MSBuild-based and CMake-based projects, including MSVC toolset upgrades and related build fixes. |
| JavaScript/TypeScript | Upgrade npm packages and adapt code to dependency changes with the project's package manager. |
| Python | Migrate Semantic Kernel or AutoGen applications to Microsoft Agent Framework. This isn't the same feature set as Java/.NET Azure migration. |
| Language-agnostic tasks | Generate containerization and Azure deployment assets, subject to the application's runtime and hosting requirements. |

The main capabilities are:

- **Assessment and planning.** Analyze code, configuration, and dependencies. Upgrade assessments identify compatibility changes; Azure-readiness assessments identify cloud dependencies and recommended remediation. Reports and artifacts vary by workflow.
- **Code transformations.** Apply language-specific changes and predefined migration patterns. Java workflows can use OpenRewrite recipes. You can explicitly capture a previous migration as a custom skill for reuse.
- **Build, dependency, and test validation.** Build the changed application, attempt compilation fixes, and check dependencies for known Common Vulnerabilities and Exposures (CVEs). Test execution and generation depend on the selected workflow, its options, and available tooling. Review unresolved issues rather than assuming a successful outcome.
- **Containerization and deployment.** Generate Dockerfiles, infrastructure as code, and deployment or CI/CD configuration. Review target resources, permissions, costs, and the deployment plan before execution.
- **Predefined tasks.** Update application code for scenarios such as managed-identity authentication, Azure SQL, Azure Database for PostgreSQL, storage, and messaging. These code tasks aren't evidence that production data has been transferred.
- **Specialized tools and agents.** IDE, CLI, and cloud integrations expose modernization tools, including Model Context Protocol (MCP) servers. Each integration requires its own setup; an MCP-compatible client alone doesn't establish support for every task.

## Java and .NET upgrade boundaries

The Java upgrade quickstart documents JDK targets 11, 17, 21, and 25, with JDK 8 as the minimum source-project version. Framework upgrade targets include Spring Boot up to 4.0, Spring Framework up to 7.x, and Jakarta EE up to 11, plus JUnit and other dependency upgrades. These are documented automation targets, not a vendor support policy. Select a supported minor release and current compatible patch; commercial support and community support can have different end dates.

Supported Java builds use Maven, including Maven Wrapper, or Gradle Wrapper version 5 or later. Kotlin DSL-based Gradle projects aren't supported by this workflow. The wrapper minimum isn't a guarantee that an old Gradle version can run on a newer target JDK. Select compatible JDK, framework, plugin, and build-tool versions together, and check the chosen vendor's lifecycle.

.NET scenarios include modern .NET upgrades and .NET Framework modernization. ASP.NET MVC/Web API migration to ASP.NET Core is different from Web Forms conversion to Blazor Server. Desktop, library, console, and test projects also have scenario-specific requirements. Assessment determines which dependencies and platform-specific features need changes; changing the target framework alone isn't a complete migration.

## Prepare the development environment

Use the following table to select the setup requirements for your development environment.

| Environment | Setup and boundaries |
| --- | --- |
| Java in Visual Studio Code | Use the latest stable VS Code with GitHub Copilot and GitHub Copilot modernization enabled, and sign in to GitHub. Current migration/custom-skill quickstarts specify VS Code 1.113 or later. Confirm that `chat.extensionTools.enabled` is `true`; if organization policy disables it, ask the administrator to review access rather than bypassing the policy. VS Code runs on Windows, macOS, and Linux; the project still needs compatible local build tools. |
| Java in IntelliJ IDEA | Use a current supported IntelliJ IDEA version, at least 2023.3, the GitHub Copilot plugin version 1.5.59 or later, and the modernization plugin. The modernization FAQ documents Windows and macOS support for IntelliJ. |
| .NET in Visual Studio | Use Windows. In Visual Studio Installer, enable the **.NET desktop development** workload with the **GitHub Copilot** and **GitHub Copilot app modernization** optional components, plus the workloads/SDKs required by the projects. Supported .NET 10 targeting requires Visual Studio 2026, version 18.0 or later; Copilot Free requires version 18.1 or later for this experience. |
| .NET in Visual Studio Code | Install **GitHub Copilot upgrade** for the upgrade workflow, or configure the separate Azure migration integration for that task. The host must be able to build and test the project; VS Code's cross-platform availability doesn't make Windows-specific projects portable. |
| GitHub Copilot CLI | Install the scenario's plugin and select its specialized agent. The general modernization plugin's Java instructions require Node.js 22 or later. Requirements aren't interchangeable with the separate Modernize CLI. |
| Modernize CLI | Install the separate modernization-agent CLI and GitHub CLI 2.45.0 or later, then authenticate. It supports portfolio assessment and planning as well as documented execution/upgrade commands. |
| Copilot cloud agent | Configure the repository's documented language-specific tools and custom agent, plus a compatible build environment. Choose an **Actions** session if the setup depends on repository setup workflows or Windows/custom runners; a **Cloud** sandbox doesn't apply those settings. Cloud-agent entitlement and organization policy also apply. |

For the documented Java IDE upgrade workflow, use a Git-managed project, install the source and target JDKs, and provide access to required dependency repositories, including Maven Central for Maven projects. Other agents can manage JDK installation differently; don't assume that every integration has the same setup behavior. Java Azure migration and custom-skill quickstarts have additional environment prerequisites, including a Java 21 or later environment; this doesn't change the minimum source-project version. For .NET, establish a successful baseline build with the SDKs, targeting packs, workloads, and package feeds needed by the original application.

Modernization uses your GitHub Copilot entitlement and applicable usage allowance. Sign in with the GitHub account that has Copilot access, and check model availability, organization policy, and spending controls before substantial runs. An Azure account isn't required for a local framework-only upgrade; Azure-backed integration testing, portfolio assessment integration, resource provisioning, and deployment require the relevant Azure access and authorization.

After installing or updating the Java extension, restart the IDE as instructed. If its modernization tools aren't available after first opening a project or updating the extension, use the documented **Refresh** action to reload them.
