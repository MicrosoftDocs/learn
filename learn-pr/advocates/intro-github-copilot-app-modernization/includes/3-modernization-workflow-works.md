GitHub Copilot app modernization follows a structured, multi-stage workflow. The exact steps vary slightly between Java and .NET, but the overall approach is consistent.

You interact with the modernization agent differently depending on your IDE:

- **Visual Studio Code (Java).** Open the app modernization extension sidebar. Select predefined or custom tasks from the task list. The agent executes in the Copilot Agent chat window, showing progress and requesting confirmation at key steps.
- **Visual Studio (.NET).** Right-click a project in Solution Explorer and select "Modernize," or open the Copilot Chat window and type _@modernize_ followed by your request. The agent runs a three-stage workflow (assessment, planning, execution), writing Markdown files under _.github/upgrades_ for review.
- **Copilot CLI.** Run natural-language prompts in the terminal, such as "Upgrade this project to JDK 21 and Spring Boot 3.2" or "Migrate this application from S3 to Azure Blob Storage."
- **Copilot Cloud Agent .** Delegate modernization tasks via GitHub issues or pull requests. The agent executes in the cloud, working independently like a human developer.

The modernization stages are as follows:

1. **Assessment.** The agent analyzes your project's code, configuration, and dependencies. It generates an assessment report identifying breaking changes, compatibility problems, deprecated patterns, cloud readiness issues, and upgrade scope. For migration scenarios, it assesses Azure readiness and recommends target Azure services.
1. **Planning.** Based on the assessment, the agent creates a detailed modernization plan. For upgrades, this includes which APIs need replacement, which dependencies need updating, and a sequenced task list. For migrations, it maps application components to Azure services and generates a remediation roadmap.
1. **Code transformation.** The agent applies code changes using a combination of AI-powered transformations and open-source tools like OpenRewrite. It replaces deprecated APIs, updates dependency versions, rewrites configuration files, and applies Azure-specific code patterns from predefined tasks.
1. **Build validation and CVE scanning.** After applying transformations, the agent automatically builds the project and resolves compilation errors. It scans for CVEs and applies security fixes. It migrates or generates unit tests to validate that application behavior is preserved.
1. **Containerization and deployment.** The agent generates Dockerfiles, Infrastructure as Code files, and CI/CD pipeline configurations for deploying to Azure App Service, Azure Container Apps, AKS, or AKS Automatic.

After all stages are complete, the agent generates a summary report documenting the results of the modernization process. This report includes project information, the number of lines of code changed, a list of updated dependencies, a summary of code changes applied, any CVE security issues that were fixed, and any unresolved minor issues that require manual follow-up. The summary report provides a comprehensive record of the upgrade that you can use during code review, share with stakeholders, or retain for compliance and audit purposes.

## Predefined tasks

Predefined tasks are expert-encoded migration patterns for common Azure scenarios. They encode best practices and apply them consistently across projects. Examples of predefined tasks include:

Java predefined tasks include:

- Switch from password-based authentication to managed identities.
- Migrate from Amazon S3 to Azure Blob Storage.
- Move from on-premises message queues to Azure Service Bus.
- Migrate configuration to Azure App Configuration.

.NET predefined tasks include:

- Migrate to managed-identity-based databases on Azure (Azure SQL DB, Azure SQL MI, Azure PostgreSQL).
- Migrate file I/O to Azure File Storage or Azure Blob Storage.
- Transition authentication to Microsoft Entra ID.
- Replace plaintext credentials with Managed Identity and Azure Key Vault.
- Move from legacy message queues (MSMQ, RabbitMQ, Amazon SQS) to Azure Service Bus.
- Replace SMTP email with Azure Communication Service.
- Transition to OpenTelemetry on Azure for logging and observability.
- Migrate to Azure Cache for Redis with Managed Identity.
- Migrate to Confluent Cloud or Azure Event Hubs for Apache Kafka.

## Custom tasks

Enterprises often have unique migration patterns. GitHub Copilot app modernization automatically generates custom tasks by analyzing code commits from previously migrated applications. These tasks serve as remediation guides for similar issues in other apps, enabling the GitHub Copilot app modernization agent to apply proven patterns across multiple codebases. With each successful migration, the knowledge base expands, accelerating future remediations and reducing manual effort.

To create a custom task, open the GitHub Copilot app modernization extension sidebar in Visual Studio Code, hover over the Tasks section, and select Create a Custom Task. This opens a task.md file where you provide a task name, a prompt describing the migration pattern, and one or more references. References can include Git commits from a previously migrated application, external links, or text files that illustrate the desired transformation. For example, if your team has already migrated one project from RabbitMQ to Azure Service Bus, you can point the custom task at the Git commit that contains those changes, and the agent will use that commit as a pattern to apply similar changes across other codebases. Once saved, the custom task appears in the My Tasks section of the extension sidebar and can be run like any predefined task. Custom tasks can also be shared with other team members by copying the task folder into the .github/appmod/custom-tasks directory of the recipient's project.

## Unit test generation

GitHub Copilot app modernization can generate unit tests as a standalone capability, independent of a full upgrade or migration workflow. This is useful when legacy codebases have low or no test coverage, which is common in applications that are candidates for modernization.

You can ask the agent to generate unit tests before starting an upgrade, giving you a baseline to verify that application behavior is preserved after modernization. The agent installs test runners if they aren't already present, generates tests based on the existing code, and runs them to validate the results. 

Generating tests before upgrading is a recommended best practice as it allows you to compare test outcomes before and after the transformation to confirm that the modernized code behaves identically to the original.