You're probably already familiar with libraries in other programming languages. Q#, as a language for quantum programming, isn't different in this case. 

The Quantum Development Kit includes [several libraries](/quantum/user-guide/libraries?azure-portal=true). They allow you to develop high-level quantum applications in Q# without having to worry about the low-level implementation details.

For example, many languages provide an expression to add numbers—for example, `a+b`—so you don't have to worry about the binary representation and implementation of that addition. This way, you can write better programs faster and focus on the problem that you want to solve.

The same is true for the Q# libraries. By providing complex quantum operations and frequently used components of quantum algorithms through simple callables and types, the libraries free you up to focus on the logic of your quantum programs. You can then start developing more impactful programs sooner.

## What is a Q# library?

At its core, a Q# library is simply a collection of operations, functions, and user-defined types. Because these are always defined within namespaces in Q#, we can consider a library a collection of namespaces.

When you make such a library available to a Q# project, you can then access its namespaces via standard `open NamespaceName;` statements at the beginning of your Q# file. You can then use the library's operations, functions, and types.

## How are Q# libraries distributed?

Libraries in Q# are distributed as [NuGet](https://www.nuget.org?azure-portal=true) packages.

NuGet is a package manager for various different platforms, and is the primary package manager for most .NET languages. It allows developers to produce, share, and consume useful code. A NuGet package is essentially a .zip file that contains compiled code and related files.

The Quantum Development Kit uses NuGet to give Q# projects access to, and thus use the code from, any compatible package. Naturally, a Q# project can use only the packages that are meant for use with Q#. Examples include packages that contain Q# libraries, new/custom simulators, or new magic commands for [Q# Jupyter Notebooks](/azure/quantum/install-overview-qdk#jupyter-notebooks).

Users can easily use the Q# libraries produced by Microsoft, along with other Q# libraries that aren't released as part of the QDK, because they're all hosted through NuGet.

As you'll learn later in this unit, the simple process of adding these libraries to your projects is the same regardless.

## What libraries come with the QDK?

Microsoft provides four libraries as part of the QDK.

The *standard library* provides much of Q#'s primary functionality and is the focus of this module. The other three libraries are focused on more domain-specific functionality:

- The *quantum chemistry library* provides a data model for loading representations of fermionic Hamiltonians (for example, molecular systems) and casting them to a representation that can be mapped to a quantum computer's physical qubits. This library also provides operations to reveal system properties and simulate dynamics.
- The *quantum machine learning library* provides an implementation of a hybrid quantum-classical algorithm that makes use of quantum computing to encode and process the data.
  
  This library isn't meant to be ready for production. It's a research environment for those interested in exploring the use of quantum computing in machine learning.
- The *quantum numerics library* provides tools to implement a host of mathematical functions in the native operations of a quantum computer.
  
  Many quantum algorithms require some level of arithmetic manipulation for the information encoded in the qubit registers. This library gives you the necessary arithmetic operations to implement algorithms like Shor's factoring algorithm.

## How can I add a Q# library to my project?

The standard library is included in every Q# project by default. Accessing other libraries, including the domain-specific libraries, requires adding their respective packages to the project.

Depending on your Q# development setup, the method of adding the packages will vary. You can find specifics at [The Q# Libraries](/azure/quantum/user-guide/libraries/) in the official documentation. Regardless of your environment, though, the process is straightforward.

For example, if you're working with Q# command-line applications in Visual Studio Code, you can simply use the `dotnet` command to add a NuGet package reference to your project. Adding the [Microsoft.Quantum.Numerics](https://www.nuget.org/packages/Microsoft.Quantum.Numerics?azure-portal=true) package then requires only running the following command:

```dotnetcli
dotnet add package Microsoft.Quantum.Numerics
```

## What's next?

In the next unit, you'll learn about how Q# API documentation is structured and how to use it.
