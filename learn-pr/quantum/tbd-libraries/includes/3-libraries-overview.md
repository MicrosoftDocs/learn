The Quantum Development Kit includes several libraries which allow you to develop high-level quantum applications in Q# without worrying about the nitty-gritty details of the actual implementation on target machines.

First and foremost, the *Q# standard libraries* comprise much of the core functionality of Q#.
Automatically accessible in all Q# projects, the types, operations, and functions defined in them span from the basics of initializing arrays and single qubit operations to high-level quantum subroutines.
Up to this point in the modules you have already gained some familiarity with them, but know that there is always more to explore.

Beyond the standard, however, there are a few additional libraries which provide domain-specific functionality.
These consist of:

- The *quantum chemistry library*, which provides a data model for loading representations of fermionic Hamiltonians (e.g. molecular systems) and casting them to a representation that can be mapped to a quantum computer's physical qubits, as well as operations to reveal system properties and simulate dynamics. 
    Quantum chemistry is already a vast field of study in its own right, advancing our understanding of organic and inorganic chemical interactions as they truly occur: according to the laws of quantum mechanics. However, their size and complexity render simulation and analysis of many crucial molecular systems out of reach of classical computing. Harnessing quantum computing for these problems will be a critical inflection point in many related fields, such as pharmaceutical engineering and materials science.

    Beyond molecular dynamics, this ability to simulate *other* quantum systems *on* a quantum computer will also open new frontiers in fundamental physics research. For example, many theorized fermionic and bosonic interactions remain out of reach of observation because of experimental limitations. Mapping those systems to a quantum computer will allow them to be isolated and studied without such complications.

- The new *quantum machine learning library*, which provides an implementation of an hybrid quantum-classical algorithm that makes use of quantum computing to encode and process the data. This library is not meant to be ready for production but as a research environment for those interested in running experiments to explore the use of quantum computing in machine learning.

- The *quantum numerics library*, which provides tools to implement a host of mathematical functions in the native operations of a quantum computer. This includes advanced signed/unsigned integer arithmetic, as well as support for fixed-point representations and polynomial evaluation. Many quantum algorithms require some level of arithmetic manipulation for the information encoded in the qubit registers. The operations implemented in this library provide you the necessary arithmetic operations to implement algorithms like Shor's factoring algorithm.

## Accessing the libraries 

Unlike the standard libraries, your Q# projects do not automatically access to the contents of these domain-specific libraries.
That is, such an `open Microsoft.Quantum.<>;` statement at the beginning of your Q# file will not recognize the namespace by default.
However, adding these libraries to your project requires only a single step (and no further installation), and you immediately have access to the types and callables (operations and functions) defined therein.
In the following units, you will see some applications of each library without having to follow along locally. 
But, if you would like to get started exploring, you can learn how to add libraries to your project at [Using additional Q# libraries](https://docs.microsoft.com/quantum/user-guide/libraries/additional-libraries?view=qsharp-preview&tabs=tabid-csproj).

In the next units you are going to see an overview of these libraries and examples of their implementation.
