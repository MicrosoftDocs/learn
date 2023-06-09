In this module, you'll gain an understanding of object-relational mappers (ORMs) and Entity Framework (EF) Core. You'll use EF Core to persist and retrieve relational data from a database.

## Example scenario

Suppose you're an employee of a pizza company named Contoso Pizza. Your manager has asked you to develop a RESTful web API service as a prerequisite for the company's web storefront and mobile application. The service will support adding, viewing, modifying, and removing types of pizza in the company's database. These four operations are often referred to as **C**reate, **R**ead, **U**pdate, **D**elete (CRUD).

## Learning objectives

In this module, you'll:

- Review object-relational mapper (ORM) concepts.
- Understand Entity Framework Core (EF Core) architecture.
- Write C# code to interact with a database using EF Core.
- Use EF Core Migrations to keep the code and database in sync.
- Use reverse engineering to generate entity models from an existing database.
- Seed a database on app startup.

## Required Tools

> [!TIP]
> You can skip installing the tools below by using GitHub Codespaces as your IDE. In another browser tab, navigate to the [GitHub repository containing the starter app for this module](https://github.com/MicrosoftDocs/mslearn-persist-data-ef-core), select the **Code** button, and create a new codespace on the `main` branch. For more information, see [Create a Codespace](https://docs.github.com/github/developing-online-with-codespaces/creating-a-codespace).
>
> Alternatively, if you have a compatible container environment installed, you can use the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension for Visual Studio Code. With the extension installed, press **F1** to open the command pallette, then search for and select **Dev Containers: Clone Repository in Container Volume** and provide the URL `https://github.com/MicrosoftDocs/mslearn-persist-data-ef-core`. This will clone the repository and open it in a container with all the required tools installed.

The following tools are required:

### .NET SDK

[!include[](../../../includes/dotnet7-sdk-version.md)]

### GitHub CLI

To clone the sample app from GitHub, you'll need the [GitHub CLI](https://cli.github.com/).

### Visual Studio Code

Ensure you have latest versions of [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true) and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp&azure-portal=true). You'll also need the [SQLite](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite&azure-portal=true) extension.
