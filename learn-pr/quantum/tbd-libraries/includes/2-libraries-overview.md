The Quantum Development Kit includes several libraries which allow you to develop high-level quantum applications in Q# without worrying about the nitty-gritty details of the actual implementation on target machines.

## What is a Q# library?

At its core, a Q# library is simply a collection of operations, functions and user-defined types. 
Since these are always defined within namespaces in Q#, we could consider a library a collection of namespaces. 

When such a library has been made available to a Q# project, its namespaces can then be accessed via standard `open NamespaceName;` statements at the beginning of your Q# file, and thus its operations, functions, and types can be utilized.

## How are Q# libaries distributed?

Libraries in Q# are distributed as [NuGet](https://www.nuget.org/) packages.
Since these can be directly added to your Q# projects, this also allows for the use of third-party libraries that are not released as part of the QDK. 

## What comes with my QDK installation?

There are four sets of libraries provided as part of the QDK and all are automatically installed with the QDK. 

Firstly, the *Q# standard library* provides much of Q#'s primary functionality and is the focus of this module. 
Then, there are three libraries focused on more domain-specific functionality: 
- The *quantum chemistry library*, which provides a data model for loading representations of fermionic Hamiltonians (e.g. molecular systems) and casting them to a representation that can be mapped to a quantum computer's physical qubits, as well as operations to reveal system properties and simulate dynamics. 
- The *quantum machine learning library*, which provides an implementation of an hybrid quantum-classical algorithm that makes use of quantum computing to encode and process the data. 
    This library is not meant to be ready for production but as a research environment for those interested in running experiments to explore the use of quantum computing in machine learning.
- The *quantum numerics library*, which provides tools to implement a host of mathematical functions in the native operations of a quantum computer.
    Many quantum algorithms require some level of arithmetic manipulation for the information encoded in the qubit registers, and the operations implemented in this library provide you the necessary arithmetic operations to implement algorithms like Shor's factoring algorithm.

> [!NOTE]
> By default, Q# projects have access to the standard library. 
> However, although the domain-specific libraries are also *installed* with the QDK, this does not mean that your Q# projects will automatically have access to their contents. 
> As we explain below, their respective packages must be explicitly added to each project. 

## How can I add a Q# library to my project?

The standard library is included in every Q# project by default, but accessing other libraries requires adding their packages to the project.
Depending on your Q# development setup, the method will vary:

> [!NOTE]
> NOTE TO REVIEWER: following taken from our docs. 
> Has this changed/should we present it differently? 
> E.g. should we more explicitly mention the `.csproj` file for the first option?

### [Q# applications or .NET interopability](#tab/tabid-csproj)

**Command prompt or Visual Studio Code:** Using the command prompt on its own or from within Visual Studio Code, you can use the `dotnet` command to add a NuGet package reference to your project.
For example, to add the [**Microsoft.Quantum.Numerics**](https://www.nuget.org/packages/Microsoft.Quantum.Numerics) package, run the following command:

```dotnetcli
dotnet add package Microsoft.Quantum.Numerics
```

**Visual Studio:** If you are using Visual Studio 2019 or later, you can add additional Q# packages using the NuGet Package Manager.
To load a package: 
1. With a project open in Visual Studio, select **Manage NuGet Packages...** from the **Project** menu.

2. Click **Browse**, select **Include prerelease** and search for the package name "Microsoft.Quantum.Numerics". 
This will list the packages available for download.

3. Hover over **Microsoft.Quantum.Numerics** and click the downward-pointing arrow to the right of the version number to install the numerics package.

For more details, see the [Package Manager UI guide](https://docs.microsoft.com/nuget/tools/package-manager-ui).

Alternatively, you can use the Package Manager Console to add the numerics library to your project via the command line interface.

![Use the Package Manager Console from the command prompt](~/media/vs2017-nuget-console-menu.png)

From the Package Manager Console, run the following:

```
Install-Package Microsoft.Quantum.Numerics
```

For more details, see the [Package Manager Console guide](https://docs.microsoft.com/nuget/tools/package-manager-console).

### [IQ# Notebooks](#tab/tabid-notebook)

You can make additional packages available for use in an IQ# Notebook by using the [`%package` magic command](https://docs.microsoft.com/qsharp/api/iqsharp-magic/package?view=qsharp-preview).
For example, to add the [**Microsoft.Quantum.Numerics**](https://www.nuget.org/packages/Microsoft.Quantum.Numerics) package for use in an IQ# Notebook, run the following command in a notebook cell:

```
%package Microsoft.Quantum.Numerics
```

Following this command, the package is available to any cells within the notebook.
To make the package available from Q# code in the current workspace, reload the workspace after adding your package:

```
%workspace reload
```

### [Python interoperability](#tab/tabid-python)


You can make additional packages available for use in a Python host program by using the [`qsharp.packages.add`](https://docs.microsoft.com/python/qsharp-core/qsharp.packages.packages) method.
For example, to add the [**Microsoft.Quantum.Numerics**](https://www.nuget.org/packages/Microsoft.Quantum.Numerics) package for use in an IQ# Notebook, run the following Python code:

```python
import qsharp
qsharp.packages.add("Microsoft.Quantum.Numerics")
```

Following this command, the package will be made available to any Q# code compiled using `qsharp.compile`.
To make the package available from Q# code in the current workspace, reload the workspace after adding your package:

```python
qsharp.reload()
```

***

## What's next?

Something, surely.

