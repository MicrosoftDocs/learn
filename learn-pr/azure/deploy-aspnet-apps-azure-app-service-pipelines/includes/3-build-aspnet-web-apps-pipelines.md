In the past, your company, following Microsoft best practices, has been relying extensively on ASP.NET Model View Controller (MVC) to develop its web apps, using the Entity Framework Code First approach to provide access to SQL Server-based data stores. The apps' code already resides in GitHub repositories, and you just set up an Azure DevOps organization and created your first Azure DevOps project. The next step you're considering is building artifacts that you can then use to deploy the apps to Azure. In this unit, you'll step through the process of setting up an Azure pipeline that will provide this functionality.

## Azure Pipelines ASP.NET web app build tasks

Use the following process to build ASP.NET app artifacts:

1. **Identify and update NuGet package dependencies**: In this task, you retrieve all packages required to perform the build.
1. **Build artifacts**: This generates a compiled app that you can subsequently test and deploy.
1. **Run unit and functional tests**: In this step, you verify functionality of the built app prior to its deployment.
1. **Index source code and publish symbols**: This allows you to debug the app on another computer that doesn't have access to the source code.
1. **Publish build artifacts to a location that you designate**: This makes the artifacts available for subsequent deployment.

While this seems like quite a bit of work, all these steps are readily available in the form of predefined Azure Pipelines tasks. Implementing the corresponding pipeline is even more straightforward, because it requires simply that you select the **ASP.NET** template on which the build pipeline will be based and point to the code repository hosting the app code. When using the classic editor, this results in automatic creation and configuration of the following tasks:

1. **NuGet tool installer** locates, downloads, and caches the version of NuGet you specify and adds it to the *PATH* system environment variable.
1. **NuGet restore** installs and updates NuGet package dependencies.
1. **Visual Studio Build** builds an artifact by using MSBuild and sets the Visual Studio version property.
1. **Visual Studio Test** runs unit and functional tests (such as Selenium, Appium, and Coded UI test) by using the Visual Studio Test runner.
1. **Index sources and publish symbols** indexes your source code and optionally publishes symbols to the Package Management symbol server or a file share you designate.
1. **Publish build artifacts** publishes build artifacts to Azure Pipelines or a file share you designate.

> [!NOTE]
> With the YAML-based approach, you need to add the last two tasks manually, but that's straightforward when using task assistant, as you'll discover in the upcoming exercise.

## Azure Pipelines ASP.NET web app build agents

Azure Pipelines rely on build agents to perform the build process. While you could potentially set up your own agents, it's considerably easier to use Microsoft-hosted agents for this purpose. Azure Pipelines offers the following versions of agents with pre-installed Visual Studio:

- **windows-2019**: based on Windows Server 2019 with Visual Studio 2019
- **vs2017-win2016**: based on Windows Server 2016 with Visual Studio 2017

> [!NOTE]
> Using self-hosted agents might be beneficial when running multiple builds against large code repositories, because Microsoft-hosted agents don't support caching between builds.
