A task you'll often perform is packaging libraries for reuse by other developers. NuGet packaging makes it trivial for any developer anywhere to acquire and properly configure all the .NET references for their applications. 

In the preceding unit, you built your modal dialog component and used it in your own application. Now you'll want to reuse it in other applications. 

In this unit, you'll learn the steps necessary to configure a Razor class library as a NuGet package. You'll also learn how to package the library for distribution by using a package-repository service, such as NuGet.org, or GitHub repositories.

## Configure a Razor class library for NuGet packaging

The .NET ecosystem makes it easy to define the properties that are necessary for other developers to identify and use your components. You can define all these properties in the project file (*\*.csproj*) of your Razor class library so that they travel with the library and are updated appropriately when your library is updated. 

You can configure fields that identify your package in the **Visual Studio Project Properties - Package** dialog, or you can create entries directly in the *\*.csproj* file yourself.

The four fields required to create a package are:

| Field | Description | Default value |
| --- | --- | --- |
| PackageId | A package identifier, unique across the entire NuGet repository. | `AssemblyName` of the library |
| Version | A specific version number in the form _Major.Minor.Patch[-Suffix]_, where _-Suffix_ optionally defines prerelease versions. | 1.0.0 |
| Authors | The authors of the package. | `AssemblyName` |
| Company | The name of the company that's responsible for creating and publishing the package. | `AssemblyName` |

Some of these fields have default values, and it might look funny to publish a package with a company name of **MyFirstLibrary**. We strongly recommend that you explicitly define these values. 

In the preceding unit, you learned that the static content of a Razor class library is available at `_content/[PACKAGE_ID]/`, and now you see where the `PackageId` value is configured.

A sample project file with these values configured might look like the following:

```xml
<PropertyGroup>
    <PackageId>Learn.MyFirstLibrary</PackageId>
    <Version>0.1.0-alpha1</Version>
    <Authors>Susan Developer, Terry Programmer</Authors>
    <Company>AdventureWorks</Company>
</PropertyGroup>
```

When you're building the project, you can also configure it to generate a NuGet package either by selecting the **Generate NuGet Package on Build** option in the Visual Studio **Project Properties** dialog or by adding a `GeneratePackageOnBuild` entry next to the other package fields, as shown here:

```xml
<GeneratePackageOnBuild>True</GeneratePackageOnBuild>
```

You can configure many optional project properties, including:

* A `Description` that's appropriate for display in the NuGet repository
* A copyright notice
* Licensing information
* Icons
* Project URLs

For a full list of properties, check the Microsoft documentation on the [MSBuild pack target](/nuget/reference/msbuild-targets#pack-target).

## Package the library

After you've written the library configuration into the *\*.csproj* file, you can generate the NuGet package either in Visual Studio, by right-clicking the project and selecting the **Pack** command, or in the project folder, by running the following command:

```dotnetcli
dotnet pack
```

This `dotnet pack` command generates a package with the PackageID and version number and places it in the standard project build output folder.
