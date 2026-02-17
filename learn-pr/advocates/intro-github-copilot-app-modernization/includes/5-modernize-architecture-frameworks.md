Beyond code-level refactoring, application modernization often involves larger changes such as upgrading the platform or framework, rearchitecting for the cloud, migrating databases, and modernizing deployment infrastructure. 

The modernization agent automates framework upgrades with deep knowledge of breaking changes between versions:

- **Java.** Upgrades between Java 8, 11, 17, 21 and 25. Upgrades Spring Boot (up to 3.5), migrates from javax to Jakarta EE (up to Jakarta EE 10), and upgrades Spring Framework (up to 6.2+). The agent uses OpenRewrite recipes for automated API replacements and verifies all changes with build fixes and CVE checks.
- **.NET.** Upgrades from older .NET versions to the latest, including the significant migration from .NET Framework to modern .NET. The agent handles project file format changes, API replacements (for example, System.Web to ASP.NET Core equivalents), and configuration migration.

The GitHub Copilot app modernization agent can also help migrating code that runs in an on-premises environment to Azure. The modernization agent can guide you through replacing on-premises dependencies with cloud-native Azure services using predefined tasks. For example:

- Replacing local file storage with Azure Blob Storage or Azure File Storage.
- Migrating from SQL Server or Oracle on-premises to Azure SQL Database with managed identity authentication.
- Moving from MSMQ or RabbitMQ to Azure Service Bus.
- Replacing SMTP-based email with Azure Communication Service.
- Transitioning from Windows Active Directory to Microsoft Entra ID.
- Migrating logging from log4net or Serilog to OpenTelemetry on Azure.

Each predefined task encodes the Azure best practice for the scenario, applies the necessary code changes, updates configuration files, and validates the result with a build and CVE scan.

GitHub Copilot app modernization is designed to integrate with portfolio assessment tools such as Azure Migrate. In this intended enterprise workflow, Azure Migrate scans the on-premises environment to discover and inventory applications, then evaluates each one for cloud readiness and identifies migration candidates. Once candidates are identified, Azure Migrate can trigger per-application assessments through GitHub Copilot app modernization, which analyzes the code, configuration, and dependencies of each application in detail. The resulting assessment reports, including cloud-readiness scores and dependency maps, can be exported and shared with architects for review. Architects can then assign developers to remediate individual applications using the agent's predefined and custom tasks, creating a continuous pipeline from portfolio-level discovery through to code-level modernization.
