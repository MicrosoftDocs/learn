The Quantum Development Kit includes several libraries which allow you to develop high-level quantum applications in Q# without worrying about the nitty-gritty details of the actual implementation on target machines.

First and foremost, the *Q# standard libraries* (do we include links or no?) comprise much of the core functionality of Q#.
Automatically accessible in all Q# projects, the types, operations, and functions defined in them span from the basics of initializing arrays and single qubit operations to high-level quantum subroutines.
Up to this point in the modules you have already gained some familiarity with them, but know that there is always more to explore.

Beyond the standard, however, there are a few additional libraries which provide domain-specific functionality.
These consist of:

- The *quantum chemistry library*, which provides a data model for loading representations of fermionic Hamiltonians (e.g. molecular systems) and casting them to a representation that can be mapped to a quantum computer's physical qubits, as well as operations to reveal system properties and simulate dynamics. 
    Quantum chemistry is already a vast field of study in its own right, advancing our understanding of organic and inorganic chemical interactions as they truly occur: according to the laws of quantum mechanics. However, their size and complexity render simulation and analysis of many crucial molecular systems out of reach of classical computing. Harnessing quantum computing for these problems will be a critical inflection point in many related fields, such as pharmaceutical engineering and materials science.

    (maybe add to intro page of q chem lib if this gets too wordy here) Beyond molecular dynamics, this ability to simulate *other* quantum systems *on* a quantum computer will also open new frontiers in fundamental physics research. For example, many theorized fermionic and bosonic interactions remain out of reach of observation because of experimental limitations. Mapping those systems to a quantum computer will allow them to be isolated and studied without such complications.

- The *quantum numerics library*, which provides tools to implement a host of mathematical functions in the native operations of a quantum computer. This includes advanced signed/unsigned integer arithmetic, as well as support for fixed-point representations and polynomial evaluation. 
    (words about oracle evaluation and e.g. cryptography)

- The new *quantum machine learning library*, which provides an implementation of the sequential classifiers that take advantage of quantum computing to understand data.
    (words go here)

Unlike the standard libraries, your Q# projects do not automatically access to the contents of these domain-specific libraries.
That is, such an `open Microsoft.Quantum.<>;` statement at the beginning of your Q# file will not recognize the namespace by default.
However, as you will see in a few units, adding these libraries to your project requires only a single step (and no further installation), and you will immediately have access to the types and callables (operations and functions) defined therein.

In the rest of this module we use (a very small part of) the quantum chemistry library to demonstrate how these QDK libraries can be applied in solving such domain-specific problems.
Future modules will dive further into using each library, but they are all fully ready for you to get started developing.

(Maybe include the first step of adding the library to the project here?)
(Better idea: additional, but small, page on specifically that? Would go after this page, before any chemistry concept details)