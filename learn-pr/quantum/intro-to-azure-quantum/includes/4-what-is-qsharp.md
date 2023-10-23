Q# is an open-source, high-level, programming language for developing and running quantum algorithms. It’s part of the Quantum Development Kit (QDK) and it's designed to be hardware agnostic, scale to the full range of quantum applications, and to optimize execution.

## Why a quantum programming language?

There are many reasons for wanting to build a quantum programming language, but the short answer would be: because we want to write algorithms, not circuits.

When writing algorithms, we should meet the following requirements for the language, compiler, and runtime:

- **Algorithms must be expressed in terms of abstract qubits, rather than physical qubits.** For large numbers of qubits, the compiler and runtime should manage the mapping from program qubits to logical (error-corrected) qubits, and then eventually to physical qubits. Doing this task by hand becomes unmanageably complicated for any nontrivial algorithm. It is also important to be able to express algorithms in terms of abstract qubits to allow for the possibility of a quantum computer with a different topology than the one the algorithm was written for.
- **Algorithms need to integrate quantum and classical computation.** The ability to perform classical and quantum computations is essential in a *universal* quantum computer, which is the ultimate machine capable of simulate any classical and quantum operation. 
- **Higher-order protocols, such as phase estimation and oblivious amplitude amplification, must be expressible.** A common pattern in quantum computing is “meta-algorithms” such as these, which operate on other operations rather than on qubits. It is necessary for development scalability to allow such algorithms to be expressed abstractly and used with the appropriate input algorithms.
- **Higher-order transformations, such as taking the adjoint of an operation, must be natively expressible.** There are two common ways to derive a new operation from an existing one in quantum computing: taking the adjoint of the operation and controlling the operation with a qubit or multiple qubits. To support writing higher-level protocols cleanly, there should be a way to express that the adjoint or controlled version of an operation should be invoked. It greatly aids development scalability for the compiler to be able to auto-generate the adjoint or controlled version of an operation.
- **Algorithms must respect the laws of physics.** For example, copying the state of a qubit should not be possible. Direct access to the qubit state should not be possible, although we allow a certain amount of validation and state examination to facilitate debugging with a simulator.

## The characteristics of Q\#

Q# can be used to write quantum algorithms, simulate them on classical computers, and then run them on actual quantum computers. Q# also provides a library of built-in quantum operations, such as quantum gates and measurements, that are used to manipulate qubits and perform quantum computations. 

:::image type="content" source="../media/qsharp.png" alt-text="Screenshot of a code snippet written in Q# language.":::

The following sections describe some key features of Q#.

### Domain-specific libraries

The Q# libraries help you keep your code high level, enabling you to run complex quantum operations without having to design low-level operation sequences.

- The standard library provides a set of essential and very useful functions and operations that can be used when writing quantum programs in Q#.
- The quantum chemistry library for simulating quantum dynamics and electronic structure problems on quantum computers.
- The quantum machine learning library, which provides an implementation of the sequential classifiers that take advantage of quantum computing to run hybrid quantum/classical machine learning experiments.
- The quantum numeric library, which provides support for a wide range of numerics functionality.

### Qubit management

In Q#, qubits are resources that are requested from the runtime when needed and returned when no longer in use. This method is similar to the way that classical languages deal with heap memory.

### Agnostic qubit type

The Q# language doesn’t specify whether the qubits in the program are logical or physical, or the type of qubit technology. The mapping from a qubit variable in a program to an actual logical or physical qubit is decided by the runtime, and that mapping may be deferred until after the topology and other details of the target device is known.

### Compiler-generated controlled and adjoint specializations

Q# includes keywords and compiler support for automatically generating the adjoint and/or controlled variation of an operation, which maps to common patterns used in reversible quantum computation. This makes writing algorithms easier and allows for compiler driven optimization of quantum code.

### First-class operations

Operations and functions in Q# are first-class entities; they can be passed to other operations, assigned to variables, and used like any other value. This makes it easy to express protocols such as amplitude amplification, phase estimation, and others.

### Classical control flow

Q# supports general classical control flow during the execution of an algorithm. For instance, the loop required for probabilistic algorithms such as Grover's search can easily be expressed in Q#, rather than having to return to the classical driver to test whether the result satisfies the oracle and rerunning if not.

### Mixed classical and quantum computation

Q# supports rich classical computation and quantum operations. This allows clean expression of adaptive algorithms such as the random walk phase estimation operation. Such algorithms are difficult to express directly in the circuit model of a fixed sequence of quantum gates.



