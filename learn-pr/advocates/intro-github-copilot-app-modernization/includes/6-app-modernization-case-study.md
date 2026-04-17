Imagine you have a legacy web application built on .NET Framework 4.8 and you want to modernize it to .NET 10, the current long-term support version. This upgrade involves substantial project file changes, API replacements, configuration migration, and deployment updates.

You could accomplish this goal with GitHub Copilot App Modernization by performing the following general steps.

You start by performing an assessment:

1. Open the solution in Visual Studio 2026 (or VS 2022 v17.14.17+).
1. Right-click the solution in Solution Explorer and select **Modernize**, or open Copilot Chat and type _@modernize upgrade to .NET 10_.
1. The agent prompts you to create a new branch. After confirmation, it begins the assessment stage.
1. The agent generates an _assessment.md_ file under _.github/upgrades_ listing breaking changes, incompatible APIs (such as System.Web.HttpContext), deprecated NuGet packages, and the overall upgrade scope.

Next you move on to planning:

1. You review the assessment. When you're happy with the assessment, you confirm to proceed.
1. The agent generates a _plan.md_ file detailing every change: converting the .csproj to SDK-style format, replacing old ASP.NET Membership authentication with ASP.NET Core Identity, updating _[OutputCache]_ attributes to _[ResponseCache]_ with the required middleware, migrating from web.config to appsettings.json, and more.
1. Each planned change references the specific files and APIs affected.

Now that the modernization plan is created, you move on to the implementation phase. In this phase the agent works through the plan sequentially, applying code changes using AI-powered transformation, and OpenRewrite recipes.

For example, it might replace _HttpContext.Current_ with dependency-injected _IHttpContextAccessor_, updates Entity Framework to Entity Framework Core, and converts the Dockerfile to use the _mcr.microsoft.com/dotnet/aspnet:10.0_ base image.

After each batch of changes, the agent automatically builds the project. If a compilation error occurs (for example, a missing namespace), the agent diagnoses the error and resolves it. Next the agent runs a CVE scan and updates any NuGet packages with known vulnerabilities. Finally, if unit tests exist, the agent runs them. If tests fail due to changed APIs, it updates the tests. If test coverage is low, it can generate additional tests.

Once the upgrade is complete, you can ask the agent to deploy the application to Azure. It can generate Infrastructure as Code files for Azure App Service, containerize the application, and set up CI/CD pipelines. All of this can be done from within your IDE.

GitHub Copilot app modernization has the agent handle specific tasks while the developer provides oversight, reviewing and confirming movement through the app modernization phases.

| **Agent handled automatically** | **Developer reviewed and confirmed** |
|---|---|
| **Project file conversion to SDK-style .csproj** | Overall assessment and plan before execution |
| **API replacement (System.Web → ASP.NET Core)** | Business logic changes requiring domain knowledge |
| **NuGet package upgrades and CVE remediation** | Authentication strategy |
| **Build error diagnosis and fix** | Test results and edge cases |
| **Dockerfile and deployment artifact generation** | Final deployment configuration |
