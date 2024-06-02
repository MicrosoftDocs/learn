.NET Aspire can be broken down into solutions for three issues that face modern cloud-native apps. These are:

1. Managing the complexity of orchestration between microservices.
1. Simplifying how your microservices use components through NuGet packages.
1. Supporting developer velocity through tooling and templates.

In this unit, see how using .NET Aspire orchestration brings benefits to your existing cloud-native apps. Then see how to enroll your app in .NET Aspire orchestration and examine the changes made to your solution.

## Benefits of .NET Aspire orchestration

Orchestration is the coordination and management of the various services within a cloud-native app. .NET Aspire provides abstractions for managing your solution's service discovery, environment variables, and container configurations. These abstractions also provide consistent setup patterns across apps with many components and services.

:::image type="content" source="../media/app-host-resource-diagram.png" alt-text="A diagram showing the relationship between the .NET Aspire AppHost project and the other services in an app." border="false":::

.NET Aspire has three base compute types it supports with orchestration:

- **ProjectResource**: A .NET project, such as ASP.NET Core web apps.
- **ContainerResource**: A container image, such as a Docker image containing Redis.
- **ExecutableResource**: An executable file.

Compare .NET Aspire with how you manage service discovery using Docker Compose. Docker Compose is excellent but starts to become unproductive when all you need to do is run several projects or executables. You need to build container images, compose the YAML to connect them, and then run apps inside of containers. Also, there are environment variable replacements (and includes) and no IntelliSense, and it's hard to determine what exactly is running and why. Debugging can also be difficult.

Configuration through declarative code is better. Using .NET Aspire, you don't need to learn anything beyond what you already know. .NET Aspire is a better experience that's easy to get started with and scales up to an orchestrator like Docker Compose using a real programming language.

.NET Aspire orchestration also supports your development in the following ways:

- **App composition**: .NET Aspire specifies the .NET projects, containers, executables, and cloud resources that make up the application.
- **Service discovery and connection string management**: The app host manages injecting the right connection strings and service discovery information to simplify the developer experience.

## Enlisting an existing app in .NET Aspire orchestration

Visual Studio provides menus to enlist an existing project in .NET Aspire orchestration.

:::image type="content" source="../media/visual-studio-add-aspire-orchestrator.png" alt-text="A screenshot of the Add menu showing the .NET Aspire Orchestrator Support highlighted.":::

The first time you add orchestration to your solution a dialog asks for the project name prefix and explains that the .NET Aspire **AppHost** and **ServiceDefaults** projects are added. When you add more projects to an already orchestrated solution, the dialog notifies you that the **AppHost** project is updated to include those projects.

If you're creating a new project, during the new project workflow, Visual Studio asks if you want to enlist in .NET Aspire orchestration.

:::image type="content" source="../media/aspire-enlist-orchestration.png" alt-text="A screenshot of the new project workflow showing the Enlist in Aspire orchestration option highlighted.":::

## Changes Aspire makes to an existing solution

When you add .NET Aspire orchestration to your solution, the following changes happen:

- An **AppHost** project is added. The project contains the orchestration code. It becomes the entry point for your app and is responsible for starting and stopping your app. It also manages the service discovery and connection string management.
- A **ServiceDefaults** project is added. The project configures OpenTelemetry, adds default health check endpoints, and enables service discovery through `HttpClient`.
- The solution's default startup project is changed to **AppHost**.
- Dependencies on the projects enrolled in orchestration are added to the **AppHost** project.
- The .NET Aspire Dashboard is added to your solution, which enables shortcuts to access all the project endpoints in your solution.
- The dashboard adds logs, traces, and metrics for the projects in your solution.

If you add orchestration to a web app project, .NET Aspire automatically adds a reference to the **ServiceDefaults** project. It then makes the following changes to the code in *Program.cs*:

- Adds a call to `AddServiceDefaults` that enables the default OpenTelemetry, meters, and service discovery.
- Adds a call to `MapDefaultEndpoints` that enables the default endpoints, such as `/health` and `/alive`.
