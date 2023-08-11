In this module, you'll create a cross-platform ASP.NET Core Razor Pages web app with .NET and C#.

## Example Scenario

Suppose you're an employee of a pizza company named Contoso Pizza. Your manager has asked you to develop a pizza inventory management page as a prerequisite for the company's internal admin website. The app should be built in such a way that the view and data model concerns are separated.

## What will you be doing?

In this module, you will:

- Understand when and why to use Razor Pages for your ASP.NET Core app.
- Review an existing ASP.NET Core app that uses Razor Pages.
- Create a new Razor Page that supports the app's product data management requirements.
- Use tag helpers to reduce the context switching between HTML and C#.
- Use Razor Page handlers to handle HTTP requests.

At the end of this module, there are links to content providing deeper dives for each feature area introduced.

## Required tools

This module uses the [.NET CLI](/dotnet/core/tools/) and [Visual Studio Code](https://code.visualstudio.com/) (Windows, Linux, and macOS) to demonstrate ASP.NET Core Razor Pages development. After completing this module, you can apply its concepts using a development environment like Visual Studio (Windows), Visual Studio for Mac (macOS), or Visual Studio Code.

> [!TIP]
> You can skip installing the tools below by using GitHub Codespaces as your IDE. In another browser tab, navigate to the [GitHub repository containing the starter app for this module](https://github.com/MicrosoftDocs/mslearn-create-razor-pages-aspnet-core), select the **Code** button, and create a new codespace on the `main` branch. For more information, see [Create a Codespace](https://docs.github.com/github/developing-online-with-codespaces/creating-a-codespace).
>
> Alternatively, you can use the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension for Visual Studio Code. With the extension installed, press **F1** to open the command pallette, then search for and select **Dev Containers: Clone Repository in Container Volume** and provide the URL `https://github.com/MicrosoftDocs/mslearn-create-razor-pages-aspnet-core`. This will clone the repository and open it in a container with all the required tools installed.

The following tools are required:

### .NET SDK

[!include[](../../../includes/dotnet7-sdk-version.md)]

### GitHub CLI

To clone the sample app from GitHub, you'll need the [GitHub CLI](https://cli.github.com/).

### Visual Studio Code

Ensure you have latest versions of [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp&azure-portal=true).
