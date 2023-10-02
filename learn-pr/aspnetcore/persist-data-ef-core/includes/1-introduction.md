In this module, you gain an understanding of object-relational mappers (ORMs) and Entity Framework Core (EF Core). You use EF Core to persist and retrieve relational data from a database.

## Example scenario

You're an employee of a pizza company named Contoso Pizza. Your manager has asked you to develop a RESTful web API service as a prerequisite for the company's new web storefront and mobile application. The service will support adding, viewing, modifying, and removing types of pizza in the company's database. These four operations are often called *create, read, update, and delete (CRUD)*.

## Learning objectives

In this module, you'll:

- Review ORM concepts.
- Understand EF Core architecture.
- Write C# code to interact with a database by using EF Core.
- Use EF Core migrations to keep the code and database in sync.
- Use reverse engineering to generate entity models from an existing database.
- Seed a database on app startup.

## Required tools

> [!TIP]
> You can skip installing the tools that are described in the next sections by using GitHub Codespaces as your integrated development environment (IDE). In a new browser tab, go to the [GitHub repository that contains the starter app for this module](https://github.com/MicrosoftDocs/mslearn-persist-data-ef-core). Select the **Code** button, and then create a new codespace on the `main` branch. For more information, see [Create a codespace](https://docs.github.com/github/developing-online-with-codespaces/creating-a-codespace).
>
> Alternatively, if you have a compatible container environment installed, you can use the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension for Visual Studio Code. When the extension is installed, select the F1 key to open the command pallette. Search for **Dev Containers: Clone Repository in Container Volume** and select it in the results. Enter the URL `https://github.com/MicrosoftDocs/mslearn-persist-data-ef-core`. The repository is cloned into a new container with all the required tools installed.

The following tools are required.

### .NET 7.0 SDK

[!include[](../../../includes/dotnet7-sdk-version.md)]

### Git command-line client

To clone the sample app from GitHub, you need a [Git](https://git-scm.com/downloads) client.

### Visual Studio Code

Ensure that you have latest versions of [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp&azure-portal=true). You also need the [SQLite](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite&azure-portal=true) extension.
