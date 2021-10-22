<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->
Packaging libraries for reuse by other developers is a common task. NuGet packaging makes it trivial for any developer anywhere to acquire and get all of the .NET references configured properly for their application.  

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->

We've now built our Modal dialog component and want to use it in several applications.  

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->

In this unit, you will learn the steps necessary to configure a Razor Class Library as a NuGet package.  We will also talk through the steps necessary to package the library for distribution using a package-repository service like NuGet.org or GitHub repositories.

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->


<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## Configuring a Razor Class Library for NuGet Packaging

The .NET ecosystem makes it easy to define the properties necessary for other developers to identify and use your components.  All of these properties can be defined in the project file (`*.csproj`) of your Razor Class Library so that they travel with and are updated appropriately when your library updates.  

Configuration of fields to identify your package can be done in the Visual Studio Project Properties - Package dialog or you can create entries directly in the `*.csproj` file yourself.

The four fields required to create a package are:

| Field | Description | Default Value |
| --- | --- | --- |
| PackageId | A package identifier, unique across the entire NuGet repository. | `AssemblyName` of the library |
| Version | A specific version number in the form _Major.Minor.Patch[-Suffix]_ where _-Suffix_ optionally defines prerelease versions. | 1.0.0 |
| Authors | The authors of the package. | `AssemblyName` |
| Company | The name of the company responsible for creating and publishing the package. | `AssemblyName` |

Some of these fields have defaults, and it might look funny to publish a package with a company name of **MyFirstLibrary**.  We strongly recommend you explicitly define these values.  

From our last unit, we indicated that the static content of a Razor Class Library is available at `_content/[PACKAGE_ID]/` and now you see where the `PackageId` value is configured.

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

<!-- Pattern for complex chunks (repeat as needed) -->
## Packaging the Library

Once the configuration for the library is written into the `*.csproj` file, you can generate the NuGet package by either right-clicking on the project and choosing the **Pack** command in Visual Studio or executing this command in the project folder:

```dotnetcli
dotnet pack
```

This command will generate a package with the PackageID and version number and place it in the standard project build output folder.
<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->