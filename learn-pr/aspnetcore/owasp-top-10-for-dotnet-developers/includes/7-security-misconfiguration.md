
Highly configurable and distributed software, along with supporting services and tooling, introduces complexity. Increased complexity also increases the attack surface by introducing more components that should be secured. Security misconfigurations can occur when an application is missing the appropriate security hardening across any part of the application stack. It can manifest itself by reusing passwords or improperly configuring permissions on cloud services.

### Security hardening

The application might be vulnerable if it's missing a rigorous, repeatable application security configuration process.

The following image shows a typical enterprise-scale application with supporting DevOps process. Here, security misconfiguration can apply to how you protect developer workstations, handle app secrets in your application, protect the CI/CD process, and so on.

:::image type="content" source="../media/enterprise-app-threats.png" alt-text="Diagram showing angles of attack in complex system.":::

Security misconfiguration can manifest itself in many places, from `web.config` or `appsettings.json` settings, a database account, connectivity, or Internet Information Services (IIS) configurations. The automation workflows and cloud hosting can be misconfigured or abused too. A CI/CD system could be storing plain-text environment credentials for release. A cloud environment could be using managed shared admin accounts instead of following the least-privileged principle. In the world of Microsoft cloud, Azure role-based access control offers granular control over permissions granted to users and cloud services.

:::image type="content" source="../media/pipeline.png" alt-text="Screenshot showing Azure DevOps Library linked with Azure KeyVault.":::

The preceding example demonstrates one of many native integrations between Azure DevOps and Azure Cloud, where Azure DevOps Library is linked with Azure KeyVault to securely access secret pipeline parameters.

Secret values should never be found in a codebase. The same practice applies to infrastructure as code (IaC) release workflows and CI/CD services themselves.

As the new addition to the team, be on the lookout for default accounts and their passwords being enabled and unchanged. Use secure settings for your application servers, frameworks, libraries, and databases. As you familiarize yourself with your team's codebase, take this opportunity to remove any unused features, components, accounts, or services from your applications.

### Code review notes

As you review the code, configuration, and deployment settings, you notice a separate set of credentials and configuration for development, QA, and production environments. Your web app takes advantage of Azure KeyVault for storing and rotating secrets like connection strings and API keys. You also notice a lack of any Dynamic Application Security Testing (DAST) pipeline tasks that can help with detecting misconfigurations. You're planning to explore Azure Marketplace for potential tools.

Security is everyone's responsibility; shared between the cloud provider and you, application developers and architects.
