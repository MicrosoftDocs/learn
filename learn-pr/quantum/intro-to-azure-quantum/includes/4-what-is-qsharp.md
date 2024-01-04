Q# is an open-source, high-level, programming language for developing and running quantum algorithms. It’s part of the Azure Quantum Development Kit (Modern QDK) and it's designed to be hardware agnostic, scale to the full range of quantum applications, and to optimize execution.

## Why a quantum programming language?

There are many reasons for wanting to build a quantum programming language, but the short answer would be: because we want to write algorithms, not circuits.

When writing algorithms, we should meet the following requirements for the language, compiler, and runtime:

- **Abstract qubits** Quantum algorithms use qubits that are not tied to specific hardware or layout. The compiler and runtime handle the mapping from program qubits to physical qubits.
- **Quantum and classical computation.** The ability to perform classical and quantum computations is essential in a *universal* quantum computer.
- **Laws of physics** Quantum algorithms follow the rules of quantum physics. For example, they cannot copy or access qubit state directly. 

## The characteristics of Q\#

Q# can be used to write quantum algorithms, simulate them on classical computers, and then run them on actual quantum computers. Q# also provides a library of built-in quantum operations, such as quantum gates and measurements, that are used to manipulate qubits and perform quantum computations. 

:::image type="content" source="../media/qsharp.png" alt-text="Screenshot of a code snippet written in Q# language.":::

The following sections describe some key features of Q#.

### Domain-specific libraries

The Q# libraries enable you to run complex quantum operations without having to design low-level operation sequences.

- The standard library provides a set of essential and very useful functions and operations that can be used when writing quantum programs in Q#.
- The quantum numeric library provides support for a wide range of numerics functionality.

### Qubit management

In Q#, qubits are resources that are requested from the runtime when needed and returned when no longer in use. This method is similar to the way that classical languages deal with heap memory.

### Agnostic qubit type

The Q# language doesn’t specify whether the qubits in the program are logical or physical, or the type of qubit technology. The mapping from a qubit variable in a program to an actual logical or physical qubit is decided by the runtime, and that mapping may be deferred until after the topology and other details of the target device is known.

### Compiler-generated controlled and adjoint specializations

Q# can automatically make operations reversible and controlled. This makes writing algorithms easier and allows for compiler driven optimization of quantum code.

### First-class operations

Operations and functions in Q# can be passed to other operations, assigned to variables, and used like any other value. This makes it easy to express protocols such as amplitude amplification, phase estimation, and others.

### Classical control flow

Q# supports general classical control flow during the execution of an algorithm. For instance, the loop required for probabilistic algorithms such as Grover's search can easily be expressed in Q#, rather than having to return to the classical driver to test whether the result satisfies the oracle and rerunning if not.

### Mixed classical and quantum computation

Q# supports rich classical computation and quantum operations. This allows clean expression of adaptive algorithms such as the random walk phase estimation operation. Such algorithms are difficult to express directly in the circuit model of a fixed sequence of quantum gates.
