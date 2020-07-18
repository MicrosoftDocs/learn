Having already installed the Quantum Development Kit for use with your preferred environment, you can easily add libraries to individual Q# projects without any further installation.

The additional domain-specific functionality is provided through NuGet packages that can be added to your Q# projects.
The standard libraries are included in every Q# project by default---that is, the operations, functions, and types from their namespaces are accessible via `open ... ;` statements in your Q# file.
However, another step is necessary to access the namespaces from the additional Q# libraries: chemistry, numerics, and machine learning.

Because this learning path has not yet introduced the use of host programs and their interoperability with Q#, we will present how to add these libraries to a project for command-line applications. 
Details on adding them to a project in other situations can be found at USING ADDL Q# LIBRARIES (link).

## Add Q# Libraries to a project for command-line applications

The NuGet package names for each library are:
- `Microsoft.Quantum.Chemistry`
- `Microsoft.Quantum.Numerics`
- `Microsoft.Quantum.MachineLearning`

Using the command-line on its own or from within Visual Studio Code, you can use the `dotnet` command to add a NuGet package reference to your project.
The form of the command for a given NuGet package is:

```dotnetcli
dotnet add package <package name>
```

> [!NOTE]
> Libraries are added to individual Q# projects, not system-wide.
> After adding a library to one project, other projects will still not have access to it.
> As such, the command must be run from the same location of the project you wish to add it to.

## Create a new Q# project

FILL (basic code to do so, as it's already been explained in prior modules)

### Add the quantum chemistry library

Throughout the rest of this module, we will use the quantum chemistry library. 
Navigate to the location of your project, and add the library by running the command:

```dotnetcli
dotnet add package Microsoft.Quantum.Chemistry
```

Your project now has access to the Q# quantum chemistry library.

