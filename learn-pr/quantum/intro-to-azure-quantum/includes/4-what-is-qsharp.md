Q# is an open-source, high-level programming language for developing and running quantum algorithms. It’s part of the Azure Quantum Development Kit (Modern QDK) and is designed to be hardware agnostic, scale to the full range of quantum applications, and optimize execution.



## The characteristics of Q\#

Q# can be used to write quantum algorithms, simulate them on classical computers, and then run them on actual quantum computers. Q# also provides a library of built-in quantum operations, such as quantum gates and measurements, that are used to manipulate qubits and perform quantum computations. 

```qsharp
@EntryPoint()
operation MeasureOneQubit() : Result {
    // The following using block creates a fresh qubit and initializes it
    // in the |0 state.
    use qubit = Qubit();
    // We apply a Hadamard operation to the state, thereby preparing the
    // state 1 / sqrt(2) (|0> + |1>).   
    H(qubit);
    // Now we measure the qubit in Z-basis.
    let result = M(qubit);
    // As the qubit is now in an eigenstate of the measurement operator,
    // we reset the qubit before releasing it.
    if result == One { X(qubit); }
    // Finally, we return the result of the measurement.
    return result;
}
```

The following sections describe some key features of Q#.

### Domain-specific libraries

The Q# libraries enable you to run complex quantum operations without having to design low-level operation sequences.

- The standard library provides a set of essential functions and operations that can be used when writing quantum programs in Q#.
- The quantum numeric library provides support for a wide range of numerical functionality.

### Qubit management

In Q#, qubits are resources that are requested from the runtime when needed and returned when no longer in use. This method is similar to the way that classical languages deal with heap memory.

### Agnostic qubit type

The Q# language doesn’t specify whether the qubits in the program are logical or physical, or the type of qubit technology. The runtime decides the mapping from a qubit variable in a program to an actual logical or physical qubit. That mapping can be deferred until after the topology and other details of the target device is known.

### Compiler-generated controlled and adjoint specializations

Q# can automatically make operations reversible and controlled. This capability makes writing algorithms easier and allows for compiler-driven optimization of quantum code.

### First-class operations

Operations and functions in Q# can be passed to other operations, assigned to variables, and used like any other value. This capability makes it easy to express protocols such as amplitude amplification, phase estimation, and others.

### Classical control flow

Q# supports general classical control flow during the execution of an algorithm. For instance, the loop required for probabilistic algorithms such as Grover's search can easily be expressed in Q#. With this type of flow, you don't have to return to the classical driver to test whether the result satisfies the oracle, and then rerun it if it doesn't.

### Mixed classical and quantum computation

Q# supports rich classical computation and quantum operations, allowing for clean expression of adaptive algorithms such as the random walk phase estimation operation. Such algorithms are difficult to express directly in the circuit model of a fixed sequence of quantum gates.
