This module explores how to use ASP.NET Core Identity to support authentication and authorization in an ASP.NET Core Razor Pages web app.

> [!NOTE]
> This module uses the [.NET CLI (command line interface)](/dotnet/core/tools/) and [Visual Studio Code](https://code.visualstudio.com) or [GitHub Codespaces](https://github.com/features/codespaces). After completing this module, you can apply its concepts using a development environment like Visual Studio (Windows), Visual Studio for Mac (macOS), or continue development using Visual Studio Code (Windows, Linux, and macOS).

In this module, you will:

* Configure Identity support in an existing ASP.NET Core web app.
* Provide new user registration capabilities.
* Extend Identity UI components.
* Customize multi-factor sign-in capabilities.
* Implement policy-based authorization using claims.
* Customize and extend the underlying Identity data store.

## Prerequisites

* Experience writing C# at the beginner level
* Experience using relational databases and SQL as a developer
* Familiarity with Entity Framework (EF) Core migrations
* Ability to write Razor at the beginner level
* Familiarity with a time-based one-time password (TOTP) authenticator app, such as Microsoft Authenticator (available in the [Google Play Store](https://play.google.com/store/apps/details?id=com.azure.authenticator) or the [Apple App Store](https://apps.apple.com/app/microsoft-authenticator/id983156458))

## Required tools

It is recommended that you complete this module in [GitHub Codespaces](https://github.com/features/codespaces). No tools are required, but you need a free GitHub account.

If you prefer to use a local development environment, you use the same Dev Container as GitHub Codespaces by installing the following tools:

* [Visual Studio Code](https://code.visualstudio.com) with the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.
* [Docker Desktop](https://www.docker.com/products/docker-desktop/), [Rancher Desktop](https://rancherdesktop.io/), or similar

Finally, if you prefer to use no containerization, you must install the following tools:

* [Visual Studio Code](https://code.visualstudio.com)
* [.NET 8 SDK](https://dotnet.microsoft.com/download)
* [SQL Server Express LocalDB](/sql/database-engine/configure-windows/sql-server-express-localdb)
* [Git](https://git-scm.com/docs/gitcli)

## Get started

In the next unit, you'll learn about ASP.NET Core Identity architecture.
