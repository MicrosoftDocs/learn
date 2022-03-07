Packaging libraries for reuse by other developers is a common task. NuGet packaging makes it trivial for any developer anywhere to acquire and get all of the .NET references configured properly for their application.  

We've now built our Modal dialog component and want to use it in several applications.  

In this unit, you will learn the steps necessary to configure a Razor class library as a NuGet package.  We will also talk through the steps necessary to package the library for distribution using a package-repository service like NuGet.org or GitHub repositories.

## Configuring a Razor class library for NuGet Packaging

The .NET ecosystem makes it easy to define the properties necessary for other developers to identify and use your components.  All of these properties can be defined in the project file (`*.csproj`) of your Razor class library so that they travel with and are updated appropriately when your library updates.  

Configuration of fields to identify your package can be done in the Visual Studio Project Properties - Package dialog or you can create entries directly in the `*.csproj` file yourself.

The four fields required to create a package are:

| Field | Description | Default Value |
| --- | --- | --- |
| PackageId | A package identifier, unique across the entire NuGet repository. | `AssemblyName` of the library |
| Version | A specific version number in the form _Major.Minor.Patch[-Suffix]_ where _-Suffix_ optionally defines prerelease versions. | 1.0.0 |
| Authors | The authors of the package. | `AssemblyName` |
| Company | The name of the company responsible for creating and publishing the package. | `AssemblyName` |

Some of these fields have defaults, and it might look funny to publish a package with a company name of **MyFirstLibrary**.  We strongly recommend you explicitly define these values.  

From our last unit, we indicated that the static content of a Razor class library is available at `_content/[PACKAGE_ID]/` and now you see where the `PackageId` value is configured.

A sample project file with these values configured might look like:

```xml
<PropertyGroup>
    <PackageId>Learn.MyFirstLibrary</PackageId>
    <Version>0.1.0-alpha1</Version>
    <Authors>Susan Developer, Terry Programmer</Authors>
    <Company>Adventureworks</Company>
</PropertyGroup>
```

You can also configure the project to generate a NuGet package when building by selecting the **Generate NuGet Package on Build** option in Visual Studio's Project Properties dialog or adding a `GeneratePackageOnBuild` entry next to the other package fields

```xml
<GeneratePackageOnBuild>True</GeneratePackageOnBuild>
```

There are many optional properties available for you to configure in a project including a `Description` appropriate for display on the NuGet repository, a copyright notice, licensing information, icons, and project URLs.  For a full list of properties, check the Microsoft documentation on the [MSBuild pack target](/nuget/reference/msbuild-targets#pack-target)

## Packaging the Library

Once the configuration for the library is written into the `*.csproj` file, you can generate the NuGet package by either right-clicking on the project and choosing the **Pack** command in Visual Studio or executing this command in the project folder:

```dotnetcli
dotnet pack
```

This command will generate a package with the PackageID and version number and place it in the standard project build output folder.