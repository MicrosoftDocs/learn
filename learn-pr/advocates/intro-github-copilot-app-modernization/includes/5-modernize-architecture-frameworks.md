Beyond code-level refactoring, application modernization can involve platform upgrades, cloud architecture, database migration, and deployment infrastructure. Treat these as related but distinct decisions.

## Upgrade compatible framework versions

Apply the version and compatibility guidance for your application's platform:

- **Java.** The current upgrade quickstart supports JDK targets 11, 17, 21, and 25; Spring Boot up to 4.0; Spring Framework up to 7.x; and Jakarta EE up to 11. Select a compatible combination and check its vendor support lifecycle. Only affected enterprise `javax` APIs move to `jakarta`; Java SE APIs such as `javax.sql` remain unchanged. Review OpenRewrite and AI-assisted transformations, build results, enabled tests, and dependency CVE findings.
- **.NET.** Upgrade older .NET applications or modernize supported .NET Framework applications. Review project-file changes, incompatible APIs, hosting, authentication, and configuration. Optional changes such as an EF6-to-EF-Core port are separate strategy decisions, not prerequisites for every runtime upgrade.

## Separate application changes from service migration

Predefined tasks can help adapt code for Azure services. Choose a target based on the application's behavior:

- **Storage.** Azure Files provides managed file shares; Azure Blob Storage provides object storage. Blob operations aren't a drop-in implementation of every local filesystem operation.
- **Databases.** Update compatible application data-access code for Azure SQL Database, Azure SQL Managed Instance, or Azure Database for PostgreSQL. An Oracle-to-SQL migration also needs database compatibility assessment and schema/data conversion; a connection-string change doesn't perform that work.
- **Messaging.** Adapt code for Azure Service Bus when moving from MSMQ, RabbitMQ, or another broker. Review settlement, retries, dead-lettering, transactions, and duplicate processing. For ordered processing of related messages, use sessions in the Standard or Premium tier and session-aware senders and receivers with a shared `SessionId`. Enable sessions when creating the destination queue or subscription; this setting can't be changed after creation. An existing non-session queue or subscription needs a replacement session-enabled entity and a planned cutover. Process each session's messages serially, or otherwise enforce application ordering; concurrent handlers can complete out of order. Sessions don't establish global ordering across unrelated sessions. PeekLock delivery can redeliver messages, so consumers must handle duplicates.
- **Email.** Choose a supported destination by scenario: Microsoft 365 High Volume Email (HVE) for operational messages within the tenant, Exchange Online for appropriate mailbox-based mail within its limits, or a Marketplace provider such as Infobip or Telesign for application-to-person or bulk delivery. HVE doesn't serve external recipients, and Exchange Online isn't a general bulk-email replacement. Review sender/domain verification, permissions, quotas, delivery behavior, and the destination's supported SMTP or API integration.
- **Identity.** Adapt application authentication to Microsoft Entra ID and authorize application identities to use the target services. This doesn't replace AD DS domain services, Group Policy, or every LDAP/Kerberos dependency; assess those separately. Managed identity removes the need to manage an application credential, but doesn't automatically grant access to data.
- **Observability.** Add OpenTelemetry instrumentation and configure export to Application Insights through Azure Monitor. This doesn't inherently require removing every existing logging abstraction; review collection, correlation, export, and duplicate telemetry.
- **Caching.** Use Azure Managed Redis as the target for a reviewed caching migration. Match the endpoint and TLS configuration to the new service, check clustering and command compatibility, and authorize the application's identity. Microsoft Entra token authentication requires renewal before expiry; for .NET, `Microsoft.Azure.StackExchangeRedis` can manage token refresh. Decide whether to preserve existing cache data or repopulate it, and rehearse the endpoint cutover.

For an HVE destination, confirm that the tenant uses Microsoft 365 Worldwide (standard multitenant). The HVE account doesn't require a Microsoft 365 license, but tenant billing requires at least one SharePoint license or a license that includes SharePoint. Use an Azure subscription in the same tenant and a resource group in that subscription. To configure Microsoft 365 pay-as-you-go billing, work with a Billing Administrator or another supported Microsoft 365 administrative role, with Owner or Contributor access to the Azure subscription and resource group. These are billing-setup permissions, not permissions to grant the sending application.

Create a billing policy and connect it to **High Volume Email** under **Billing** > **Pay-as-you-go** > **Services** in the Microsoft 365 admin center. Assign that policy to the dedicated HVE account, and confirm that its billing-related **Account status** is **Active** in the Exchange admin center before sending. Creating a policy alone isn't sufficient: a disconnected policy, inactive subscription, or missing tenant SharePoint license can prevent billing validation.

Configure `smtp.hve.mx.microsoft` on port `587` with STARTTLS, preferably using OAuth under your organization's policy. HVE accounts don't have receiving mailboxes; set a Reply-To address to a monitored mailbox if replies are needed.

> [!NOTE]
> Code modernization doesn't by itself complete a database or service cutover. Plan target provisioning, schema/data transfer, permissions, connectivity, validation, rollback, and cutover separately. Use the migration tools supported for the source/target pair, such as Azure Database Migration Service for supported SQL migrations.

Review the generated code and its build/test results, then exercise the integration against a representative target environment. A dependency CVE check doesn't validate database contents, access policies, message delivery, or production capacity.

## Connect portfolio assessment to application work

Azure Catalyst's code-insights integration is in preview. It combines portfolio discovery with GitHub Copilot modernization assessments for ASP.NET and Java web apps. Supported hosting targets include App Service, Container Apps, and AKS. Confirm that your organization's policies permit using this preview integration before uploading assessment reports.

For the at-scale assessment route, start with a project that has discovered the applications and web apps. Install Azure CLI, Modernize CLI, and its required GitHub CLI, and use an account with access to the source repositories and permission to add code insights. The documented built-in role is still named **Azure Migrate Decide and Plan Expert**; assign it, or a role with the required permissions, at the project's resource-group or subscription scope. Then follow these steps to connect the assessment results:

1. In the portfolio inventory or assessment, select the applications or web apps, then **Add code insights** > **GitHub Copilot modernization**.
1. Download the at-scale assessment configuration and complete the application-to-repository mapping. Preserve its generated output configuration.
1. Authenticate with `gh auth login` and `az login`, then run `modernize assess --source <configuration-file>`.
1. After a successful assessment, review the reports uploaded and mapped back to the portfolio project. Recalculate existing assessments to incorporate the new code insights; automatic report upload doesn't recalculate them.
1. Have architects review readiness and prioritize work, then assign developers to execute reviewed per-application modernization plans.

Code insights aren't currently supported through private endpoints. Portfolio discovery doesn't automatically authorize source-code changes or production deployment; assessment, remediation, and release remain separate decisions.
