You are probably already familiar with libraries in other programming languages. 
Q# as a language for quantum programming is not different in this case. 

The Quantum Development Kit includes several libraries which allow you to develop high-level quantum applications in Q# without having to worry about the low-level implementation details.
For example, many languages provide some form of `a + b` to simply add two numbers, and because you don't have to think about the binary representation and implementation of that addition, you can write better programs faster by only worrying about the important part, the logic of what you're doing with those numbers. 
The same is true for the Q# libraries---by providing complex quantum operations and frequently-used components of quantum algorithms through simple callables and types, they free you up to focus on the logic of your quantum program and therefore start developing more impactful programs sooner.


## What is a Q# library?

At its core, a Q# library is simply a collection of operations, functions, and user-defined types. 
Since these are always defined within namespaces in Q#, we could consider a library a collection of namespaces. 

When such a library has been made available to a Q# project, its namespaces can then be accessed via standard `open NamespaceName;` statements at the beginning of your Q# file, and thus its operations, functions, and types can be utilized.

Note that namespaces essentially just provide the fully qualified names of the particular callables or types contained in them.
Therefore it's possible for callables/types from distinct libraries or packages (installable units of library code) to ultimately belong to the same namespace.

## How are Q# libraries distributed?

Libraries in Q# are distributed as [NuGet](https://www.nuget.org/) packages. 
NuGet is a package manager used for a variety of different platforms, and is the primary package manager used by most .NET languages.
It enables developers to produce, share, and consume useful code. 
A NuGet *package* is essentially a ZIP file containing compiled code and related files.

The Quantum Development Kit uses NuGet to give Q# projects access to, and thus use the code from, any compatible package.
Naturally only those packages meant for use with Q# can be used, such as those containing Q# libraries, new/custom simulators, or new magic commands for [Q# Jupyter Notebooks](https://docs.microsoft.com/quantum/quickstarts/install-jupyter?tabs=tabid-conda).
Since they are all hosted through NuGet, users can easily use the Q# libraries produced by Microsoft, as well as other third-party Q# libraries that are not released as part of the QDK. 

As you will learn further below, the simple process of adding these libraries to your projects is the same regardless.

## What libraries come with the QDK?

There are four libraries provided by Microsoft as part of the QDK.

Firstly, the *standard library* provides much of Q#'s primary functionality and is the focus of this module. 
Then, there are three libraries focused on more domain-specific functionality: 
- The *quantum chemistry library*, which provides a data model for loading representations of fermionic Hamiltonians (e.g. molecular systems) and casting them to a representation that can be mapped to a quantum computer's physical qubits, as well as operations to reveal system properties and simulate dynamics. 
- The *quantum machine learning library*, which provides an implementation of a hybrid quantum-classical algorithm that makes use of quantum computing to encode and process the data. 
    This library is not meant to be ready for production, but rather is a research environment for those interested in exploring the use of quantum computing in machine learning.
- The *quantum numerics library*, which provides tools to implement a host of mathematical functions in the native operations of a quantum computer.
    Many quantum algorithms require some level of arithmetic manipulation for the information encoded in the qubit registers, and this library provides you the necessary arithmetic operations to implement algorithms like Shor's factoring algorithm.


## How can I add a Q# library to my project?

The standard library is included in every Q# project by default, but accessing other libraries—including the domain-specific libraries discussed above—requires adding their respective packages to the project.

Depending on your Q# development setup, the method of doing so will vary. 
Specifics for can be found at [Using additional Q# libraries](https://docs.microsoft.com/quantum/user-guide/libraries/additional-libraries) in the official documentation.
Regardless of the your environment, though, the process is very straightforward.

For example, if you are working with Q# command-line applications in Visual Studio Code, you can simply use the `dotnet` command to add a NuGet package reference to your project.
Adding the [**Microsoft.Quantum.Numerics**](https://www.nuget.org/packages/Microsoft.Quantum.Numerics) package would then require only running the following command:

```dotnetcli
dotnet add package Microsoft.Quantum.Numerics
```


## What's next?

In the next unit you will learn about the Q# API documentation, specifically how it is structured and how to navigate it.
