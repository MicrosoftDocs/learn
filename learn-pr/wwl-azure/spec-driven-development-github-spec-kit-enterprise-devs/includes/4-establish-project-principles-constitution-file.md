The constitution file is the foundation of spec-driven development with GitHub Spec Kit. It captures non-negotiable principles, constraints, and standards that govern your project. By defining these items upfront, you ensure every specification, plan, and implementation adheres to organizational requirements automatically.

## Purpose of the constitution

In Spec-Driven Development, the constitution (constitution.md) serves as your project's immutable rule set. It documents what must always be true, regardless of which features you build or how requirements evolve.

Think of the constitution as guardrails for AI-assisted development. When GitHub Copilot generates a technical plan or code, it references the constitution to verify proposals comply with your standards. If the constitution states "All data must be encrypted at rest," GitHub Copilot doesn't suggest storing files in plaintext—it automatically incorporates encryption into designs.

The constitution addresses several critical needs:

- **Consistency enforcement**: Projects spanning months or involving multiple developers can drift from architectural decisions. The constitution ensures alignment by encoding standards that AI assistants always reference.

- **Compliance documentation**: Regulatory requirements, security policies, and internal governance rules must be followed. The constitution makes requirements explicit, creating an auditable record of how you enforce compliance.

- **Institutional knowledge capture**: Experienced architects and security teams make decisions based on hard-won lessons. The constitution preserves this wisdom in a form that guides AI code generation, preventing repeatedly rediscovering the same constraints.

- **Reduced cognitive load**: Developers don't need to remember every organizational standard while prompting AI. The constitution automates enforcement of policies like "use Azure Key Vault for secrets" or "authenticate via Microsoft Entra ID."

In enterprise development environments, constitutions often encode:

- Security requirements mandated by corporate policies.
- Performance and scalability targets for enterprise workloads.
- Technology choices aligned with Azure services and internal tooling.
- Coding standards and architectural patterns from engineering best practices.
- Compliance obligations like General Data Protection Regulation (GDPR), accessibility standards, or audit requirements.

## Structure of an effective constitution

A well-structured constitution organizes principles into categories that AI assistants can easily reference.

Common sections include:

- Technology standards.
- Security requirements.
- Performance and scalability.
- Coding standards.
- Compliance and governance.

The following sections illustrate how to define each category effectively.

### Technology standards

Technology standards are used to specify approved technologies, platforms, and frameworks.

For example, the following section mandates Azure services and .NET for backend development:

```markdown
## Technology Standards

- All cloud resources must be hosted on Microsoft Azure.
- Backend services use .NET 8 or later.
- Frontend applications use React or Blazor.
- Database: Azure SQL Database or Cosmos DB (no on-premises SQL Server).
- Secret management exclusively via Azure Key Vault.
```

These constraints prevent AI from suggesting incompatible technologies. If the constitution mandates Azure, GitHub Copilot doesn't propose Amazon Web Services Lambda functions.

### Security requirements

Security requirements can be used to define things like authentication, authorization, encryption, and data protection rules.

For example, the following section establishes security principles for an internal application:

```markdown
## Security Requirements

- Authenticate all API requests using Microsoft Entra ID tokens.
- Encrypt all data at rest using AES-256 encryption.
- Encrypt data in transit using TLS 1.2 or higher.
- Never log personally identifiable information (PII).
- Store no secrets in source code or configuration files.
- Implement role-based access control (RBAC) for all features.
```

Security principles are critical for enterprise development. Explicit requirements ensure generated code incorporates security from the start.

### Performance and scalability

Performance and scalability requirements are used to set expectations for system behavior under load.

For example, the following section defines performance targets for an API:

```markdown
## Performance and Scalability

- APIs must respond within 200ms for 95th percentile requests.
- System must handle 10,000 concurrent users.
- Use asynchronous processing for operations exceeding 5 seconds.
- Implement caching for frequently accessed data.
- Design for horizontal scalability using Azure App Service or Container Apps.
```

Performance requirements guide architectural decisions. If the constitution requires handling large file uploads asynchronously, the plan incorporates background processing.

### Code standards and guidelines

Standards and guidelines provide requirements that help to ensure code quality.

For example, the following section outlines coding conventions for a .NET project:

```markdown
## Coding Standards

- Follow Microsoft C# Coding Conventions.
- Maintain minimum 80% unit test coverage.
- All public APIs documented with XML comments.
- Use dependency injection for service dependencies.
- Implement structured logging using ILogger interface.
```

Coding standards ensure consistency across the codebase. AI-generated code aligns with team conventions when the constitution references them.

### Compliance and governance

Compliance and governance requirements are used to document regulatory and internal policy requirements.

For example, the following section captures compliance principles for data handling:

```markdown
## Compliance and Governance

- Comply with GDPR for all user data processing.
- Implement audit logging for all data modifications.
- Support accessibility standards (WCAG 2.1 Level AA).
- Enable monitoring and alerting via Azure Application Insights.
- Retain logs for minimum 90 days for compliance audits.
```

Compliance principles protect your organization from regulatory violations. The constitution ensures these principles aren't forgotten during development.

## Create the constitution with GitHub Spec Kit

GitHub Spec Kit's `/speckit.constitution` command can be used to create or update a constitution file.

### Existing projects

When you're working on an existing project that already includes a constitution file, you can update the constitution using the `/speckit.constitution` command. GitHub Copilot reviews the existing constitution and suggests updates based on your codebase. Updates to the GitHub Spec Kit itself can also be reflected in the suggested changes.

When you're adding GitHub Spec Kit to an existing project that doesn't yet have a constitution, you can generate one using the `/speckit.constitution` command in GitHub Copilot Chat. GitHub Copilot reviews the existing codebase and infers project principles and constraints to create an initial `constitution.md` file. If necessary, you can refine the generated constitution to ensure it accurately reflects your project's requirements.

### New projects

When you're starting a new project using GitHub Spec Kit, you can generate a constitution from scratch using the `/speckit.constitution` command in GitHub Copilot Chat.

To create the constitution for a new project:

1. Open your project in Visual Studio Code and ensure that GitHub Spec Kit is initialized.

1. Open GitHub Copilot Chat, and then run the `/speckit.constitution` command with a natural language description of your project principles and constraints.

    For example, you might provide the following prompt:

    ```plaintext
    /speckit.constitution Create principles focused on code quality, testing standards, user experience consistency, and performance requirements. Include governance for how these principles should guide technical decisions and implementation choices.
    ```

    GitHub Copilot generates a structured `constitution.md` file with sections organized by category.

### Refine the generated constitution

After GitHub Copilot generates the initial constitution, review and edit it to ensure accuracy.

Consider the following steps:

- **Add missing principles**: If GitHub Copilot omitted important requirements, add them manually. For instance, if your organization requires specific logging formats, add that constraint.

- **Remove unnecessary content**: GitHub Copilot might generate boilerplate or overly generic principles. Delete anything that doesn't provide concrete guidance.

- **Make principles specific and testable**: Replace vague statements with measurable criteria. Change "system should be fast" to "API responses complete within 200 ms for 95% of requests."

- **Align with internal standards**: Reference existing documents when possible. For example: "Follow the Engineering Excellence guidelines v2.3 for API design."

- **Verify with stakeholders**: Share the constitution with security, compliance, and architecture teams to confirm it captures all necessary requirements.

The constitution is a living document, but it changes infrequently. Once established, it provides stable guidance across feature development.

## Constitution in the Spec-Driven Development workflow

After you create the constitution, GitHub Spec Kit automatically references it during subsequent workflow phases:

- **Specification phase**: When you run `/speckit.specify` to create feature specs, GitHub Copilot checks the constitution to ensure requirements don't violate established principles. If the spec proposes storing files locally, GitHub Copilot flags this conflict with the constitution's Azure Blob Storage mandate.

- **Planning phase**: The `/speckit.plan` command generates technical plans that explicitly verify compliance with constitution requirements. The plan includes sections showing how the design satisfies each relevant principle.

- **Analysis phase**: Running `/speckit.analyze` compares your spec, plan, and tasks against the constitution, identifying inconsistencies. For example, if tasks include implementing username/password authentication but the constitution requires Microsoft Entra ID, analysis catches this deviation.

- **Implementation phase**: When you generate code with `/speckit.implement`, GitHub Copilot produces implementations honoring constitution constraints. Code automatically includes Microsoft Entra ID authentication if mandated by the constitution.

This integration is why the constitution is so powerful—write principles once, and AI automatically enforces them throughout development.

## Enterprise-specific constitution considerations

When creating constitutions for enterprise internal projects, incorporate these common requirements:

- **Azure-first architecture**: Mandate Azure services for hosting, storage, databases, and supporting infrastructure. This requirement aligns with corporate cloud strategy and available tooling.

- **Enterprise authentication**: Require Microsoft Entra ID for authentication and RBAC for authorization. Most enterprise internal apps integrate with corporate identity systems.

- **Security and compliance**: Reference enterprise security policies, TrustWorthy Computing principles, and applicable compliance frameworks.

- **Monitoring and observability**: Mandate Azure Application Insights or equivalent monitoring solutions. Enterprise applications need comprehensive telemetry for production support.

- **Developer tooling standards**: Specify approved frameworks, libraries, and development practices. For example, require use of approved NuGet packages from internal feeds.

- **Accessibility**: Include WCAG 2.1 Level AA compliance requirements. Enterprise internal tools must be accessible to employees with disabilities.

Example enterprise internal constitution snippet:

```markdown
# Employee Portal Constitution

## Azure Platform Standards
- Host all services on Azure App Service or Azure Container Apps
- Use Azure Blob Storage for document storage
- Database: Azure SQL Database or Cosmos DB
- Secrets stored exclusively in Azure Key Vault
- Use Azure Front Door for global distribution

## Identity Integration
- Authenticate via Microsoft Entra ID using OAuth 2.0 / OpenID Connect
- Implement role-based access control using Microsoft Entra ID groups
- Support multi-factor authentication (MFA)
- No custom authentication or local user databases

## Corporate Compliance
- Follow enterprise Security Development Lifecycle (SDL) practices
- Scan all dependencies for known vulnerabilities
- Implement audit logging per enterprise retention policies
- Support data residency requirements for EU users (GDPR)
- Accessibility: WCAG 2.1 Level AA minimum

## Development Standards
- Backend: .NET 10 following coding conventions adopted by the organization
- Use approved packages from internal NuGet feed
- Minimum 80% code coverage with unit tests
- All APIs documented with OpenAPI/Swagger
- Structured logging using ILogger interface
```

By establishing these principles upfront in the constitution, you ensure every feature built for the employee portal automatically aligns with enterprise engineering standards, security requirements, and architectural patterns. The constitution transforms organizational knowledge into executable constraints that guide AI-assisted development.

## Summary

The constitution file is a critical artifact in spec-driven development with GitHub Spec Kit. It captures immutable project principles, constraints, and standards that govern every phase of development. By defining these requirements upfront, you enable GitHub Copilot to automatically enforce compliance throughout specification, planning, analysis, and implementation.
