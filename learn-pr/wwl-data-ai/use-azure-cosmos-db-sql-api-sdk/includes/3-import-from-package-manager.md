The Azure Cosmos DB SDKs (Software Development Kits) are hosted on **NuGet**, **PyPI**, and **npm** for .NET, Python, and JavaScript respectively. To import the SDK into your project, you must use the package manager for the respective programming language. Select the tab that corresponds to the SDK you want to explore.

::: zone pivot="csharp"

The **Microsoft.Azure.Cosmos** library, including all of its previous versions, are hosted on **nuget** to make it easier to import the library into a .NET application.

## Importing a NuGet package

To import a NuGet package into a .NET application, you must use the .NET CLI. The CLI includes a ``dotnet add`` command that is used to add a resource to a .NET project. To specifically add a NuGet package, you must do one of the following things:

### Import the latest version of the package

Invoke the ``dotnet add package`` command with only the name of the package. For example, this command imports the latest stable version of the **Microsoft.Azure.Cosmos** library.

```bash
dotnet add package Microsoft.Azure.Cosmos
```

> [!TIP]
> This command only imports stable versions of the package. If a newer preview of the package is available, it imports the older stable version. If no stable version is available, it doesn't import the package at all.

### Import a specific version of the package

Invoke the ``dotnet add package`` command with the name of the package. The optional ``--version`` argument allows specifying a specific package version. For example, this command imports the **3.41.1** version of the **Microsoft.Azure.Cosmos** library.

```bash
dotnet add package Microsoft.Azure.Cosmos \
    --version 3.41.1
```

> [!TIP]
> Specifying the package version is the only way to import preview versions of packages that aren't flagged as stable yet.

## .NET project file

Once imported, the package specification is added to the **csproj** file for the .NET project. The project file uses the XML format and a new element named **PackageReference** is created within the **ItemGroup** element with the name of the package and the version. In this example, the **3.41.1** version of the **Microsoft.Azure.Cosmos** library was imported into the project from NuGet.

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
  </PropertyGroup>
  <ItemGroup>
    <PackageReference Include="Microsoft.Azure.Cosmos" Version="3.41.1" />
  </ItemGroup>
</Project>
```

> [!NOTE]
> The version of the package is added whether you specified it in the import command or not. If you didn't specify a package version, the version of the latest stable package that was imported is specified in the project file.

::: zone-end

::: zone pivot="python"

The **azure-cosmos** library, including all of its previous versions, are hosted on **PyPI** to make it easier to import the library into a Python application.

## Installing the Python package

To install the ``azure-cosmos`` package, you can use ``pip``, the standard package installer for Python. This installation can be done in one of two ways:

### Install the latest version of the package

Invoke the ``pip install`` command with only the name of the package. This command installs the latest stable version of the **azure-cosmos** library.

```bash
pip install azure-cosmos
```

> [!TIP]
> This command only imports stable versions of the package. If a newer preview of the package is available, it imports the older stable version. If no stable version is available, it doesn't import the package at all.

### Install a specific version of the package

Invoke the pip install command with the name of the package and specify the version using `==`. For example, this command installs version **4.8.0** of the **azure-cosmos** library.

```bash
pip install azure-cosmos==4.8.0
```

> [!TIP]
> Specifying the version is necessary if you need to install a preview version or a specific version that matches your project's requirements.

### Python project dependencies file

When using a virtual environment or managing dependencies, it's common to list packages in a **requirements.txt** file. This file should include the name of the package and the version, if necessary. Here's an example with the **4.8.0** version of the **azure-cosmos** library.

```bash
azure-cosmos==4.8.0
```

> [!NOTE]
> If you run `pip freeze` after installing packages, it will create a **requirements.txt** file with the currently installed versions, which you can use to replicate the environment later.

::: zone-end

::: zone pivot="node"

The **@azure/cosmos** library, including all of its previous versions, are hosted on **npm** to make it easier to import the library into a JavaScript application.

### Installing the JavaScript package

To install the ``@azure/cosmos`` package, use ``npm``, the standard package manager for JavaScript. This installation can be done in one of the following ways:

### Install the latest version of the package

Invoke the ``npm install`` command with the name of the package. This command installs the latest stable version of the **@azure/cosmos** library.

```bash
npm install @azure/cosmos
```

> [!TIP]
> This command installs the latest stable version. To install preview versions or a specific version, you need to specify the version explicitly.

### Install a specific version of the package

Use the ``@<version>`` syntax to install a specific version. For example, this command installs version **4.1.1** of the **@azure/cosmos** library.

```bash
npm install @azure/cosmos@4.1.1
```

> [!TIP]
> Installing a specific version is necessary if you want to use a preview version or ensure compatibility with other parts of your project.

### JavaScript project dependencies file

Once installed, the package and its version are listed in the **package.json** file under the **dependencies** section. Here's an example showing **4.1.1** of the **@azure/cosmos** library.

```json
{
  "name": "cosmosdb-js-project",
  "version": "1.0.0",
  "main": "index.js",
  "dependencies": {
    "@azure/cosmos": "^4.1.1"
  }
}
```

> [!NOTE]
> The version is added to **package.json** whether you specify it during installation or not. If no version is specified, the latest stable version is added by default.

::: zone-end
