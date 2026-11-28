Imagine you're modernizing a C# ASP.NET MVC 5 web application from .NET Framework 4.8 to ASP.NET Core on .NET 10, a long-term support release. This involves more than retargeting the project: hosting, request handling, configuration, authentication, and dependencies need review. A Web Forms application would require a different conversion, such as the documented Web Forms-to-Blazor scenario.

## Prepare and assess

Use Windows and Visual Studio 2026, version 18.0 or later, with the .NET 10 SDK. In Visual Studio Installer, enable the **.NET desktop development** workload and its **GitHub Copilot** and **GitHub Copilot app modernization** optional components, plus **ASP.NET and web development**. Install the .NET Framework targeting pack and other components required to build the original solution. If you use Copilot Free, use Visual Studio 2026 version 18.1 or later. Sign in with the GitHub account that has Copilot access, restore dependencies, and establish a successful baseline build and reviewed test results. Save existing work and use a dedicated Git branch.

> [!NOTE]
> Modernization availability in Visual Studio 2022 17.14.17 or later doesn't mean that IDE supports targeting .NET 10. This Visual Studio-based example requires Visual Studio 2026/18.0 or later. Building with a separately installed .NET CLI has different tooling compatibility rules.

Start the assessment without authorizing an immediate production migration:

1. Open the solution and select **Modernize** from its **Solution Explorer** context menu, or enter `@Modernize upgrade this ASP.NET MVC application to ASP.NET Core on .NET 10` in Copilot Chat.
1. Confirm the target, branching strategy, and guided workflow so that you can review stage transitions.
1. Review `assessment.md` under `.github\upgrades\<scenarioId>\`. Confirm that it covers the application's `System.Web` usage, package compatibility, deployment dependencies, and business-critical behavior.
1. Review the proposed strategy in `upgrade-options.md`, including in-place versus side-by-side migration and optional technology changes.

## Review the plan's behavioral decisions

Ask the agent to create `plan.md`, then review the affected files and APIs. In particular:

- **Projects and configuration.** Review SDK-style project conversion and the new hosting model. Move application settings to the appropriate ASP.NET Core configuration providers, but retain or generate any `web.config` required for IIS hosting. Don't copy secrets into source-controlled settings.
- **Authentication.** Choose a suitable identity design rather than assuming an ASP.NET Membership database becomes ASP.NET Core Identity automatically. Plan account, password, role, and authorization behavior explicitly. Password formats aren't automatically interchangeable; choose a reviewed transition, such as password reset, and test existing-user sign-in. An older migration sample isn't a ready-made .NET 10 conversion script.
- **Caching.** `[ResponseCache]` configures HTTP caching headers; it isn't an equivalent replacement for server output caching. If the application needs server-controlled response storage, use ASP.NET Core output caching: register `builder.Services.AddOutputCache()`, add `app.UseOutputCache()` after routing, CORS, authentication, and authorization middleware when present, and opt selected endpoints in with `[OutputCache]` or an output-cache policy. Review expiration, invalidation, cache-key variation, and personalized responses. The default policy excludes authenticated requests and responses that set cookies; don't override these protections just to reproduce an old attribute.
- **Request context.** Use the controller's `HttpContext` where available. For a custom service that needs request context, register `builder.Services.AddHttpContextAccessor()` and inject `IHttpContextAccessor`. Its `HttpContext` can be null outside a request and isn't thread-safe. Pass copied values to background work rather than retaining the request context.
- **Data access.** Decide whether to retain EF6 with compatible packages/providers or separately port to EF Core. EF6 supports modern .NET; EF Core isn't a drop-in replacement. A port requires model, query, transaction, and behavior validation, even when the code compiles. Existing EF6 migrations aren't directly reusable as EF Core migrations. Confirm which schema changes are already applied and establish a reviewed EF Core migration baseline before generating further schema changes.

These are application-specific decisions, not a guaranteed list of automatic replacements. Confirm the plan before execution.

## Execute and evaluate the result

The .NET agent executes the approved plan using its upgrade skills and tracks progress in `tasks.md`. Review build results, dependency CVE findings, and test execution. If the agent can't resolve a problem, address it before continuing. Review changes to tests carefully: adapting a test to a new API is different from weakening its assertion to conceal a regression.

After the upgrade, run the full relevant test suite and exercise authentication, caching, database access, and external integrations. Record unresolved failures and vulnerabilities as release blockers or explicit risk decisions.

If containerization is appropriate, generate a Dockerfile for the upgraded application. For example, `mcr.microsoft.com/dotnet/aspnet:10.0` is an ASP.NET Core runtime image, not an SDK/build image. Build and publish with compatible SDK tooling, select an appropriate OS/image variant, and validate the container before deployment.

For Azure deployment, first confirm the subscription, resource group, required permissions, compatible hosting configuration, and costs. Ask the agent to generate and review infrastructure as code and deployment/CI/CD assets. Deploy to a nonproduction environment, validate operational behavior, and approve a rollback-capable production release separately.

The following table distinguishes the agent's assistance from the decisions you retain.

| Agent assistance | Developer decision |
| --- | --- |
| Project and API transformations | Approve scope and business-logic changes |
| Package updates and dependency CVE fixes | Review compatibility and unresolved vulnerabilities |
| Build fixes and test changes | Confirm assertions, results, and edge cases |
| Authentication and data-access migration suggestions | Approve identity design and optional EF port |
| Container and deployment artifact generation | Approve resources, permissions, cost, and release |
