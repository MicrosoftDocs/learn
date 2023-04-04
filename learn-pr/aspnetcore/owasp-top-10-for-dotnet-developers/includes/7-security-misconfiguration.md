<!-- ## A05: Security Misconfiguration -->

Highly configurable and distributed software, along with supporting services and tooling, introduces complexity. Example of an eterprise application with supporting DevOps process can be seen on the image below. Here, security misconfiguration can apply to how you protect developer workstations, handle app secrets in your application, protect the CI/CD process etc.

### Security Hardening
At enterprise, and in matter of fact any, scale, security misconfiguration  can occur when an application is missing appropriate security hardening across any part of the application stack or improperly configured permissions on cloud services.

:::image type="content" source="../media/enterprise-app-threats.png" alt-text="angles of attack in complex system":::

The application might be vulnerable if the application is without a rigorous repeatable application security configuration process.

Security misconfiguration can manifest itself in many places, from `web.config` or `appsettings.json` settings, database account and connectivity configuration, IIS configurations to CI/CD pipeline secret handling or incorrect Azure Role Base Access Control use.

:::image type="content" source="../media/pipeline.png" alt-text="Azure DevOps Library linked with Azure KeyVault":::

The example above demonstrates one of many native integrations between Azure DevOps and Azure Cloud where Azure DevOps Library is linked with Azure KeyVault to securely access secret pipeline parameters.
Secret values should never be found in codebase. The same practice applies to infrastructure as code (IaC) release workflows and CI/CD services themselves.

As the new addition to the team, be on a lookout for default accounts and their passwords being enabled and unchanged. Use secure settings for your application servers, frameworks, libraries and databases. As you familiarize yourself with your team's codebase take this opportunity to remove any unused features, components, accounts or services from your applications.


### Code Review Notes

As you review the code, configuration and deployment settings you noticed separate set of credentials and configuration for development, QA and production environments. Your web app takes advantage of Azure KeyVault for storing, and if need be rotating, secrets like connection strings and API keys. You also noticed lack of any e Dynamic Application Security Testing (DAST) pipeline tasks that can help with  detection of misconfigurations. You're planning to explore Marketplace for potential tools.
