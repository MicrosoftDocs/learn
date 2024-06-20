
Before you start writing quantum programs, it's important to understand the structure and components of a Q# program.

In this unit, you'll review the main components of a Q# program.

## Namespaces

Every Q# file starts with a namespace. Here's an example:

```qsharp
namespace HelloQuantum {
    // Your code goes here.
}
```

The `namespace` keyword is used to define a namespace. Namespaces are used to organize Q# code into logical units. Their use becomes important when you use Q# libraries in your programs and when you write your own libraries.

## Allocating qubits

In Q#, to obtain a qubit, you use the `use` keyword. Every qubit you allocate with the `use` keyword starts in the $\ket{0}$ state.

You can allocate one or many qubits at a time. Here's an example that allocates one and five qubits:

```qsharp
use q1 = Qubit(); // Allocate one qubit
use q5 = Qubit[5]; // Allocate five qubits
```

## Quantum operations

Operations are the basic building blocks of a Q# program. A Q# operation is a quantum subroutine. That is, it's a callable routine that contains quantum operations that modify the state of the qubit register.

To define a Q# operation, you specify a name for the operation along with its inputs and its output. Here's a basic example:

```qsharp
operation SayHelloQ() : Unit {
    Message("Hello quantum world!");
}
```

Here, `SayHelloQ` is the name of the operation. It takes zero arguments as its input and returns type `Unit`, which means that the operation returns no information.

Q# libraries also provide operations that you can use in your programs, such as the Hadamard, `H`, operation, which puts a qubit into a superposition state.

## Types

Q# provides many built-in types you might be already familiar with, including `Int`, `Double`, `Bool`, and `String`. 

In this example, the `Unit` type is used to indicate that the operation doesn't return any information:

```qsharp
operation SayHelloQ() : Unit {
    Message("Hello quantum world!");
}
```

In the following units, you'll work with the `Result` type, which is specific type to quantum computing. A `Result` type is the result of measuring a qubit and can be either `One` and `Zero`.

## Quantum libraries

Q# libraries contain functions and operations that you can use in quantum programs. When you call a function or operation from a library, you use the `open` directive and specify the library's namespace. For example, to use the `Microsoft.Quantum.Intrinsic` library, you do the following:

```qsharp
    open Microsoft.Quantum.Intrinsic;
```

## Entry point

`EntryPoint` tells the Q# compiler where to begin executing the program. Every Q# program must have one entry point followed by an operation. For example, the following code defines an entry point operation, `HelloQ`, that prints "Hello quantum world!" to the console:

```qsharp
namespace HelloQuantum {

    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation HelloQ() : Unit {
        Message("Hello quantum world!");
    }
}
```

> [!NOTE]
> Note that the above Q# program opens the`Microsoft.Quantum.Intrinsic` library to use the `Message` operation, which writes a message to the console.

## Measuring qubits

In Q#, the `Measure` operation performs a joint measurement of one or more qubits in the specified Pauli bases, which can be `PauliX`, `PauliY`, or `PauliZ`. The `Measure` operation returns a `Result` type that is either `One` or `Zero`.

To implement a measurement in the computational basis $\lbrace\ket{0},\ket{1}\rbrace$ you can also use the `M` operation, which performs a measurement in the Pauli Z-basis. Thus, the `M` operation is equivalent to applying `Measure([PauliZ], [qubit])`.

## Resetting qubits

In Q#, qubits must be in the $\ket{0}$ state by the time they are released. When you have finished using a qubit, you use the `Reset` operation to reset the qubit to the $\ket{0}$.

```qsharp
    // Reset the qubit so it can be safely released.
    Reset(qubit);
```

